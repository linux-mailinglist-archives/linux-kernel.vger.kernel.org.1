Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652CB2B6756
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgKQOZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:25:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgKQOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:25:45 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B186221FC;
        Tue, 17 Nov 2020 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605623143;
        bh=56cvIXZlMxNuswpAfZ65Rr7eBSVJPUrqGNADm+IBwWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9BdSDn1bCJJol0UpEdN286Nb4foJ7ftIK5rvFKwynYpMD2vR5eXxJZ8LXq5yRmF1
         wW0D7R7GgU8OkKiVi0tBjbMFIFiAazNCpyOSXm/i3LgAIK009QEUrg6Ybpc/GFlBAE
         elsGhNTGmjSze8G/XncgGS77mVgin3Ry78Ib7kqM=
Date:   Tue, 17 Nov 2020 14:25:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] regulator: hi6421v600-regulator: move it from staging
Message-ID: <20201117142523.GD5142@sirena.org.uk>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
 <471362653f22a8748202c55babd2b462056a5797.1605530560.git.mchehab+huawei@kernel.org>
 <20201116183833.GC4739@sirena.org.uk>
 <20201117090724.4ade833a@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <20201117090724.4ade833a@coco.lan>
X-Cookie: Pause for storage relocation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 09:08:22AM +0100, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > This probe code looks very different to other regulator drivers, this
> > alone should have been a warning that the driver needs some substantial
> > refactoring here.  As indicated information about what regulators are
> > present on devices and their properties should be in the driver not the
> > DT, the driver should just be able to register them unconditionally and
> > use of_match and regulators_node to allow the core to find any
> > constraints that are provided by the platform.

> The setup for MFD/regulator is different than almost all other
> regulator drivers currently upstreamed[1].=20

It really shouldn't be doing anything unusual.

> It means that, for the regulator driver to work, two drivers
> should be probed first: the SPMI bus controller driver
> (hisi-spmi-controller.c) and the SPMI bus client driver, which is
> at the MFD driver(hi6421-spmi-pmic.c).

> Only after having both probed, the regulator driver can be
> probed.

This is totally fine and very common for drivers in general, a
combination of probe deferral and fw_devlink exists to sort this stuff
out.

> Also, as all the communication between the PM chip
> and the SoC happens via a single serial bus, there's no
> sense on probing the regulators in parallel.

> That's mainly the reason why I opted to serialize the probe
> inside hi6421v600-regulator.c.=20

I can't think of a regulator driver that doesn't have an entirly
serialized probe routine, that's not the issue.  The issue is that
almost nothing that the probe routine is doing is done by other
regulator drivers.

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+z3VMACgkQJNaLcl1U
h9AIlwf9GtLYXFKKGNEQWjdf/Itfjnh8gyQP+5GihjpkiYch3YtDrIDWxsjxEfPD
/MtvxLPT52m1NP/del1x35eLeqyJTsNKHLB+GAzcV7DKUxmbXJUeE130hFt0SO9J
d8nWU69yRROMIdqZ5F3CI3nfGtLa7eYn+aDEVihW3MItIeORc7M1VdvPHR4Rlh88
MZvJ/PQodMtkPiuVB4kGN8jDTcXyiUMPu95cuvly7iwCzcYWAasBvZ3zkXoee98a
38W5FEMxjqDvRhRz+ivnolxRemKjtFS5z7YuBCWmpmUrp/LT0QNXrKhZh1qJNHPL
wcX3dQ3Zbmq9qFWjHn4nCh5WuUtXwQ==
=pWHl
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
