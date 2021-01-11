Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31E82F1B22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbhAKQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbhAKQhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:37:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9F420B1F;
        Mon, 11 Jan 2021 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382984;
        bh=FJ6UYmcp9qZ1+F9nDoqN3eSCeXg5LWZGhO2qmO2UrgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erEHoJgEokRZJPDaOfAepJ6+VEHuyp7HvfoJ+KEJ2EyWGzv0KVvCFc2J2gTDQM58v
         rTjbHSoJHqMp9+g27xZk2GKBbGxnUHJ9eANnJjyKCoTFFccA/EA3LSyV5eCwcC3BqP
         f8WW2UlhOhalPXGu0Iq/WpCI+nfy4NG28cFzJXv1GPA9RyWKpymG2G9rABQYCg8/G5
         j+2IonqWPZXA5QpQMZKBOUMv9KSLxdRQKvXQHbyOjx4ZbTTvh4no/eT4oFQ4kSSz7c
         f0zEwxhCMeSeszOrS2mlPq058PPIywzyL0oz4K/DXteje68hDf1F1JbjqAtyGRSkfu
         1VuLM+o1Sigdg==
Date:   Mon, 11 Jan 2021 16:35:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: soc-pcm: Fix uninitialised return value in
 variable ret
Message-ID: <20210111163551.GA33269@sirena.org.uk>
References: <20210108123546.19601-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20210108123546.19601-1-colin.king@canonical.com>
X-Cookie: Made with real ingredients.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 12:35:46PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently when attempting to start the BE fails because the
> FE is not started the error return variable ret is not initialized
> and garbage is returned.  Fix this by setting it to 0 so the

This doesn't apply against current code, please check and resend.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8fmYACgkQJNaLcl1U
h9Buowf/Z7C140455AraBh0sDuBCFIG9HvDvb3RUm0/Xt5lR91JwaVxdYRlBbjJ0
dLSaYFh0GepPSHSAAn+AjVG5dN+26Lck2t/19LRscETOIZlqNwJ+YNY5f/FLJlau
Fe7Z6qDaPUL/WgeDGaY1gqAsJpdVdfGP1ojKEXeqsKjyZnB35D7Ftt9Ouw/v5MPV
V4z2ody8iK6SwNe/kIRIZndr8c2DOz3nodv0nBBuEn+18jdL1twh3CqqiL0eirCa
nC9dqQWuy12SdRHWWv6w1M/lfWqVdZKhVO5/d/2jS2nGOr2bphnJ5/3Hy9ecbF5o
TKGZIfArkmvxX+IAXxXeyPP85xKDBg==
=RuRu
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
