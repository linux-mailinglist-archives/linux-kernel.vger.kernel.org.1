Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A771028F7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgJORcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJORcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:32:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA9C22243;
        Thu, 15 Oct 2020 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602783143;
        bh=7/ktMrN+y9RlPlNt0esVc1KuysNkY3EZ6vHms7U3vkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD45W9726yurL26MnLtgE/4TPDHPiyUFXea8r3OIhuyK+bTUokXp6nAYQf+SACX7V
         X/bjtyJ+65dY+/V0mXFmOCRV/DNPxRTAgrxHcZUJ+w4qbX7/fX8MSgRkZ5EfYAchYT
         cHsBHs7nN1KmigHWJTXNHVqFze2+ZD/Kzk15dsHw=
Date:   Thu, 15 Oct 2020 18:32:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>, robh+dt@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] ARM: dts: Add dts for Raspberry Pi 4 + Cirrus Logic
 Lochnagar2
Message-ID: <20201015173216.GH4390@sirena.org.uk>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014145418.31838-7-rf@opensource.cirrus.com>
 <e9db1a11519dce0938cef867179160a818ec4143.camel@suse.de>
 <89913f8b-fe92-1a31-77ff-49ea3f3d3294@opensource.cirrus.com>
 <5d2587193f0e99996445d5fa507a8acf7854fed3.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <5d2587193f0e99996445d5fa507a8acf7854fed3.camel@suse.de>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2020 at 05:12:42PM +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2020-10-15 at 12:14 +0100, Richard Fitzgerald wrote:

> > We want something in mainline so that it can be used by people
> > developing on mainline and taken as a starting point for configuring
> > the codecs for other host platforms. The RPi is a convenient platform to
> > use as the base because it is widely available and low-cost.

> If what you want to convey is the proper way of configuring your specific
> device the way to go is writing a devicetree binding. See
> Documentation/devicetree. It's even possible to validate a given devicetree
> against the bindings (given they are written in yaml format).

These devices already have bindings, that doesn't really help with
describing how a specific board is wired up.

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Ih6AACgkQJNaLcl1U
h9A9yQf8Dm2aPZjUMMPafvwdr+3w8pMcyoUheiSN5MklP1b8yRi2feJfIB5PqzQn
bk13oOB7cxs4WNQgbZqLPLjJf8bgkutB5Kwga1mm2xDDIdt620GgvMrOosXH05io
xcm3oyOP5mZrvhzHyBdQV6J9DTF6t/ITVF1pefQhP0JiyOsG+jgU+ScDHrLlqXcO
yOpJiU0V2D9PEa38sCfBwHtvqBmYioIfDtAr9IZdoXgIRX+h6TQ2tnzpkrTUmXjY
vDxYu6IRjpvtT6vSvN9I0hM5VS/2AmOE8+taDkVdLUriN13gPPpk5HVJoKv9/qzw
nY4VIdhSllJWzlilek+ouj4S61KrwQ==
=cCIV
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
