Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071B72D58FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbgLJLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:11:01 -0500
Received: from foss.arm.com ([217.140.110.172]:35680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgLJLLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:11:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B642F30E;
        Thu, 10 Dec 2020 03:10:14 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06353F718;
        Thu, 10 Dec 2020 03:10:11 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:10:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, luto@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Message-ID: <20201210111008.GB88655@C02TD0UTHF1T.local>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
 <20201209181514.GA14235@C02TD0UTHF1T.local>
 <87tusuzu71.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tusuzu71.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:54:26PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 09 2020 at 18:15, Mark Rutland wrote:
> > In arch/x86/kernel/apic/io_apic.c's timer_irq_works() we do:
> >
> > 	local_irq_save(flags);
> > 	local_irq_enable();
> >
> > 	[ trigger an IRQ here ]
> >
> > 	local_irq_restore(flags);
> >
> > ... and in check_timer() we call that a number of times after either a
> > local_irq_save() or local_irq_disable(), eventually trailing with a
> > local_irq_disable() that will balance things up before calling
> > local_irq_restore().

I gave the patchlet below a spin with my debug patch, and it boots
cleanly for me under QEMU. If you spin it as a real patch, feel free to
add:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/x86/kernel/apic/io_apic.c |   22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1618,21 +1618,16 @@ static void __init delay_without_tsc(voi
>  static int __init timer_irq_works(void)
>  {
>  	unsigned long t1 = jiffies;
> -	unsigned long flags;
>  
>  	if (no_timer_check)
>  		return 1;
>  
> -	local_save_flags(flags);
>  	local_irq_enable();
> -
>  	if (boot_cpu_has(X86_FEATURE_TSC))
>  		delay_with_tsc();
>  	else
>  		delay_without_tsc();
>  
> -	local_irq_restore(flags);
> -
>  	/*
>  	 * Expect a few ticks at least, to be sure some possible
>  	 * glue logic does not lock up after one or two first
> @@ -1641,10 +1636,10 @@ static int __init timer_irq_works(void)
>  	 * least one tick may be lost due to delays.
>  	 */
>  
> -	/* jiffies wrap? */
> -	if (time_after(jiffies, t1 + 4))
> -		return 1;
> -	return 0;
> +	local_irq_disable();
> +
> +	/* Did jiffies advance? */
> +	return time_after(jiffies, t1 + 4);
>  }
>  
>  /*
> @@ -2117,13 +2112,12 @@ static inline void __init check_timer(vo
>  	struct irq_cfg *cfg = irqd_cfg(irq_data);
>  	int node = cpu_to_node(0);
>  	int apic1, pin1, apic2, pin2;
> -	unsigned long flags;
>  	int no_pin1 = 0;
>  
>  	if (!global_clock_event)
>  		return;
>  
> -	local_irq_save(flags);
> +	local_irq_disable();
>  
>  	/*
>  	 * get/set the timer IRQ vector:
> @@ -2191,7 +2185,6 @@ static inline void __init check_timer(vo
>  			goto out;
>  		}
>  		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
> -		local_irq_disable();
>  		clear_IO_APIC_pin(apic1, pin1);
>  		if (!no_pin1)
>  			apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
> @@ -2215,7 +2208,6 @@ static inline void __init check_timer(vo
>  		/*
>  		 * Cleanup, just in case ...
>  		 */
> -		local_irq_disable();
>  		legacy_pic->mask(0);
>  		clear_IO_APIC_pin(apic2, pin2);
>  		apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
> @@ -2232,7 +2224,6 @@ static inline void __init check_timer(vo
>  		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
>  		goto out;
>  	}
> -	local_irq_disable();
>  	legacy_pic->mask(0);
>  	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
>  	apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
> @@ -2251,7 +2242,6 @@ static inline void __init check_timer(vo
>  		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
>  		goto out;
>  	}
> -	local_irq_disable();
>  	apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
>  	if (apic_is_x2apic_enabled())
>  		apic_printk(APIC_QUIET, KERN_INFO
> @@ -2260,7 +2250,7 @@ static inline void __init check_timer(vo
>  	panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
>  		"report.  Then try booting with the 'noapic' option.\n");
>  out:
> -	local_irq_restore(flags);
> +	local_irq_enable();
>  }
>  
>  /*
