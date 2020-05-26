Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AD1E1EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgEZJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 05:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbgEZJnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:43:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1A22070A;
        Tue, 26 May 2020 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590486226;
        bh=hG9j6+3ji+zDQrp3ZLgUC5FBKnZJCU+bvoATs/HBw7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a677DcfUrdHhUz3553B6ZmSVl8QPidGd0fwheUS3FKNkrQIlbUYuJvAN+WPdzgq0p
         wAr8QSBjzJALGXInyBSHNDzjH5s7d+Z6PtKfuP5W09xtxjlffV124CkPFbS+xrPIyP
         9TUiBUI4LIbT/Q5C12grOY1AMmz191qDX/JCBbq4=
Date:   Tue, 26 May 2020 10:43:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wu000273@umn.edu
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        p.zabel@pengutronix.de, tglx@linutronix.de,
        lsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu
Subject: Re: [PATCH] treewide: fix incomplete error-handling in
 img_i2s_in_probe.
Message-ID: <20200526094344.GA4607@sirena.org.uk>
References: <20200525055011.31925-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200525055011.31925-1-wu000273@umn.edu>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 12:50:11AM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
>=20
> Function "pm_runtime_get_sync()" is not handled by "pm_runtime_put()"
> if "PTR_ERR(rst) =3D=3D -EPROBE_DEFER". Fix this issue by adding
> "pm_runtime_put()" into this error path.

This isn't a treewide change, this is a patch for a single driver...

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7M5M8ACgkQJNaLcl1U
h9AlSAf+PkXX6x+qlzTWOzPIkdObtg2VzoE87Jft37a6QYBzzIkjOOXTY6Xf3HAc
AZDsq3fRm0cmqGDnDwGlNE/3ZOieRc3szrLUBX2h5YIRgDKTrjikt8ANKSFsH4vK
00MYpW8ytCjKsIGx6Y2KQTDcpw02mBOb/TCm3fXO85JyQPmgLglkyosvgwlKD50l
VI2PD9SobyiUDJDpTSfe4aISwD4BmBmufbQTkVspfrVUTPh/46NL0htdXwb5sTDi
wCkk4vmNlYDNwue5OYQ666sk70a1UbGymlQ7+PAZu0G13yy0Sb1B9X4hMszmXOSY
3euIj+cf4/svTUes3CgEt6NJizcK+w==
=gHa+
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
