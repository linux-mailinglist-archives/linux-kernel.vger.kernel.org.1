Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51452C7FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgK3IVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3IVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:21:02 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38EEE20719;
        Mon, 30 Nov 2020 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606724421;
        bh=zcO96qtwubsSF8tB+hhDMt+At4k19t+kqouww3vPuE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pj01KIS0LUbgJwVKCBh81A6equxHcvYnAKUflGYw2ytrPzzJvRcDX0VagP6AXHGyy
         hApIBQhIefQWNTcOkS9BP8j5/pP2+UFy6jfCCaW0ft3Nya2CIQMDqjz/0vd+AFyzx8
         laDHmu6R6+BMECqR7zki2TCfsep4eiKSiSfNx8pM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjePz-00EcjO-0n; Mon, 30 Nov 2020 08:20:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 08:20:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [v3 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
In-Reply-To: <20201130033055.38462-1-biwen.li@oss.nxp.com>
References: <20201130033055.38462-1-biwen.li@oss.nxp.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1271261ba2ad021041e0ba331c96a2d7@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: biwen.li@oss.nxp.com, linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[- jason]

On 2020-11-30 03:30, Biwen Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add an new IRQ chip declaration for LS1043A and LS1088A
> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v3:
> 	- cleanup code
> 	- remove robust copyright
> 
> Change in v2:
> 	- add despcription of bit reverse
> 	- update copyright
> 
>  drivers/irqchip/irq-ls-extirq.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ls-extirq.c 
> b/drivers/irqchip/irq-ls-extirq.c
> index 4d1179fed77c..47804ce78b21 100644
> --- a/drivers/irqchip/irq-ls-extirq.c
> +++ b/drivers/irqchip/irq-ls-extirq.c
> @@ -18,7 +18,7 @@
>  struct ls_extirq_data {
>  	struct regmap		*syscon;
>  	u32			intpcr;
> -	bool			bit_reverse;
> +	bool			is_ls1021a_or_ls1043a;
>  	u32			nirq;
>  	struct irq_fwspec	map[MAXIRQ];
>  };
> @@ -30,7 +30,7 @@ ls_extirq_set_type(struct irq_data *data, unsigned 
> int type)
>  	irq_hw_number_t hwirq = data->hwirq;
>  	u32 value, mask;
> 
> -	if (priv->bit_reverse)
> +	if (priv->is_ls1021a_or_ls1043a)
>  		mask = 1U << (31 - hwirq);
>  	else
>  		mask = 1U << hwirq;
> @@ -174,14 +174,9 @@ ls_extirq_of_init(struct device_node *node,
> struct device_node *parent)
>  	if (ret)
>  		goto out;
> 
> -	if (of_device_is_compatible(node, "fsl,ls1021a-extirq")) {
> -		u32 revcr;
> -
> -		ret = regmap_read(priv->syscon, LS1021A_SCFGREVCR, &revcr);
> -		if (ret)
> -			goto out;
> -		priv->bit_reverse = (revcr != 0);
> -	}

This isn't explained in the commit message. You are changing the way
you infer some properties, and that's not innocent. Please describe
all important changes in the commit message.

> +	if (of_device_is_compatible(node, "fsl,ls1021a-extirq") || \

Spurious trailing \?

> +	    of_device_is_compatible(node, "fsl,ls1043a-extirq"))
> +		priv->is_ls1021a_or_ls1043a = true;

Which is better written as:

         priv->is_ls1021a_or_ls1043a = (of_device_is_compatible(node, 
"fsl,ls1021a-extirq") ||
                                        of_device_is_compatible(node, 
"fsl,ls1043a-extirq"));
> 
>  	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
>  					  &extirq_domain_ops, priv);
> @@ -195,3 +190,5 @@ ls_extirq_of_init(struct device_node *node, struct
> device_node *parent)
>  }
> 
>  IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", 
> ls_extirq_of_init);
> +IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", 
> ls_extirq_of_init);
> +IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", 
> ls_extirq_of_init);

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
