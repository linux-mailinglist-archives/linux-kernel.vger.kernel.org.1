Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD22C6B64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgK0SLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbgK0SLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:11:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC5E2224B;
        Fri, 27 Nov 2020 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606500664;
        bh=GOtDwNfIhUq+POtPsrXPeT+zoJQVMxW8Vt07c7R3iMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pGO/WfMdos4kmv6rR2wLucpChqUbbj2mvV1rcjHNkHIpkmgK+KyF4MQxczsZ0eERE
         NMgjEQlH6iju50Pe8cAdycJr+fw+KT1k5QbDeXQq0kwNozYv5qZl3KxSwnajVG0CRw
         A1/CKa8yXMCN6gP6ygBzGpx0vHVaLPrbsGdY364c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kiiCz-00E8DC-Oq; Fri, 27 Nov 2020 18:11:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Nov 2020 18:11:01 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        CC Hwang <cc.hwang@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH v1 1/3] irqchip/gic: enable irq target all
In-Reply-To: <1606486531-25719-2-git-send-email-hanks.chen@mediatek.com>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
 <1606486531-25719-2-git-send-email-hanks.chen@mediatek.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a3bd54fb5fe1c8ea11559d7459710263@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hanks.chen@mediatek.com, tglx@linutronix.de, matthias.bgg@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, cc.hwang@mediatek.com, kuohong.wang@mediatek.com, loda.chou@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-27 14:15, Hanks Chen wrote:
> Support for interrupt distribution design for SMP system solutions.

As far as I know, we have been supporting interrupt distribution on
ARM SMP systems pretty well for the past... what... 15 years?
I'm sure Russell can dig out an ARM926 SMP system that even predates
that.

> With this feature enabled ,the SPI interrupts would be routed to
> all the cores rather than boot core to achieve better
> load balance of interrupt handling.

Please quantify this compared to the current distribution method.

> That is, interrupts might be serviced simultaneously on different CPUs.

They already can. What is new here? Or do you mean the *same* interrupt
being serviced by different CPUs *at the same time*? That'd be fun.

> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> ---
>  drivers/irqchip/Kconfig            |  12 ++++
>  drivers/irqchip/irq-gic-v3.c       | 107 +++++++++++++++++++++--------
>  include/linux/irqchip/arm-gic-v3.h |   1 +
>  kernel/irq/cpuhotplug.c            |  22 ++++++
>  kernel/irq/manage.c                |   7 ++
>  5 files changed, 122 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index c6098eee0c7c..c88ee7731e92 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -597,4 +597,16 @@ config MST_IRQ
>  	help
>  	  Support MStar Interrupt Controller.
> 
> +config ARM_IRQ_TARGET_ALL
> +	bool "Distribute interrupts across processors on SMP system"
> +	depends on SMP && ARM_GIC_V3
> +	help
> +	  Support for interrupt distribution design for
> +	  SMP system solutions. With this feature enabled ,the
> +	  SPI interrupts would be routed to all the cores rather
> +	  than boot cpu to achieve better load balance of interrupt
> +	  handling
> +
> +	  If you don't know what to do here, say N.

There is no way we start introducing conditional compilation for
architectural features. Either this works at all times, or it doesn't
exist.

