Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5A2B7B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgKRKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:46:34 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42085 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgKRKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:46:32 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 490921BF209;
        Wed, 18 Nov 2020 10:46:28 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:46:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH v3 4/5] irqchip: ocelot: Add support for Serval platforms
Message-ID: <20201118104628.GC4556@piout.net>
References: <20201116162427.1727851-1-gregory.clement@bootlin.com>
 <20201116162427.1727851-5-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116162427.1727851-5-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 17:24:26+0100, Gregory CLEMENT wrote:
> This patch extends irqchip driver for ocelot to be used with an other
> vcoreiii base platform: Serval.
> 
> Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/irqchip/irq-mscc-ocelot.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
> index 9964800c53c2..584af3b0a9e2 100644
> --- a/drivers/irqchip/irq-mscc-ocelot.c
> +++ b/drivers/irqchip/irq-mscc-ocelot.c
> @@ -44,6 +44,18 @@ static const struct chip_props ocelot_props = {
>  	.n_irq			= 24,
>  };
>  
> +static const struct chip_props serval_props = {
> +	.flags			= FLAGS_HAS_TRIGGER,
> +	.reg_off_sticky		= 0xc,
> +	.reg_off_ena		= 0x14,
> +	.reg_off_ena_clr	= 0x18,
> +	.reg_off_ena_set	= 0x1c,
> +	.reg_off_ident		= 0x20,
> +	.reg_off_trigger	= 0x4,
> +	.reg_off_force		= 0x8,
> +	.n_irq			= 24,
> +};
> +
>  static const struct chip_props luton_props = {
>  	.flags			= FLAGS_NEED_INIT_ENABLE |
>  				  FLAGS_FORCE_LUTON_STYLE,
> @@ -210,6 +222,14 @@ static int __init ocelot_irq_init(struct device_node *node,
>  
>  IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
>  
> +static int __init serval_irq_init(struct device_node *node,
> +				  struct device_node *parent)
> +{
> +	return vcoreiii_irq_init(node, parent, &serval_props);
> +}
> +
> +IRQCHIP_DECLARE(serval_icpu, "mscc,serval-icpu-intr", serval_irq_init);
> +
>  static int __init luton_irq_init(struct device_node *node,
>  				 struct device_node *parent)
>  {
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
