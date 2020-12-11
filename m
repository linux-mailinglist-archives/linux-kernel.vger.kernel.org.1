Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374142D7767
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405396AbgLKOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404180AbgLKOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:05:01 -0500
Date:   Fri, 11 Dec 2020 14:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607695460;
        bh=nwyG42Ft2fRxW+LZK8kLv0XFhrG3mqZsivQxBfVP6h8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdb2u+3AMtv4MolcAN6YGLvHgcYc/znWGUJgjS/rZqkz4gY1YaMEJdRMWHB4dIlhj
         syCNoialhqgufd9B7wrseTGW1USEIXcR5SI6U+TH22TENv/tvltbXv+HQ5cSfCS+/5
         doDvPaHjOQCemBK84741XHeiw08W2li7q0FAZgart4Fs4+UeGwkDUDHTZ3+oycez58
         9qx2S9M8e/DVrYuURptnvrnmItxK4NwIddHW60CiHfmJn2EfenH0SUyKppv8Ntyq2J
         lyysh2DGjACUYwGI6XM+zAMs2Weea4SFkKtlvDgAXzUTSNxH1hy0Rg4Al1L8TP28iD
         hw6VgwNm/kxRg==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add pf8x00 PMIC
Message-ID: <20201211140412.GD4929@sirena.org.uk>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
 <20201210221629.17312-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20201210221629.17312-1-adrien.grassein@gmail.com>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2020 at 11:16:28PM +0100, Adrien Grassein wrote:
> Add a devicetree binding documentation for the pf8x00 regulator driver.

Please don't send new patches in reply to old threads, it makes it hard
to keep track of what is going on.

> +          regulator-name:
> +            pattern: "^ldo[1-4]$"
> +            description:
> +              should be ldo1", ..., "ldo4"

This is part of the generic regulator binding and since it's for board
specific usage it should not be constrained by the chip binding.

> +          nxp,vselect-en:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description:
> +              Only available for ldo2. When specified, use the VSELECT
> +              input pin of the chip to control the output voltage of the
> +              ldo02 regulator. (3.3V if VSELECT is LOW, 1.8V if HIGH).

How is VSELECT used without a binding specifying some mechanism for
control?

> +          nxp,ilim-microamp:
> +            $ref: /schemas/types.yaml#definitions/uint32
> +            minimum: 2100
> +            maximum: 4500
> +            default: 2100
> +            enum: [ 2100, 2600, 3000, 4500 ]
> +            description:
> +              Defines the maximum current delivered by the regulator in microamp.

Instead of implementing a custom property this should use the already
existing properties for current limits, this is a common thing for
hardware to have so we shouldn't have custom bindings.  We'll need to
relax the check the code currently has for a non-zero minimum limit but
otherwise everything should already be there.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/TfFwACgkQJNaLcl1U
h9DHmQf+J6eBS3ktnfdMA7vXj4vjK4zc06b/pJOkkkFUd9RlEBtYcAYUBX2Lr5Tg
C/pRbwGf5xwcNKbC87vxoJh9SyhPWPUTgvK/LmTKKoUOov4PGvNd4toEZtCrs8hy
OBSy4rrVgsEArZ698WJvoH83kbAurE9OOSU7jfgwPh+LpFyMSp2InRKk18vfPgxF
kDad/QJAteAgFNC5CQf9iFdpjszDFOYzalddv6Xwta2gcT9Q0HEVFHPmloeZ4wrd
IKD3iQhHFcHB6gjn4rADutEec1g7nmvm7HGNVWC5qCg543Fdqm5V6KmBBpoJXL8E
ZLEfOz8aqoo+YZhjEzQQJfqVG51Vdg==
=w27h
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
