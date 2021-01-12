Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D82E2F32B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbhALOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:11:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbhALOLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:11:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B32EC22CE3;
        Tue, 12 Jan 2021 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610460670;
        bh=hpBkXkpfVvhqn9UxMndwBMEg/zq+ZpBDqDGrYlMlsxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGgKME/NkiIOUGZpTTOkLQ5dM/Ds/F6lXcRUxQZRCf3mI1fevkQeNQyyBGEnOFKiZ
         SXsCn/ogR1Tm4njb2wwV3QOONqYdMUUeJYk1j40KhAr7kP2ZjMEjPgKVMNBi/c/OwX
         phj/rJlg6jL8xyUs5trlYoagvyHuFV0x90r3kYntXF22hZl7vwnRdUonUrqqbsNPEA
         qrhAFoDiY3btHmL9QxSiakPNIZ1Oucnklp7d3NVZyp7lWXZDGt0tiSAlBZtW9bb5ZO
         w9PMIAUwUOQwLJPvGCLV1BqhlBq93ZhIjrPhIQOivk1OQhZ8Tg6JG9B4KfxT8D9Hsj
         AxkVBn9/ZTaqA==
Date:   Tue, 12 Jan 2021 14:10:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Message-ID: <20210112141036.GC4646@sirena.org.uk>
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
 <20210107135459.GB4726@sirena.org.uk>
 <CAGvk5PqMCEib8Yr=V4SxT0BBMoC1+yGXm0y+52+LwC5dPQUVnA@mail.gmail.com>
 <20210112004207.GN4728@sirena.org.uk>
 <CABXOdTc-HkVW7UuDLoWf2opVO1n-W2EF-E2hJEm_D6=2P32_qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <CABXOdTc-HkVW7UuDLoWf2opVO1n-W2EF-E2hJEm_D6=2P32_qw@mail.gmail.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 05:52:31PM -0800, Guenter Roeck wrote:
> On Mon, Jan 11, 2021 at 4:42 PM Mark Brown <broonie@kernel.org> wrote:

> > TBH that seems like a big enough change to split out from this and done
> > as a separate series, I'd be perfectly happy to apply your original
> > change.  I guess part of doing that sync up should ideally be to
> > refactor things so that it can be done mechanically in future.

> Being able to do it mechanically was the idea for introducing the script.
> Unfortunately it doesn't help to have such a script if people don't use it.

Looking at the issues Yu-Hsuan mentions and briefly at the code I guess
there's some updates needed with the script for namespacing around at
least pd_ to avoid the need for hand massaging things, that'll put
people off using the script.

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/9rdwACgkQJNaLcl1U
h9DtWwf+K0SkjUpwh/wmWL/qEAmPhRCFTMJeLJAws7yixp9Kl5/XgnhLENhcdpVg
RyRTdEsdOSmelonIEaKDDdbLtTmdV+FFg1+G5uNjIKF9Qt2Oni5DGweuaLZjcHDz
Z2Xr3w9tWAb4mCIRsG18NIihLqrmltIysCZDQtsWIZg9B2eFO8Hd6SeJ8W+nPHIj
Rt02Cs+qs8jHR4WBVOLAV38F5UABhIUQ6re5htDLjQ2bD5g45vtVmL5WplDToub3
nJwnyDwVH4YIgegUzoR1nicEs5IXqCeYEcDvak5CXF4oiYWaRloJracNvuP0Ard+
THX891gQcNp/VfmP7dvgu72VR3KSbg==
=8wv8
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
