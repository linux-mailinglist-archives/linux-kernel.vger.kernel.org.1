Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4433C2F1D48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbhAKR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:59:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbhAKR70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 368A3223C8;
        Mon, 11 Jan 2021 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610387925;
        bh=l9BECwPh5Uw1xsnT6CBJ//g1d59ts1A3zWVtuCkzoJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1+EiBSpawyQ677csW0iNpD59tJDqpWFYDwZz4nKjt0Y9Al9lI7opSvj8kTSUGTNj
         O6Y+MOWGgOs1KX/rFdNcBol0oLWJHStoHBwYpDYry62Qiczcq9iMJIUNZXLZheY4iS
         2CwuicaCpop9rxRtKh68mCr8RcbeGe4i94QmoG0JUxVwUOJWEw8MijkN8Qm/ENkvq+
         04dz7pdgQZlyIw+EYn8jLSCbMUpUBiRI88YayrW0BvXmEicRn6E3O6df9bH3R6nIFp
         +vZUoMLPcPRCP9RZ6JKyXEti2kiyeihkazsxmXG7QhAMjdlnBw9V/any77rK4WR9S6
         70Amgsr9TZ+5g==
Date:   Mon, 11 Jan 2021 17:58:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: soc-pcm: Fix uninitialised return value in
 variable ret
Message-ID: <20210111175812.GK4728@sirena.org.uk>
References: <20210108123546.19601-1-colin.king@canonical.com>
 <20210111163551.GA33269@sirena.org.uk>
 <9bef4fe5-0eed-03f8-9505-909b669ba49b@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <9bef4fe5-0eed-03f8-9505-909b669ba49b@canonical.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 05:37:36PM +0000, Colin Ian King wrote:
> On 11/01/2021 16:35, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> ..both set ret to non-zero, which I believe will throw a subsequent
> warning messagethat's not strictly related.

> my fix was acked by zhucancan@vivo.com, so I'm now confused what is the
> *correct* fix.

Quite probably yours in which case it'll need rebasing - IIRC I looked
at the various patches at fairly separate times and didn't connect them,
my workflow is based on queueing things for automated processing later
so I won't always remember seeing something similar.

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8kbQACgkQJNaLcl1U
h9DAkwf+M1VbQOU/Iy6orX+mjHXlUnvmVyBAj7mzFuZiwwbG0+Eh3ZdHM1zNcNO4
oLc75RxJJjJu4LVtwB2yNCi/ecE6wpn4RCQphOUqC0JceV7Fmv1g6DbgQm7FAEg6
c51rug8SVBRaNw3MisdINNE6LOAuO7lRTJYzCINoei2Bc5VvhGva4E2mhnXvr7Ht
o6T03efSI+GFHGtXt5UzmzwSJd55bx/I1hmzPSSkIgqLhgMsCiqEAm/ksQrUD7Hl
cIZBh4puCJwHry9XMaqDK1FX8l4eg1Ey6suXcsBBvbsXUJG/C75zFr5rgLb38y0w
yCqLHIaGdltiVwB+kQAZ/MXBZct/Dw==
=6anD
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--
