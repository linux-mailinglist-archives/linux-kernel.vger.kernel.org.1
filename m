Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9966299316
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786734AbgJZQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786707AbgJZQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:57:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546452068D;
        Mon, 26 Oct 2020 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603731444;
        bh=XmX6A5dOrT7WqJQna3rzilmb9nV0XqwdxyjS4DZdXEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spfUEF175Trz/DmMSvKaULQDVGy2BQTVfG/DiGwdAtV5LCKPP6cO5FUWcwAnwMZ4w
         9+fDwhbMOi3MRBrLCcAMAkH7s7FMjgHWv/oky0Oq2VVsX5FZdOiJ5ier7qwPh+2/td
         BbtxTnJ7dYJCCmEFvg0xITwAZpziohyiWEA1qBck=
Date:   Mon, 26 Oct 2020 16:57:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alexandre.torgue@st.com, robh@kernel.org, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: Re: [PATCH v2 2/2] dt-bindings: stm32: dfsdm: remove
 stm32-adfsdm.txt binding
Message-ID: <20201026165720.GG7402@sirena.org.uk>
References: <20201020155709.2621-3-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <20201020155709.2621-3-olivier.moysan@st.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2020 at 05:57:09PM +0200, Olivier Moysan wrote:
> Device tree audio configuration for STM32 DFSDM is already
> covered in the following binding:
> Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> Remove stm32-adfsdm.txt obsolete binding.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+W/+8ACgkQJNaLcl1U
h9CPMgf+KTRCiGSyBxhUE1u/M2akejBvVr7Dx8sFslGtFFE8Iwr2D84zpI3/N+bF
0PYNahj9ur9gfNaKOLzQ+vH43Em59mjbdM5tL+ws97s5KvHDTQHtv4sWwceNG635
eTffbX/qd3MYwtRENfvGG+rMunPntaLfmCA/98Dm/c9NmyIwWL9VB8/HnYfEI/a6
YVTSsn+N6K9mLXTUD4N0CyhcQRxZDCvpgcbwsh2wtQO4xdx4vx174EDfyTT8HZF9
01x2ATDmoFoxsyEe75UQ2umKQ97hTgf0UDT17abwAZGFHTcH3DmvYRnenLxIyVmX
lmfhsylfvgLNnkypJT9lirXhrY7YZw==
=L9DH
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
