Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D5241DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgHKQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgHKQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:01:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D16206B5;
        Tue, 11 Aug 2020 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597161667;
        bh=WqOeCwBrfL1Ph4eW+msUcABQxFvWOzeS+Ilt/PQFHLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKwI0NPsElnu0sNHlCbru4nBORecokpfU8RGDSlJMxTaHdd1bMlBL5hXfBbaLG2M5
         oUfD0Z3cuNCKmjUXoioD4LvkIKSu8Siq4rnmHHsr6yGM5N8GOirH9JAq2us/QOkOwX
         rQ34UJ3RKhpxxS7jq79uRjcLEZ7nu9OiPABjc3qQ=
Date:   Tue, 11 Aug 2020 17:00:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/33] mfd, regulator: get rid of unused code at
 HiSilicon SPMI PMIC
Message-ID: <20200811160039.GI6967@sirena.org.uk>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
 <c8ffb2144274b6f9807667455b705ecd6338ac0e.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline
In-Reply-To: <c8ffb2144274b6f9807667455b705ecd6338ac0e.1597160086.git.mchehab+huawei@kernel.org>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2020 at 05:41:30PM +0200, Mauro Carvalho Chehab wrote:
> There are some checks there which could make sense for
> downstream builds, but doesn't make much sense for
> upstream ones. They came from the official Hikey970 tree
> from Linaro, but even there, the commented-out code is not
> set via other Kconfig vars.

> So, let's just get rid of that. If needed later, this
> patch can be (partially?) reversed.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/hisi_pmic_spmi.c            |  63 --------
>  drivers/regulator/hisi_regulator_spmi.c | 196 +-----------------------
>  include/linux/mfd/hisi_pmic.h           |  42 -----
>  3 files changed, 8 insertions(+), 293 deletions(-)

This is fixing stuff added in the previous patch, please just fold these
fixes into the first patch.

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ywKYACgkQJNaLcl1U
h9DfTgf/R98UUwdsptqlmy77TLWRqmGvuqch0ReEGcX0+dvQjwpmLMJTnhxcWIdV
3HOx7BUNAXDC40wVtk3cFPH5HbsY+5vVSH/adlDxlhW/u07/B7M9NlraomuDoXAP
mv60PGLMoQzI/ofealJWfAnxvP+a9ihJULkX+8ppu/JnEtY3e/SjzOvZeOTVtmwV
hIs52HoLyzBBUtbcqFLGThgJuu8DCL41ovj91rFEIy/NUz0Q7v388or51x5aq64r
j1nSV1mbfyW4kWL2LoqdeEa8PX6Gbz8OOH/L5D/eYBvx4gmzUjFjlUF4gyaDlLTH
UkmL3HMYEqFndRCp5V6IKMYLrUSkQA==
=FdxW
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
