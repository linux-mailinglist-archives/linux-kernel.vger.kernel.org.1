Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616F4273266
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIUTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUTFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:05:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1502086A;
        Mon, 21 Sep 2020 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600715130;
        bh=Z+nsJCPU/F5vhcfsVUjdc0LGbpEOpJ8PL57Fv04B9g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFMIFWWu6zIOeETAyj2qQjFCanjQwssfHT8qiXUTLrcwLSLA+mem9L2XU1jwXcItX
         yyAYl4mVuZnQdlrsROxzX7hDb5bKKLdCmQou4WnZ+vG220ykIxTeNIHpvPuNd0Qm3y
         RX6kif6QzkUabtZU9jz6u3pJAN1ymmIKVXF+KAts=
Date:   Mon, 21 Sep 2020 20:04:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] ASoC: tas2770: Convert bit mask to GENMASK in header
Message-ID: <20200921190437.GJ4792@sirena.org.uk>
References: <20200918190548.12598-1-dmurphy@ti.com>
 <20200918190548.12598-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
Content-Disposition: inline
In-Reply-To: <20200918190548.12598-6-dmurphy@ti.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 02:05:45PM -0500, Dan Murphy wrote:
> Update the hardcoded masks with the GENMASK macro. Also update some of
> the hardcoded bits with the BIT macro

Cleanups like this should come after any fixes in the series, that way
fixes can be sent as fixes if needed which isn't appropriate for random
cleanups.

--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o+UQACgkQJNaLcl1U
h9DRYQf+OmG7fcyQnhVmWY5UjYnz30wXYinU51PregENPVmAEEpyk/K+Rxcax9jZ
FGbnbx9fha6RTsya4rvHELI3nWt0MGfx4aR4zudhiEWCaYpR++h5iZxIU79COxCT
DlW4wRQqxycA7JNNRHin50FtIPBEUyskpbhlITdaFemnAqDGBGaf800aiAvLAgJq
au85ttHLZkuXvkeCnLcpVcJw9afiKilJjgoBTOaC6qKJ4xpEZK7XAHFY/mNtUi3w
0GfeIwe0S2J0newEHXkPa2y7s8+0rtlVTRkVnZxy1nqm3+EXyROoRImUG0O8koru
WpI9EJTvH2p5CJXHIc2J40XjdbXleQ==
=xBBA
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--
