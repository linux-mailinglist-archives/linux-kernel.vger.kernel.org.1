Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068F22D12B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgLGN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgLGN4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:56:37 -0500
Date:   Mon, 7 Dec 2020 13:55:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607349356;
        bh=aR/NRdBp/XTaHY/Lbtre73wBwiC7h9vzC9/Oqrv1lPc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmYCI9Ua3j27G+ZVFuL74cZKEsHUncnzriJeaNgXWdg5PXNtiS0jhSZCHy5JFdm+h
         8GfUeOzQBcKwx5BBwI5i+Vla43gx6hBUVPJoRDndrbi+ZR2nKubFniGzDVH6P1srRB
         4RGCceW4hL35l5PpQT0PKn1kKHdCt49xY1EEZcOHomsu44U3HHaVIS1z3L5JPXsaKf
         cQ0S7ObEN5RlU8SH62D/+9D7fsifto55+OqHm9UfDh9Z9+/4ikQOgvjH13g4H82ZDf
         O+OWPgsEY9YEKN/6TBsfEMmUMjy3HGpd+xAlpwGh4VRAR0dOrGlu2VhfY6qJOaS7lg
         YEDGzlismANEw==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator
Message-ID: <20201207135551.GE5694@sirena.org.uk>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <20201206002629.12872-1-adrien.grassein@gmail.com>
X-Cookie: Absinthe makes the tart grow fonder.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2020 at 01:26:28AM +0100, Adrien Grassein wrote:
> Add dt-bindings for the pf8x00 driver.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +  compatible:
> +    enum:
> +      - nxp,pf8x00

Compatible strings should be for specific devices not wildcards.

> +          nxp,hw-en:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              Only available for ldo2. Used to enable or disable ld02.

I don't understand what this is documenting - what is "hw-en" and how is
it used to enable or disable LDO2?

> +          nxp,vselect-en:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              Only available for ldo2. When specified, use the VSELECT p=
in
> +              of the chip to control the output voltage of the ldo02 reg=
ulator.

Shouldn't there be a GPIO specified somewhere or something so that the
VSELECT pin can be controlled? =20

> +          nxp,ilim-ma:
> +            $ref: /schemas/types.yaml#definitions/uint32
> +            minimum: 2100
> +            maximum: 4500
> +            default: 2100
> +            enum: [ 2100, 2600, 3000, 4500 ]
> +            description: |
> +              Defines the maximum current delivered by the regulator (in=
 mA).

Is this not a fixed property of the regulator?

> +          nxp,quad-phase:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              This allow regulators  sw1 and sw2, or sw3 and sw4 or sw4 =
and sw5
> +              to work together to deliver a maximum 10A current.

Presumably this must be set on both the regulators being grouped
together?

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/ONGYACgkQJNaLcl1U
h9ALMgf/S3CUgMICMMHH6IBVaLN/WVSxyeihoNEW60F6OBxUO0Y7Ru0S8Q1PnMzm
VLK/6pN5hXe73lDyZD2bOD2UMeU9mrb6uUWDuBeTC0wJ6fRXkLKOm/TmUFEkAPZW
Bwa1GwZKaWm6TMw8FeenA07jQX6Wmj9PtOXdsxHmXVAeEts5VXBHRkapKVuUesWx
B3Ly6tGRU1xm/mt/9abrvEZmiKuc+RkLooIrM3Fbw9yyxyElhBvHAVDYDGbW3hWi
BFLDZkQ3Mhv5F7YVjOjD4tzD7L0O9UgnV31eXAJBN8DMvFoSTlaCJKzlFJ7L+4ZB
lL/TCFraAyLpsHcZ3Da62A+qrDAsMQ==
=nRAA
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
