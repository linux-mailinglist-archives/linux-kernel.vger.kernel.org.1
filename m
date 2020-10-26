Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322442988B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771175AbgJZIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771047AbgJZIoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:44:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 322C9223B0;
        Mon, 26 Oct 2020 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603701853;
        bh=yl4Jr0apm2y5t/1h4vG0U+9RG0/DEtSNGs1mZ7dsnrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ykfuwBzfYzwDxngBERNMABnYWx9PZ0Wt3f61944YqpUGcWrDtnSnHqzuhfbRIhU/o
         dIB56qXPfukNKFctZTx4Z9U7iJm7xIrZXMxkgeFQZDAM4qLYCoaWPj59gikFDMyRlg
         JDw750Ok1Udzgac7NXkmkHJOcm1TI2nU60E85yvg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kWy6s-004Gna-UZ; Mon, 26 Oct 2020 08:44:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 08:44:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
In-Reply-To: <20201026080127.40499-1-biwen.li@oss.nxp.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <31d8971374c261003aee9f4807c8ac8c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: biwen.li@oss.nxp.com, shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 08:01, Biwen Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add an new IRQ chip declaration for LS1043A and LS1088A
> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA

Three things:
- This commit message doesn't describe the bit_reverse change
- Please add a cover letter
- Sending the same series again after 4 days is not OK, specially when
   the initial one was during the merge window.

Thanks,

         M.

> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  drivers/irqchip/irq-ls-extirq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-ls-extirq.c 
> b/drivers/irqchip/irq-ls-extirq.c
> index 4d1179fed77c..564e6de0bd8e 100644
> --- a/drivers/irqchip/irq-ls-extirq.c
> +++ b/drivers/irqchip/irq-ls-extirq.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +// Copyright 2019-2020 NXP
> 
>  #define pr_fmt(fmt) "irq-ls-extirq: " fmt
> 
> @@ -183,6 +184,9 @@ ls_extirq_of_init(struct device_node *node, struct
> device_node *parent)
>  		priv->bit_reverse = (revcr != 0);
>  	}
> 
> +	if (of_device_is_compatible(node, "fsl,ls1043a-extirq"))
> +		priv->bit_reverse = true;
> +
>  	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
>  					  &extirq_domain_ops, priv);
>  	if (!domain)
> @@ -195,3 +199,5 @@ ls_extirq_of_init(struct device_node *node, struct
> device_node *parent)
>  }
> 
>  IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", 
> ls_extirq_of_init);
> +IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", 
> ls_extirq_of_init);
> +IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", 
> ls_extirq_of_init);

-- 
Jazz is not dead. It just smells funny...
