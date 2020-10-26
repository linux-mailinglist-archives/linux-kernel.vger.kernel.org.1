Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCC299A37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395484AbgJZXK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395475AbgJZXK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:10:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A32F20759;
        Mon, 26 Oct 2020 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603753856;
        bh=+rA3mXse0duYebj29NlP/iv4vLfme+C3PEBv33IDzrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHjp+5jrlZUjjS4s9kch5YsSP5uJuL32CjMBRUGnmzQsCPbIQTMYiby7XugKM1gVy
         Ef6vxvWkE8+t6r+VzMiqZ0YCq6Yoyhp3g4IouKpfw+h+BpJSFV8B8oodDAOh6K6xrs
         3kSvxOS/fL+4dkwOH1wyjxOMiX5KPtqSOp+x770Q=
Date:   Mon, 26 Oct 2020 23:10:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, cujomalainey@chromium.org,
        =?utf-8?Q?=C5=81ukasz?= Majczak <lmajczak@google.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Fix kabylake_ssp_fixup
 function
Message-ID: <20201026231051.GK7402@sirena.org.uk>
References: <20201014141624.4143453-1-tfiga@chromium.org>
 <20201014190226.GE4580@sirena.org.uk>
 <20201026222747.GD2802004@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <20201026222747.GD2802004@chromium.org>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 10:27:47PM +0000, Tomasz Figa wrote:
> On Wed, Oct 14, 2020 at 08:02:26PM +0100, Mark Brown wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative (it often is
> > for search engines if nothing else) then it's usually better to pull out
> > the relevant sections.

> Okay, I'll trim things down next time. Somehow I was convinced it's a
> common practice.

It is unfortunately far more common than it should be but that doesn't
mean that it's a good idea!

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+XV3oACgkQJNaLcl1U
h9DHEQf+P9XM66VGrpm7CJvgSRIOiFF94Fk/gQFsulGNkv+W9YcF+z4wsrEsR3kh
5bZuxRsp06aabr2ESWJ5pwQzMyH5q8E4Ou7UhOBxJHzBqr6imfzshTm/1X+4Orq2
tlkrkSxHdJt7Gm9/joTRrzs5S7agkKfRZKZdSpIN2ve5ztRqKL5tc310LMAwyOJF
k6pezKd5Hb9ds7zWQ/yHMCTi/AUzPB9aPwI0nq5tgWbndsZ0hgSCI1Ze1gi05v/d
y7jKlPQmYP5hvWRDNqsXx63M1jJKsh40+it8XQnxuaFG8k9kd9s8lGifmAGBEraE
RBYD2VOBrziPtYW2uH3IT+G6xbSy3A==
=oJS/
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
