Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E52E2B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 13:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgLYM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 07:29:46 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38669 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLYM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 07:29:46 -0500
X-Originating-IP: 91.165.34.75
Received: from aptenodytes (91-165-34-75.subs.proxad.net [91.165.34.75])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E0F5D60002;
        Fri, 25 Dec 2020 12:29:02 +0000 (UTC)
Date:   Fri, 25 Dec 2020 13:29:01 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 1/4] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <X+XbDe5/U4rk/FxS@aptenodytes>
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com>
 <20201223212947.160565-2-paul.kocialkowski@bootlin.com>
 <1608829305.375557.2966449.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="coPQJsKTER+El0UT"
Content-Disposition: inline
In-Reply-To: <1608829305.375557.2966449.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--coPQJsKTER+El0UT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 24 Dec 20, 10:01, Rob Herring wrote:
> On Wed, 23 Dec 2020 22:29:44 +0100, Paul Kocialkowski wrote:
> > The Xylon LogiCVC is a display controller implemented as programmable
> > logic in Xilinx FPGAs.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
> >  1 file changed, 313 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/xylon,log=
icvc-display.yaml
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/disp=
lay/xylon,logicvc-display.example.dt.yaml: logicvc@43c00000: 'display@0' do=
es not match any of the regexes: '^gpio@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree=
/bindings/mfd/xylon,logicvc.yaml
>=20
> See https://patchwork.ozlabs.org/patch/1420307

Just so you know, this specific issue is fixed in patch 2/4.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--coPQJsKTER+El0UT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl/l2w0ACgkQ3cLmz3+f
v9FHVwf/aZ0gtCsvdn07c78G0BjhQepFkKpgOl+V3xroH0VbIy8Eg+7HBpTBE5fN
0Hso6uGwLF/FCsYXVAge+Bi/LWCCSBAgwyRaag1mVlDN5FXXvitTJeJ5KKOmFKa+
klOOlO6gfdpLsO2ATbacGkTTKaJqPfSLJoAflRZpndnhB/WCOmQY0gYiW35wT0IC
ePzP3Bew2vzBSJ2HbpauF6/hXvieTiLVvF/MwdrJyW9XzO0y1Rta9DUJjMbgsEH5
scRicL6o5HscTnG99RuyHDfsv11w4v0gIspjvjiMuVHwfJx9gs1pdTkxp/QnQwDz
Ig87NMhqQbdl9cFAizCXYRl7xDkLhg==
=Ecid
-----END PGP SIGNATURE-----

--coPQJsKTER+El0UT--
