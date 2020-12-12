Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCC2D8A79
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 23:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408133AbgLLW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 17:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLW7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 17:59:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34F9C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 14:58:20 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koDqC-0000y7-AX; Sat, 12 Dec 2020 23:58:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koDqA-00039f-Jk; Sat, 12 Dec 2020 23:58:14 +0100
Date:   Sat, 12 Dec 2020 23:58:14 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] driver core: platform: don't oops in
 platform_shutdown() on unbound devices
Message-ID: <20201212225814.pg73imvdm2eevw3w@pengutronix.de>
References: <20201212213832.237027-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlgm2d37siqq5rfz"
Content-Disposition: inline
In-Reply-To: <20201212213832.237027-1-dmitry.baryshkov@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlgm2d37siqq5rfz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Sun, Dec 13, 2020 at 12:38:32AM +0300, Dmitry Baryshkov wrote:
> Platform code stopped checking if the device is bound to the actual
> platform driver, thus calling non-existing drv->shutdown(). Verify that
> _dev->driver is not NULL before calling shutdown callback.

I'd write:

	On shutdown the driver core calls the bus' shutdown callback also for
	unbound devices. A driver's shutdown callback however is only called for
	devices bound to this driver. Commit 9c30921fe799 ("driver core:
	platform: use bus_type functions") changed the platform bus from driver
	callbacks to bus callbacks, so the shutdown function must be prepared to
	be called without a driver. Add the corresponding check in the
	shutdown function.

With that adding the backtrace isn't necessary (and the patch is fine).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qlgm2d37siqq5rfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/VSwMACgkQwfwUeK3K
7AmL+Af+Kt4G3f6WdUMguwk1HfuKTUs0kfdJ3hHRf54vNyO+MitUddUK2sfyw6ns
FbAEgf+30lK5EVFoYcQtwxXweEZQa7sGREPWyzTkkz6HPyiDorC+C0iDJ6MtQQDs
St8crw/DDhUohd/DKP3NF9nKRZZj47/ehFHakotMz9ljrdJjCcanDtV2zWTMBOSR
7zp0MCuyIiHy2LSzJsyxfpyk0JcJY1gu1/OVyXK7kJFcDuRgO4A2zmY8Aed8UIif
5SrdsQ2H+HnGqqQYr9T96zTYUjOea9LbSpkhLGrc8wcIyN5CW07n02fC8kEpUVrE
CiEs0ap5b5kMYK1vOoU1rSbHQWsFDw==
=/HEc
-----END PGP SIGNATURE-----

--qlgm2d37siqq5rfz--
