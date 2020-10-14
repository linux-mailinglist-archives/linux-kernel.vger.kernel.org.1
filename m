Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7252D28E6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbgJNS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389489AbgJNS4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:56:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5BF20691;
        Wed, 14 Oct 2020 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602701799;
        bh=+ltEREMql2yyINqmA9gqQrQYDWKSt6A5cI/39B9w9tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1IGhGhQGkU4HC1se8IgwwQ9G/D32skpp7hFVvKoxNFcqc9F292xSNWZc5K4/FuBJj
         iDe5KB8fbE2IiyPlQhyo7NmVyI7FGo1Omh4EavqGS2JsLz/+59wbWDTDQ9rkGWeu98
         mmeoYq3TBmfA+YVfcSwqRuZI98uhh7oLXuncxpDo=
Date:   Wed, 14 Oct 2020 19:56:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, nsaenzjulienne@suse.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Message-ID: <20201014185632.GD4580@sirena.org.uk>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20201014145418.31838-1-rf@opensource.cirrus.com>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2020 at 03:54:11PM +0100, Richard Fitzgerald wrote:
> This set of patches provides support for using the Cirrus Logic
> Lochnagar audio development platform plus Cirrus Logic Madera/Arizona
> codecs with the simple-card machine driver and a Raspberry Pi4. The
> ultimate aim is to provide the dts file but some updates are needed to
> the simple-card machine driver.

Why extend simple-card and not the more modern and flexible
audio-graph-card?

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+HSd8ACgkQJNaLcl1U
h9Dd+gf9H9W9GnnZzIpKoLpRNV0tJouG88erTYHIDCw6oummw/+zMd0A/LMkyf6i
uocPRbZ0ZILdTnLxbhFAvsXwFg7NsBJf4PsmHkcixBmA1wCw66DE2aQn4lPZnXNE
2dkwmDVhNYwxq7UBqREr64XgpGGQlnGW19J3F3Vf1bYwS061BuEmGx7aEumoKfL+
0MyUkBA1Yi3x+/v77XNmg3WD0DWYhP938ljNBXxRmhGB5zH20ieUxKrZV6c4lS+0
MlFwMfPhV12NQnZYiynma+gILfHmU/JDE4qLsaCKhaVtHUCydSmfoPuFTazNZ2hR
xvHC2xLmqY3aNKT97MW1sgKRPdO8iA==
=ej9C
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
