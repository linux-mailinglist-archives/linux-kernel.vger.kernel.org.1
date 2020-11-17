Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7952B6BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgKQRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgKQRjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:39:22 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86D9020678;
        Tue, 17 Nov 2020 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605634761;
        bh=8Y298WUPfpNgU5OeSR8YjRPSwhj59gCzY0Q8Rp1JKXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rh330JgBlRDcdmzGCbne7Zn8yPG2WKKxT0JXScM9cjXAoCaG+TubdqRJt8qQlUJYT
         3AzoaAo2/DeguxT5UkjGVaTQjpNWOyUpjxBG89w+B5mw959acewLs/kp1anEio6Lr5
         Dv+7whUB5HzgehLCesAH1smeLgkkYSrtlq1X3KMM=
Date:   Tue, 17 Nov 2020 17:39:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
Message-ID: <20201117173901.GH5142@sirena.org.uk>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline
In-Reply-To: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
X-Cookie: Pause for storage relocation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2020 at 12:20:36AM +0200, Viorel Suman (OSS) wrote:

>  static void ak4458_power_off(struct ak4458_priv *ak4458)
>  {
> -	if (ak4458->reset_gpiod) {
> -		gpiod_set_value_cansleep(ak4458->reset_gpiod, 0);
> -		usleep_range(1000, 2000);
> +	if (ak4458->reset) {
> +		reset_control_assert(ak4458->reset);
> +		msleep(20);

We should really leave the support for doing this via GPIO in place for
backwards compatibility I think, we could mark it as deprecated in the
binding document.  Otherwise this makes sense to me and solves a real
problem we have with the handling of resets so we should look into doing
this for new bindings.

One thing I'm not clear on is if there's some way to ensure that we
don't have different instances of the device resetting each other
without them noticing?  Shouldn't be an issue in practice for the use
here.

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+0CrQACgkQJNaLcl1U
h9DIeAf+Mk60aGQVQY93Dm7fXGJgMzSKeAF/RY8WkFrPKQqZzaFA3OS3lpW/gij6
MwtpXcN3Cqe6CkMB8Do5x2QX9Hyen2WugykcBHZXYpYyxDTFklh0nmFepoXtQl8B
RpNC6LrJNiXgvG9wPIt0g8KhO6Ymzz7Z1ZQUQGPsCS6/4rYyHtWJ9ntXOWSbBsfx
9/7Zd0RaHGOEdP1VlCJkdUBWOaQTkwvm8bNLw3cmqfHMWyGwBw0SfLJJCVWgwDN4
Axx3ycQeNzIuh5NYfbdQ+qj9bWxXic8t4rSPpzuuFRDMYSsi5C5O3OYUaufGESWM
1pPc0lCRGEw80sjyH5pDBV+NkkiVhA==
=KK9w
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
