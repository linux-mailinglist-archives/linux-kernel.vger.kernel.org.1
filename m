Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22429E847
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgJ2KFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:05:16 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46939 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJ2KFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:05:15 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A26C9E0013;
        Thu, 29 Oct 2020 10:05:13 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:05:13 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: vendors: add Elimo Engineering vendor
 prefix
Message-ID: <20201029100513.GB460689@aptenodytes>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201029022000.601913-2-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20201029022000.601913-2-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 29 Oct 20, 02:19, Matteo Scordino wrote:
> Add elimo as vendor prefix for dt bindings, since we are adding a dtsi
> for a SoM and a dts for an SBC

LGTM.

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 2735be1a8470..b877a3516277 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -319,6 +319,8 @@ patternProperties:
>      description: Elgin S/A.
>    "^elida,.*":
>      description: Shenzhen Elida Technology Co., Ltd.
> +  "^elimo,.*":
> +    description: Elimo Engineering Ltd.
>    "^embest,.*":
>      description: Shenzhen Embest Technology Co., Ltd.
>    "^emlid,.*":
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl+ak9kACgkQ3cLmz3+f
v9ETzQgAnVQvHptd0ctN6NgJfYOMSEmpNFC8SMyEoq3iv/tSDn7m/YCYLpewiESK
2khsTWitdmqf3f/O1w6uAxim1Afiw4HwQwqqwpvx258MadW+1Srj+ErNkmGBuAOE
nB1bXfa714DGgjRV2H9iekRVKwUNcd2CUKdt4v94n2X8RQVLaSslP3eFdakY7LOU
gftnGALSYx2pmmQ3P6IHK1P8M83ggomBEVf3A5HviI2bQze3rk7oSRDN1yKWdQN4
uSmggWLhVcUoNC2Dkn8Dx1rYIEruwIMDtfKSf+OTUnxqh0IGPi3Ki4ptGYez3unv
GuU46OFTn8TU8HVwMpBxlPYkS0LSLA==
=38TV
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