> +
>  endmenu
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 16fecc0febe8..62a878ce4681 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -381,6 +381,12 @@ static inline bool gic_supports_nmi(void)
>  	       static_branch_likely(&supports_pseudo_nmis);
>  }
> 
> +static inline bool gic_supports_1n(void)
> +{
> +	return (IS_ENABLED(CONFIG_ARM_IRQ_TARGET_ALL) &&
> +		~(readl_relaxed(gic_data.dist_base + GICD_TYPER) & 
> GICD_TYPER_No1N));
> +}
> +
>  static int gic_irq_set_irqchip_state(struct irq_data *d,
>  				     enum irqchip_irq_state which, bool val)
>  {
> @@ -716,6 +722,7 @@ static void __init gic_dist_init(void)
>  {
>  	unsigned int i;
>  	u64 affinity;
> +

Spurious whitespace.

>  	void __iomem *base = gic_data.dist_base;
>  	u32 val;
> 
> @@ -759,16 +766,27 @@ static void __init gic_dist_init(void)
>  	/* Enable distributor with ARE, Group1 */
>  	writel_relaxed(val, base + GICD_CTLR);
> 
> -	/*
> -	 * Set all global interrupts to the boot CPU only. ARE must be
> -	 * enabled.
> -	 */
> -	affinity = 
> gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
> -	for (i = 32; i < GIC_LINE_NR; i++)
> -		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
> +	if (!gic_supports_1n()) {
> +		/*
> +		 * Set all global interrupts to the boot CPU only. ARE must be
> +		 * enabled.
> +		 */
> +		affinity = 
> gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
> +		for (i = 32; i < GIC_LINE_NR; i++)
> +			gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
> 
> -	for (i = 0; i < GIC_ESPI_NR; i++)
> -		gic_write_irouter(affinity, base + GICD_IROUTERnE + i * 8);
> +		for (i = 0; i < GIC_ESPI_NR; i++)
> +			gic_write_irouter(affinity, base + GICD_IROUTERnE + i * 8);
> +	} else {
> +		/* default set target all for all SPI */
> +		for (i = 32; i < GIC_LINE_NR; i++)
> +			gic_write_irouter(GICD_IROUTER_SPI_MODE_ANY,
> +					  base + GICD_IROUTER + i * 8);
> +
> +		for (i = 0; i < GIC_ESPI_NR; i++)
> +			gic_write_irouter(GICD_IROUTER_SPI_MODE_ANY,
> +					  base + GICD_IROUTERnE + i * 8);

Why should we decide to distribute interrupts to all CPUs by default 
when
we don't even know where to route them?

> +	}
>  }
> 
>  static int gic_iterate_rdists(int (*fn)(struct redist_region *, void
> __iomem *))
> @@ -1191,29 +1209,64 @@ static int gic_set_affinity(struct irq_data
> *d, const struct cpumask *mask_val,
>  	if (gic_irq_in_rdist(d))
>  		return -EINVAL;
> 
> -	/* If interrupt was enabled, disable it first */
> -	enabled = gic_peek_irq(d, GICD_ISENABLER);
> -	if (enabled)
> -		gic_mask_irq(d);
> +	if (!gic_supports_1n()) {
> +		/* If interrupt was enabled, disable it first */
> +		enabled = gic_peek_irq(d, GICD_ISENABLER);
> +		if (enabled)
> +			gic_mask_irq(d);
> 
> -	offset = convert_offset_index(d, GICD_IROUTER, &index);
> -	reg = gic_dist_base(d) + offset + (index * 8);
> -	val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
> +		offset = convert_offset_index(d, GICD_IROUTER, &index);
> +		reg = gic_dist_base(d) + offset + (index * 8);
> +		val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
> 
> -	gic_write_irouter(val, reg);
> +		gic_write_irouter(val, reg);
> 
> -	/*
> -	 * If the interrupt was enabled, enabled it again. Otherwise,
> -	 * just wait for the distributor to have digested our changes.
> -	 */
> -	if (enabled)
> -		gic_unmask_irq(d);
> -	else
> -		gic_dist_wait_for_rwp();
> +		/*
> +		 * If the interrupt was enabled, enabled it again. Otherwise,
> +		 * just wait for the distributor to have digested our changes.
> +		 */
> +		if (enabled)
> +			gic_unmask_irq(d);
> +		else
> +			gic_dist_wait_for_rwp();
> +
> +		irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +
> +	} else {
> +		/*
> +		 * no need to update when:
> +		 * input mask is equal to the current setting
> +		 */
> +		if (cpumask_equal(irq_data_get_affinity_mask(d), mask_val))
> +			return IRQ_SET_MASK_OK_NOCOPY;
> +
> +		/* If interrupt was enabled, disable it first */
> +		enabled = gic_peek_irq(d, GICD_ISENABLER);
> +		if (enabled)
> +			gic_mask_irq(d);
> +
> +		offset = convert_offset_index(d, GICD_IROUTER, &index);
> +		reg = gic_dist_base(d) + offset + (index * 8);
> 
> -	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +		/* GICv3 supports target is 1 or all */
> +		if (cpumask_weight(mask_val) > 1)
> +			val = GICD_IROUTER_SPI_MODE_ANY;

There is a massive difference between targeting more than one CPU
and targeting all the CPUs. This breaks all existing drivers and
userspace that need to manage interrupt affinity.

> +		else
> +			val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
> +
> +		gic_write_irouter(val, reg);
> +
> +		/*
> +		 * If the interrupt was enabled, enabled it again. Otherwise,
> +		 * just wait for the distributor to have digested our changes.
> +		 */
> +		if (enabled)
> +			gic_unmask_irq(d);
> +		else
> +			gic_dist_wait_for_rwp();

Why so much code duplication?

> +	}
> 
> -	return IRQ_SET_MASK_OK_DONE;
> +	return IRQ_SET_MASK_OK;
>  }
>  #else
>  #define gic_set_affinity	NULL
> diff --git a/include/linux/irqchip/arm-gic-v3.h
> b/include/linux/irqchip/arm-gic-v3.h
> index f6d092fdb93d..c24336d506a3 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -80,6 +80,7 @@
>  #define GICD_CTLR_ENABLE_SS_G0		(1U << 0)
> 
>  #define GICD_TYPER_RSS			(1U << 26)
> +#define GICD_TYPER_No1N			(1U << 25)
>  #define GICD_TYPER_LPIS			(1U << 17)
>  #define GICD_TYPER_MBIS			(1U << 16)
>  #define GICD_TYPER_ESPI			(1U << 8)
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 02236b13b359..779512e44960 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -87,6 +87,18 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  		return false;
>  	}
> 
> +#ifdef CONFIG_ARM_IRQ_TARGET_ALL

