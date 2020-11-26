Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC72C5BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404770AbgKZSSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:18:41 -0500
Received: from foss.arm.com ([217.140.110.172]:42920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404410AbgKZSSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:18:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0AC231B;
        Thu, 26 Nov 2020 10:18:39 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ED3A3F23F;
        Thu, 26 Nov 2020 10:18:38 -0800 (PST)
References: <20201124141449.572446-1-maz@kernel.org> <20201124141449.572446-3-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
In-reply-to: <20201124141449.572446-3-maz@kernel.org>
Date:   Thu, 26 Nov 2020 18:18:33 +0000
Message-ID: <jhj7dq8ugli.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 24/11/20 14:14, Marc Zyngier wrote:
> @@ -680,14 +679,22 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>        * Some hardware gives randomly wrong interrupts.  Rather
>        * than crashing, do something sensible.
>        */
> -	if (unlikely(!irq || irq >= nr_irqs)) {
> +	if (unlikely(!irq || irq >= nr_irqs || !(desc = irq_to_desc(irq)))) {
>               ack_bad_irq(irq);
>               ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW) &&
> +	    unlikely(irq_settings_is_raw(desc))) {
> +		generic_handle_irq_desc(desc);

If I got the RCU bits right from what Thomas mentioned in

  https://lore.kernel.org/r/87ft5q18qs.fsf@nanos.tec.linutronix.de
  https://lore.kernel.org/r/87lfewnmdz.fsf@nanos.tec.linutronix.de

then we're still missing something to notify RCU in the case the IRQ hits
the idle task. All I see on our entry path is

  trace_hardirqs_off();
  ...
  irq_handler()
    handle_domain_irq();
  ...
  trace_hardirqs_on();

so we do currently rely on handle_domain_irq()'s irq_enter() + irq_exit()
for that. rcu_irq_enter() says CONFIG_RCU_EQS_DEBUG=y can detect missing
bits, but I don't get any warnings with your series on my Juno.


Now, irq_enter() gives us:

  rcu_irq_enter();
  irq_enter_rcu()
    raise_softirq faffery;
    __irq_enter()
      irqtime accounting;
      preempt count + lockdep; } __irq_enter_raw()

Looking at irqentry_enter() + DEFINE_IDTENTRY_SYSVEC_SIMPLE(), I *think* we
would be fine with just:

  rcu_irq_enter();
  __irq_enter_raw();

  generic_handle_irq_desc()

  __irq_exit_raw();
  rcu_irq_exit();

I tested that and it didn't explode (though I haven't managed to make
CONFIG_RCU_EQS_DEBUG squeal). Also please note RCU isn't my forte, so the
above may contain traces of bullcrap.

>       } else {
> -		generic_handle_irq(irq);
> +		irq_enter();
> +		generic_handle_irq_desc(desc);
> +		irq_exit();
>       }
>
> -	irq_exit();
> +out:
>       set_irq_regs(old_regs);
>       return ret;
>  }
[...]
> @@ -180,3 +182,16 @@ static inline bool irq_settings_is_hidden(struct irq_desc *desc)
>  {
>       return desc->status_use_accessors & _IRQ_HIDDEN;
>  }
> +
> +static inline bool irq_settings_is_raw(struct irq_desc *desc)
> +{
> +	if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW))
> +		return desc->status_use_accessors & _IRQ_RAW;
> +
> +	/*
> +	 * Using IRQ_RAW on architectures that don't expect it is
> +	 * likely to be wrong.
> +	 */
> +	WARN_ON_ONCE(1);

Per __handle_domain_irq()'s short-circuit evaluation, this is only entered
when the above config is enabled. Perhaps a better place to check for this
would be in __irq_settings_clr_and_set().

> +	return false;
> +}
