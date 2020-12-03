Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC192CD984
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbgLCOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387784AbgLCOoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:44:39 -0500
Date:   Thu, 3 Dec 2020 14:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607006639;
        bh=DxJ4yIYFgoE+1eOz/ODDS5hA3PYUv9G+Xtpre9H2l3U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6YKWIB+WG0ISjOdzos63GK19W7EXUSf5DOAIg5xNO0Qd6voGpvfVSsNfMyzth2kT
         kQGPY0CC2GSrS+9NA2onWGCzvP57m3NFXrZ6CTxJG0Qy8Kl7Vh2EKR6Ebn50l/lDjw
         srbZgZOv7pIILINBadg/xsnLwHsnIg48wWzsLczP/0uw1vudr87Ci2c4ETN5HQrC/i
         h+HNoatu9wTRuRtgBmz0bJ0XFnFz3ZGRiDvgcnrZud6co5dSVFDEtG/BpcqwXLE7lv
         XSPByT4+xQI5qUoDJ4JEjQV0TNLnBhLz30OXF6DJCNOFvj3kEPTTzUonYeMqHmn4JL
         H2AtLhsJd4Xkg==
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Agrawal Akshu <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: add missed checks for clk_get()
Message-ID: <20201203144356.GG4700@sirena.org.uk>
References: <20201203143116.405930-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20201203143116.405930-1-hslester96@gmail.com>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2020 at 10:31:16PM +0800, Chuhong Yuan wrote:

>  	da7219_dai_wclk = clk_get(component->dev, "da7219-dai-wclk");
> +	if (IS_ERR(da7219_dai_wclk))
> +		return PTR_ERR(da7219_dai_wclk);
> +
>  	da7219_dai_bclk = clk_get(component->dev, "da7219-dai-bclk");
> +	if (IS_ERR(da7219_dai_bclk))
> +		return PTR_ERR(da7219_dai_bclk);

This is also buggy - instead of ignoring the errors (which is an issue)
we now leak the wclk if the bclk fails.  Probably should convert to devm
as well.

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/I+asACgkQJNaLcl1U
h9B6wQf/WHDDI4u+PUzca/wx02KyGxHEMupD7sXA+muUTiOQJBg5ZjZsrhA8A1hm
QE1YZhTrsOoNgVOMxJf6xTNOZuuL4SLg1Ui425NLyEo1RFGje54n+sH4bHqYhI+Z
86YIurOLx9pyazc6eJUzhOWC4A99ZoaOP8tTztw3Q3rbtktTNavbD54ypj0C+pb8
YoJlgqI5RYaDNvxDc23s5UiEUgTDG/Ux7kjAn7b44y3sApcuUNYPXWkhgSWSfPmY
j6073kxyYlLUwnsa/ZhZcx4ebFzA1mgz6bf8hdkxW+dszJxh7/GPTfj2eWmgBz57
9o9c433ExVA2aVQLLoZjPA4HCDudZA==
=6c+8
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
