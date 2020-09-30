Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A327E766
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgI3LGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgI3LGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:06:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2392076B;
        Wed, 30 Sep 2020 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601463968;
        bh=A+5d4n50XZGl/CNzpoGjTWy3agqpCL9F0ZtwZwYubWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wu8q+qWAno4fq0pmDBPwwUhaPqvsx7R5ZyT5oyqFSsNo/89BB3sgxY1x8dhC1jM+G
         hhrc69YY8TjT7tnIYYuN0e3BIJD3Ld2LUrigi89XbkfnZqoxvvnKuFI8Lk/CPlPVjv
         Vwpv8Es8H4vGwR13Mk0DEkHSs8WDMfNFc2XacbTw=
Date:   Wed, 30 Sep 2020 12:05:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: rtmv20: Update DT binding document and
 property name parsing
Message-ID: <20200930110508.GE4974@sirena.org.uk>
References: <1601460480-4259-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <1601460480-4259-1-git-send-email-u0084500@gmail.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 06:08:00PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> 1. Add vendor suffix to all proprietary properties.

You should need a driver update to match this one?

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90ZmQACgkQJNaLcl1U
h9DLLAf6A8PokkW2b799yPHKLilZUQOZDjvGgvqG2hQ0DvAXO3VszQ7k1hvnYtOZ
aKz9t/SKUQtYPN2V/Yw1cQ1vqIBgYyjxm1RJhDwGgEOGtvxOwdp8V/SNHRU7al/L
9ZbhQb6A2PkVq2MVMsYEnGFYgDAGf0gYoiQkdd63psa5JoCUEk4WYCMh8C7su6on
j9GtdRcYAlPjMXuBqwN6W+aSct5pV6aPXUJmQUPMFQqPkvxfWGs5eQEfEXVbaM0X
W3jYIdcl/wxLlFSvPtUSCxpmw/fvJwpp8RmSF0pjGDMz6lCSmh3qVUjlA3gOt4QL
zrGGE8MIT92j+/xZiQ5ainJ7o5NCvg==
=TDzA
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
