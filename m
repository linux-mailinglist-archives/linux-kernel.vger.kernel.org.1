Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA02E25A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 10:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgLXJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 04:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgLXJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 04:24:23 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC10C061794;
        Thu, 24 Dec 2020 01:23:43 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 8CE77BFDA5;
        Thu, 24 Dec 2020 10:23:39 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id C74DCC1D31; Thu, 24 Dec 2020 10:23:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 52B00C1D2D;
        Thu, 24 Dec 2020 10:23:31 +0100 (CET)
Date:   Thu, 24 Dec 2020 10:23:30 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: allwinner: Add V3s compatible
 description
Message-ID: <X+ReEjkqIYF1UseK@collins>
References: <20201218205436.2326872-1-contact@paulk.fr>
 <2475548.3AtxBWxPV6@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PWZPojefCF+DTRoY"
Content-Disposition: inline
In-Reply-To: <2475548.3AtxBWxPV6@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PWZPojefCF+DTRoY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 22 Dec 20, 09:21, Jernej =C5=A0krabec a =C3=A9crit :
> Dne petek, 18. december 2020 ob 21:54:35 CET je Paul Kocialkowski napisal=
(a):
> > Introduce bindings description for the V3s PWM, which is
> > register-compatible with the A20 PWM.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>=20
> This is meant to be used together with V3s PWM patch you recently send? C=
an=20
> you please resend them together, with fixed compatible in DT node? Curren=
tly=20
> it's not clear why this patch is needed and PWM patch will need fix anywa=
y.

I've sent them together (this one is v2 1/2 and 2/2 is the PWM dt patch).

You can grab it at: https://lore.kernel.org/patchwork/patch/1355289/
if it didn't reach your emails.

Cheers,

Paul

> > ---
> >  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml in=
dex
> > 7dcab2bf8128..04ff708fdc86 100644
> > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> > @@ -24,6 +24,9 @@ properties:
> >        - items:
> >            - const: allwinner,sun8i-a83t-pwm
> >            - const: allwinner,sun8i-h3-pwm
> > +      - items:
> > +          - const: allwinner,sun8i-v3s-pwm
> > +          - const: allwinner,sun7i-a20-pwm
> >        - items:
> >            - const: allwinner,sun50i-a64-pwm
> >            - const: allwinner,sun5i-a13-pwm
>=20
>=20
>=20
>=20

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--PWZPojefCF+DTRoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAl/kXhIACgkQhP3B6o/u
lQwggw/+PE/9DPHRtzUcnwkzS1Q0LLtt63bSdLTT11wDKBBx8tZ1IKMeqWj4uw9E
cbnvP83A/XR8ul4to5vL3qvWoWk4H2sTl5YeAFLLo9Rbwie58/PCFO+mDksUWUEl
RVGC17Pd/sMYK2pf+qpzFNmkELnVr3aY3pm2D+e2tHyyIfbFWbdIJkaGMfVm5f1/
BraZ86G0bGhMTszP+lrGnuMrInshWOS7R7v/7OGlosPNSmvsNKHdV0uUv3vEsvaf
BmtVFDJDWSse9YhcKrpv0t4Nfa/B/du9O/yjAzw9s1MIKMfvHCp270IMrmB/EpOS
DehY8mzPnUZJxK7E7IUttjtpvT6rXyFwft4W93nPJ3h1xLSNMjAXgxOiEuGz5hqD
gYNclj3Hb5MwLPEnhmkvOqDdbVdNj14H2MwfPjnbIuFlWdZJ7QCeLmpgrCO4p8cG
O7rdAMnm9tHoJ/M5edKYySpH1V4qKiHgqYhV1KOg3AVi4Y/3kjbEP6z0l+zmeLRR
GXgJqthK7A901f//217zndKCPPpHmT/0RStsfEN28HoRVs7KqTvpNV0O0pLwcmoE
XgqDspLvCECW/gPkWZyKuoQjBPyOuhKn5iTt2t7o0UMqdxZkjRCwdjWIKJrXWUsy
eHwnRFGpl6FSjGFgXz7TNZ3sizcw+RCpzyD7SJvKOER7qHp3t3c=
=TS49
-----END PGP SIGNATURE-----

--PWZPojefCF+DTRoY--
