Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18BD2BAA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKTMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgKTMwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:52:05 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B40422227;
        Fri, 20 Nov 2020 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605876724;
        bh=gVvuE4pkpAUADqJHVNPHHCwOvhV7mliptOrIX9C+MJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2aJL/dpZ0M3TK1/IKN2hppQ7aanyTMSHaiSUo/lnNjK6F+iikpAe1Xpz2EsItbi+
         uPdcpPGKQEjIfT21xFL62DccJXFvDwF6SieVMVIqeavvRpAFtA289ZL/ob73s9l3ll
         YCy0I3W1AKnPf5CR0p41Q0I3V5/3zxIzO+kP5pzk=
Date:   Fri, 20 Nov 2020 12:51:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <adam.ward@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/9] regulator: da9121: Add support for device variants
 via devicetree
Message-ID: <20201120124851.GB6751@sirena.org.uk>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
 <f5c4446ff019173127fba460948f152dc6f8cf6f.1605868780.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <f5c4446ff019173127fba460948f152dc6f8cf6f.1605868780.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 12:14:55PM +0000, Adam Ward wrote:

> @@ -1,7 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2020 Axis Communications AB */
> +/* Copyright (C) 2020 Axis Communications AB
> + *
> + * DA9121 Single-channel dual-phase 10A buck converter

Please make the entire comment a C++ one so things look more
intentional.

> +	node = of_get_child_by_name(chip->dev->of_node, "regulators");
> +	if (!node) {
> +		dev_err(chip->dev, "Regulators node not found\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	num = of_regulator_match(chip->dev, node, da9121_matches,
> +				 ARRAY_SIZE(da9121_matches));

Use of_parse_cb().

> +	/* interrupt assumptions require at least one buck to be configured */
> +	if (num == 0) {
> +		dev_err(chip->dev, "Did not match any regulators in the DT\n");
> +		return ERR_PTR(-EINVAL);
> +	}

The physical presence of the regulator is not going to change based on
the DT.

> +		if (variant_parameters[chip->variant_id].num_bucks == 2) {
> +			uint32_t ripple_cancel;
> +			uint32_t reg = (i ? DA9xxx_REG_BUCK_BUCK2_7
> +					  : DA9121_REG_BUCK_BUCK1_7);

Please write normal conditional statements to improve legibility.

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+3u94ACgkQJNaLcl1U
h9CLUwf+PKMjV6kQxmzcjBW63co2YHRDQYzMeqqTd/RzO6QZvlYT0k5WBHEicoPO
FWQEUoT5oVU4CuzbhlLJu1gKkpm6yaUWvPODSj6BDO5wvlrHHWwZhhNQ1OEhWu67
MAb0z/kYnoRMYVHyphd97yuAV3P4bnCg17sNUKpaE6x/rIeAQ/y2329zWV5ITCRR
u+jZCLMnBrrbJxojlBpCjMUODPLvGyHh6dpjOHIqCCWtCn9TGZY56KWwZ3oXjSkV
VRNComzykM1qMMj1xaVR51uEQJ9iUY8Hm04pEDORVmpLH5cFh93M+YkgAQ5/yzJt
KWZzu1EBnRv2BYNUI8I6+CDqYoTFHQ==
=AGtx
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
