Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AF2D7C91
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394592AbgLKROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393817AbgLKRNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:13:53 -0500
Date:   Fri, 11 Dec 2020 17:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607706792;
        bh=F5Kv0EXSh42CiQPNz++tgaA25ukosSBxIT5Ldln1VW0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeTm2w7JomXu7/zgHHiMeR4oCW71Aq6UxyutXI8Thdi556rSRJ5CyYkaTu7CXjOFO
         LsVO9tEWQ+fCdApLj4ciVqdOdON91FuoYJDAYFH2+nbVVWQnHvrcWGF68Rb1LVJg/v
         vb36vlRjQBQhk5A+NUHF+DmeJzThdzkuerm5hSGOgHtP8F2W2R3hHLSHAH9nM3ZzP5
         wpBGuvxgZkl/VJpqk+EpU1+hGfR7Qgca0Udlu4sdXwGDLlUGiTG8RPAhXE6ZUKJFvv
         /9QWNsCkuK2BTFTDQSw0SqXtTcqGb9TKwOV+97GU1qci41swM7AIE4TzInvO08Ja4s
         tLUPJwLY4SZzw==
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib
 skl_tplg_complete
Message-ID: <20201211171305.GG4929@sirena.org.uk>
References: <20201211170629.871085-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <20201211170629.871085-1-ribalda@chromium.org>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 11, 2020 at 06:06:29PM +0100, Ricardo Ribalda wrote:

> If dobj->control is not initialized we end up in an OOPs during
> skl_tplg_complete:

>  		for (i = 0; i < se->items; i++) {
> -			struct snd_ctl_elem_value val;
> +			struct snd_ctl_elem_value val = {};

This bit looks like a separate fix?

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/TqKAACgkQJNaLcl1U
h9BQeAf+OFcaJQh4d/Gjojcw4mPYxpP3Kwf7I4v7LvLnqMTDdaE1mdliR1JM+2YF
P+dKGxT1sP9q8FpsjAIDl20dRdGHa/yMdJcIGs8CZj9uEBxMuUu2OZVlHnTZ5kzS
tNxszxGAuQop+kJRlENIQ19TsOGpmgMYlllysVFyHGg6ZYi/yQA9ugqqjwoMlSg6
9A9leB+N1XfdvD6SqOFx904JpWoAh2XgD9W4CbjogSSg+lqroPBl2cQGaOkvhzOY
/jiYg7pVDqss0Hw6PHHLLBUqnzdfrd+G8XerW9ZK8PXcAroXfBYA9KlV+4UT14Fo
MPH2vmMrMbj488G0uYfsB3RYMQA5iw==
=DfZj
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
