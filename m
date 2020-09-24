Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B427711C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgIXMem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbgIXMel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:34:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01703221EB;
        Thu, 24 Sep 2020 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600950881;
        bh=vUr9YRwd8hF9XVYF5mU6UJwtg0FyUtpF0E+w/IWZWq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMLUNwVGVpBWEcEDHnBGCIEwvLQ53r6P2qMp1LdjUS1aZkB1DQXc7wZm3dwpv22Kl
         zx6HW380Wd0V9v0bEAic87a0Mtn7nU4oJj20yGVPnI1rqP7r3NcKmGxOZ8CYFBg85Z
         AL7ZqhHa2LovElH/FMpx1MfgjR2wxMaNqVouAbrQ=
Date:   Thu, 24 Sep 2020 13:33:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs: fix spelling typo in comments
Message-ID: <20200924123346.GE4754@sirena.org.uk>
References: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 02:43:59PM +0800, Wang Qing wrote:
> Modify the comment typo: "compliment" -> "complement".

These are both English words, and compliment appears to be the one that
is used in the datasheet for this part...=20

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9skikACgkQJNaLcl1U
h9AxRQf/S8gmS+UH+JNtXpZHuFOgB5egaqnkf4SwuZYxea8zSzPdU+E/Mt7JlpCP
avHwW2gQ62VSV3dv3eZLhc7JXwBU0+26cOSaUouzsyR6Xn0Qjh29+Zp1PsQyu8if
YvD/mdzEfb+j1WX75BQiA7y34PTRhLLKMdjET4jLUsf6T+R2btEde/jKGB1os+Gx
OMSPXu/IFPqIjZGnKCG1nCZKOQUhV7PGTr1x29ZMfnonsvTX33dbsALLO5xiJcPw
gefvylbfnma4XnXYQlzt6pJ4VwwsPcsUFb2AAeaEv2zVQuU1qNa5vRd2WAm6aC9c
j6dSFfl87W97J4JDH8AM8FzO1AFqTQ==
=VsqG
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