No way.

> +	/*
> +	 * No move required, if interrupt is 1 of N IRQ.
> +	 * write current cpu_online_mask into affinity mask.
> +	 */
> +	if (cpumask_weight(desc->irq_common_data.affinity) > 1) {
> +		cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);

Again, this is totally bogus.

> +
> +		return false;
> +	}
> +#endif
> +
>  	/*
>  	 * Complete an eventually pending irq move cleanup. If this
>  	 * interrupt was moved in hard irq context, then the vectors need
> @@ -191,6 +203,16 @@ static void irq_restore_affinity_of_irq(struct
> irq_desc *desc, unsigned int cpu)
>  	struct irq_data *data = irq_desc_get_irq_data(desc);
>  	const struct cpumask *affinity = irq_data_get_affinity_mask(data);
> 
> +#ifdef CONFIG_ARM_IRQ_TARGET_ALL
> +	/*
> +	 * No restore required, if interrupt is 1 of N IRQ.
> +	 */
> +	if (cpumask_weight(affinity) > 1) {
> +		cpumask_set_cpu(cpu, irq_data_get_affinity_mask(data));
> +		return;
> +	}

Same thing.

> +#endif
> +
>  	if (!irqd_affinity_is_managed(data) || !desc->action ||
>  	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
>  		return;
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c460e0496006..770b97e326bd 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -270,7 +270,14 @@ int irq_do_set_affinity(struct irq_data *data,
> const struct cpumask *mask,
>  	switch (ret) {
>  	case IRQ_SET_MASK_OK:
>  	case IRQ_SET_MASK_OK_DONE:
> +#ifndef CONFIG_ARM_IRQ_TARGET_ALL
>  		cpumask_copy(desc->irq_common_data.affinity, mask);
> +#else
> +		if (cpumask_weight(mask) > 1)
> +			cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);
> +		else
> +			cpumask_copy(desc->irq_common_data.affinity, mask);

And again.

> +#endif
>  		fallthrough;
>  	case IRQ_SET_MASK_OK_NOCOPY:
>  		irq_validate_effective_affinity(data);

To sum it up:

- You claim that the current interrupt distribution model is either non
   functional or inefficient. I expect you to demonstrate this.

- You claim that this brings some kind of improvement: I expect you to
   describe workloads and numbers that demonstrate the improvements.
   1:N distribution has repeatedly shown to have much worse behaviour
   that 1:1 distribution, so I really wonder what's new here.

- You break existing APIs where a driver or userspace can legitimately
   decide to route an interrupt to 2 CPUs out of 256 if it decides to.
   That's not acceptable.

- You pollute the core code with hacks that should never be there. If 
the
   current behaviour is a problem, please state what the problem is.

- You don't factor in the requirements of the pseudo-NMI masking, 
meaning
   the IRI doesn't know about the current PMR and will not be able to
   efficiently dispatch interrupts.

- I don't see anything that configures the participating nodes to the 
1:N
   distribution, meaning it currently works by chance.

- How does it work with CPU hotplug, where we actively move the 
interrupts
   away from a CPU going down? With this scheme, the interrupts keep 
being
   delivered to the wrong CPU, resulting in lost interrupts if they were
   edge triggered.

As it stands, I can't imagine this code making it in the kernel.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
