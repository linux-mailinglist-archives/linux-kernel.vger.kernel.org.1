Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C012AA5A9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgKGOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:01:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7475CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 06:01:44 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kbOmg-0005WW-4R; Sat, 07 Nov 2020 15:01:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kbOmZ-00062N-4x; Sat, 07 Nov 2020 15:01:31 +0100
Date:   Sat, 7 Nov 2020 15:01:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] tty/serial: delete break after return
Message-ID: <20201107140129.kpfhanzjidvdg662@pengutronix.de>
References: <20201107032924.25044-1-bernard@vivo.com>
 <20201107032924.25044-2-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2yx3n4pwj2ycubx"
Content-Disposition: inline
In-Reply-To: <20201107032924.25044-2-bernard@vivo.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r2yx3n4pwj2ycubx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the Subject is wrong, it should use a prefix similar to "serial: imx:".
It's a good idea to check previous patches to the same file to pick a
suitable prefix. (E.g. git log --oneline drivers/tty/serial/imx.c)

On Fri, Nov 06, 2020 at 07:29:23PM -0800, Bernard Zhao wrote:
> Delete break after return, which will never run.
>=20
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/tty/serial/imx.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1731d9728865..09703079db7b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32=
 offset)
>  	switch (offset) {
>  	case UCR1:
>  		return sport->ucr1;
> -		break;
>  	case UCR2:
>  		/*
>  		 * UCR2_SRST is the only bit in the cached registers that might
> @@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u=
32 offset)
>  		if (!(sport->ucr2 & UCR2_SRST))
>  			sport->ucr2 =3D readl(sport->port.membase + offset);
>  		return sport->ucr2;
> -		break;
>  	case UCR3:
>  		return sport->ucr3;
> -		break;
>  	case UCR4:
>  		return sport->ucr4;
> -		break;
>  	case UFCR:
>  		return sport->ufcr;
> -		break;

you're the third to send this patch since October 20:

	https://lore.kernel.org/r/20201026125142.21105-1-zhangqilong3@huawei.com
	https://lore.kernel.org/r/20201020130709.28096-1-trix@redhat.com

My comment for these was:

> this might be subjective, but I like the break being there for clearity.
> So I object to make a patch to remove them. In case I'm outvoted I'd at
> least want empty lines instead.

Zhang Qilong wrote he found the patch opportunity by manual code
inspection, I would have expected that there is a tool that identifies a
break after a return. If you had tool support, please mention the tool
in the commit log (if you really want to keep following the patch's
idea).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r2yx3n4pwj2ycubx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+mqLYACgkQwfwUeK3K
7AnNIgf/UHJ/DjPejB9zw25GzZ7IQLzdHiG9HlQ4ktJl4T6EJefgi94VOYy2OZJK
Ca43/iMM8sYu4EpLg66ySRwjE0kfidPTmc3itd2uwl8En+i4+NgpsTAQkpddc+n9
nosMbe2O/qaVx2vX/m4MXngw0erQ+5BECiaFAPdBGeuAph9HdYp9y+M5zw6ew5wp
hyyyr/KyBaVvZo8sSz8pyL60hVdlflINzOt5A0pAFzDH1DQ3Om7mZDEQvKwtpkTh
+Vyg9rmsw4FIqgQXsZWtOZcOfcaC946pn9/hiCu5KYn+DSBcDRNZ2AYAR3CmT46S
uhvUEP0qqS7qN7pgi8lCHA+M5ANTrw==
=xZYO
-----END PGP SIGNATURE-----

--r2yx3n4pwj2ycubx--
