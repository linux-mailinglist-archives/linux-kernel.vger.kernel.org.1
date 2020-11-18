Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85FD2B7B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgKRKqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:46:44 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34909 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgKRKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:46:44 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 75E2B1BF212;
        Wed, 18 Nov 2020 10:46:41 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:46:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH v3 5/5] irqchip: ocelot: Add support for Jaguar2 platforms
Message-ID: <20201118104641.GD4556@piout.net>
References: <20201116162427.1727851-1-gregory.clement@bootlin.com>
 <20201116162427.1727851-6-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116162427.1727851-6-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 17:24:27+0100, Gregory CLEMENT wrote:
> This patch extends irqchip driver for ocelot to be used with an other
> vcoreiii base platform: Jaguar2.
> 
> Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/irqchip/irq-mscc-ocelot.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
> index 584af3b0a9e2..0dfea8771172 100644
> --- a/drivers/irqchip/irq-mscc-ocelot.c
> +++ b/drivers/irqchip/irq-mscc-ocelot.c
> @@ -70,6 +70,18 @@ static const struct chip_props luton_props = {
>  	.n_irq			= 28,
>  };
>  
> +static const struct chip_props jaguar2_props = {
> +	.flags			= FLAGS_HAS_TRIGGER,
> +	.reg_off_sticky		= 0x10,
> +	.reg_off_ena		= 0x18,
> +	.reg_off_ena_clr	= 0x1c,
> +	.reg_off_ena_set	= 0x20,
> +	.reg_off_ident		= 0x38,
> +	.reg_off_trigger	= 0x5c,
> +	.reg_off_force		= 0xc,
> +	.n_irq			= 29,
> +};
> +
>  static void ocelot_irq_unmask(struct irq_data *data)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> @@ -237,3 +249,11 @@ static int __init luton_irq_init(struct device_node *node,
>  }
>  
>  IRQCHIP_DECLARE(luton_icpu, "mscc,luton-icpu-intr", luton_irq_init);
> +
> +static int __init jaguar2_irq_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	return vcoreiii_irq_init(node, parent, &jaguar2_props);
> +}
> +
> +IRQCHIP_DECLARE(jaguar2_icpu, "mscc,jaguar2-icpu-intr", jaguar2_irq_init);
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
