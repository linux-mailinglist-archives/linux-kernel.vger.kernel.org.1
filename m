Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507912DEB9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 23:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgLRW3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:29:43 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52082 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgLRW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:29:43 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 708001C0B7D; Fri, 18 Dec 2020 23:29:00 +0100 (CET)
Date:   Fri, 18 Dec 2020 23:29:00 +0100
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
Message-ID: <20201218222900.GA16661@duo.ucw.cz>
References: <cover.1606495281.git.agx@sigxcpu.org>
 <20201127200908.GA1162@amd>
 <20201128191019.GB6719@bogon.m.sigxcpu.org>
 <20201128205848.GA20920@duo.ucw.cz>
 <20201129114609.GA3242@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20201129114609.GA3242@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > Patches are on top of Shawn's imx/defconfig
> > > >=20
> > > > Thanks for bringing support for your hardware to the mainline.
> > > >=20
> > > > Can I ask phone-devel@vger.kernel.org to be cc-ed for phone-related
> > > > changes?
> > >=20
> > > Good point. Done with v3.
> > >=20
> > > > How complete is the support?
> > >=20
> > > The components enabled should work in 5.11 (there's some LCD/DSI patc=
hes
> > > in flight (that's why i did not send the corresponding DT addition ye=
t)
> > > and we need to submit a DT for Evergreen (imx8mq-librem5r4).
> > >=20
> > > https://git.sigxcpu.org/cgit/talks/2020-debconf-mobile/plain/talk.pdf
> > >=20
> > > is a bit outdated but has some numbers starting on page 24.
> >=20
> > Thanks for pointer :-).
> >=20
> > > > In particular, what interface do you use to configure audio routing
> > > > for the modem?
> > >=20
> > > https://salsa.debian.org/DebianOnMobile-team/callaudiod manages
> > > > that.
> >=20
> > Does kernel provide mixer interface for callaudiod to do its job?
>=20
> callaudiod handles selecting e.g. earpiece vs. speaker by selecting the
> right pulseaudio ports (it's invoked by calls (the phone call handling
> application via DBus) and only relies on the codec being an alsa
> device and hence handled by pulseaudio/alsa-ucm.
>=20
> Wys (https://source.puri.sm/Librem5/wys) manages the routing between the
> modem and codec by listening to ModemManager's state and connecting audio
> source and sink (again solely via pulsaudio so again just relying on
> modem and codec being alsa devices). Since the modem is not part of the
> SoC on the Librem 5 it's a completely separate device.

Aha, yep, sorry -- I forgot. I was hoping to copy solution for Librem
5 to Droid 4, but that won't work, as Droid 4 is doing audio in
hardware, while Librem does it in wys.

Best regards,

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX90tLAAKCRAw5/Bqldv6
8slvAJ96rMENwzWOxe2ZenVTUyv/Ju/fyACggUCjpeRob6iSrb5SmtRP4SF9sew=
=hB1m
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
