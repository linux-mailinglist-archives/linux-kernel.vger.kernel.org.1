Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1F2AF7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKKSLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:11:53 -0500
Received: from foss.arm.com ([217.140.110.172]:59472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgKKSLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:11:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E18E1474;
        Wed, 11 Nov 2020 10:11:43 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0BFF3F718;
        Wed, 11 Nov 2020 10:11:41 -0800 (PST)
Subject: Re: [PATCH] arm64: kexec: Use smp_send_stop in machine_shutdown
To:     Henry Willard <henry.willard@oracle.com>
References: <1604705148-1831-1-git-send-email-henry.willard@oracle.com>
From:   James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com
Message-ID: <a68252a0-4248-4523-da8d-0ecfc3bc207b@arm.com>
Date:   Wed, 11 Nov 2020 18:11:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604705148-1831-1-git-send-email-henry.willard@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

On 06/11/2020 23:25, Henry Willard wrote:
> machine_shutdown() is called by kernel_kexec() to shutdown
> the non-boot CPUs prior to starting the new kernel. The
> implementation of machine_shutdown() varies by architecture.
> Many make an interprocessor call, such as smp_send_stop(),
> to stop the non-boot CPUs. On some architectures the CPUs make
> some sort of firmware call to stop the CPU. On some architectures
> without the necessary firmware support to stop the CPU, the CPUs
> go into a disabled loop, which is not suitable for supporting
> kexec. On Arm64 systems that support PSCI, CPUs can be stopped
> with a PSCI CPU_OFF call.

All this variation is because we want to to get the CPU back in a sane state, as if we'd
just come from cold boot. Without the platform firmware doing its initialisation, the only
way we have of doing this is to run the cpuhp callbacks to take the CPU offline cleanly.


> Arm64 machine_shutdown() uses the CPU hotplug infrastructure via
> smp_shutdown_nonboot_cpus() to stop each CPU. This is relatively
> slow and takes a best case of .02 to .03 seconds per CPU which are
> stopped sequentially.

Hmmm, looks like cpuhp doesn't have a way to run the callbacks in parallel...


> This can take the better part of a second for
> all the CPUs to be stopped depending on how many CPUs are present.
> If for some reason the CPUs are busy at the time of the kexec reboot,
> it can take several seconds to shut them all down.

Busy doing what?

I assume the problem is CPUs starting work on behalf of user-space, which is now
pointless, which prevents them from scheduling into the cpuhp work quickly.

Does hoisting kexec's conditional call to freeze_processes() above the #ifdef - so that
user-space threads are no longer schedule-able improve things here?


> Each CPU shuts itself down by calling PSCI CPU_OFF.

> In some applications such as embedded systems, which need a very
> fast reboot (less than a second), this may be too slow.

Where does this requirement come from? Surely kexec is part of a software update, not
regular operation.


> This patch reverts to using smp_send_stop() to signal all
> CPUs to stop immediately. Currently smp_send_stop() causes each cpu
> to call local_cpu_stop(), which goes into a disabled loop. This patch
> modifies local_cpu_stop() to call cpu_die() when kexec_in_progress
> is true, so that the CPU calls PSCI CPU_OFF just as in the case of
> smp_shutdown_nonboot_cpus().

This is appropriate for panic(), as we accept it may fail.

For Kexec(), the CPU must go offline, otherwise we can't overwrite the code it was
running. The arch code can't just call CPU_OFF in any context. See 5.5 CPU_OFF' of
https://developer.arm.com/documentation/den0022/d

5.5.2 describes what the OS must do first, in particular interrupts must be migrated away
from the CPU calling CPU_OFF. Currently the cpuhp notifiers do this, which after this
patch, no longer run.

You're going to need some duct-tape here, but I recall the proposed
'ARCH_OFFLINE_CPUS_ON_REBOOT', which would help, but isn't a complete thing. From the
discussion:
https://lore.kernel.org/lkml/87h80vwta7.fsf@nanos.tec.linutronix.de/
https://lore.kernel.org/lkml/alpine.DEB.2.21.1908201321200.2223@nanos.tec.linutronix.de/

using cpuhp to offline these CPUs is the right thing to do.
If the problem is its too slow, can we tackled that instead?


> Using smp_send_stop() instead of
> smp_shutdown_nonboot_cpus() reduces the shutdown time for 23 CPUs
> from about .65 seconds on an idle system to less than 5 msecs. On a
> busy system smp_shutdown_nonboot_cpus() may take several seconds,
> while smp_send_stop() needs only the 5 msecs.

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 4784011cecac..2568452a2417 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -142,12 +143,22 @@ void arch_cpu_idle_dead(void)
>   * This must completely disable all secondary CPUs; simply causing those CPUs
>   * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
>   * kexec'd kernel to use any and all RAM as it sees fit, without having to
> - * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
> - * functionality embodied in smpt_shutdown_nonboot_cpus() to achieve this.
> + * avoid any code or data used by any SW CPU pin loop. The target stop function
> + * will call cpu_die() if kexec_in_progress is set.
>   */
>  void machine_shutdown(void)
>  {
> -	smp_shutdown_nonboot_cpus(reboot_cpu);
> +	unsigned long timeout;
> +
> +	/*
> +	 * Don't wait forever, but no longer than a second
> +	 */

For kexec we must wait for the CPU to exit the current kernel. If it doesn't we can't
overwrite the current memory image with the kexec payload.

Features like CNP allow CPUs to share TLB entries. If a CPU is left behind in the older
kernel, the code its is executing will be overwritten and its behaviour stops being
predictable. It may start allocating junk TLB entries, that CNP allows CPUs in the new
kernel to use, resulting in hard to debug crashes.

For kdump we avoid this problem by ensuring the old and new kernels never overlap. The old
kernel doesn't even have the kdump carveout mapped.


> +	timeout = USEC_PER_SEC;
> +
> +	smp_send_stop();
> +	while (num_online_cpus() > 1 && timeout--)
> +		udelay(1);
> +	return;
>  }
>  
>  /*


Thanks,

James
