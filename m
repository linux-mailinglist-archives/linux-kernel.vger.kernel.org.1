Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5138277655
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgIXQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIXQNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:13:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA9B206C3;
        Thu, 24 Sep 2020 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964024;
        bh=HATEJboxOjdhNSGz2l0g/RJsS3n5T59PRj0uzzAMhUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YI4ID7HR/7kd0ZthQQQUyaGlQTvG2r/Cx+xE7NC4h4PcP07HTaDxJZzh0q9HYW1k+
         tbmydK5TdZAjo0UXyEZcWBawBRfFhwxHtnQArM6BfObTklpYmSuSfcESrwUQ80NLw2
         Oje3lqWzirG6S9OqTyS0petbKKTMY8unvSpjUXbo=
Date:   Thu, 24 Sep 2020 17:12:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Wang Qing <wangqing@vivo.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs: fix spelling typo in comments
Message-ID: <20200924161249.GG4754@sirena.org.uk>
References: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
 <20200924123346.GE4754@sirena.org.uk>
 <062568971307793dcc80337f85545c4765241933.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <062568971307793dcc80337f85545c4765241933.camel@perches.com>
X-Cookie: Programmers do it bit by bit.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 09:01:21AM -0700, Joe Perches wrote:
> On Thu, 2020-09-24 at 13:33 +0100, Mark Brown wrote:

> > and compliment appears to be the one that
> > is used in the datasheet for this part...=20

> It's difficult to fix datasheet typos.

Right, and if we search for the thing in the datasheet we should find
the thing in the datasheet so it's best to follow the datsheet even if
we don't think it's correct.

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9sxYAACgkQJNaLcl1U
h9CCaQf+LLzkqnUGpFjawsKtPZWnUeywEzgLkvxTAL3xcZnTzLmuaJ5/fUJV4Fox
gDppXiRJMYzk4OfMOR+VFbgzIn4q9ePxRSlJAFOsSmZv8YWUAtpfB17R07Av/Kgz
+pAiXLXLBj+jgUiSUP26gKa4GJ1Pfd/Y52UKs8HK+E6dJ6KIzR/NXb1rY9BlYUy2
AXERvogxODOAd2JkSU3au5gv4OhqM9Bfi7y3UZ+uU804vVSWU+3MjiWCiFbYMLSS
/IEtHjK20TxChyGLjy3e2pF4X7ntIovx3aqfklSSNW/e+n0FnYzEFWsgQeQ8AoIO
FqQysHyj5A4ww0mUPmS/ZZite0Zgww==
=H+Mo
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
