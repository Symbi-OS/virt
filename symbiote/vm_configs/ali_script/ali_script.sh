- idle=poll: 
	Forces the clock to avoid entering the idle state.
- processor.max_cstate=1: 
	Prevents the clock from entering deeper C-states (energy saving mode), so it does not become out of sync. 
- isolcpus
	specifies CPUs listed in the realtime-variables.conf file 
- nohz
	turns off the timer tick on an idle CPU; set to off by default 
- nohz_full
	turns off the timer tick on a CPU when there is only one runnable task on that CPU; needs nohz to be set to on
	build with CONFIG_NO_HZ_FULL
- intel_pstate=disable
	prevents the Intel idle driver from managing power state and CPU frequency 
- nosoftlockup
	prevents the kernel from detecting soft lockups in user threads 
- In the above example, the kernel boot command-line parameters look as follows:
	isolcpus=1-3,5,9-14 nohz=on nohz_full=1-3,5,9-14 intel_pstate=disable nosoftlockup
- skew_tick=1
	The parameter ensures that the ticks per CPU do not occur simultaneously by making their start times 'skewed'. Skewing the start times of the per-CPU timer ticks decreases the potential for lock conflicts, reducing system jitter for interrupt response times. 
- To see if a cpu is actually tickless and has nohz_full working, do the following
	perf stat -C 1 -e irq_vectors:local_timer_entry taskset -c 1 ./small_stress.sh
	where small_stress.sh is 
	#!/bin/bash
	end=$((SECONDS+1))
	while [ $SECONDS -lt $end ]; do d=1; done
	The default kernel timer configuration shows 1000 ticks on a busy CPU:
		1000 irq_vectors:local_timer_entry
	With the dynamic tickless kernel configured, you should see 1 tick instead: 
		1 irq_vectors:local_timer_entry
	another way 
	# watch -n1 -d "cat /proc/interrupts|egrep 'LOC|CPU'"
- After isolating cpus, move housekeeping stuff like RCU to other cpus
	for i in `pgrep rcu[^c]` ; do taskset -pc 0 $i ; done
	where 0 is the cpu you want to move these processes to.
- After isolating CPUs, set iqr affinity for all interrupts to other cpus
	echo mask > /proc/irq/irq_number/smp_affinity
	where mask is hex
	This can be helpful
		Zero-based CPU ID:	0 1 2 3  4  5  6   7   8   9   10   11   12
		Decimal Value:		1 2 4 8 16 32 64 128 256 512 1024 2048 4096
		printf %0.2x'\n' 1024
		Also, for all CPUs 0 to 7, the number is 8th decimal value - 1, i.e., 255
- (OPTIONAL) Build with CONFIG_HOTPLUG_CPU=y.  After boot completes, force
	the CPU offline, then bring it back online.  This forces
	recurring timers to migrate elsewhere.	If you are concerned
	with multiple CPUs, force them all offline before bringing the
	first one back online.  Once you have onlined the CPUs in question,
	do not offline any other CPUs, because doing so could force the
	timer back onto one of the CPUs in question.
- Enable RCU to do its processing remotely via dyntick-idle by
	Build with CONFIG_NO_HZ=y and CONFIG_RCU_FAST_NO_HZ=y
- Build with CONFIG_RCU_NOCB_CPU=y and boot with the rcu_nocbs=
	boot parameter offloading RCU callbacks from all CPUs susceptible
	to OS jitter.  This approach prevents the rcuc/%u kthreads from
	having any work to do, so that they are never awakened.	
	Using rcu_nocbs=cpulist to allow the user to move all RCU offload threads to a housekeeping CPU
	You still have to manually move rcu threads to other CPUs
	Setting rcu_nocb_poll to relieve each CPU from the responsibility awakening their RCU offload threads. 
- To get rid of the xfs_log_worker interference, you can use the tunable workqueues feature of the kernels bdi-flush writeback threads.  If you are using core 0 as your "housekeeping CPU", then you could affine the bdi-flush threads to core 0 like so:
	echo 1 > /sys/bus/workqueue/devices/writeback/cpumask
	It takes a hex argument, so 1 is actually core 0.
- intel_idle.max_cstate=0 processor.max_cstate=0 idle=poll intel_pstate=disable
- disable_ht.sh turbo-boost.sh set_irq_affinity_bnx2x.sh
- Set the default irq affinity mask. The argument is a cpu list.
	irqaffinity=<cpu list>
- Disable both lockup detectors, i.e. soft-lockup and NMI watchdog (hard-lockup).
	nowatchdog
- Disable all the latest security mitigations
	mitigations=off
- nosoftlockup intel_idle.max_cstate=0 processor.max_cstate=0 mce=ignore_ce idle=poll
- taskset all threads taskset -ac 8-15 ./uperf.static -m /workloads/iperf.xml -a
----------------------------------------------
intel_idle.max_cstate=0 processor.max_cstate=0 idle=poll intel_pstate=disable nr_cpus=16 isolcpus=8-15 nohz=on nohz_full=8-15 nosoftlockup skew_tick=1 rcu_nocbs=8-15 rcu_nocb_poll
----------------------------------------------
append initrd=ukl/ukl-initrd-final.cpio.gz console=tty1,115200 console=ttyS0,115200 nr_cpus=16 isolcpus=8-15 nohz=on nohz_full=8-15 nosoftlockup intel_idle.max_cstate=0 processor.max_cstate=0 mce=ignore_ce skew_tick=1 rcu_nocbs=8-15 rcu_nocb_poll irqaffinity=0-7 nowatchdog mitigations=off ip=192.168.19.37:::255.255.255.0::eth0:none root=/dev/ram0 -- 0 ukl
append initrd=ukl/ukl-initrd-final.cpio.gz console=tty1,115200 console=ttyS0,115200 nr_cpus=16 intel_idle.max_cstate=0 processor.max_cstate=0 mitigations=off ip=192.168.19.37:::255.255.255.0::eth0:none root=/dev/ram0 -- 0 ukl
