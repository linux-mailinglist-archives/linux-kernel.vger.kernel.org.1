Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A8303AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbhAZKx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:53:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:53889 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbhAZCrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:47:07 -0500
IronPort-SDR: xDHicu4KIjwAZ8udXYmfWauCFrOkusy3jA7MoQiiZwZudj61SB2+Zi9yFTs/DQxof6sQJkrbWW
 HQL/q2xXvoOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264661970"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="xz'?scan'208";a="264661970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:45:16 -0800
IronPort-SDR: hG1v35FHbkuAgacQf9zUEMdrd9KQMCSyKVND3CsXna99r1Vcv0VI/FvUsnHw8jKkqzGYfVXllF
 tiXNVrYAMaaA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="xz'?scan'208";a="387641826"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.6.97]) ([10.238.6.97])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:45:13 -0800
Subject: Re: [workqueue] d5bff968ea:
 WARNING:at_kernel/workqueue.c:#process_one_work
To:     Hillf Danton <hdanton@sina.com>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@intel.com,
        lkp <lkp@lists.01.org>
References: <20210125092900.1839-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <7b97a3ff-a1a3-55c4-0643-1346dfb276b2@linux.intel.com>
Date:   Tue, 26 Jan 2021 10:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125092900.1839-1-hdanton@sina.com>
Content-Type: multipart/mixed;
 boundary="------------8B5DB8DD0B990E62A672F037"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8B5DB8DD0B990E62A672F037
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/25/2021 5:29 PM, Hillf Danton wrote:
> On 25 Jan 2021 16:31:32 +0800 Xing Zhengjun wrote:
>> On 1/22/2021 3:59 PM, Hillf Danton wrote:
>>> On Fri, 22 Jan 2021 09:48:32 +0800 Xing Zhengjun wrote:
>>>> On 1/21/2021 12:00 PM, Hillf Danton wrote:
>>>>> On Wed, 20 Jan 2021 21:46:33 +0800 Oliver Sang wrote:
>>>>>> On Fri, Jan 15, 2021 at 03:24:32PM +0800, Hillf Danton wrote:
>>>>>>> Thu, 14 Jan 2021 15:45:11 +0800
>>>>>>>>
>>>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>>>
>>>>>>>> commit: d5bff968ea9cc005e632d9369c26cbd8148c93d5 ("workqueue: break affinity initiatively")
>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.11b
>>>>>>>>
>>>>>>> [...]
>>>>>>>>
>>>>>>>> [   73.794288] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2192 process_one_work
>>>>>>>
>>>>>>> Thanks for your report.
>>>>>>>
>>>>>>> We can also break CPU affinity by checking POOL_DISASSOCIATED at attach
>>>>>>> time without extra cost paid; that way we have the same behavior as at
>>>>>>> the unbind time.
>>>>>>>
>>>>>>> What is more the change that makes kworker pcpu is cut because they are
>>>>>>> going to not help either hotplug or the mechanism of stop machine.
>>>>>>
>>>>>> hi, by applying below patch, the issue still happened.
>>>>>
>>>>> Thanks for your report.
>>>>>>
>>>>>> [ 4.574467] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
>>>>>> [ 4.575651] pci 0000:00:01.0: Activating ISA DMA hang workarounds
>>>>>> [ 4.576900] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>>>>>> [ 4.578648] PCI: CLS 0 bytes, default 64
>>>>>> [ 4.579685] Unpacking initramfs...
>>>>>> [ 8.878031] -----------[ cut here ]-----------
>>>>>> [ 8.879083] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2187 process_one_work+0x92/0x9e0
>>>>>> [ 8.880688] Modules linked in:
>>>>>> [ 8.881274] CPU: 0 PID: 22 Comm: kworker/1:0 Not tainted 5.11.0-rc3-gc213503139bb #2
>>>>>
>>>>> The kworker bond to CPU1 runs on CPU0 and triggers the warning, which
>>>>> shows that scheduler breaks CPU affinity, after 06249738a41a
>>>>> ("workqueue: Manually break affinity on hotplug"), though quite likely
>>>>> by kworker/1:0 for the initial workers.
>>>>>
>>>>>> [ 8.882518] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>>>> [ 8.887539] Workqueue: 0x0 (events)
>>>>>> [ 8.887838] EIP: process_one_work+0x92/0x9e0
>>>>>> [ 8.887838] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 74 85 13 00 ff 05 b8 30 04 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>>>> [ 8.887838] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>>>> [ 8.887838] ESI: 43c04720 EDI: 42e45620 EBP: de7f23c0 ESP: 43d7bf08
>>>>>> [ 8.887838] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>>>> [ 8.887838] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>>>>>> [ 8.887838] Call Trace:
>>>>>> [ 8.887838] ? worker_thread+0x98/0x6a0
>>>>>> [ 8.887838] ? worker_thread+0x2dd/0x6a0
>>>>>> [ 8.887838] ? kthread+0x1ba/0x1e0
>>>>>> [ 8.887838] ? create_worker+0x1e0/0x1e0
>>>>>> [ 8.887838] ? kzalloc+0x20/0x20
>>>>>> [ 8.887838] ? ret_from_fork+0x1c/0x28
>>>>>> [ 8.887838] _warn_unseeded_randomness: 63 callbacks suppressed
>>>>>> [ 8.887838] random: get_random_bytes called from init_oops_id+0x2b/0x60 with crng_init=0
>>>>>> [ 8.887838] --[ end trace ac461b4d54c37cfa ]--
>>>>>
>>>>>
>>>>> Instead of creating the initial workers only on the active CPUS, rebind
>>>>> them (labeled pcpu) and jump to the right CPU at bootup time.
>>>>>
>>>>> --- a/kernel/workqueue.c
>>>>> +++ b/kernel/workqueue.c
>>>>> @@ -2385,6 +2385,16 @@ woke_up:
>>>>>     		return 0;
>>>>>     	}
>>>>>     
>>>>> +	if (!(pool->flags & POOL_DISASSOCIATED) && smp_processor_id() !=
>>>>> +								pool->cpu) {
>>>>> +		/* scheduler breaks CPU affinity for us, rebind it */
>>>>> +		raw_spin_unlock_irq(&pool->lock);
>>>>> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>> +		/* and jump to the right seat */
>>>>> +		schedule_timeout_interruptible(1);
>>>>> +		goto woke_up;
>>>>> +	}
>>>>> +
>>>>>     	worker_leave_idle(worker);
>>>>>     recheck:
>>>>>     	/* no more worker necessary? */
>>>>> --
>>>>>
>>>> I test the patch, the warning still appears in the kernel log.
>>>
>>> Thanks for your report.
>>>>
>>>> [  230.356503] smpboot: CPU 1 is now offline
>>>> [  230.544652] x86: Booting SMP configuration:
>>>> [  230.545077] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>> [  230.545640] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>> [  230.545675] masked ExtINT on CPU#1
>>>> [  230.593829] ------------[ cut here ]------------
>>>> [  230.594257] WARNING: CPU: 0 PID: 257 at kernel/workqueue.c:2192 process_one_work+0x92/0x9e0
>>>> [  230.594990] Modules linked in: rcutorture torture mousedev input_leds
>>>> led_class pcspkr psmouse evbug tiny_power_button button
>>>> [  230.595961] CPU: 0 PID: 257 Comm: kworker/1:3 Not tainted 5.11.0-rc3-gdcba55d9080f #2
>>>
>>> Like what was reported, kworker bond to CPU1 runs on CPU0 and triggers
>>> warning, due to scheduler breaking CPU affinity for us. What is new, the
>>> affinity was broken at offline time instead of bootup.
>>>
>>>> [  230.596621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>> [  230.597322] Workqueue:  0x0 (rcu_gp)
>>>> [  230.597636] EIP: process_one_work+0x92/0x9e0
>>>> [  230.598005] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>>>> 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 f4 85 13 00 ff 05 cc 30 04
>>>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>> [  230.599569] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>> [  230.600100] ESI: 43d94240 EDI: df4040f4 EBP: de7f23c0 ESP: bf5f1f08
>>>> [  230.600629] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>> [  230.601203] CR0: 80050033 CR2: 01bdecbc CR3: 04e2c000 CR4: 000406d0
>>>> [  230.601735] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>>>> [  230.602265] DR6: fffe0ff0 DR7: 00000400
>>>> [  230.602594] Call Trace:
>>>> [  230.602813]  ? process_one_work+0x20e/0x9e0
>>>> [  230.603181]  ? worker_thread+0x32d/0x700
>>>> [  230.603522]  ? kthread+0x1ba/0x1e0
>>>> [  230.603818]  ? create_worker+0x1e0/0x1e0
>>>> [  230.604157]  ? kzalloc+0x20/0x20
>>>> [  230.604524]  ? ret_from_fork+0x1c/0x28
>>>> [  230.604850] ---[ end trace 06b1e66b5e17fa85 ]---
>>>> [  230.605504] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>>>> [  230.766960] smpboot: CPU 1 is now offline
>>>> [  230.814803] x86: Booting SMP configuration:
>>>> [  230.815306] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>> [  230.815964] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>
>>>
>>> Unlike the above diff that is at most papering over the problem
>>> sitting somewhere in the scheduler, add change to creating worker
>>> by skipping set_cpus_allowed_ptr() because we will wake it up after
>>> attaching it to worker pool.
>>>
>>> If we can ignore rescuer for now, then the allowed ptr is only
>>> updated at on/offline time; lets see the difference at boot time.
>>>
>>>
>>> --- a/kernel/workqueue.c
>>> +++ b/kernel/workqueue.c
>>> @@ -1844,16 +1844,10 @@ static struct worker *alloc_worker(int n
>>>     * cpu-[un]hotplugs.
>>>     */
>>>    static void worker_attach_to_pool(struct worker *worker,
>>> -				   struct worker_pool *pool)
>>> +				   struct worker_pool *pool,
>>> +				   int update_cpus_allowed)
>>>    {
>>>    	mutex_lock(&wq_pool_attach_mutex);
>>> -
>>> -	/*
>>> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>>> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>>> -	 */
>>> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>> -
>>>    	/*
>>>    	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>>    	 * stable across this function.  See the comments above the flag
>>> @@ -1867,6 +1861,9 @@ static void worker_attach_to_pool(struct
>>>    	list_add_tail(&worker->node, &pool->workers);
>>>    	worker->pool = pool;
>>>    
>>> +	if (update_cpus_allowed)
>>> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>> +
>>>    	mutex_unlock(&wq_pool_attach_mutex);
>>>    }
>>>    
>>> @@ -1942,8 +1939,11 @@ static struct worker *create_worker(stru
>>>    	set_user_nice(worker->task, pool->attrs->nice);
>>>    	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>>    
>>> -	/* successful, attach the worker to the pool */
>>> -	worker_attach_to_pool(worker, pool);
>>> +	/*
>>> +	 * attach the worker to the pool without asking scheduler to
>>> +	 * update CPUs allowed
>>> +	 */
>>> +	worker_attach_to_pool(worker, pool, 0);
>>>    
>>>    	/* start the newly created worker */
>>>    	raw_spin_lock_irq(&pool->lock);
>>> @@ -2508,7 +2508,7 @@ repeat:
>>>    
>>>    		raw_spin_unlock_irq(&wq_mayday_lock);
>>>    
>>> -		worker_attach_to_pool(rescuer, pool);
>>> +		worker_attach_to_pool(rescuer, pool, 1);
>>>    
>>>    		raw_spin_lock_irq(&pool->lock);
>>>    
>>> --
>>>
>> I test the patch, the warning still appears in the kernel log.
> 
> Thanks.
>>
>> [   55.754187] smpboot: Booting Node 0 Processor 1 APIC 0x1
>> [   55.785594] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>> [   55.785646] masked ExtINT on CPU#1
>> [   55.920602] ------------[ cut here ]------------
>> [   55.921355] WARNING: CPU: 0 PID: 160 at kernel/workqueue.c:2192 process_one_work+0x92/0x9e0
>> [   55.922583] Modules linked in: rcutorture torture mousedev evbug
>> input_leds led_class tiny_power_button psmouse pcspkr button
>> [   55.924294] CPU: 0 PID: 160 Comm: kworker/1:2 Not tainted 5.11.0-rc3-00186-g77bf4e461cfa #2
> 
> Same issue as before.
> 
>> [   55.925552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>> [   55.926763] Workqueue:  0x0 (rcu_gp)
>> [   55.927298] EIP: process_one_work+0x92/0x9e0
>> [   55.927950] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>> 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 94 85 13 00 ff 05 b8 30 04
>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>> [   55.930726] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>> [   55.931642] ESI: 43d90540 EDI: df48c0f4 EBP: de7f23c0 ESP: bfb47f08
>> [   55.932590] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>> [   55.933609] CR0: 80050033 CR2: 024e994c CR3: 7fd80000 CR4: 000406d0
>> [   55.934555] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>> [   55.935457] DR6: fffe0ff0 DR7: 00000400
>> [   55.936041] Call Trace:
>> [   55.936534]  ? process_one_work+0x20e/0x9e0
>> [   55.937305]  ? worker_thread+0x2dd/0x6a0
>> [   55.938018]  ? kthread+0x1ba/0x1e0
>> [   55.938598]  ? create_worker+0x1e0/0x1e0
>> [   55.939315]  ? kzalloc+0x20/0x20
>> [   55.940000]  ? ret_from_fork+0x1c/0x28
>> [   55.940627] ---[ end trace d155e9e6402de179 ]---
>> [   55.941641] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>> [   56.155271] smpboot: CPU 1 is now offline
>> [   56.193613] x86: Booting SMP configuration:
>> [   56.194400] smpboot: Booting Node 0 Processor 1 APIC 0x1
> 
> The changes in the diff below are
> 
> 1/ at rescue time, change CPU affinity only if POOL_DISASSOCIATED
> is not set, and print warning the same way as offline time.
> 
> 2/ at offine time, dont update allowed CPUs after setting
> POOL_DISASSOCIATED because we no longer have interest in affinity.
> 
> 3/ at online time, mark pcpu before binding affinity.
> 
> Though one change a diff is appreciated, by the WARNs, we can tell
> which is what if any warning goes into dmesg.
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1844,25 +1844,23 @@ static struct worker *alloc_worker(int n
>    * cpu-[un]hotplugs.
>    */
>   static void worker_attach_to_pool(struct worker *worker,
> -				   struct worker_pool *pool)
> +				   struct worker_pool *pool, int set)
>   {
>   	mutex_lock(&wq_pool_attach_mutex);
>   
>   	/*
> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> -	 */
> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> -
> -	/*
>   	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>   	 * stable across this function.  See the comments above the flag
>   	 * definition for details.
>   	 */
>   	if (pool->flags & POOL_DISASSOCIATED)
>   		worker->flags |= WORKER_UNBOUND;
> -	else
> +	else {
>   		kthread_set_per_cpu(worker->task, true);
> +		if (set)
> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> +						pool->attrs->cpumask) < 0);
> +	}
>   
>   	list_add_tail(&worker->node, &pool->workers);
>   	worker->pool = pool;
> @@ -1943,7 +1941,7 @@ static struct worker *create_worker(stru
>   	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>   
>   	/* successful, attach the worker to the pool */
> -	worker_attach_to_pool(worker, pool);
> +	worker_attach_to_pool(worker, pool, 0);
>   
>   	/* start the newly created worker */
>   	raw_spin_lock_irq(&pool->lock);
> @@ -2508,7 +2506,7 @@ repeat:
>   
>   		raw_spin_unlock_irq(&wq_mayday_lock);
>   
> -		worker_attach_to_pool(rescuer, pool);
> +		worker_attach_to_pool(rescuer, pool, 1);
>   
>   		raw_spin_lock_irq(&pool->lock);
>   
> @@ -4923,7 +4921,6 @@ static void unbind_workers(int cpu)
>   
>   		for_each_pool_worker(worker, pool) {
>   			kthread_set_per_cpu(worker->task, false);
> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>   		}
>   
>   		mutex_unlock(&wq_pool_attach_mutex);
> @@ -4977,9 +4974,9 @@ static void rebind_workers(struct worker
>   	 * from CPU_ONLINE, the following shouldn't fail.
>   	 */
>   	for_each_pool_worker(worker, pool) {
> +		kthread_set_per_cpu(worker->task, true);
>   		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>   						  pool->attrs->cpumask) < 0);
> -		kthread_set_per_cpu(worker->task, true);
>   	}
>   
>   	raw_spin_lock_irq(&pool->lock);
> --
> 
I test the patch, the warning still appears in the kernel log, but the 
warning is different from before.

[    0.054803] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[    0.054803] masked ExtINT on CPU#1
[    0.054803] smpboot: CPU 1 Converting physical 0 to logical die 1
[    1.890338] ------------[ cut here ]------------
[    1.890338] WARNING: CPU: 1 PID: 18 at kernel/kthread.c:508 
kthread_set_per_cpu+0x156/0x180
[    1.890338] Modules linked in:
[    1.890338] CPU: 1 PID: 18 Comm: cpuhp/1 Not tainted 
5.11.0-rc3-00186-ged03082352b2 #2
[    1.890338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.12.0-1 04/01/2014
[    1.890338] EIP: kthread_set_per_cpu+0x156/0x180
[    1.890338] Code: 00 00 00 00 ff 05 68 4e 04 43 83 c4 08 5b 5e 5f c3 
8d 76 00 ff 05 34 50 04 43 0f 0b e9 f9 fe ff ff 8d 76 00 ff 05 2c 4e 04 
43 <0f> 0b eb 9d 8d b6 00 00 00 00 ff 05 40 4e 04 43 0f 0b e9 45 ff ff
[    1.890338] EAX: 42f52ce0 EBX: 00000001 ECX: 00000000 EDX: 00000001
[    1.890338] ESI: 43d76300 EDI: 43c0de00 EBP: de7f2564 ESP: 43d6beb8
[    1.900350] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
[    1.901303] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
[    1.902280] Call Trace:
[    1.902682]  ? workqueue_online_cpu+0x12b/0x640
[    1.903415]  ? workqueue_prepare_cpu+0xa0/0xa0
[    1.904155]  ? cpuhp_invoke_callback+0x1ed/0x1340
[    1.904941]  ? cpuhp_thread_fun+0x28f/0x460
[    1.905630]  ? cpuhp_thread_fun+0x49/0x460
[    1.906298]  ? smpboot_thread_fn+0x446/0x620
[    1.910275]  ? kthread+0x1ba/0x1e0
[    1.910857]  ? __smpboot_create_thread+0x260/0x260
[    1.911659]  ? kzalloc+0x20/0x20
[    1.912368]  ? ret_from_fork+0x1c/0x28
[    1.913016] ---[ end trace 6f6c005278241eba ]---
[    1.913971] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[    1.920012] smp: Brought up 1 node, 2 CPUs
[    1.920299] smpboot: Max logical packages: 2
[    1.921019] smpboot: Total of 2 processors activated (10774.03 BogoMIPS)



-- 
Zhengjun Xing

--------------8B5DB8DD0B990E62A672F037
Content-Type: application/octet-stream;
 name="dmesg.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.xz"

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
--------------8B5DB8DD0B990E62A672F037--
