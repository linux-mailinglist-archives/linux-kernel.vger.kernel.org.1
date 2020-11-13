Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3D2B1FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgKMQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMQMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:12:01 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562EA2076E;
        Fri, 13 Nov 2020 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605283920;
        bh=Fn17hh3pWFGUEXoHqDEupLKztXazD710yS3CyNpdX6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmjzJqUG7djArN0Me3XtBxhVNTEQPfTQUS+Pv0DMYe36NmGjALV0L+tFMywTLLW0t
         EpMQN3Zh630jcp7bjgf3eNnHyxqmY6Wge88R6b//mqxPf1e/MLc5zkQeEJd5W+CtPb
         ACeiS2mxRV7jxB2x2b9lOe09LG/4G7nqpOboNfoI=
Date:   Fri, 13 Nov 2020 16:11:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     lgirdwood@gmail.com, axel.lin@ingics.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, ttynkkynen@nvidia.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/6] regulator: core: do not continue if selector match
Message-ID: <20201113161144.GA4355@sirena.org.uk>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
 <1605280870-32432-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1605280870-32432-3-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2020 at 05:21:06PM +0200, Claudiu Beznea wrote:
> Do not continue if selector has already been located.

This doesn't apply against current code, please check and resend.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+usD8ACgkQJNaLcl1U
h9D9FggAhfjW1qkUWNVF5sUtv0D+r7MlzNb5DOx5IsU44tjQV52LwRdna31Y9E90
Mn2sM6Qrg49P4SScwIyKZfMs9hKh/w40kq/TSiam+0lwS2TavmODts+mPS+FIhuT
yu51KDx1CLNTzbHKcHS7SbGGzXjLcjk8RC4zuOxwtn/IPbh05ktPeP6Oj9zqXMbZ
pDQt15RhMXSyNWHZBFo1PQBnjwMQU3ZSuLqu9BsXDADGwJUfBPV+EkHTdi63F18P
1Asyvncd700tIqCiwZhtQiKAQulprcNEDBw2A0fHlw1YRfmS+VF6+qWImW1/Yds9
N0ztBsOBUg3Nchjwg2u9iKFDvxWGkw==
=9sF/
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
