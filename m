Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD61127532D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIWIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:23:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2339 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:23:54 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b05eb0001>; Wed, 23 Sep 2020 01:23:07 -0700
Received: from localhost (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 08:23:53 +0000
Date:   Wed, 23 Sep 2020 10:23:50 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] clk: tegra: Drop !provider check in
 tegra210_clk_emc_set_rate()
Message-ID: <20200923082350.GA1203543@ulmo>
References: <20200922191641.2305144-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200922191641.2305144-1-sboyd@kernel.org>
X-NVConfidentiality: public
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600849387; bh=rw6XyC6D0Wn/tIYkzkI1BvwS8429JZzAsGLs0aTeYn8=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=ahesYUWYSFiid8Exz4lMCERtcxoH/fU5PGE3AVzFpjhRN2wVIGvu0Z2NIw05VPls0
         J8x8GOQ1P1+lQpwsZHttz2T+PD3lajtZQIaY57XwF7825N1D617712cOKR+Wn8Gvpq
         JLJOAiCvbd32IH+UcUysAj8Is8C65inheJieZ6M7OZpZKuTOd9D40QssZ14DUaG2yd
         P+9gj1SFmd9fiTQLaRaOH9+wMdZQ2nXm6LAFhneGAZRpbrV6x8avaI290O88xvBX1A
         MWRkTZnX0WSt7YKD8xBIt0do5odX3CwZFHQdye/iK+/kByTBxzOZstIBgoMVUpxpqt
         Oh2md+BeNFxVQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 12:16:41PM -0700, Stephen Boyd wrote:
> The provider variable is already dereferenced earlier in this function.
> Drop the check for NULL as it is impossible.
>=20
> Found with smatch
>=20
> drivers/clk/tegra/clk-tegra210-emc.c:131 tegra210_clk_emc_set_rate() warn=
: variable dereferenced before check 'provider' (see line 124)
>=20
> Cc: Joseph Lo <josephl@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Fixes: 0ac65fc946d3 ("clk: tegra: Implement Tegra210 EMC clock")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/tegra/clk-tegra210-emc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rBhYACgkQ3SOs138+
s6EaAA//Y5DplW5lffkHg6ZLa50L/fr/LxCD6tJax+aU2QFvKGVFzPx6JLU7/My9
LR2zhjV4Q0VceG+FYZuVVoIoFMbrDvlyPEwYWWjlyJLMkp9t/rwZEo9jdpdE9Icc
+QhbseF1SV4fVCQLHnynUnQqGieZt0zyOMNDw6h8kqiGqfGs9B2pqedK1XcfmfBd
qM7juy+MpaOWS6rVg9hbM0ZKscbLUgPYJyrejbaMMDuBTYP7sVjW5vPhFHmBKyPl
2AgwpYIsrmZB234KxjeoToibt5hL2fJwNJ8folMA2WYfBVyoQfIwbmUUyihy0269
OOauVdb5zv6qn7Axsim5mZxQAfsVT4ILgyqFHhdKwg2HWjZeGC9CQp1ykK9x7p0C
mRJmnZLpsB8251vrXRp0GV07EQjOmzUKmJPb7Wv+LYjjwsFAIzfK2iw3NE38bDlk
GNcNORN+EQM3jP6WvGgWLDKN/HB4GrhqXCwYTB4PoJzF6gjcls80j4w6xM6TMxoQ
9UpeG1hptfusU+zc8k2lLpbnK/sg71n/nWUcLLHZLg9QXtOtyg+I7DZB1bIL4z3X
C3m88zLMZnl1nmdZoOXiv3ixYEC1Rn2jJrN6oFDuH7pWZGfFp7og7Csttdk0k1rs
3V35PwJ6yNosa5NbPy3uVMt57sirjnSY+Ufpf820/hCBpfTEQlw=
=OQhr
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
