Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BCC298CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774842AbgJZMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774805AbgJZMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:13:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4596320874;
        Mon, 26 Oct 2020 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603714400;
        bh=KbAfpS5AGRw5GfH3m/mCuY+N0Ih33X21Px2gXTmbOKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrT63QoEtM/OdfjjrX6o5GPSeccdFPpsBnbBzIPFgAAREFTx7HUK8cSq8W9qXB8CM
         4cK90m4mOUJM/yXNseO/y+8zH+eieL0kRdBjvzXQXxnEIcZ667D1WedHxzJZrcYm4j
         iTrOTygDy3S0CaBJWIXoSA0r6W+aki5znY5h55ts=
Date:   Mon, 26 Oct 2020 12:13:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: regulator: add support for MT6392
Message-ID: <20201026121316.GB7402@sirena.org.uk>
References: <20201024200304.1427864-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20201024200304.1427864-1-fparent@baylibre.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 24, 2020 at 10:03:03PM +0200, Fabien Parent wrote:

> +Required properties:
> +- compatible: "mediatek,mt6392-regulator"

This is no longer used by the driver, should be unneeded and therefore
should be removed.

> +- mt6392regulator: List of regulators provided by this controller. It is named

This property doesn't seem to appear anywhere - there's regulators, the
collection of subnodes for each individual regulator which I think is
what is referenced here, but nothing called mt6392regulator.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+WvVsACgkQJNaLcl1U
h9COeAf9G6DwjRqvGX5pwncOY8E6kwgs2U7scP5J99ohq9wz9+kF8shwvsGPt2fj
SBfCd0U2GnI653lSXhxJntBFX5NeEyeLayYK/lUr3Xt35POLywsFM+kz08YvYDDL
WC+1pLt3CHQOSZF7FAOYATGzQi3Fah2VdJyNiA/FJxBbomJIomfpSo5PxVW15jlI
gFnUDzCWCtC4XjW8pA0el03F9PzKevC8lnYu51OxzaztC+qiPTYX/l1Kk5yA3ose
jHVRKfU9xIM0k3C/kr1O0Om7z6aRBVQTxpKwQxZURvDGcRoSQm1V43ksgKkfAVtJ
xdKXp5fIp3hAHFlXRxo3B+cARA9OWw==
=XYZl
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
