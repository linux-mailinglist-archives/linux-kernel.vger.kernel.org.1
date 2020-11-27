Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52562C6D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgK0W0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:26:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52884 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbgK0UJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:09:24 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C1A2D1C0BA1; Fri, 27 Nov 2020 21:09:08 +0100 (CET)
Date:   Fri, 27 Nov 2020 21:09:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] arm64: defconfig: Enable Librem 5 hardware
Message-ID: <20201127200908.GA1162@amd>
References: <cover.1606495281.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <cover.1606495281.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series enables components found on Purism's Librem 5
> that are available in mainline.
>=20
> - changes from v1
>   - As per review comments from Krzysztof Kozlowski
>     https://lore.kernel.org/linux-arm-kernel/CAJKOXPdEwiSTg+cMes_wes5oz2F=
1qEexsus6iHenuLs9SAXk6g@mail.gmail.com/
>     - Squash config changes into a single commit
>   - Add touch controller
>=20
> Patches are on top of Shawn's imx/defconfig

Thanks for bringing support for your hardware to the mainline.

Can I ask phone-devel@vger.kernel.org to be cc-ed for phone-related
changes?

How complete is the support?

In particular, what interface do you use to configure audio routing
for the modem?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/BXOMACgkQMOfwapXb+vKMDwCfeVehz/dUwFZ6LGuqAeeai88m
r0cAoKCFrcm01w2lifPIvevCXdBiKEN7
=70XS
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
