Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD092C495F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgKYUxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgKYUxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:53:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1181C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:53:32 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ki1n9-0001YC-FF; Wed, 25 Nov 2020 21:53:31 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ki1n8-0006l7-PP; Wed, 25 Nov 2020 21:53:30 +0100
Date:   Wed, 25 Nov 2020 21:53:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] drivers: make struct device_driver::remove return void
Message-ID: <20201125205328.q6zjoq4k5u4xvipw@pengutronix.de>
References: <20201110150723.1592682-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzeclta7trytqhqz"
Content-Disposition: inline
In-Reply-To: <20201110150723.1592682-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lzeclta7trytqhqz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

On Tue, Nov 10, 2020 at 04:07:23PM +0100, Uwe Kleine-K=F6nig wrote:
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index ecc304149067..ed79a5c657e5 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -295,7 +295,7 @@ static int amba_probe(struct device *dev)
>  	return ret;
>  }
> =20
> -static int amba_remove(struct device *dev)
> +static void amba_remove(struct device *dev)
>  {
>  	struct amba_device *pcdev =3D to_amba_device(dev);
>  	struct amba_driver *drv =3D to_amba_driver(dev->driver);
> @@ -303,6 +303,9 @@ static int amba_remove(struct device *dev)
> =20
>  	pm_runtime_get_sync(dev);
>  	ret =3D drv->remove(pcdev);
> +	if (ret)
> +		dev_info(dev, "Failed to remove (%pe), ignoring\n",
> +			 ERR_PTR(ret));
>  	pm_runtime_put_noidle(dev);
> =20
>  	/* Undo the runtime PM settings in amba_probe() */
> @@ -312,8 +315,6 @@ static int amba_remove(struct device *dev)
> =20
>  	amba_put_disable_pclk(pcdev);
>  	dev_pm_domain_detach(dev, true);
> -
> -	return ret;
>  }
> =20
>  static void amba_shutdown(struct device *dev)
> [...]
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index ee7ba5b5417e..6a3058d4476a 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -107,7 +107,7 @@ struct device_driver {
> =20
>  	int (*probe) (struct device *dev);
>  	void (*sync_state)(struct device *dev);
> -	int (*remove) (struct device *dev);
> +	void (*remove) (struct device *dev);
>  	void (*shutdown) (struct device *dev);
>  	int (*suspend) (struct device *dev, pm_message_t state);
>  	int (*resume) (struct device *dev);

I tried to let coccinelle help me finding functions I need to adapt for
this change, but I failed. (That is, functions that currently return an
int and are used to set (or initialize) the remove callback for a struct
device_driver.) Can you help me here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lzeclta7trytqhqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl++xEUACgkQwfwUeK3K
7Al8Xwf+KodT9uZV8Zd6148pzVHIMn9kO0fAHsxtVQ+wdDDoEQV5qfpO6JNrWeKy
Wv04MrvBRwZ7Chx4VIDjfVYOF4bCJWksPQYF/fYx33gPbCvqFs7Pb8xZyVP+yK9y
rhf9ZIBUh/+TljQQV2+dkl4V1RZl4G4MfWqygV0g0rMhRFJ4CxdUj1A6gUYzyhkY
tGuGF7Q7Wz9mGYkSd0C2Sl+tATWTTHRIqQe+9hBugv+F64D+EotXX2eVau3scft6
YzNgIZGy1QxuKEn4OH9a7B+qiKubZHnDx7yIrmKxE03UE+tJ8sFXnZdwmX79dNIn
fFIW8dOWgec/2DqEFwslpFZ69nltLQ==
=gCyg
-----END PGP SIGNATURE-----

--lzeclta7trytqhqz--
