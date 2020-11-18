Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6052B7B92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgKRKp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:45:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58495 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgKRKp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:45:27 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 56AB520000A;
        Wed, 18 Nov 2020 10:45:23 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:45:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH v3 3/5] irqchip: ocelot: Add support for Luton platforms
Message-ID: <20201118104522.GB4556@piout.net>
References: <20201116162427.1727851-1-gregory.clement@bootlin.com>
 <20201116162427.1727851-4-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116162427.1727851-4-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/11/2020 17:24:25+0100, Gregory CLEMENT wrote:
>  static void ocelot_irq_unmask(struct irq_data *data)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	struct irq_domain *d = data->domain;
> +	struct chip_props *p = d->host_data;
>  	struct irq_chip_type *ct = irq_data_get_chip_type(data);
>  	unsigned int mask = data->mask;
>  	u32 val;
>  
>  	irq_gc_lock(gc);
> -	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(0)) |
> -	      irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(1));
> -	if (!(val & mask))
> -		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
> +	if (p->flags & FLAGS_HAS_TRIGGER) {
> +		val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 0)) |
> +			irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 1));
> +		if (!(val & mask))
> +			irq_reg_writel(gc, mask, p->reg_off_sticky);
> +	}
>  
>  	*ct->mask_cache &= ~mask;
> -	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
> +	irq_reg_writel(gc, mask, p->reg_off_ena_set);
>  	irq_gc_unlock(gc);
>  }

Looking at that again, I think you should leave this function as is...

>  
> +static void luton_irq_force(struct irq_data *data,
> +			    struct irq_chip_generic *gc,
> +			    struct chip_props *p)
> +{
> +	int off = p->reg_off_force + (data->hwirq * sizeof(u32));
> +	u32 val = irq_reg_readl(gc, off);
> +
> +	irq_reg_writel(gc, val | BIT(3), off);
> +}
> +
> +static int ocelot_irq_force(struct irq_data *data,
> +			    enum irqchip_irq_state which, bool state)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	struct irq_domain *d = data->domain;
> +	struct chip_props *p = d->host_data;
> +	int ret = -EINVAL;
> +
> +	/* Only supports triggering */
> +	if ((which == IRQCHIP_STATE_PENDING ||
> +	     which == IRQCHIP_STATE_ACTIVE) &&
> +	    state && p->reg_off_force) {
> +		if (p->flags & FLAGS_FORCE_LUTON_STYLE)
> +			/* Config register style */
> +			luton_irq_force(data, gc, p);
> +		else
> +			/* New, bitmask style */
> +			irq_reg_writel(gc, data->mask, p->reg_off_force);
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +

I think the addition of the force function may be separated in an
different patch.

> -static int __init ocelot_irq_init(struct device_node *node,
> -				  struct device_node *parent)
> +static int __init vcoreiii_irq_init(struct device_node *node,
> +				    struct device_node *parent,
> +				    const struct chip_props *p)
>  {
>  	struct irq_domain *domain;
>  	struct irq_chip_generic *gc;
>  	int parent_irq, ret;
>  
> +	pr_info("%s: Load, %d irqs\n", node->name, p->n_irq);
> +

Is this necessary?

>  	parent_irq = irq_of_parse_and_map(node, 0);
>  	if (!parent_irq)
>  		return -EINVAL;
>  
> -	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
> +	domain = irq_domain_add_linear(node, p->n_irq,
>  				       &irq_generic_chip_ops, NULL);
>  	if (!domain) {
>  		pr_err("%pOFn: unable to add irq domain\n", node);
>  		return -ENOMEM;
>  	}
>  
> -	ret = irq_alloc_domain_generic_chips(domain, OCELOT_NR_IRQ, 1,
> +	ret = irq_alloc_domain_generic_chips(domain, p->n_irq, 1,
>  					     "icpu", handle_level_irq,
>  					     0, 0, 0);
>  	if (ret) {
> @@ -92,16 +171,23 @@ static int __init ocelot_irq_init(struct device_node *node,
>  		goto err_gc_free;
>  	}
>  
> -	gc->chip_types[0].regs.ack = ICPU_CFG_INTR_INTR_STICKY;
> -	gc->chip_types[0].regs.mask = ICPU_CFG_INTR_INTR_ENA_CLR;
> +	gc->chip_types[0].regs.ack = p->reg_off_sticky;
> +	gc->chip_types[0].regs.mask = p->reg_off_ena_clr;
>  	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
>  	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
>  	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
> +	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;

This is assigned the same member twice.

As said, you can probably leave ocelot_irq_unmask so we avoid having an
if in the hot path.

You should test here for triggers and if they are not available, then
you can use regs.enable/regs.disable and irq_gc_mask_disable_reg and
irq_gc_unmask_enable_reg instead of regs.mask and
irq_gc_mask_set_bit/ocelot_irq_unmask

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
