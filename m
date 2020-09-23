Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B0275C65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:52:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFB72223E;
        Wed, 23 Sep 2020 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600876360;
        bh=+7ByMTj8FlYNE7VGGp3fA9NtzySfAdboCzVSLNd4GmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWNzjseYuvFRQCZYPyJzSd5BrxZeefHQtk2bRrIaBkF09s7rOdeTIUvx2Zci1zM3w
         H0aNR9PD2KAv0Ujsfx9yd9PBWlyijB9sWO9Hx+PtlzV3xiz23bYaADIG5Sv9zDGsw1
         h5fSatR9p04g0qrFIeCSXgfkuyo7871FdFkGsGzg=
Date:   Wed, 23 Sep 2020 16:51:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: tas2770: Remove ti,asi-format property
Message-ID: <20200923155145.GD5707@sirena.org.uk>
References: <20200923132600.10652-1-dmurphy@ti.com>
 <20200923132600.10652-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20200923132600.10652-4-dmurphy@ti.com>
X-Cookie: This report is filled with omissions.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2020 at 08:25:58AM -0500, Dan Murphy wrote:
> Remove the property ti,asi-format as the driver only reads this property
> and performs no action against it.

We should probably leave the property as documented and move it to
deprecated rather than delete the documentation entirely.

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9rbxAACgkQJNaLcl1U
h9DWogf+N7wq2sJT/UoUOg+Xwc+9JTtl34Hw1R9U48+KUz4ZZEGy22qXTrfQaJAC
5SPFzfGTdNHshXfQOh/HzomFSGyvN4tIMIrakmNyih494n5luYcduK7t9P+za/T/
fVbXObc9K9JPZbr+FqcQ7Q6grJHttMweCeU5ur4A31fEbe+1u4gTYnMTyVyAWMpd
giwjBF4WbJqhFdqQH/eTcG7oF/qC8UC1ku79ijTuzF/xnKOcbWiFWEMlldpfck0j
3y2+NPeUeBWhKquhkilspHS33Lpj08sRz/GlT0vSmTSC6ZdvFzfWTzyEJ/B0et5s
wgicD0fcnoWInmkimjomae/sHXZKpA==
=nmCG
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
