Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F52B7FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKRO4G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Nov 2020 09:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgKRO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:56:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:56:05 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kfOsH-0002Vs-7t; Wed, 18 Nov 2020 15:55:57 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kfOsF-00042W-RT; Wed, 18 Nov 2020 15:55:55 +0100
Message-ID: <16613681b429ff814089d8529061b1c906bbb288.camel@pengutronix.de>
Subject: Re: [PATCH] phy: amlogic: replace devm_reset_control_array_get()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yejune Deng <yejune.deng@gmail.com>, kishon@ti.com,
        vkoul@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        lorenzo.pieralisi@arm.com, repk@triplefau.lt
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Wed, 18 Nov 2020 15:55:55 +0100
In-Reply-To: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
References: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
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

On Wed, 2020-11-18 at 10:36 +0800, Yejune Deng wrote:
> devm_reset_control_array_get_exclusive() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/phy/amlogic/phy-meson-axg-pcie.c       | 2 +-
>  drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> index 377ed0d..3204f02 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-pcie.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> @@ -155,7 +155,7 @@ static int phy_axg_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> -	priv->reset = devm_reset_control_array_get(dev, false, false);
> +	priv->reset = devm_reset_control_array_get_exclusive(dev);
>  	if (IS_ERR(priv->reset))
>  		return PTR_ERR(priv->reset);
>  
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> index 08e3227..bab6345 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> @@ -418,7 +418,7 @@ static int phy_g12a_usb3_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_disable_clk_ref;
>  
> -	priv->reset = devm_reset_control_array_get(dev, false, false);
> +	priv->reset = devm_reset_control_array_get_exclusive(dev);
>  	if (IS_ERR(priv->reset))
>  		return PTR_ERR(priv->reset);
>  

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
