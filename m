Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8732D8CA3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 11:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394317AbgLMKaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 05:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgLMKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 05:30:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16B1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 02:29:29 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koOd0-0000re-Qj; Sun, 13 Dec 2020 11:29:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koOcz-0000Yt-5x; Sun, 13 Dec 2020 11:29:21 +0100
Date:   Sun, 13 Dec 2020 11:29:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] driver core: platform: don't oops in
 platform_shutdown() on unbound devices
Message-ID: <20201213102918.lpvhzbqwae63nns4@pengutronix.de>
References: <20201212235533.247537-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pn44pw7wy433nbaj"
Content-Disposition: inline
In-Reply-To: <20201212235533.247537-1-dmitry.baryshkov@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pn44pw7wy433nbaj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 13, 2020 at 02:55:33AM +0300, Dmitry Baryshkov wrote:
> On shutdown the driver core calls the bus' shutdown callback also for
> unbound devices. A driver's shutdown callback however is only called for
> devices bound to this driver. Commit 9c30921fe799 ("driver core:
> platform: use bus_type functions") changed the platform bus from driver
> callbacks to bus callbacks, so the shutdown function must be prepared to
> be called without a driver. Add the corresponding check in the shutdown
> function.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")

nice commit log :-)

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pn44pw7wy433nbaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/V7PsACgkQwfwUeK3K
7AkzbggAoEJb4JKgVNlAmCumDDV2R4Be0oj8KRrGg7Wew75+cL/6MEFauis6hmMo
WnnLrP3ZPgTndI2g6vsQef2PuVVJS6M+5UQUatONp7KzW0w7o6wZWiQBPcvIfnyX
qPNvfP1hdVguXpsZpveqLGioufrceR9xbxmHBkAtsZppDcEiPTh8L039qRisNdTg
IiQz9KqeucFCAA4EglsCEeWtbaRww0WiQ+5NcZjy/rnniyA/GyauvUUxJJHPZr1Y
bKVH6q/cG1aL3xB0fdEH4X5w29Tay6jZEzqq7X/Jy/5kBn9K3gqz3GYIQ86SwtUt
3vvfmszT4QaxKXJBXU1jkkaj1QXzJA==
=fbDd
-----END PGP SIGNATURE-----

--pn44pw7wy433nbaj--
