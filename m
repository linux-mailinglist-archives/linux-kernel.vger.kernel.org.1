Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F090329A7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409148AbgJ0JdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbgJ0JdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:33:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C512224E;
        Tue, 27 Oct 2020 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603791183;
        bh=z5CM28156VEXnHyu1Yja2r3drQA5pjsZ18ZLWjM1vEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dLGUfGuBMR/YH5n22GfjQ93X7kYrSkLIpZiby/SnOVR5a2i8HFOuO5jnuKueouoS1
         stG/FjiW5z2UdszeJaJTa92sialDUlalKvJNu1Jw1pwwBevnvW0+3cik0HB5wBMJNO
         JXrgfhyWVFiWLauTEylgTdpwCRJZtvY/51iIE8PA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kXLLh-004dI0-7g; Tue, 27 Oct 2020 09:33:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Oct 2020 09:33:01 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
In-Reply-To: <20201027044619.41879-1-biwen.li@oss.nxp.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d5d6deb90b4b3d086024fcf01b737da9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: biwen.li@oss.nxp.com, linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 04:46, Biwen Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add an new IRQ chip declaration for LS1043A and LS1088A
> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A. 
> SCFG_INTPCR[31:0]
>   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
>   reverse)
> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

You clearly couldn't be bothered to read what I wrote in my earlier
replies. I'm thus ignoring this series...

> ---
> Change in v2:
> 	- add despcription of bit reverse
> 	- update copyright
> 
>  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-ls-extirq.c 
> b/drivers/irqchip/irq-ls-extirq.c
> index 4d1179fed77c..9587bc2607fc 100644
> --- a/drivers/irqchip/irq-ls-extirq.c
> +++ b/drivers/irqchip/irq-ls-extirq.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> +/*
> + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> + * Copyright 2020 NXP

... specially when you keep attributing someone else's copyright to NXP.

         M.
-- 
Jazz is not dead. It just smells funny...
