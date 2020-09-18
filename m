Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72626FE04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIRNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgIRNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:15:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652CB23719;
        Fri, 18 Sep 2020 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600434924;
        bh=FwUV2XVOFCWTnaBpapY1oJ3Zg02BuffjgARpsBxmqoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwvzmWtiFqN0tqhMrt/XquikEhcaZ4PFRdM/zLSzcz4zIfYVEDQ6XBQeLEXaBrgEw
         6M1CQfPhLjMOBoVEDyB3Mnq0c/0UbwntCb8zlI8hoGcdmFTMr4siSvErwDdbTw3TAg
         U1CsDpIDU8XtQnWQkBxF8mFpOC37EJqa5B2yRTcc=
Date:   Fri, 18 Sep 2020 14:14:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] regmap: fix return of unintialized value in
 variable ret
Message-ID: <20200918131434.GG5703@sirena.org.uk>
References: <20200918131158.24083-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20200918131158.24083-1-colin.king@canonical.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 02:11:58PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> A recent commit removed the intialization of ret and now the !config
> error return path returns a bogus uninitialized value in ret. Fix
> this by explicitly setting ret to -EINVAL for this error exit path.

I already applied a patch for this.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9ksrkACgkQJNaLcl1U
h9BZggf/X73CVmpulLjsNipt985pXNKkibPt9bWqQsWTiwbhU9j06StCCD1axGQR
fZdX2Lk+kb9aVd7BSc7V4Ri5GRAJoi4y/mbypUEQszMuvq63LpLPvjzhbMc36md1
5aDhaPEQbtQTVpmTPkdtZO0nFnZfrUSQCRk03F+oHVM1iXt3Ua6ftOnWgjzVtlOA
jCYhkmeLBmD9PdWlfK/H90VHaKDyw2h/d8sCsSFOtWAkUwtLHxU0sqJLh6qVGFLB
TP7IUipcCOpGxQw3gxFOptLogC8L4G+xHeUulrnT0fxjDxNHVvMRjevc3ZiW4o4w
7xgoGuso1q5asbs3KKBz940WN6E5ig==
=ng5Z
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
