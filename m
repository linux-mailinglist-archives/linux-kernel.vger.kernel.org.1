Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A022D9D81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392054AbgLNRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgLNRUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:20:24 -0500
Date:   Mon, 14 Dec 2020 17:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607966379;
        bh=bCVmDKin80UwRLK3QP42XBuzcvX1vaMfWPRWPv/RKFA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8oGUKbeHhDMltp/h3UjokbSScr0C8Vy46jl6y6xphIflhhnROQUaOBaHn2+Lted2
         9GY/w4NoOym77BvhcftFfd9JwUZQD7mcbLOqcOwFOdSc5BP/tanFd1mmjPN02SIs6L
         fRcCOs6mXEMmeE7BxCbsNiqixgECw11Y9Y217Uz6Gq+9QK7JwIrGhBid6xEEfV1t4D
         yRoIYP6TomDj8n61qI/JLiQNPKnqBON5g1tcQJPrxdmXIgnaT/L44GNfkR6dPiSq1c
         FPPjmlUbro+pr1kvGc79rLSLdrAGB65JocvZIKkvftgq2zVAOrV24rPa/F3wI5S8YT
         myM5pAxGnjHug==
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        lars@metafoo.de
Subject: Re: [RFC PATCH] ASoC: pcm_dmaengine: Add support for BE DAIs
Message-ID: <20201214171928.GB4880@sirena.org.uk>
References: <20201202085838.1779525-1-codrin.ciubotariu@microchip.com>
 <20201208170422.GG6686@sirena.org.uk>
 <7ab6bffa-f88e-3e2b-287a-89eee2c01819@microchip.com>
 <20201208193156.GJ6686@sirena.org.uk>
 <b98d9b89-268b-5a4f-57bc-b7f95d6c81a4@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <b98d9b89-268b-5a4f-57bc-b7f95d6c81a4@microchip.com>
X-Cookie: Everything you know is wrong!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 06:00:55PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:

> Also, I noticed that the HW constraints added by a DAI driver (a codec=20
> for example) are added to PCM's runtime->hw_constraints, even if the DAI=
=20
> driver is part of a BE. Shouldn't these constraints be applied only to=20
> BE and eventually merge them to FE (struct snd_pcm_hardware) if=20
> dai_link->dpcm_merged_* are set?

Probably, not sure why it's done like that.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/XnqAACgkQJNaLcl1U
h9BjgQf/f/WBaHkOk3bC8134oouvuQy/LZdSjlSV8PExQ0uwTpHn3L33vpu5DUa0
j0upkz44ZeJTuN9rPuWmlQZPPQiBJMzum7g3SMupNVTHg5pK3jvMzMibOSbpMmGV
U0ffm1avkLZl9iD5SPmkjOS5aENk/dDzUDvPrItaEJqN/zcOqh1KGmlmOeOCHd4M
w5vh7gWfcZiajAiBj0PLCiiGU8lf6h3G8R/5Qtp+2T81+dH5sKaQlg3BVyG9VU0m
643JshGvppylQj2JBGPS6uIZBHXWX52EUT22nRa/ZRESDBPbf5qH7hE6s6ac30r2
naIKWmzV2O1iz46yH2JWV1FwjF0reA==
=gib7
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
