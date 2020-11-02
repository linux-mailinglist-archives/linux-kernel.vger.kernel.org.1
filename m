Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1952A30B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgKBRA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:00:26 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:56592 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgKBRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:00:26 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id E7D3EC0139;
        Mon,  2 Nov 2020 18:00:23 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 543C3C1DDC; Mon,  2 Nov 2020 18:00:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id B75C2C0888;
        Mon,  2 Nov 2020 18:00:14 +0100 (CET)
Date:   Mon, 2 Nov 2020 18:00:13 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 8/9] dt-bindings: arm: sunxi: Add SL631 with IMX179
 bindings
Message-ID: <20201102170013.GC2037@collins>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-9-contact@paulk.fr>
 <20201102101333.4bm2lfqpqnbpyp63@gilmour.lan>
 <20201102103340.GD11809@aptenodytes>
 <20201102142744.lxjvu67pr7dmxzo7@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20201102142744.lxjvu67pr7dmxzo7@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 02 Nov 20, 15:27, Maxime Ripard wrote:
> On Mon, Nov 02, 2020 at 11:33:40AM +0100, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Mon 02 Nov 20, 11:13, Maxime Ripard wrote:
> > > On Sat, Oct 31, 2020 at 07:21:36PM +0100, Paul Kocialkowski wrote:
> > > > Document the compatible strings for the SL631 Action Camera with IM=
X179.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Doc=
umentation/devicetree/bindings/arm/sunxi.yaml
> > > > index afa00268c7db..0fa0c0b5d89f 100644
> > > > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > > @@ -754,6 +754,12 @@ properties:
> > > >            - const: sinlinx,sina33
> > > >            - const: allwinner,sun8i-a33
> > > > =20
> > > > +      - description: SL631 Action Camera with IMX179
> > > > +        items:
> > > > +          - const: unknown,sl631-imx179
> > > > +          - const: unknown,sl631
> > > > +          - const: allwinner,sun8i-v3
> > > > +
> > >=20
> > > unknown is not a valid vendor (and you should explain why you picked
> > > that vendor name in the first place).
> >=20
> > Ah right, it's not in the vendor prefixes. The rationale is that there =
is no
> > indication of what the vendor might be on the PCB. Should I maybe use
> > allwinner here?
>=20
> You should mention it in the commit log for a start :)

Definitely.

> But yeah, we've used allwinner as a fallback for those cases so far.

Okay then, I'll go with that and add some explanation in the commit log.

Thanks for the review!

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAl+gOx0ACgkQhP3B6o/u
lQyZjg//bI9Bjbp/LlD/A9/teDuAzTJbir0itEikjyEReXElCuoX7l7qE05+p4jP
gm/YaZKIux8D8HZggC+oHbw0VaTyLHj0vxcQ10NwHJoVAhChcH+Ucf+WX3L2+qxl
FKdt9cn610jXl7CscZg9KcwWBC3a9EVpVXR73yVluwHN3y4iPE+c6geiatiReRI2
Pjh7LUc5u5GNv+HQPjOdp/SpNUdoo1KvUPyb8AWIaPHYoj5PoORa8u95vgG6xLSi
TbbC35O3ctNCWCOM73me2nDBJEQ5c2jTuyy1lPW2uCA+HdO00I/YrTfOyw3x+6XI
PLOP6QC818BnSE2+Y/aa4xoTvU+PNAu5j6Fp6bLLF0WRVqgSb/QUGclcdbD55jux
p6zvSpXjvAqz+VFjloNbcZQ5tc7gvFowP9lFUMLa9I0Y0nlX3gzuLHIBPo4ahOes
f5UKjYHyRZlGK4MKPOc17A90Oc+bPTb3Nk0ctnXLRpeTLBO/q4qXymhNeTcG4D3K
/9lICNidpUs7Vp3zT/OaJfBKsvWL+BTDy++Hrz3JgZ4AYtkE/iZzP5ofNK7Vj/iR
XG5ZuhR0z42CeoHwzWrp8xijGkaQkEF4rPvNzOP4ambN3iCL0jftoj6RQvDZ9Y70
aPlwg+JKF/M7/8qzSmn2ldH1rZhkAHqFHn9v2DX8DAuy7p/mJnU=
=Axqj
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
