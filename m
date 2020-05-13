Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE011D1046
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgEMKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 06:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgEMKvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:51:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 351AF20675;
        Wed, 13 May 2020 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589367106;
        bh=FL+28LkNQoD75GVysexp8B1GX+IVYhv26EcjeQpqLJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+bv5PN8O7fdV9WyaB3O2NkdA5XTQcKoJ1dPJV95CqgXoiC4lch8+CW2PhlDX0GJg
         P+xgomodWAWLKo566SxMQf3LryNQj27sl5X8fCWDYHe1gMrAKl0qO2CJ57f2AnC2Hs
         i/Wv4HZmNXs0qreisS/ojZ20AVgYV1r+QDfYM9rk=
Date:   Wed, 13 May 2020 11:51:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com,
        ryans.lee@maximintegrated.com
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200513105144.GC4803@sirena.org.uk>
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20200513074523.21086-1-steves.lee@maximintegrated.com>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 04:45:23PM +0900, Steve Lee wrote:

> Changes since V2:
> 	* Removed warn massage in max98390_dsm_calib_get func=20
> 	  and add comment.

The problem isn't the warning, the problem is that you have an empty
operation.  You should either implement the function (eg, by caching the
value written) or remove it and fix whatever problems you were running
into further up the stack when it's missing.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl670T8ACgkQJNaLcl1U
h9AjZQf8DB8kAssj3tu4IkLMijV1aFweTzAeMyn08L7i45ykX2//t7+LU7aFgxPF
AI0vHc3UxL9odhba6fd4B0NjK5tMcNcw8x5HFrpNaOOv12q4qxTdqksEs//iiy6W
gP0Vpvgd1FlxXkVRyKN5CbbyiVMpM6wml100f7e8pFtxvOCy0m7J/C38iqre+NX1
rwiqCuQsAlN88+lYzGumpUkWioo4SXLOWkxd5KrtOj6E2X0iJ91x98661CSIZ+1F
bINPSn2bRMJFg6md27V9DiVf3qzkWimna3uLD+GKaT6lyRi4kCMJ0G0jp7LY8h4t
GDMtTt4CQ0iORk0Ep+rD17LsJNuAzw==
=wU/c
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
