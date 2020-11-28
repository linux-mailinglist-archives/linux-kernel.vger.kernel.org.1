Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65752C7150
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbgK1V41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:57260 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbgK1U7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:59:36 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AC57E1C0B7C; Sat, 28 Nov 2020 21:58:48 +0100 (CET)
Date:   Sat, 28 Nov 2020 21:58:48 +0100
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
Message-ID: <20201128205848.GA20920@duo.ucw.cz>
References: <cover.1606495281.git.agx@sigxcpu.org>
 <20201127200908.GA1162@amd>
 <20201128191019.GB6719@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20201128191019.GB6719@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This series enables components found on Purism's Librem 5
> > > that are available in mainline.
> > >=20
> > > - changes from v1
> > >   - As per review comments from Krzysztof Kozlowski
> > >     https://lore.kernel.org/linux-arm-kernel/CAJKOXPdEwiSTg+cMes_wes5=
oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com/
> > >     - Squash config changes into a single commit
> > >   - Add touch controller
> > >=20
> > > Patches are on top of Shawn's imx/defconfig
> >=20
> > Thanks for bringing support for your hardware to the mainline.
> >=20
> > Can I ask phone-devel@vger.kernel.org to be cc-ed for phone-related
> > changes?
>=20
> Good point. Done with v3.
>=20
> > How complete is the support?
>=20
> The components enabled should work in 5.11 (there's some LCD/DSI patches
> in flight (that's why i did not send the corresponding DT addition yet)
> and we need to submit a DT for Evergreen (imx8mq-librem5r4).
>=20
> https://git.sigxcpu.org/cgit/talks/2020-debconf-mobile/plain/talk.pdf
>=20
> is a bit outdated but has some numbers starting on page 24.

Thanks for pointer :-).

> > In particular, what interface do you use to configure audio routing
> > for the modem?
>=20
> https://salsa.debian.org/DebianOnMobile-team/callaudiod manages
> > that.

Does kernel provide mixer interface for callaudiod to do its job?

Best regards,

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8K6CAAKCRAw5/Bqldv6
8rj4AJ9trJ07IZ4duCyAEdCRtbayxfyDJACffnsSErrluQ5lsGQKRSxKv4+v1yQ=
=91qG
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
