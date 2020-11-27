Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F102C672F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgK0Nsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgK0Nsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:48:35 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A517820B1F;
        Fri, 27 Nov 2020 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606484915;
        bh=fd264u93t1nwc5MZfJtEMyyYmuNOSUL6wWPSw7HHy3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtEqjfxGheOI5S9zdbORKratc7LKR87AuJWrsUQ3GoDqxVVE0p5AZRb8wYQkmht73
         DOpb7GHlVuerZN3k2ZVYkpPgllm06uhzMf5fk9kriaKp1zZG5qjnZRFrUMydQdbVFG
         T1gH8rvp0hZiFTnok8HGNE3ZG/Qd/iZczhRGoufY=
Date:   Fri, 27 Nov 2020 13:48:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH v2 1/3] Documentation: mcp16502-regulator: fix spelling
 mistake
Message-ID: <20201127134809.GB4845@sirena.org.uk>
References: <20201127093142.GP2455276@dell>
 <20201127125202.23917-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20201127125202.23917-1-michael@fossekall.de>
X-Cookie: All work and no pay makes a housewife.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2020 at 01:52:00PM +0100, Michael Klein wrote:
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>   No changes in v2

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/BA5kACgkQJNaLcl1U
h9AP9wf/SneFM9BFiQp8zGWGnt9z1dQHQ+cC4AYOd3jTSHZFFHjyUss6LGlZEz/h
ZNTMneF83G4wW3MTQKQEdywJ6m2Pf1gGGb57YuUVSNqF+RmwfJWRHdGGa+EO5v1y
VN7YGlkchinEsK1fbVZYETYOnKkD8/yZtu5CX0fC4gqbTZMdRstCCUOe1F+/q5wW
8DkqXrXR8TrvePcTkJaEgk5pjOWkZU2RSpLU8A39mT/1WM6kaougA+Aj4uFd8GFK
QDv8IR22bvgauAExLOZOgsqgQ2qFZno/bCKloU8VQVhJJbrftpSjCtwFsDgVsYwR
5DrcvYpNvxq4QmSk/7BUm3yEnF8ktg==
=GRBi
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
