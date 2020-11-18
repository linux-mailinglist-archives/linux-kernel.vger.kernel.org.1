Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363B42B7FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgKRO4J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Nov 2020 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgKRO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:56:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD6DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:56:08 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kfOsN-0002X4-U8; Wed, 18 Nov 2020 15:56:03 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kfOsI-00042j-Hp; Wed, 18 Nov 2020 15:55:58 +0100
Message-ID: <97c6e913bcc1472e2d0f2ff1709e03aefd795d85.camel@pengutronix.de>
Subject: Re: [PATCH] soc: amlogic: replace devm_reset_control_array_get()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yejune Deng <yejune.deng@gmail.com>, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Nov 2020 15:55:58 +0100
In-Reply-To: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
References: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
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

Hi Yejune,

On Wed, 2020-11-18 at 10:48 +0800, Yejune Deng wrote:
> devm_reset_control_array_get_exclusive() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/soc/amlogic/meson-ee-pwrc.c     | 3 +--
>  drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index ed7d2fb..50bf5d2 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -413,8 +413,7 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
>  			dev_warn(&pdev->dev, "Invalid resets count %d for domain %s\n",
>  				 count, dom->desc.name);
>  
> -		dom->rstc = devm_reset_control_array_get(&pdev->dev, false,
> -							 false);
> +		dom->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
>  		if (IS_ERR(dom->rstc))
>  			return PTR_ERR(dom->rstc);
>  	}
> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> index 8790627..b4615b2 100644
> --- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> +++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> @@ -304,7 +304,7 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
>  		return PTR_ERR(regmap_hhi);
>  	}
>  
> -	rstc = devm_reset_control_array_get(&pdev->dev, false, false);
> +	rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
>  	if (IS_ERR(rstc)) {
>  		if (PTR_ERR(rstc) != -EPROBE_DEFER)
>  			dev_err(&pdev->dev, "failed to get reset lines\n");

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
