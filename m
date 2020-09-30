Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF2127E905
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgI3MzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3MzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:55:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1057C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:55:17 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kNbdW-0000jY-5o; Wed, 30 Sep 2020 14:55:10 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kNbdV-0003uN-JB; Wed, 30 Sep 2020 14:55:09 +0200
Message-ID: <eb0d1aa14e3269f80bc8a92645e9198cbee0c91c.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: prima2: Constify static sirfsoc_rstc_ops
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Barry Song <baohua@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Sep 2020 14:55:09 +0200
In-Reply-To: <20200929201738.349465-1-rikard.falkeborn@gmail.com>
References: <20200929201738.349465-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rikard,

On Tue, 2020-09-29 at 22:17 +0200, Rikard Falkeborn wrote:
> The only usage of sirfsoc_rstc_ops is to assign its address to the ops
> field in the reset_controller_dev struct, which is a const pointer. Make
> it const to allow the compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
>  arch/arm/mach-prima2/rstc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
> index 9d56606ac87f..1ee405e2dde9 100644
> --- a/arch/arm/mach-prima2/rstc.c
> +++ b/arch/arm/mach-prima2/rstc.c
> @@ -53,7 +53,7 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
>  	return 0;
>  }
>  
> -static struct reset_control_ops sirfsoc_rstc_ops = {
> +static const struct reset_control_ops sirfsoc_rstc_ops = {
>  	.reset = sirfsoc_reset_module,
>  };
>  

regards
Philipp
