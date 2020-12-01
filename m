Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733792CA4DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbgLAOCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLAOCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:02:48 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90665206A5;
        Tue,  1 Dec 2020 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831328;
        bh=aW2Hilu+u+FMSDt5jSfZ3YdcB27AWISjkZ0EP8TJWQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtqmQG0koaZUqaFmNb+rtx67Tm9dd6VjODehyw6xXK8mEEyh7DeGkwz/gajC6g3nv
         loRp7Ac3YteEiU1ejG1M0OyeYdVkUza0H+cu8Q5qAOBneQekHh40FygeggCjOdac3u
         R77KJSip6s/6h3NLaJtD2XEn7i00eU2/YQLgT+N0=
Date:   Tue, 1 Dec 2020 14:01:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V4 00/10] regulator: da9121: extend support to variants,
 add features
Message-ID: <20201201140138.GC5239@sirena.org.uk>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2020 at 01:52:26PM +0000, Adam Ward wrote:

> V4:
>=20
>  - Request IRQ directly and free in release function to avoid masking race

I already applied the previous version, please send an incremental patch
with this change.

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GTMIACgkQJNaLcl1U
h9Akqwf+PbJNGSNYmM2ZeJY3L9kNFrayy+mO58TU0LyCIz+mdLJshwoRPcNoqqha
YsGcVXjLMRMG6RFUicFl9xJLjFp4gW84CzBu4BfdcQZ2fjn9tkS6O/F9oVA4r3G3
UcGsuLOR5vMtNQeejOueBhKcmYhU9Ln24lZMXflcSYU955AC0Wk9djbAE3F7KUGo
cU1ViyZyiC6nzVwb7Vx8PC3Dwp6MS8vZeL9FziGMYHMyiGmnCs7oPYocB61tK5lt
Xz2/lfJEXzu/En2/ukFPv2Nsn2Oepyf2cE6UGtjOVdm6OgKCJ3bVK9phRCakXUxo
hhAKaCyVg2ZgPAani37viP09EdPb/A==
=YEEb
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
