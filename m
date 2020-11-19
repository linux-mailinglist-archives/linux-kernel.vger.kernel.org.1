Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF592B97DD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgKSQ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgKSQ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:27:32 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C10322264;
        Thu, 19 Nov 2020 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605803251;
        bh=/2m0UE5hapRt4xJpiOoTf2TgBaWZK9N+sr6VYXqk/x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyjYlDNbHSZv76PQ4zRZDZguqFWthwVKkK3b6h5A5Zke0STt50ZD3F0VPn7r12TIe
         OY+67VcNRWbP9pI1egGTini2nwbt2WAC1yXfW0S1CYiYHwD9tBFNZNfteIsjFIkUxs
         3+kax8D0seJooMkdHfECXXtzJsZ0qbdVkDjW4K6Y=
Date:   Thu, 19 Nov 2020 16:27:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
Message-ID: <20201119162711.GE5554@sirena.org.uk>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
 <20201117173901.GH5142@sirena.org.uk>
 <VI1PR0401MB2272061C958E91FCAA239EB892E20@VI1PR0401MB2272.eurprd04.prod.outlook.com>
 <20201118115500.GB4827@sirena.org.uk>
 <VI1PR0401MB22726479D60E9B603A6848BC92E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB22726479D60E9B603A6848BC92E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2020 at 04:22:42PM +0000, Viorel Suman wrote:

> > Flip side of that then, how do we know when a reset has actually happened?

> I don't see how this can be achieved - I'd imagine some "shared" reset
> framework notification mechanism calling back all "listeners" in the moment
> the assert/deassert actually happened, there is no such mechanism currently
> implemented.

Yes, I'd expect some notification via callback or sometihng.

> In this specific case the GPIO purpose is to just to power on/off all codecs.
> In my view with this approach it's enough to know that all codecs will be
> powered on the first _deassert_ call and will be powered off on the last
> _assert_ call.

In general it can be useful to know if the device was actually reset
since then you can skip any reinitialization you might need to do due to
that in cases where the reset didn't actually end up happening.  Not a
blocker but it would be useful.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2nN4ACgkQJNaLcl1U
h9Bn8gf+Nb8Aw5P4LUp+fdufSBFwKEGFetQnq1XD3TvBypHN71zl/v54c11k8sRy
LIPaUtApaaXa20ln6E4WfvGv0AWkpK2kHw2Uoc7hfLvcnVY4MOabqyZ1NstDE9yT
WPW4uvLwJjDeWWNdMRLyqNoi/2XkqE5f6/Jy2HsflLnEX7h/vOQF/mjUq/leUSws
H11EIM1XKMtnIhnLuhcOLIXIse7i9nPLML7FGwn7Y7ShLP1PPpzANAa5Cn9AzonK
7Wa1hrq6eNuZRkdU3aZ5THDTphhQpbOAfhD8j/zsuYtoVhvu2za6LjQx6srTDFWc
O6uQlQpvWMyKCRrA0sLHmp8YRSnu6Q==
=LLq9
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
