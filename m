Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD21A524E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgDKNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 09:14:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43580 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 09:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586610838; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1XJAdmDRDfqEilvxXKzunudTz10S0nZa0ndDzJpqLQ=;
        b=o5AAeoYCxjcUgoubZAgGynGkQoEo4xH3nJfqaQhPD8wOobcerMgZlzDZhVxT5SBPkBEkdh
        IDjWmJyjPMZBih9yw4xGt8f633BcyQ99H/lP7TUMx4DM7/yJawjKPz2Q0a+Y8MX4sSgt91
        xoBwQv8wGYgxUqu33dn+XGhSsb/FQtk=
Date:   Sat, 11 Apr 2020 15:13:47 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: phy: jz4770: Add a missing '\n' in a log message
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Message-Id: <ZQKM8Q.561QQF8CXZTU3@crapouillou.net>
In-Reply-To: <20200411063811.6767-1-christophe.jaillet@wanadoo.fr>
References: <20200411063811.6767-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Le sam. 11 avril 2020 =E0 8:38, Christophe JAILLET=20
<christophe.jaillet@wanadoo.fr> a =E9crit :
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Is that so?

 From what I could see these macros add the \n themselves if needed. So=20
the \n were omitted on purpose.

-Paul

> Fixes: 541368b46b82 ("usb: phy: Add driver for the Ingenic JZ4770 USB=20
> transceiver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/phy/phy-jz4770.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/phy/phy-jz4770.c=20
> b/drivers/usb/phy/phy-jz4770.c
> index 3ea1f5b9bcf8..8f62dc2a90ff 100644
> --- a/drivers/usb/phy/phy-jz4770.c
> +++ b/drivers/usb/phy/phy-jz4770.c
> @@ -125,13 +125,13 @@ static int jz4770_phy_init(struct usb_phy *phy)
>=20
>  	err =3D regulator_enable(priv->vcc_supply);
>  	if (err) {
> -		dev_err(priv->dev, "Unable to enable VCC: %d", err);
> +		dev_err(priv->dev, "Unable to enable VCC: %d\n", err);
>  		return err;
>  	}
>=20
>  	err =3D clk_prepare_enable(priv->clk);
>  	if (err) {
> -		dev_err(priv->dev, "Unable to start clock: %d", err);
> +		dev_err(priv->dev, "Unable to start clock: %d\n", err);
>  		return err;
>  	}
>=20
> @@ -191,7 +191,7 @@ static int jz4770_phy_probe(struct=20
> platform_device *pdev)
>=20
>  	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base)) {
> -		dev_err(dev, "Failed to map registers");
> +		dev_err(dev, "Failed to map registers\n");
>  		return PTR_ERR(priv->base);
>  	}
>=20
> @@ -199,7 +199,7 @@ static int jz4770_phy_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(priv->clk)) {
>  		err =3D PTR_ERR(priv->clk);
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get clock");
> +			dev_err(dev, "Failed to get clock\n");
>  		return err;
>  	}
>=20
> @@ -207,14 +207,14 @@ static int jz4770_phy_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(priv->vcc_supply)) {
>  		err =3D PTR_ERR(priv->vcc_supply);
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "failed to get regulator");
> +			dev_err(dev, "Failed to get regulator\n");
>  		return err;
>  	}
>=20
>  	err =3D usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
>  	if (err) {
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "Unable to register PHY");
> +			dev_err(dev, "Unable to register PHY\n");
>  		return err;
>  	}
>=20
> --
> 2.20.1
>=20


