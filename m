Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618591D751C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgERKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgERKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:25:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9047A20657;
        Mon, 18 May 2020 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589797516;
        bh=Eaeopgb7k64NvMRJRFgKStNcTRQI/XLC/CYzyt+WMZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esCVAepPOf2uIfV4GcU4IVH5KCwyFK5iyZq5UBUM6vL5beEz3krpBi66kjN4sfuV5
         +LF+4ve0dcSh6BUfua9fo+3rjQztB9nZwNO6hv1Pfz4UwXeYbWolvR6PuLOKQiGSVS
         YMF+XTc6C1RuWqZm0egXkJ6G3zGXdbI7n5CkvwIQ=
Date:   Mon, 18 May 2020 11:25:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix format and unused assignment
Message-ID: <20200518102513.GA8699@sirena.org.uk>
References: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 03:44:05PM +0800, Tang Bin wrote:
> In the function fsl_micfil_startup(), the two lines of dev_err()
> can be shortened to one line. And delete unused initialized value
> of 'ret', because it will be assigned by the function
> fsl_micfil_set_mclk_rate().

This is two separate changes with no overlap so would have been better
sent as separate patches.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7CYoYACgkQJNaLcl1U
h9DxVwf9EjET5pmKEmkJIyEEevXgdVBnEiqOseuE559viDAK89WlL+AGIO+0E0+P
rALP/qUBAX1MVom2U+GtBsuYLlSYKjP4g7vTwcKihKhapvLL50UyRD41wdE0sYAo
cfZd+cZrNUKRtyoUjpEMssa8xiz2f6ygBWbvqOO3MRCLyEraQ5bF5+OkcanGY9j+
k0L5GL1cjdX5Ts6QkdO0EF1JOgCzgUKOETwQC/U8KKw26Gvn6pngBVRJZGFEvI83
cKKf3NQeVZtsO0g+qsl+mU4jXuIdkTv0Z1ptdvCa/MhhYkbzLWoiJh+jqoldRJ3s
Jcb75FYE6uBLd1xSoB8ybjT/KGOY9g==
=CoR6
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
