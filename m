Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64D62E799A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgL3NRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgL3NRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:17:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F6E3217BA;
        Wed, 30 Dec 2020 13:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609334190;
        bh=AkIQMFW3uBWg0gGY3L1pmtX/HhTTMeoRJWJ7Vk4TO1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L58OaIVOcbGms4rTCqXro1aX5Njbgnj7qwZGelpPOPbnR1t/lDqUf6tyKZD4gsBDD
         ixbe0WZ8l/uJjQr6Pb8vzd1Bpt1RWP2jUbAbKeHk0KLdmJcOX25Wrf1hNpFE4zA4fK
         n/I1CTf9GNSBVfectAvujzS3E7f7EqySg3M+SEEKb07fcCl6lgbfPgf+fm9qqiqETd
         fFcry8suuTC2IRaZ/CaEDI4oMBgnpBPZN/9+WNuNa6fOJKc+Uwx4YF5dRLocmxx1Kj
         KCIqYSG9ZdFNqCz9/duIitFMosFtv26TBvajZ3w1WFKZYKqu4KFIkpm3KDZRMNbWjx
         A34fAkEaDfNgQ==
Date:   Wed, 30 Dec 2020 13:16:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Message-ID: <20201230131605.GB4428@sirena.org.uk>
References: <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150635.GP9673@ediswmail.ad.cirrus.com>
 <20201229151548.GG4786@sirena.org.uk>
 <1d982dd1-eb02-e7c7-357e-83cf5003c624@redhat.com>
 <21333e30-1e7a-2c95-9e7c-6325c7e78f9a@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <21333e30-1e7a-2c95-9e7c-6325c7e78f9a@opensource.cirrus.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 29, 2020 at 04:51:57PM +0000, Richard Fitzgerald wrote:
> On 29/12/2020 15:40, Hans de Goede wrote:

> > I guess we should move it out of drivers/extcon then though.
> > I suggest using: sound/soc/cirrus/arizona-jack-detect.c
> > Note that sound/soc/cirrus is a new dir here. Would that work
> > for you ?

> Shouldn't it be sound/soc/codecs/arizona-jack.c so that it is with all
> the other code for those codecs?

That is what I would expect too.

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/sfZUACgkQJNaLcl1U
h9CFSgf/f+vIYBwZ3rH9QPaqfupdc6tEu8+Fq4isSWufnfyuPY3KAZouiqdbNv8p
0Rm9lfFQ67lJLEktLfFXwC7v43abUZrh9Ms6MrfEMVVoJcVVs+u4wuHUraq32VE4
QFzIPPcQm+kNT5npR0y9dSAW5JVg6q6/iyY9Taxaw/72r78+5Rw00XkLkMwTeifR
Y25bS7zfNSUNKuCLVKrCMY6w1q9ufLX2ekPOdgz0oPn/99Q2VhCCvrPVnVJi98PL
AF/DNWxYUHxP+5LZZUyZneUw2jckwVvPMLeERLE4ADd7MEgZU3BGTQcxo3F8QTgc
0INXfUZy2WdHt/+8QmfkSAmBXs0DGQ==
=zAvb
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
