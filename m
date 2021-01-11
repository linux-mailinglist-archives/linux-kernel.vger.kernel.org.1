Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2E2F0E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbhAKIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbhAKIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:40:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D44C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:40:17 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kyskJ-0005yL-El; Mon, 11 Jan 2021 09:40:15 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kyskC-0007QZ-NI; Mon, 11 Jan 2021 09:40:08 +0100
Date:   Mon, 11 Jan 2021 09:40:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        kernel@pengutronix.de
Subject: efm32 is dead [Was: Old platforms: bring out your dead]
Message-ID: <20210111084008.thwf7eca5qeb3gmg@pengutronix.de>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="orf7mgrrculzwlck"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--orf7mgrrculzwlck
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> * efm32 -- added in 2011, first Cortex-M, no notable changes after 2013

It was quite fun to work on Cortex-M and cooperate with Energymicro and
ARM. But apart from the nice memorys there is I think little gain in
keeping efm32.

I understood your mail as offer to care for removing? If so, please
go on with efm32. If it helps you I can prepare patches to remove the
platform, too.

Best regards and thanks for you taking care,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--orf7mgrrculzwlck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8DuUACgkQwfwUeK3K
7AlOtgf7BGoOnzzrqbJfHXYJRtwuQwmTvJ03JNiNzuSmCOWPHf4IvZpwACr1hDQY
Dg/j0s6zH2upZPsadbsrsQPCMnhvxTvX7tQvLnK6Mf4qzBFV/5d1Ti0KCN4s5zYK
MyWr4ScqCTk63S2nOg+RnXgNgTxKd3cHRqwMf/dxgvOnxGYjr3rv1knLbIlYIIhD
pUfHx/2F1li04+IU92CB4seWa4MV8j/6Ta5MWigAHcjMTvaYbaV0tNexzwbUTqbc
X4pC48giAC+dUm8v6RMjAH9Pw7f8WddFrmv/rm2bfeV0N90AsRh3iqyGwrYRV0iR
+uS91/n0pRY+u8erhkU7r94s+9uTMg==
=R/ym
-----END PGP SIGNATURE-----

--orf7mgrrculzwlck--
