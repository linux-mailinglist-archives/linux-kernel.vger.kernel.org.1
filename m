Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3473C2D2E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgLHPWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgLHPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:22:54 -0500
Date:   Tue, 8 Dec 2020 15:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607440933;
        bh=agNWNjQCc77UMknNZ+hqc7G36GIX7edrBXKF11O9ZzM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnRyKhdbPBeKAFCf3aXCoNV3ZIWToIpoE64c032G+yHtSUTK/S/HHMXgTahu4fMDY
         Oikm0kgBkpY7GOIBCGVvuqjpmHM7bALrYyG4ByqCRwx6Fj5ItyCf0MbKIzoobdCisI
         5pHp7ueSgRLzLMnvCEd2xK8IBmJkAWaznEAf8Qf82AmbgDEgT+Iz9UBKav0UIB2Wk+
         i1XOjmIXHhf6943Fl5PD0O54ALLJlQ7ywXsj9pBfHNbJoh+sfja/WeSJI6i8eu1O7z
         64yPbnTC/SC86928VoZobnbBuCICyrjLXSFQz46fGfx8Wfsjvb3G8AhTQNpzGBySax
         z9cR+1M8b1z6w==
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, sharadg@nvidia.com,
        jonathanh@nvidia.com, kuninori.morimoto.gx@renesas.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: Re: Re: [PATCH v6 0/6] Tegra210 audio graph card
Message-ID: <20201208152206.GF6686@sirena.org.uk>
References: <1606413823-19885-1-git-send-email-spujar@nvidia.com>
 <160683107678.35139.14772386553150233276.b4-ty@kernel.org>
 <a3541d83-1f2e-c60f-05f8-4fdd8c8f4175@nvidia.com>
 <20201207123131.GB5694@sirena.org.uk>
 <14d2a6cc-9ca6-f6dd-ae83-6fc75d5361eb@nvidia.com>
 <20201208121312.GB6686@sirena.org.uk>
 <a6ecb66e-db25-dcfa-4a70-d9b2fad75cd9@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <a6ecb66e-db25-dcfa-4a70-d9b2fad75cd9@nvidia.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2020 at 08:18:21PM +0530, Sameer Pujar wrote:

> > I don't seem to have them in my backlog so either there was feedback
> > from someone else I was expecting to see addressed or some other issue.

> I am pretty sure that it is not because of any outstanding comments, because
> I got none on v6 and previous v5 feedback was taken care. May be this is
> because of the doc dependency I listed in the cover letter?

Ah, yes - Rob said the dependency needed some rework.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Pmh0ACgkQJNaLcl1U
h9B7Zwf9GGi3vqDul7G6TFq9/yQzz54/ViItyV8CHg0CuGmqI+LRO8c0kCH7q1J1
JqIf1OJiTxZrmKJJntJls8toh5GEJyuHnp9dUgv13wmRzgBduecr96Xzk3epHjTM
fs6k3x9+IvGuCCAZ5gL2znrPE/QSR48jSjJczOz5WFyxC35dKU85Nl6Tb4/80npN
3qYKZ6WuXnge3/ckBH0s9Wvmj4EN77cGAbkOvJxbG5QgAYlHzK6FEM+RzbbUtMbv
SugMrZ4yKT8a74dv+jXNKztE7vephHPcZNSBM3G4E2bJ6uurnUJQdBrRgkGNKc3S
UiXFEjmtP6XMmBiEcaVJQIFTYGY9bA==
=QfyK
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
