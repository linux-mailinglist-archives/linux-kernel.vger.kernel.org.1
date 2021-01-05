Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DBC2EA6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbhAEIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbhAEIsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:48:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F8B22525;
        Tue,  5 Jan 2021 08:47:57 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kwi0Q-005OF7-JS; Tue, 05 Jan 2021 08:47:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jan 2021 08:47:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/irq-pruss-intc: implement set_type() callback
In-Reply-To: <20210104183656.333256-1-david@lechnology.com>
References: <20210104183656.333256-1-david@lechnology.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <02075e85faa562e19b3aeccd53635cbc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: david@lechnology.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, s-anna@ti.com, grzegorz.jaszczyk@linaro.org, nsekhar@ti.com, bgolaszewski@baylibre.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-04 18:36, David Lechner wrote:
> This implements the irqchip set_type() callback for the TI PRUSS
> interrupt controller. This is needed for cases where an event needs
> to be active low.
> 
> According to the technical reference manual, the polarity should always
> be set to high, however in practice, the polarity needs to be set low
> for the McASP Tx/Rx system event in conjunction with soft UART PRU
> firmware for TI AM18XX SoCs, otherwise it doesn't work.

I remember asking about this when I reviewed the patch series, and
was told that there was no need to handle anything *but* level high.
As a consequence, the DT binding doesn't have any way to express
the trigger configuration.

Now this? What is going to drive the configuration?

> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/irqchip/irq-pruss-intc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-pruss-intc.c 
> b/drivers/irqchip/irq-pruss-intc.c
> index 5409016e6ca0..f882af8a7ded 100644
> --- a/drivers/irqchip/irq-pruss-intc.c
> +++ b/drivers/irqchip/irq-pruss-intc.c
> @@ -334,6 +334,32 @@ static void pruss_intc_irq_unmask(struct irq_data 
> *data)
>  	pruss_intc_write_reg(intc, PRU_INTC_EISR, hwirq);
>  }
> 
> +static int pruss_intc_irq_set_type(struct irq_data *data, unsigned int 
> type)
> +{
> +	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
> +	u32 reg, bit, val;
> +
> +	if (type & IRQ_TYPE_LEVEL_MASK) {
> +		/* polarity register */
> +		reg = PRU_INTC_SIPR(data->hwirq / 32);
> +		bit = BIT(data->hwirq % 32);
> +		val = pruss_intc_read_reg(intc, reg);
> +
> +		/*
> +		 * This check also ensures that IRQ_TYPE_DEFAULT will result
> +		 * in setting the level to high.
> +		 */
> +		if (type & IRQ_TYPE_LEVEL_HIGH)
> +			val |= bit;
> +		else
> +			val &= ~bit;
> +
> +		pruss_intc_write_reg(intc, reg, val);

RMW  of a shared register without locking?

> +	}
> +
> +	return 0;

What happens when this is passed an edge configuration? It should at
least return an error.

> +}
> +
>  static int pruss_intc_irq_reqres(struct irq_data *data)
>  {
>  	if (!try_module_get(THIS_MODULE))
> @@ -389,6 +415,7 @@ static struct irq_chip pruss_irqchip = {
>  	.irq_ack		= pruss_intc_irq_ack,
>  	.irq_mask		= pruss_intc_irq_mask,
>  	.irq_unmask		= pruss_intc_irq_unmask,
> +	.irq_set_type		= pruss_intc_irq_set_type,
>  	.irq_request_resources	= pruss_intc_irq_reqres,
>  	.irq_release_resources	= pruss_intc_irq_relres,
>  	.irq_get_irqchip_state	= pruss_intc_irq_get_irqchip_state,

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
