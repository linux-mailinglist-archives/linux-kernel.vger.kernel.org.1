Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59F72A30AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKBQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:59:37 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:56576 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgKBQ7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:59:37 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 52FC5C013D;
        Mon,  2 Nov 2020 17:59:35 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 5F88FC1DD2; Mon,  2 Nov 2020 17:59:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id A4BB9C1DCD;
        Mon,  2 Nov 2020 17:59:22 +0100 (CET)
Date:   Mon, 2 Nov 2020 17:59:22 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 6/9] ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
Message-ID: <20201102165922.GB2037@collins>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-7-contact@paulk.fr>
 <20201102101211.wtkmgfm2rcm5gdyp@gilmour.lan>
 <20201102102522.GB11809@aptenodytes>
 <20201102134418.vn7i3e4gpwomxcnj@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20201102134418.vn7i3e4gpwomxcnj@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 02 Nov 20, 14:44, Maxime Ripard wrote:
> On Mon, Nov 02, 2020 at 11:25:22AM +0100, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Mon 02 Nov 20, 11:12, Maxime Ripard wrote:
> > > On Sat, Oct 31, 2020 at 07:21:34PM +0100, Paul Kocialkowski wrote:
> > > > The V3s/V3 has a NMI interrupt controller, mainly used for the AXP2=
09.
> > > > Its address follows the sytsem controller block, which was previous=
ly
> > > > incorrectly described as spanning over 0x1000 address bytes.
> > >=20
> > > Is it after, or right in the middle of it?
> >=20
> > That's up for interpretation actually:
> > - The V3 datasheet mentions that System Control is 0x01C00000 --- 0x01C=
00FFF;
> > - In practice, sunxi_sram.c uses a regmap with max_reg set to 0x30 for =
the
> >   V3s/H3 so this gives us some room.
> >=20
> > Looking at other SoCs with the same setup (take sun8i-r40 for instance),
> > system-control is limited to 0x30 and the NMI controller follows it.
> > In the case of R40, the SRAM controlled is also said to be 4K-long in t=
he
> > Allwinner docs.
> >=20
> > So all in all, this leads me to believe that the system-controller inst=
ance
> > stops well before 0x1c000d0 on the V3s as well. Otherwise, we should al=
so
> > make the R40 consistent.
>=20
> That's a bit unfortunate, but yeah, I guess we want to remain consistent =
here.

Honestly I think the Allwinner docs are plain wrong on this one.
IIRC they used to describe the NMI as a separate controller in the memory
map. I think they just overlook it now and copy/paste 4K size for each
controller regardless of the actual hardware, so I'm not very worried.

Cheers,

Pauls

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAl+gOuoACgkQhP3B6o/u
lQwWBA//b32OKC11RTCgxme9fX39MvwYZCzJcPyISRTBGEEnoxuDxrhdtbywcbwq
V6WV0alqd6C/VaflLa8rnUBeVJFBmVhqi1C3+A4DLu6sRE8siW2yjBU9SbFyrKI7
oGVUD3RL7dR+Zks247PU+HwMzqr93K2cx2bDfyAE/4xf2vt6TpPlHrcYkFKKrrK0
pMf3nsf+YIwBC1VY5RJlhw4WxAkzVnmJ4Rr7CDsGnaWHJ5FU8MLVM4mbVUXwcBsh
qlH3iX0ezx8TBplXL+pJeSz/XwpUULuWTb4vmH59f2vF0dEqOSUe6O3hyNtNvn67
WUtfp2qeM6c2U0v6gze8q1D1aewKDLzJnUAiL0YflVXqn1g94Gz3Wm4yZmHOpOi7
0r3jlDK6fuzaaGztURiBYbWDAC1m5BGbeWPlvLc0MaEWk5F3sCHqdg7q80tgu/iN
ILsXYlwei8Oobs/U9U3dlaWZq8CJ973IRVDfzRypD4QSn7E+gvXBEdT5DYXvrkZx
4FVPUoejI/mj2hTvzna6GjlnM3AwZYP6rNd9uTCwaI6dlPqPb20oeztY4b94LnpY
WdPfy2ErQdcZBmZC3tU18Ll8qFw/y6Q4Bf6KugOSPDg9OJzyX37WuibLA6aszgfi
kmK/UX3oHAN/NUqZga3QXAqjCmx5ladqnTRf/ZjBCgmNmCYfO/U=
=ByNw
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
