Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C026F9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIRJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:58:56 -0400
Received: from foss.arm.com ([217.140.110.172]:37714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRJ6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:58:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C7711D4;
        Fri, 18 Sep 2020 02:58:55 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30363F73B;
        Fri, 18 Sep 2020 02:58:52 -0700 (PDT)
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard
 interrupts
To:     Marc Zyngier <maz@kernel.org>, jonathanh@nvidia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-9-maz@kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <f3af8930-b61d-4945-475c-b49e326cd24f@arm.com>
Date:   Fri, 18 Sep 2020 10:58:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901144324.1071694-9-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

(CC: +Jon)

On 01/09/2020 15:43, Marc Zyngier wrote:
> Change the way we deal with GIC SGIs by turning them into proper
> IRQs, and calling into the arch code to register the interrupt range
> instead of a callback.

Your comment "This only works because we don't nest SGIs..." on this thread tripped some
bad memories from adding the irq-stack. Softirq causes us to nest irqs, but only once.


(I've messed with the below diff to remove the added stuff:)

> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4ffd62af888f..4be2b62f816f 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -335,31 +335,22 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>  		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
>  		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
>  
> -		if (likely(irqnr > 15 && irqnr < 1020)) {
> -			if (static_branch_likely(&supports_deactivate_key))
> -				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
> -			isb();
> -			handle_domain_irq(gic->domain, irqnr, regs);
> -			continue;
> -		}
> -		if (irqnr < 16) {
>  			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
> -			if (static_branch_likely(&supports_deactivate_key))
> -				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
> -#ifdef CONFIG_SMP
> -			/*
> -			 * Ensure any shared data written by the CPU sending
> -			 * the IPI is read after we've read the ACK register
> -			 * on the GIC.
> -			 *
> -			 * Pairs with the write barrier in gic_raise_softirq
> -			 */
>  			smp_rmb();
> -			handle_IPI(irqnr, regs);

If I read this right, previously we would EOI the interrupt before calling handle_IPI().
Where as now with the version of this series in your tree, we stuff the to-be-EOId value
in a percpu variable, which is only safe if these don't nest.

Hidden in irq_exit(), kernel/softirq.c::__irq_exit_rcu() has this:
|	preempt_count_sub(HARDIRQ_OFFSET);
|	if (!in_interrupt() && local_softirq_pending())
|		invoke_softirq();

The arch code doesn't raise the preempt counter by HARDIRQ, so once __irq_exit_rcu() has
dropped it, in_interrupt() returns false, and we invoke_softirq().

invoke_softirq() -> __do_softirq() -> local_irq_enable()!

Fortunately, __do_softirq() raises the softirq count first using __local_bh_disable_ip(),
which in-interrupt() checks too, so this can only happen once per IRQ.

Now the irq_exit() has moved from handle_IPI(), which ran after EOI, into
handle_domain_irq(), which runs before. I think its possible SGIs nest, and the new percpu
variable becomes corrupted.

Presumably this isn't a problem for regular IRQ, as they don't need the sending-CPU in
order to EOI, which is why it wasn't a problem before.

Adding anything to preempt-count around the whole thing upsets RCU, and softirq seems to
expect this nesting, but evidently the gic does not. I'm not sure what the right thing to
do would be. A dirty hack like [0] would confirm the theory.

/me runs

Thanks,

James



[0] A dirty hack
-----------%<-----------
diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f62433..50e14d8cbec3 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -376,7 +376,7 @@ static inline void invoke_softirq(void)
        if (ksoftirqd_running(local_softirq_pending()))
                return;

-       if (!force_irqthreads) {
+       if (false) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
                /*
                 * We can safely execute softirq on the current stack if
@@ -393,6 +393,7 @@ static inline void invoke_softirq(void)
                do_softirq_own_stack();
 #endif
        } else {
+               /* hack: force this */
                wakeup_softirqd();
        }
 }
-----------%<-----------
