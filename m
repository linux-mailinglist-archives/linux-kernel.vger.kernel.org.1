Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF92F4A43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbhAMLai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbhAMLah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:30:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53D11233E2;
        Wed, 13 Jan 2021 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610537396;
        bh=Pr7ftSzEqQFBRyhav+VqvsVYCOqSGrjRiOX48WdaDb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhrVfXZCs65OzdDtMVbfheKemMz0Or+aNf7/XFlLpV8LaL2mMNiM8nIx6vbfR97iC
         kRmOPP4IKMKSG5QwBt/NXI2B4YFNX6gim2HExyJeslQ0tVYurU8LU2UDlRC+dw9F0e
         Gm9EinpEPfKIRQNU2v/j2eTLfF0eSI3fUNyW9DIqDj4Vu/yNI3h4r7GVrNpri8+GzV
         adWFgwjMsMrByEWYtVc+Ld/nG8e2G/QGYGLJf6pyK6Jd9aZnACX1yltRpEy94/DwMb
         SflW1+ReYdLx3o0e+Pv+avejf15YU+BbzAn1aml9fuqsSKxPBzYvkRJjB6m93NDf7D
         BqEEP+B03xbAQ==
Date:   Wed, 13 Jan 2021 11:29:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: intel: fix soundwire dependencies
Message-ID: <20210113112923.GA4641@sirena.org.uk>
References: <20210112203250.2576775-1-arnd@kernel.org>
 <20210112203250.2576775-2-arnd@kernel.org>
 <cde511d6-fa14-0cab-f00c-f75ad2d8281c@linux.intel.com>
 <CAK8P3a3rOG8eCNQbk01-_t7RtyJknWbo-9tKo3959KhU5tcXsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3rOG8eCNQbk01-_t7RtyJknWbo-9tKo3959KhU5tcXsg@mail.gmail.com>
X-Cookie: Ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 11:36:15PM +0100, Arnd Bergmann wrote:

> I was indeed wondering whether the intel-dsp-config.c is just
> another layering violation: this is another generic piece
> of code that seems to contain too much knowledge about
> specific hardware implementations.

The purpose of that code is to try to figure out which of the multiple
sets of drivers and firmwares available for Intel systems it's best to
run on any given system by default and choose between them at runtime
(or allow that choice to be overridden by users) so it's all about
knowing about specific hardware implementations.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/+2ZIACgkQJNaLcl1U
h9D4awf/f/riblTLLLU0M4zy8SvdlZaC8UIH+GjOit2GLE0GyR4zgWkE9BGrNO6U
qE31bCPBZ2Yl4juHbKwSX8eaun32fPa9KlcNTcs8VNHiBfHx6Z8umGuXglsfqnbk
U3iKit1fa+Gf82OABwAnl9EVsGIKrFMPqGU97B064/vByeEqlNlQdN7XdIIq9b0b
RLUaBEMZ8aBgXGZ1TiUCeMi1VaIvJI/YiqwqwNDhkhvb91yUNyVwDwjGtmWr0MEd
mrruFa/tgd35ngWgZ2/k/RoZUHFvKWr/dvQ52/Yh4qLfRwrouLkd9QtqNeBXgWmd
KTjwCczLvKzMe1znK8tKq4d+LVF7tA==
=pwE+
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
