Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF621BD248
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 04:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD2CcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 22:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2CcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:32:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F8620730;
        Wed, 29 Apr 2020 02:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588127530;
        bh=W8/EyZPYK/miEiqAgzNxrcEQq3GEA2RTZHOJSMhHw38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCbkO5/izw0BXWLaRIUG1HrsPMhgFXEcXH8Pohqne7jNYyiRUTUlVyZlPW3wl+sGv
         3xtV0TcqiyNQqsPIm6u433+WVvpUQX6IE4LbkPyaiOe7lvYPVnAEv+FflIFNSQkG7P
         d6vF5sg58rwM4gPwwwa+RKyDl+82lGfIxXkZnwag=
Date:   Wed, 29 Apr 2020 10:32:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, allison@lohutok.net, info@metux.net,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, git@andred.net,
        abel.vesa@nxp.com, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/4] ARM: imx: cpu: drop dead code
Message-ID: <20200429023201.GJ32592@dragon>
References: <1584004645-26720-1-git-send-email-peng.fan@nxp.com>
 <1584004645-26720-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584004645-26720-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:17:23PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> imx_soc_device_init is only called by i.MX6Q/SL/SX/UL/7D/7ULP.
> So we could drop the switch case for i.MX1/2/3/5 which are dead code
> that never be executed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/cpu.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index 2df649a84697..0302cb66134b 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -108,30 +108,6 @@ static int __init imx_soc_device_init(void)
>  		goto free_soc;
>  
>  	switch (__mxc_cpu_type) {
> -	case MXC_CPU_MX1:
> -		soc_id = "i.MX1";
> -		break;
> -	case MXC_CPU_MX21:
> -		soc_id = "i.MX21";
> -		break;
> -	case MXC_CPU_MX25:
> -		soc_id = "i.MX25";
> -		break;
> -	case MXC_CPU_MX27:
> -		soc_id = "i.MX27";
> -		break;
> -	case MXC_CPU_MX31:
> -		soc_id = "i.MX31";
> -		break;
> -	case MXC_CPU_MX35:
> -		soc_id = "i.MX35";
> -		break;
> -	case MXC_CPU_MX51:
> -		soc_id = "i.MX51";
> -		break;
> -	case MXC_CPU_MX53:
> -		soc_id = "i.MX53";
> -		break;

The code is here to completeness.  If it doesn't get in your way, let's
just keep it.

Shawn

>  	case MXC_CPU_IMX6SL:
>  		ocotp_compat = "fsl,imx6sl-ocotp";
>  		soc_id = "i.MX6SL";
> -- 
> 2.16.4
> 
