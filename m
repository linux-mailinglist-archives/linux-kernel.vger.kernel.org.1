Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABDC2F1C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389413AbhAKRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388655AbhAKRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B589922AAD;
        Mon, 11 Jan 2021 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610385652;
        bh=xu5gy4M4CtiKHHhXf817tQ4NAfRrgpb0PC2kGtDFUYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fF9htN6G0xKJQCCJ8yD9XDRfPBfPGG9dWMSP7V2iI1pNDu/T2QQuuqe1kItotkh3a
         DnqyKKii7cosHcqVVTznY1ggoroskwLWD2UqPk6F9H8LBh+qZTfC5X7lOcRcMuvkdU
         zba88C7g/igF392KvHtorbelnanBj3+UP2XuehbV9yhL/mtDwz2jDjZOnjp9aCUm9l
         i/t3DQcix0FxkSDkcEdob/anEXscEtTVsG3IwB7Z47KLPFUE0bhY4PLnGC1fXKThb6
         kzEeiHrJT1+rw8AHtqho31Pf1/okOMjW8JIVZLSxFBSSg7xm+gE+bewkI77nFy2zK8
         Hznl4xExbUd8Q==
Date:   Mon, 11 Jan 2021 17:20:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     jagan@amarulasolutions.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/6] regulator: dt-bindings: pf8x00: remove
 nxp,ilim-ma property
Message-ID: <20210111172019.GH4728@sirena.org.uk>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
 <20210108225006.153700-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
In-Reply-To: <20210108225006.153700-4-adrien.grassein@gmail.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2021 at 11:50:03PM +0100, Adrien Grassein wrote:
> This property seems useless because we can use the
> regulator-max-microamp generic property to do the same
> and using generic code.

This made it into a kernel release so we should continue to honour it,
it's fine to deprecate it though.

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8iNMACgkQJNaLcl1U
h9DibQf/XTVXJw76h3g1lJ6Xxtn0kbRZMoG2xmgA1KGcmcwjsiBJFIuPAKz7yvfT
fayKCL782y3aG9z0FW3RFtGToM8h6FzmTQQpUiFmMjUQrMuJ2a77rhYf3apXj8+D
1QeDXf5j1qlSQmkD12FFsL8YO+J+yhKFt6xRvmAMjCXqHmoSPEUEO1WrdWrvonQt
x9XKnB16vpzQHAlaMBjKejhvc7qaWv1+krs4spC12XoBuyZt+Jt0PK9U/b3N1exr
Bev7tmfs8qPK+UpLHZ54LgVPJjD43qP6SyO/aPcVKnFIXHbwJRvxcuPbgTymYprx
2NHBtTqhR4Bb3yIMhd9RBwn7xrPteg==
=x6TJ
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
