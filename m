Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806B22EBE54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbhAFNLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbhAFNLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:11:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F7AF22EBD;
        Wed,  6 Jan 2021 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609938665;
        bh=79wddeIkl6fxtztJZXYazG9ptPsHlnjqs/ligBQXeMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOzTNsUZRihG5hwg4TULYCcxSKgCU6r010mu39TRym7YLpOhDKFtVfI3v4cU1TtEo
         J6MKaaqzwtTHyaOLn4auZKqaFjzotTiWHYuPNh2LGtBrEWPwSvNFWWSEK5zy4grMy2
         kuubSjxLqyIy9i7lpG2q7XpMUkJliW3sGOUGSgeHgA43lBDEXjhufwIGhcUrBlsgsR
         EMyjD8YWQBiaFQLlVnPwlXPvtEa9zzME1+6S3n2IwzrAYiKTUx2pD7KiIx+n8iscQp
         5l5tY3A8+2pi7h5RcuBjluaHZYxZ9IOCyGA6jHVZxcE/cNLSGq3FSmiKvpX5ZtS6pH
         THoMKkqSI5fzA==
Date:   Wed, 6 Jan 2021 13:10:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20210106131037.GD4752@sirena.org.uk>
References: <20210106103453.152275-1-andre.przywara@arm.com>
 <20210106103453.152275-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <20210106103453.152275-5-andre.przywara@arm.com>
X-Cookie: Happy feast of the pig!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 06, 2021 at 10:34:52AM +0000, Andre Przywara wrote:
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098, defines an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
> This can be discovered via the SMCCC >=v1.1 interface, and provides
> up to 192 bits of entropy per call.

Reviewed-by: Mark Brown <broonie@kernel.org>

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/1tswACgkQJNaLcl1U
h9AU0gf/WEpGA7/Gqcj19WM0HyGcWr3K5f9j/Oet7jlOJd3xp5/OK/lHnRGxQ3UT
u51f8W2bmXF6OQ645seYsM+hEkcDJq+VFk+/wFE2w7TORZRLs1r9tFb6KrWrOCt2
A6ogtATKDYDwQeYIzf5+Ed3h/BP1Kgs3bPKo65hBulxWZUnRpIm3JlZegTGYC7hz
IXW3Ok1pRiyBbzBSR90NC8MW3TfPrBQEZEz8cmdSwu9ft1uLJqFumPB7nFVv747q
lCno+cS55Ikyj2OrdzQTLmsIYYutBgfd5yP9h3LHRIXZz5NC6eWlkKMqx/gL/sTO
XHQHqe3gdxNQ5gduTzONG4LqoOrw6Q==
=FSJJ
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
