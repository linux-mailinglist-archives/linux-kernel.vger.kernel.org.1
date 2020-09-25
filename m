Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6369279233
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgIYUfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgIYUfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:35:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E2A2344C;
        Fri, 25 Sep 2020 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601062179;
        bh=Qnb4GmVJK+KSCmaIF8ewnftUKFwuL9MIqaQIMNr/Qzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPLPzGJrSwQ0wxzHBcU6TR3tcD6MY9WSGBpePQIRe5XEDzKYOeVVrfPb4kAL62Wap
         xXlF4cGDV5hJPlr4h72d1KC5PnVzMWTnK9RE9dT3Sny6+xFHB6WvNzz2B506eBw26s
         o8N6VSV5tPwW5UVDzEiRnc1iHxdHX3k0LtJFBOqw=
Date:   Fri, 25 Sep 2020 20:28:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tuo Li <t-li20@mails.tsinghua.edu.cn>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, baijiaju1990@gmail.com,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: rockchip: fix a possible divide-by-zero bug in
 rockchip_i2s_hw_params()
Message-ID: <20200925192844.GA10127@sirena.org.uk>
References: <20200830095106.4412-1-t-li20@mails.tsinghua.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20200830095106.4412-1-t-li20@mails.tsinghua.edu.cn>
X-Cookie: Dime is money.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 30, 2020 at 05:51:06PM +0800, Tuo Li wrote:
> The variable bclk_rate is checked in:
>   if (bclk_rate && mclk_rate % bclk_rate)

This doesn't apply against current code, please check and resend:

HEAD is now at bbd59df075ab Merge series "ASoC: Intel: sdw machine driver updates for 5.10" from Kai Vehmanen <kai.vehmanen@linux.intel.com>:
Applying: ASoC: rockchip: fix a possible divide-by-zero bug in rockchip_i2s_hw_params()
Using index info to reconstruct a base tree...
M	sound/soc/rockchip/rockchip_i2s.c
Falling back to patching base and 3-way merge...
Auto-merging sound/soc/rockchip/rockchip_i2s.c
CONFLICT (content): Merge conflict in sou

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9uROsACgkQJNaLcl1U
h9C92gf/RsB/lEQG1UKkloEDE1VbvFPSaiYS79/aMhlVUBUW116VogCV7sq/mQ10
WEG6ygMD4mUoU9PAYXPpn8+boQJ9fVNNYF76UmKpMHm6ZjopJ6gZZ/ARj3jBje4H
QgtJEYhcYFodqFs5LP5sVswlq06rguAH1cYrHgM9YYYZtWimsqfD2SD63QZaog8m
eBgk0duJ4ys5HzfPUhpfRgXjH8r6LNHCLRQy8UW1vHHYG3yfpUA9YNLITMHWbyq0
eDUZJzcpnErjHj3FaHoxjm4ohvOnlVMz+U9+LEjuz0Z8VfBk3SE7C6Rj1dN3JpdA
vR+WgSZG2A7qGkMp20/0IX+qKdILbA==
=cION
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
