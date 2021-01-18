Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E1D2F9B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbhARINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbhARINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:13:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B98C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:12:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1PeX-0002bZ-Bf; Mon, 18 Jan 2021 09:12:45 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1PeV-0006w5-Cb; Mon, 18 Jan 2021 09:12:43 +0100
Date:   Mon, 18 Jan 2021 09:12:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org, Bruno Thomsen <bth@kamstrup.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-flex-concentrator: fix pcf2127 reset
Message-ID: <20210118081237.mgcxyob42hv5hdnp@pengutronix.de>
References: <20210111151537.12530-1-bruno.thomsen@gmail.com>
 <20210118063252.GJ28365@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tehix5zhhrl3q6mw"
Content-Disposition: inline
In-Reply-To: <20210118063252.GJ28365@dragon>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tehix5zhhrl3q6mw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:32:53PM +0800, Shawn Guo wrote:
> On Mon, Jan 11, 2021 at 04:15:37PM +0100, Bruno Thomsen wrote:
> > RTC pcf2127 device driver has changed default behaviour of the watchdog
> > feature in v5.11-rc1. Now you need to explicitly enable it with a
> > device tree property, "reset-source", when used in the board design.
>=20
> It sound that the existing DTBs are broken by this default behaviour
> change?

I didn't do a representative research, but I expect that there are only
very few machines that have a working watchdog setup using the pcf2127.
All other machines were surprised by commit

	0e735eaae165 ("rtc: pcf2127: add watchdog feature support")

because they suddenly had a non-functional watchdog device. The
alternative would be to "fix" the device trees of all these machines to
restore pre-v5.4-rc1 behaviour. This is IMHO worse.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tehix5zhhrl3q6mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAFQukACgkQwfwUeK3K
7Am55gf+Ovx9hJP0bLpt4Sc5iOSaKU/x3Jo40vV0amY/uvZkHTPJEbRb5R7sweFC
mXjK0WkkLhLKJZJHSmiz2AC4iu3Hf/Q96IjQ8XxmsSHdszv4Kit3ALwFSRNB3b5q
2xzq1t1MNYchIH2hHoBRx/RZR0t6+0JwJhHfldsC1kce8mFp6upg3bsNlesM1HmT
hWARzMC1ev4JiRj9NkVQLy0NZWOrgZD6Tr/PARigv25vKA6i7xUdxwlekJQkFmrf
8Scvj8/yFfPczgFhOwMTIMqai0cJVvMEbpVq/wqftAh+OLqA3z0uPKaUQ4toXto0
SPAEZZUqJ5pZhsEh7yPoZhjrzElWaw==
=bunu
-----END PGP SIGNATURE-----

--tehix5zhhrl3q6mw--
