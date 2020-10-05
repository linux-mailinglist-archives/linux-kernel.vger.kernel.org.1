Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D228378E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJEOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgJEOWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:22:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC4720757;
        Mon,  5 Oct 2020 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601907738;
        bh=rohRkjYXGDVbVyyjLQfiikgc4tSkUWCPn7vn8cHk/Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Het7cDoNouuYdNOoJGCxq14+5aAazTf0V61d7jFTL0gucnD5oQE3kscVnTz8Jy4R6
         AHDvJTHJ6awMjSo7qy2/VWSo0cxEqwfqm/L+cq6Btv2Jx86+QMUTPF0wNNCS3qqpRq
         O7IrOFIQMyXEndzbrQHCgw4Vh19xSqxc+Ev6II2M=
Date:   Mon, 5 Oct 2020 15:21:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Make constraint debug processing conditional
 on DEBUG
Message-ID: <20201005142115.GD5139@sirena.org.uk>
References: <20201005131546.22448-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20201005131546.22448-1-geert+renesas@glider.be>
X-Cookie: Most of your faults are not your fault.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2020 at 03:15:46PM +0200, Geert Uytterhoeven wrote:

> Fixes: 194dbaefa0da24bb ("regulator: Lower priority of constraint logging")

This is an optimization rather than a bug fix.

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl97K9oACgkQJNaLcl1U
h9C4KQf9Grpci6F4kBsbXA0+mBhCqdIkcO/KvwHJPACG01Dy6jDwrLA/4lh6fE1R
61KP8x/Vc1JTISbsCYGi3O1KQxWZPKVRfkmGxodZVP2Xtekd//DcX5kT0mvuiSRR
RCbTJZX4ojNB1lM3BrOutKlpVVC6qL6Ltw8GLbzORoVi6x+HmSLy/o0SYpuevc2J
a7Bn0JK6UpO3jnmI201g1WXExSoiqbu342B6Vw07GW5nZenC/APDKrSryWqdDF08
Hg6JAHfb54Bd/q6J7wKeY8+VFUFIsawKMAhuKAgLwsNYsxzbHa6f2f9YG3zF4eRH
HMde+4gru5ZaHReugTHrF19mTQhiZg==
=97yH
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
