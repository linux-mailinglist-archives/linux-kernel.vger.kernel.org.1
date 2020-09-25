Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF1278F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgIYQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYQwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:52:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414C2208B6;
        Fri, 25 Sep 2020 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601052754;
        bh=pAs4PaULX4H5SxYmIVtY8k566DgwXqnpA8RvoFzZpYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTdBKkL5tYw/mImn8swZhrGk9vzf6nzl7Hw0XikzigszJWCPBiP+hWaf/13VbN389
         5FIClElHwfvwmJnLWq40CsK3iFZD6ElWocTEo+6s1fIGB2yQyY4hiuAK019ZjvVNCA
         cRFeddNyhDjvsggDQf+fZfo+WddkNz8XZaVKIJ6A=
Date:   Fri, 25 Sep 2020 17:51:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tuo Li <t-li20@mails.tsinghua.edu.cn>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, baijiaju1990@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: rockchip: fix a possible divide-by-zero bug in
 rockchip_i2s_hw_params()
Message-ID: <20200925165139.GH4841@sirena.org.uk>
References: <20200830095106.4412-1-t-li20@mails.tsinghua.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
In-Reply-To: <20200830095106.4412-1-t-li20@mails.tsinghua.edu.cn>
X-Cookie: Onward through the fog.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 30, 2020 at 05:51:06PM +0800, Tuo Li wrote:
> The variable bclk_rate is checked in:
>   if (bclk_rate && mclk_rate % bclk_rate)

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9uIBoACgkQJNaLcl1U
h9BPeAf9H4D1Q4H2endgDKFyhv77X9QSGBc0ttIMBIVm0+Sak3GDEkoTnPh6d9Ug
JUOIrJ0MsnS1f4sLC2Vj/NASTEa+cBQLQ2Vup5OBfkCQXBaWSm3J+UwQzujiX3o6
K/1Z4eyCfi83a5nWTlGqrzA7VLcG8Og4YcttIXGxXcOOctfzXrH+NUtZDzXvxxfm
Bn7o/Ja/4wlLRPpbXPowMn7sNlZrxwNAtNhmOobCOgZtCGPhJLvdrEk035oQK/82
y+s3JQChKzfTsDyyo10KR/nC7unePe9EWdsuEobaX47B2OywzsjRX4nD9Jw8NjRD
WRUxBaZJYk3Pblx0uegXkIv09S+Z+A==
=kTPr
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--
