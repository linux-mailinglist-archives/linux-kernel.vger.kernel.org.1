Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A72E70C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgL2NHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgL2NHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:07:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0D32206DC;
        Tue, 29 Dec 2020 13:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609247211;
        bh=767pTnLA+j4X7uox4aQm6zuaRfEEfJwX4e+yCz3P8+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlEUa6+5i6F4DHLudX75WRRpoeLGZhGlaVTbRYjg4hwM9F/Miwu2mG8u6viaBEn67
         EGJxHytqdqigddV9uPne9croSNN5Bs2Xq1QYtxfX9CVocoR9WMLK/PxCr9OPrAj54a
         BLwVu3Cbnt4otrsv5IVDiGh9kmMEeHP0m7yb1bwUDXOY0vwHvlB2/ShCOqQV05HR6D
         XLGTCPpH2kvyJwS0TuJR7aITHi9sQjlTki4fHWfS5SOx5DWvmTu45UprDqV85sCBAi
         pdJwvaJRzWED8G1tRha8JynrdgXHPrxdQBCzMKQ7McRwxwk3ZBFTpn7bAYMYnyFEr9
         imdth/fiy/V8A==
Date:   Tue, 29 Dec 2020 13:06:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH] regmap: irq: do not allow setting irq bits during ack
Message-ID: <20201229130629.GD4786@sirena.org.uk>
References: <1609191951-15590-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <1609191951-15590-1-git-send-email-tharvey@gateworks.com>
X-Cookie: Mother Earth is not flat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 28, 2020 at 01:45:51PM -0800, Tim Harvey wrote:

> Some interrupt controllers may not de-assert their interrupt if
> bits are set when acknowledging the bits that caused the interrupt.

> Take care to not apply the mask to the status until we are done
> acknowledging the interrupt and take care to mask the bits according
> for the ack_invert state.

I can't understand what this commit message is trying to say, sorry.
Which bits are you talking about when you say "if bits are set"?  Isn't
acknowleding the interrupt clearing the bits asserting the interrupt?  I
can't tell what the problem you're trying to fix is.

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/rKdUACgkQJNaLcl1U
h9B8HQgAhuWZe3NhnIBuOga3GlhY+ondsTBRTDwS7Sz/mC8Vs7jQ7OScNZAKNfra
L/dRgiQZb1oSikCid09gBzqvv4qd3OFwUNYrlW/GmxBmk1mEMtKqJ6ZmDaAWN5mY
DM/xoEKOkS8QvgaGrHTmvi7LCx1NOp7DqPMXHDMIlIy3xEsDhNdJOmL3lvIe0vnR
9XVxgNF4o4mV1fMk+Lg0/BvopSrT99m4ebfxcf53V3NbgjU0zTApZ/VPH2mtlA+p
RowjkFmAzKrfqPtWHdSVBakvfuXKb9RGzJZ5VxNiRIKJWxNozeG80Mg7NFMHFLIN
lYKZy7gpVbUBIwsFRVaeuW/NgTWpeQ==
=0Mb5
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
