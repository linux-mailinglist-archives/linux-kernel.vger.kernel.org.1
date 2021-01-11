Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE62F1D17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbhAKRuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388804AbhAKRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:50:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C970C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:49:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kz1Jr-0006fa-0Q; Mon, 11 Jan 2021 18:49:31 +0100
Subject: Re: [PATCH 1/1] ARM: imx: build suspend-imx6.S with arm instruction
 set
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20210111151704.26296-1-max.krummenacher@toradex.com>
 <20210111151704.26296-2-max.krummenacher@toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <ecc65820-6b94-bb11-f475-aa0296fce5b8@pengutronix.de>
Date:   Mon, 11 Jan 2021 18:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210111151704.26296-2-max.krummenacher@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.21 16:17, Max Krummenacher wrote:
> When the kernel is configured to use the Thumb-2 instruction set
> "suspend-to-memory" fails to resume. Observed on a Colibri iMX6ULL
> (i.MX 6ULL) and Apalis iMX6 (i.MX 6Q).
> 
> It looks like the CPU resumes unconditionally in ARM instruction mode
> and then chokes on the presented Thumb-2 code it should execute.
> 
> Fix this by using the arm instruction set for all code in
> suspend-imx6.S.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> ---
> 
>  arch/arm/mach-imx/suspend-imx6.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
> index 1eabf2d2834be..e06f946b75b96 100644
> --- a/arch/arm/mach-imx/suspend-imx6.S
> +++ b/arch/arm/mach-imx/suspend-imx6.S
> @@ -67,6 +67,7 @@
>  #define MX6Q_CCM_CCR	0x0
>  
>  	.align 3
> +	.arm

You had a return to thumb at the end of this subroutine in the cover letter,
yet here it's omitted. Why?

>  
>  	.macro  sync_l2_cache
>  
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
