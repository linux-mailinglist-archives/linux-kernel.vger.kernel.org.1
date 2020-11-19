Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C022B9A87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgKSSWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:22:15 -0500
Received: from foss.arm.com ([217.140.110.172]:37058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgKSSWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:22:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41F21396;
        Thu, 19 Nov 2020 10:22:13 -0800 (PST)
Received: from [192.168.2.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B1353F70D;
        Thu, 19 Nov 2020 10:22:12 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64: kexec: Use smp_send_stop in machine_shutdown
To:     Henry Willard <henry.willard@oracle.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com
References: <1604705148-1831-1-git-send-email-henry.willard@oracle.com>
 <a68252a0-4248-4523-da8d-0ecfc3bc207b@arm.com>
 <327a6a60-5ba8-4aa2-6a0e-e5f99e4e0bf0@oracle.com>
Message-ID: <27a056db-d805-edef-fd27-02cdde415eaa@arm.com>
Date:   Thu, 19 Nov 2020 18:22:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <327a6a60-5ba8-4aa2-6a0e-e5f99e4e0bf0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

On 16/11/2020 21:11, Henry Willard wrote:
> On 11/11/20 10:11 AM, James Morse wrote:
>> On 06/11/2020 23:25, Henry Willard wrote:
>>> machine_shutdown() is called by kernel_kexec() to shutdown
>>> the non-boot CPUs prior to starting the new kernel. The
>>> implementation of machine_shutdown() varies by architecture.
>>> Many make an interprocessor call, such as smp_send_stop(),
>>> to stop the non-boot CPUs. On some architectures the CPUs make
>>> some sort of firmware call to stop the CPU. On some architectures
>>> without the necessary firmware support to stop the CPU, the CPUs
>>> go into a disabled loop, which is not suitable for supporting
>>> kexec. On Arm64 systems that support PSCI, CPUs can be stopped
>>> with a PSCI CPU_OFF call.
>> All this variation is because we want to to get the CPU back in a sane state, as if we'd
>> just come from cold boot. Without the platform firmware doing its initialisation, the only
>> way we have of doing this is to run the cpuhp callbacks to take the CPU offline cleanly.

> If it is unsafe to call cpu_ops.cpu_die (or cpu_die) on Arm except from cpuhp shouldn't
> something detect that?

It wouldn't be the first undocumented assumption in linux!


>>> Arm64 machine_shutdown() uses the CPU hotplug infrastructure via
>>> smp_shutdown_nonboot_cpus() to stop each CPU. This is relatively
>>> slow and takes a best case of .02 to .03 seconds per CPU which are
>>> stopped sequentially.

>> Hmmm, looks like cpuhp doesn't have a way to run the callbacks in parallel...
>>
>>
>>> This can take the better part of a second for
>>> all the CPUs to be stopped depending on how many CPUs are present.
>>> If for some reason the CPUs are busy at the time of the kexec reboot,
>>> it can take several seconds to shut them all down.

>> Busy doing what?

> Executing user code

Nice. For EL0 you can always interrupt it, so that shouldn't matter.
I guess the issue is CPUs waiting for an irqsave spinlock that can't be interrupted until
they've finished the work they are doing.


>> I assume the problem is CPUs starting work on behalf of user-space, which is now
>> pointless, which prevents them from scheduling into the cpuhp work quickly.
>>
>> Does hoisting kexec's conditional call to freeze_processes() above the #ifdef - so that
>> user-space threads are no longer schedule-able improve things here?

> It might help the worst cases, but even on an idle system it takes a while.

>>> Each CPU shuts itself down by calling PSCI CPU_OFF.
>>> In some applications such as embedded systems, which need a very
>>> fast reboot (less than a second), this may be too slow.

>> Where does this requirement come from? Surely kexec is part of a software update, not
>> regular operation.

> The requirement comes from the owner of the larger environment of which this embedded
> system is a part.

> So, yes, this is part of software maintenance of a component during
> regular operation.

What does kexec as part of its regular operation? kexec re-writes all of memory! Surely
its only for software updates, which can't happen by surprise!

(This one second number has come up before. Why not 2, or 10?)


Pavel had a similar requirement. He was looking at doing the kexec-image re-assembly with
the MMU enabled. This benefits a very large kexec-image on platforms with lots of memory,
but where the CPUs suffer when making non-cacheable accesses. The combined series is here:
https://gitlab.arm.com/linux-arm/linux-jm/-/commits/kexec+mmu/v0/

But this didn't show enough of an improvement on Pavel's platform.


>>> This patch reverts to using smp_send_stop() to signal all
>>> CPUs to stop immediately. Currently smp_send_stop() causes each cpu
>>> to call local_cpu_stop(), which goes into a disabled loop. This patch
>>> modifies local_cpu_stop() to call cpu_die() when kexec_in_progress
>>> is true, so that the CPU calls PSCI CPU_OFF just as in the case of
>>> smp_shutdown_nonboot_cpus().
>> This is appropriate for panic(), as we accept it may fail.
>>
>> For Kexec(), the CPU must go offline, otherwise we can't overwrite the code it was
>> running. The arch code can't just call CPU_OFF in any context. See 5.5 CPU_OFF' of
>> https://developer.arm.com/documentation/den0022/d
>>
>> 5.5.2 describes what the OS must do first, in particular interrupts must be migrated away
>> from the CPU calling CPU_OFF. Currently the cpuhp notifiers do this, which after this
>> patch, no longer run.

> I believe this is done by irq_migrate_all_off_this_cpu(), which is called by
> take_cpu_down() scheduled on the processor to be shutdown by stop_machine_cpuslocked(). I
> missed that. While take_cpu_down() is running on the target processor the boot CPU is
> waiting, which is part of the reason for the latency.

Something that may help, but is short of touching the cpuhp code:
You may find that some of the cpuhp callbacks for drivers aren't necessary if this
kernel's state is never going to be restored. Drivers can tell this is happening because
kexec calls the device shutdown() callback. (it also triggers the reboot notifiers).

Its possible that a device's shutdown callback could unregister the cpuhp callbacks and
return the device to a sensible state. Looking at the PMU drivers under drivers/perf there
are many more users of cpuhp callbacks than implementers of shutdown.

This would unfortunately need checking changing per-driver.


(any change like this patch that skips the cpuhp callbacks is likely to expose bugs in
drivers that don't implement shutdown, or relied on the cpuhp for kexec)


>> You're going to need some duct-tape here, but I recall the proposed
>> 'ARCH_OFFLINE_CPUS_ON_REBOOT', which would help, but isn't a complete thing. From the
>> discussion:
>> https://lore.kernel.org/lkml/87h80vwta7.fsf@nanos.tec.linutronix.de/
>> https://lore.kernel.org/lkml/alpine.DEB.2.21.1908201321200.2223@nanos.tec.linutronix.de/
>>
>> using cpuhp to offline these CPUs is the right thing to do.
>> If the problem is its too slow, can we tackled that instead?

> I think it is relatively slow because the CPUs are shutdown sequentially. Besides ia64,
> most of the architectures that support kexec, appear to kill them all at once. I will try
> again. Thanks for the pointers.

Improving cphup to be able to bring CPUs online/offline in parallel is the best option,
but its also the hardest. You get two bites of the cherry with this as your next kernel
may be able to bring all the secondary cores online in parallel too.


Thanks,

James
