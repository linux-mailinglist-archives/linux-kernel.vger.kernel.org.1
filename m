Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6A1E9008
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgE3J1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 05:27:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56670 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgE3J1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:27:00 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 69F3B1C0C0E; Sat, 30 May 2020 00:52:17 +0200 (CEST)
Date:   Sat, 30 May 2020 00:52:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>, Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Message-ID: <20200529225217.GA23601@duo.ucw.cz>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
 <20200424093226.GB2647@amd>
 <20200424124423.jo25ai5oifvalgpr@earth.universe>
 <20200529140555.ozlvz4egihkvo3aw@earth.universe>
 <20200529160204.GA6025@duo.ucw.cz>
 <20200529180306.pjevb6qdv7jvmxtu@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20200529180306.pjevb6qdv7jvmxtu@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Fri, May 29, 2020 at 06:02:04PM +0200, Pavel Machek wrote:
> > > ping?
> >=20
> > Well, I thought that we maybe do not need standard LEDs on medical hard=
ware.
>=20
> The discussion died and the patch was not applied :) In general
> IDK how worthwhile it is to use standard LED names for them. I
> suppose the number of people planning to create something like
> OpenWRT for medical devices is not so big.

:-)

> > > > The device is a medical patient monitor and these are alarm LEDs
> > > > informing about critical device or patient status. They are
> > > > referenced by their color (those are discrete LEDs, not a
> > > > multi-color one) basically everywhere. The only exception is
> > > > "silenced", which means that audible alarm is surpressed. I
> > > > don't think we have something comparable for any of those LEDs
> > > > in the mainline tree.
> >=20
> > Actually, we have "platform:*:mute" LEDs, that could be used for
> > "silenced".
>=20
> I see you point, but wonder if mute is the right choice. The LED
> signals a silenced alarm, which IMHO is not the same:
>=20
> * The alarm silencing is temporary and system unsilences after
>   1-2 minutes.
> * LED is usually blinking instead of solid like a laptop mute LED
>   (so that operator is aware of silenced alarm)
> * Device usually cannot be put into silenced mode before the alarm
>   appears
> * Some medical devices still generate perodic beeps
>=20
> AFAIK this is named alarm silencing by basically everyone for
> medical devices. So I think naming this platfrom:*:mute would
> increase the mess.

Ok, I guess it does not matter much. Generally no two LEDs behave
exactly the same, and I'd believe this would be close enough, but
=2E.. it really does not matter.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtGSIQAKCRAw5/Bqldv6
8t7PAJ9ow6Q+gMjdqrdDFtfPSloIuwM0NgCfVMVP20+FwwaIKnq0iwnn6/DdIDM=
=BaAq
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
