Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91227E3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgI3Ido (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgI3Idn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:33:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1500206B7;
        Wed, 30 Sep 2020 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601454823;
        bh=gzVLfv8RiLpAzmqXpqrx3KnFJdITD8hmlSt5xS1fWxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tJOr65bbsPhh8hfGB4wO/avqaxBDyU/ewHkYhmuc3DE6XF1QhIg2X4y1d9gutc2uG
         lB66UaJbOefbKGl/gk1ZDr/4XsR17/p3gRgqLf/6JrXAuL/bXW+gr+0ZEzDzIonXrr
         F8v7AXHwGb9jKKiPlkMjuNr6AaHlhTaGEX0g09zo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kNXYS-00G6ve-V8; Wed, 30 Sep 2020 09:33:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Sep 2020 09:33:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip/ti-sci-inta: Add support for unmapped
 event handling
In-Reply-To: <20200930074559.18028-3-peter.ujfalusi@ti.com>
References: <20200930074559.18028-1-peter.ujfalusi@ti.com>
 <20200930074559.18028-3-peter.ujfalusi@ti.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <af9ce252820bab9a21207ef2173da9fd@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peter.ujfalusi@ti.com, nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30 08:45, Peter Ujfalusi wrote:
> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the 
> INTA's
> supervision as unmapped events in AM64.

What does "unmapped event" mean? An event that doesn't require a 
mapping?
Or an internally generated event? Or a proxy event?

> 
> In order to keep the current SW stack working, the INTA driver must 
> replace
> the dev_id with it's own when a request comes for BCDMA or PKTDMA
> resources.

This seems to support my second option. Please clarify what you mean 
exactly.

> 
> Implement parsing of the optional "ti,unmapped-event-sources" phandle 
> array
> to get the sci-dev-ids of the devices where the unmapped events 
> originate.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/irqchip/irq-ti-sci-inta.c | 72 +++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c
> b/drivers/irqchip/irq-ti-sci-inta.c
> index bc863ef7998d..00f5b34863c5 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -85,6 +85,8 @@ struct ti_sci_inta_vint_desc {
>   * @base:		Base address of the memory mapped IO registers
>   * @pdev:		Pointer to platform device.
>   * @ti_sci_id:		TI-SCI device identifier
> + * @difu_cnt:		Number of TI-SCI device identifiers for unmapped events
> + * @dev_ids_for_unmapped: Pointer to an array of TI-SCI device 
> identifiers
>   */
>  struct ti_sci_inta_irq_domain {
>  	const struct ti_sci_handle *sci;
> @@ -96,11 +98,33 @@ struct ti_sci_inta_irq_domain {
>  	void __iomem *base;
>  	struct platform_device *pdev;
>  	u32 ti_sci_id;
> +
> +	int difu_cnt;

I like silly acronyms as much as the next man, but please adopt
sensible names. unmapped_cnt, or something.

> +	u32 *dev_ids_for_unmapped;

unmapped_dev_ids?

>  };
> 
>  #define to_vint_desc(e, i) container_of(e, struct 
> ti_sci_inta_vint_desc, \
>  					events[i])
> 
> +static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta,
> +				  u32 hwirq)
> +{
> +	u16 dev_id = HWIRQ_TO_DEVID(hwirq);
> +	int i;
> +
> +	if (inta->difu_cnt == 0)
> +		return dev_id;
> +
> +	for (i = 0; i < inta->difu_cnt; i++) {
> +		if (dev_id == inta->dev_ids_for_unmapped[i]) {
> +			dev_id = inta->ti_sci_id;

ti_sci_id is a u32, and you are implicitly casting it as u16.
One of the two is wrong.

> +			break;
> +		}
> +	}
> +
> +	return dev_id;
> +}
> +
>  /**
>   * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
>   * @desc:	Pointer to irq_desc corresponding to the irq
> @@ -251,7 +275,7 @@ static struct ti_sci_inta_event_desc
> *ti_sci_inta_alloc_event(struct ti_sci_inta
>  	u16 dev_id, dev_index;
>  	int err;
> 
> -	dev_id = HWIRQ_TO_DEVID(hwirq);
> +	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
>  	dev_index = HWIRQ_TO_IRQID(hwirq);
> 
>  	event_desc = &vint_desc->events[free_bit];
> @@ -352,14 +376,15 @@ static void ti_sci_inta_free_irq(struct
> ti_sci_inta_event_desc *event_desc,
>  {
>  	struct ti_sci_inta_vint_desc *vint_desc;
>  	struct ti_sci_inta_irq_domain *inta;
> +	u16 dev_id;
> 
>  	vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
>  	inta = vint_desc->domain->host_data;
> +	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
>  	/* free event irq */
>  	mutex_lock(&inta->vint_mutex);
>  	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
> -						 HWIRQ_TO_DEVID(hwirq),
> -						 HWIRQ_TO_IRQID(hwirq),
> +						 dev_id, HWIRQ_TO_IRQID(hwirq),
>  						 inta->ti_sci_id,
>  						 vint_desc->vint_id,
>  						 event_desc->global_event,
> @@ -562,7 +587,6 @@ static void 
> ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
>  	arg->desc = desc;
>  	arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
>  }
> -
>  static struct msi_domain_ops ti_sci_inta_msi_ops = {
>  	.set_desc	= ti_sci_inta_msi_set_desc,
>  };
> @@ -574,6 +598,42 @@ static struct msi_domain_info
> ti_sci_inta_msi_domain_info = {
>  	.chip	= &ti_sci_inta_msi_irq_chip,
>  };
> 
> +static int ti_sci_inta_get_unmapped_sources(struct
> ti_sci_inta_irq_domain *inta)
> +{
> +	struct device *dev = &inta->pdev->dev;
> +	struct device_node *node = dev_of_node(dev);
> +	struct of_phandle_iterator it;
> +	int count, err, ret, i;
> +
> +	count = of_count_phandle_with_args(node, "ti,unmapped-event-sources",
> +					   NULL);
> +	if (count <= 0)
> +		return 0;
> +
> +	inta->dev_ids_for_unmapped = devm_kcalloc(dev, count,
> +					sizeof(*inta->dev_ids_for_unmapped),
> +					GFP_KERNEL);
> +	if (!inta->dev_ids_for_unmapped)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources",
> +			    NULL, 0) {
> +		ret = of_property_read_u32(it.node, "ti,sci-dev-id",
> +					   &inta->dev_ids_for_unmapped[i++]);
> +		if (ret) {
> +			dev_err(dev, "ti,sci-dev-id read failure for %s\n",
> +				of_node_full_name(it.node));

Use the printk format specifier instead of of_node_full_name.

> +			of_node_put(it.node);
> +			return ret;
> +		}
> +	}
> +
> +	inta->difu_cnt = count;
> +
> +	return 0;
> +}
> +
>  static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
>  {
>  	struct irq_domain *parent_domain, *domain, *msi_domain;
> @@ -629,6 +689,10 @@ static int ti_sci_inta_irq_domain_probe(struct
> platform_device *pdev)
>  	if (IS_ERR(inta->base))
>  		return PTR_ERR(inta->base);
> 
> +	ret = ti_sci_inta_get_unmapped_sources(inta);
> +	if (ret)
> +		return ret;
> +
>  	domain = irq_domain_add_linear(dev_of_node(dev),
>  				       ti_sci_get_num_resources(inta->vint),
>  				       &ti_sci_inta_irq_domain_ops, inta);

         M.
-- 
Jazz is not dead. It just smells funny...
