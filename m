Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780B02F4F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbhAMPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMPwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:52:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 809D1233FC;
        Wed, 13 Jan 2021 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610553135;
        bh=q7k3TGI/eq411WQSLCAtz/yGhi4vyahhPoB4r6TRi3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYtMOaPBls1DYxFjBt3mDEdERuN+4AAeYk8pjtp46ZrVveuXYPKXkvs/Iw0v1c5Uo
         GTa4Efio7Sqg6hyBMGWA6Ku1DsnZXm3A9uQr8v9iOB+h7yhz/HPvcHGP3y68JNjtm8
         pQvws64DztvDBWkhRKHEdQBID8B+Iy6ThTszVu27aVGqzjQXXsnHmUXBOowmcI/xgE
         mNJEj7le3EaJNHOKw0O2RzQLHwGfey5NCPag/yAlpXdqkq0QYU3TE0Kh5dwVB4XM8Q
         sdav1G4M0LjMP+FQEStUJQzCNpAhv1BHxy2OQL+CESBvrq0i8dGbVkYckuhhz1WzR6
         VylOuNbxu4K2A==
Date:   Wed, 13 Jan 2021 15:51:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>, robh+dt@kernel.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/6] ASoC: audio-graph-card: Support setting component
 plls and sysclks
Message-ID: <20210113155141.GE4641@sirena.org.uk>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-4-rf@opensource.cirrus.com>
 <87y2gzymc5.wl-kuninori.morimoto.gx@renesas.com>
 <762d798c-bd75-e24a-40fd-263f68f1a5f1@opensource.cirrus.com>
 <87czy9r9ue.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
In-Reply-To: <87czy9r9ue.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 13, 2021 at 09:00:19AM +0900, Kuninori Morimoto wrote:

> Ahh, sorry for my unclear comment.
> I think "PLL settings" is very board/platform specific,
> so, adding such code to common driver will be issue in the future.
> This is the reason why I don't want add it to audio-graph-card.

I don't think it's *that* weird, they're a fairly common feature of
devices and in terms of integration aren't particularly different to
sysclks, though this is for more complex CODECs.

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl//FwwACgkQJNaLcl1U
h9CFBAf/Uxyi2fl/ossDgvy6HHNeO5hAZODyWKycY+ozxjsHrifNijcW0bol/c5j
chPhusj8uJnWw7JyIGbDWY3MabdzLB0T+TKANqIYVWaf2yVthuv3xQ43dpNO6qpt
qm2h+bepzSHJUarSWNFTtAgjhU06m97O/fUs1EOjlUt42LA+W/u2e+5ApaNllrpb
WM968+eDlrIyPddtjeSy8eSLDJq9WdxiaCUOqQDEHDEYNSA5YBeohViMyvOCiKxV
REcCisD9EZx0tIjPCFWUpzaKd7Sew6KnpPaopyLwGQi699kzxlqjTCOs+A5drJIo
et9ncrYvRyLx0HN0E4ubWvabQsWZHg==
=7p08
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
