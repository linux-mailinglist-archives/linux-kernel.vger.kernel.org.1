Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336E12D48BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgLISQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:16:12 -0500
Received: from foss.arm.com ([217.140.110.172]:38436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgLISQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:16:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0928F1FB;
        Wed,  9 Dec 2020 10:15:26 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B118B3F68F;
        Wed,  9 Dec 2020 10:15:22 -0800 (PST)
Date:   Wed, 9 Dec 2020 18:15:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Message-ID: <20201209181514.GA14235@C02TD0UTHF1T.local>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120115943.GD3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:59:43PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 12:46:23PM +0100, Juergen Gross wrote:
> > +static __always_inline void arch_local_irq_restore(unsigned long flags)
> > +{
> > +	if (!arch_irqs_disabled_flags(flags))
> > +		arch_local_irq_enable();
> > +}
> 
> If someone were to write horrible code like:
> 
> 	local_irq_disable();
> 	local_irq_save(flags);
> 	local_irq_enable();
> 	local_irq_restore(flags);
> 
> we'd be up some creek without a paddle... now I don't _think_ we have
> genius code like that, but I'd feel saver if we can haz an assertion in
> there somewhere...

I've cobbled that together locally (i'll post it momentarily), and gave it a
spin on both arm64 and x86, whereupon it exploded at boot time on x86.

In arch/x86/kernel/apic/io_apic.c's timer_irq_works() we do:

	local_irq_save(flags);
	local_irq_enable();

	[ trigger an IRQ here ]

	local_irq_restore(flags);

... and in check_timer() we call that a number of times after either a
local_irq_save() or local_irq_disable(), eventually trailing with a
local_irq_disable() that will balance things up before calling
local_irq_restore().

I guess that timer_irq_works() should instead do:

	local_irq_save(flags);
	local_irq_enable();
	...
	local_irq_disable();
	local_irq_restore(flags);

... assuming we consider that legitimate?

With that, and all the calls to local_irq_disable() in check_timer() removed
(diff below) I get a clean boot under QEMU with the assertion hacked in and
DEBUG_LOCKDEP enabled.

Thanks
Mark.

---->8----
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b3c7e0d4a09..e79e665a3aeb 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1631,6 +1631,7 @@ static int __init timer_irq_works(void)
        else
                delay_without_tsc();
 
+       local_irq_disable();
        local_irq_restore(flags);
 
        /*
@@ -2191,7 +2192,6 @@ static inline void __init check_timer(void)
                        goto out;
                }
                panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
-               local_irq_disable();
                clear_IO_APIC_pin(apic1, pin1);
                if (!no_pin1)
                        apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
@@ -2215,7 +2215,6 @@ static inline void __init check_timer(void)
                /*
                 * Cleanup, just in case ...
                 */
-               local_irq_disable();
                legacy_pic->mask(0);
                clear_IO_APIC_pin(apic2, pin2);
                apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
@@ -2232,7 +2231,6 @@ static inline void __init check_timer(void)
                apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
                goto out;
        }
-       local_irq_disable();
        legacy_pic->mask(0);
        apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
        apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
@@ -2251,7 +2249,6 @@ static inline void __init check_timer(void)
                apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
                goto out;
        }
-       local_irq_disable();
        apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
        if (apic_is_x2apic_enabled())
                apic_printk(APIC_QUIET, KERN_INFO
