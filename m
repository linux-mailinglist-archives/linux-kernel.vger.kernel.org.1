Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5899A28E6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbgJNTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgJNTCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:02:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7A82078A;
        Wed, 14 Oct 2020 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602702153;
        bh=tiVZn7Uy6aKe/fKNIUCOYWaPAhUmavw7le8FCSbV6DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AM3qqRs3fxoCLtIV80QDm6MedkQc1V4Gd9AmLRYNhh6hJmUp41RLmmGTmSEsaXYfq
         RVTtCwBR4ncHqZNHgAJMj3trSbtsxbxaFjvLWU8a/BDKXJlAnN30qW4mbcnEvv7KO5
         uwfSD5oaGRBifPN7jzp1UzVo81sMXX43iFj5aKDk=
Date:   Wed, 14 Oct 2020 20:02:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, cujomalainey@chromium.org,
        =?utf-8?Q?=C5=81ukasz?= Majczak <lmajczak@google.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Fix kabylake_ssp_fixup
 function
Message-ID: <20201014190226.GE4580@sirena.org.uk>
References: <20201014141624.4143453-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <20201014141624.4143453-1-tfiga@chromium.org>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 02:16:24PM +0000, Tomasz Figa wrote:

> Fixes a boot crash on a HP Chromebook x2:
>=20
> [   16.582225] BUG: kernel NULL pointer dereference, address: 00000000000=
00050
> [   16.582231] #PF: supervisor read access in kernel mode
> [   16.582233] #PF: error_code(0x0000) - not-present page
> [   16.582234] PGD 0 P4D 0
> [   16.582238] Oops: 0000 [#1] PREEMPT SMP PTI
> [   16.582241] CPU: 0 PID: 1980 Comm: cras Tainted: G         C        5.=
4.58 #1
> [   16.582243] Hardware name: HP Soraka/Soraka, BIOS Google_Soraka.10431.=
75.0 08/30/2018

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+HS0EACgkQJNaLcl1U
h9D8fwf9FvyHCTN7VxT8U5K/g01w3t4Oz9J2KNU29AFJcwQRN9tFkguWron/RH82
W4Hpmis1Hwcou3ECVp0K39jUq43kj7SEgsVMM8EU1498b9y8Y0oFXXmzWi7TBuXO
sbgHdVdS2QEsHmfTN06LY2MSDPcecOvKRYlEXrSSKs96+A1HL5b6wxBfNwFhuqaQ
RUa0mmJunCEyLH3s+RmjHXJ4YFCzcz5mc2TZmi92IZ6FDn1Ji4xZFHkulNZ5qzHZ
q3Rxx580TeC316jSAzO6PZ13ivKiQ/K5HwbvxpvpW7nKVPnBMXfYMGOv3mmyECaj
IxJGuJfes8NzHppDVT9C/xCnORqFWQ==
=PR0C
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
