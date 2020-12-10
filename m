Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7169E2D5F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbgLJPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390594AbgLJPIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:08:43 -0500
Date:   Thu, 10 Dec 2020 15:07:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607612882;
        bh=KoxOBKWsIg2Wt9l8K5GKIQKzwk5N7dcuEaIEps5LD5c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgclQwK8xnkoZ5Cp6KABImVZgSOO74FBVdF7lcjniKRtgWMDMHJCtE85ifOLeNmZK
         o9bFiEPXXMD6QMSLicBzKLyXvfenbZe8kpwxX1SyddtcRqjGymF2Hbu9FD/di/gvmF
         jd3AgmfXG3jE+BqR+7jI2i2cB/U9pkZOSLWpOJ19JVHBEgZGFUOOkXlPa+RPE8z46a
         07WlCKgK7tSTx0RqSkf/AtlJ7zC6Dhd+LR7UUqhfFDHfW565QjZ11qgBBW2ACfKhVK
         txyge2n4wlMDmHWEWKnXROPpAZA0nuauTEn3fd7t6Rg8/N6qC7hj0kZEvG6XRGoNgU
         q7/8QTPM/oQCg==
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
Message-ID: <20201210150756.GA10381@willie-the-truck>
References: <20201124141449.572446-1-maz@kernel.org>
 <20201124141449.572446-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124141449.572446-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Nov 24, 2020 at 02:14:45PM +0000, Marc Zyngier wrote:
> Some interrupts (such as the rescheduling IPI) rely on not going through
> the irq_enter()/irq_exit() calls. To distinguish such interrupts, add
> a new IRQ flag that allows the low-level handling code to sidestep the
> enter()/exit() calls.
> 
> Only the architecture code is expected to use this. It will do the wrong
> thing on normal interrupts. Note that this is a band-aid until we can
> move to some more correct infrastructure (such as kernel/entry/common.c).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/irq.h   |  2 ++
>  kernel/irq/Kconfig    |  3 +++
>  kernel/irq/debugfs.c  |  1 +
>  kernel/irq/irqdesc.c  | 17 ++++++++++++-----
>  kernel/irq/settings.h | 15 +++++++++++++++
>  5 files changed, 33 insertions(+), 5 deletions(-)

[...]

> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 1a7723604399..f5beee546a6f 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -667,10 +667,9 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned int irq = hwirq;
> +	struct irq_desc *desc;
>  	int ret = 0;
>  
> -	irq_enter();
> -
>  #ifdef CONFIG_IRQ_DOMAIN
>  	if (lookup)
>  		irq = irq_find_mapping(domain, hwirq);
> @@ -680,14 +679,22 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>  	 * Some hardware gives randomly wrong interrupts.  Rather
>  	 * than crashing, do something sensible.
>  	 */
> -	if (unlikely(!irq || irq >= nr_irqs)) {
> +	if (unlikely(!irq || irq >= nr_irqs || !(desc = irq_to_desc(irq)))) {
>  		ack_bad_irq(irq);
>  		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW) &&
> +	    unlikely(irq_settings_is_raw(desc))) {
> +		generic_handle_irq_desc(desc);

Based on tglx's previous comments, I was expecting to see calls to
__irq_{enter,exit}_raw() around this. Are they hiding somewhere else or
are they not needed?

Will
