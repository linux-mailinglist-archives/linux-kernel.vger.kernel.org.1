Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C942FA24B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404518AbhARN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404791AbhARNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:55:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A7C221F8;
        Mon, 18 Jan 2021 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610978117;
        bh=ykgFhUqSM1dyJBvw0Rywlt6WHe0ZmeC2SAS93hYZkRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWfeqVULU5LOFwX+zHhR7ooyTHeoB068knM+l7TtzY1V0br2LJrTuprNWbLljIhSQ
         +IIYMEH0tVE2PhpBjBJ82jzb2swQU2zcc/bErazzIdDOE+GsQgdW+gv9xN2I1tO9sn
         fajtB1v9z2BXgF/PaVGp4U8KqNCfBqzvzInOoOCCn8yoSLtbnnl+SDTA/vy2LrEiJK
         +Ex1pRMOnqoywNYYLBIHHMsPGGHyEsdksyTN48/XXE92yDXyoGgq1KR+JieSNUzgZe
         EamHHfuud0RIXDgf1lj13cZ1lxYPNL5H/uWPALj39S4PXZc4SbQ7gQvDubzk1giXy9
         KxS6dZ0ghhFgg==
Date:   Mon, 18 Jan 2021 13:54:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] regulator: hi6421v600-regulator: move it from
 staging
Message-ID: <20210118135440.GM4455@sirena.org.uk>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
 <d0a7cae3c654d25e01b0c436e00de55a21cd7f64.1610975633.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <d0a7cae3c654d25e01b0c436e00de55a21cd7f64.1610975633.git.mchehab+huawei@kernel.org>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:28:12PM +0100, Mauro Carvalho Chehab wrote:

> index f385146d2bd1..3b23ad56b31a 100644
> --- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.ya=
ml
> +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.ya=
ml
> @@ -60,6 +60,8 @@ required:
>    - reg
>    - regulators
> =20
> +additionalProperties: false
> +
>  examples:
>    - |
>      /* pmic properties */

Why is this part of this patch?

> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Device driver for regulators in Hisi IC
> +//
> +// Copyright (c) 2013 Linaro Ltd.
> +// Copyright (c) 2011 Hisilicon.
> +//

This looks like it needs an update.

> +// This program is free software; you can redistribute it and/or modify
> +// it under the terms of the GNU General Public License version 2 as
> +// published by the Free Software Foundation.
> +//
> +// This program is distributed in the hope that it will be useful,
> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +// GNU General Public License for more details.

This boilerplate can be removed.

> +static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct hi6421_spmi_reg_info *sreg =3D rdev_get_drvdata(rdev);
> +	struct hi6421_spmi_pmic *pmic =3D sreg->pmic;
> +	int ret;
> +
> +	/* cannot enable more than one regulator at one time */
> +	mutex_lock(&sreg->enable_mutex);
> +	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
> +		     HISI_REGS_ENA_PROTECT_TIME + 1000);
> +
> +	/* set enable register */
> +	ret =3D hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
> +				   rdev->desc->enable_mask,
> +				   rdev->desc->enable_mask);

If for some reason the PMIC is sufficiently fragile to need a delay
between enables it's not clear why the driver is doing it before
enabling rather than after, presumably there's issues with the regulator
ramping up and stabalising its output=20

> +	/* set enable register to 0 */
> +	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
> +				    rdev->desc->enable_mask, 0);

I'm not sure all these comments are adding anything.

> +	if (unlikely(selector >=3D rdev->desc->n_voltages))
> +		return -EINVAL;

This should not be a hot path that needs an unlikely() annotation.

> +static unsigned int
> +hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
> +				       int input_uV, int output_uV,
> +				       int load_uA)
> +{
> +	struct hi6421_spmi_reg_info *sreg =3D rdev_get_drvdata(rdev);
> +
> +	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA))
> +		return REGULATOR_MODE_NORMAL;

This means that for *any* load at all we select NORMAL - I'm not
convinced this is intentional?

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFkx8ACgkQJNaLcl1U
h9CCJQf+JZE52OG1ptTsbSKUutT6ORzmQVWG6aAfTo8g32Z9wgbLY2jYIVYh/gEd
dqFNvXFpVCy22tOaAKybiteHGhS4941GKXI5zQ/bkRTVaNt9S4H6qACeNJ9OZUvv
OKP1s5V1Xpdgodu4Zd1VAKrT1ewYxt6y4R2mltc5rb4sm9J2vkeYjnVd2bioe6Xp
BHMYppqMJoy3bxiRFizy91HxmwSD/v6FYk3FIn40+vYIGQ2OjBElMhBPO9xrdRy6
2BCgn+4WIQrK2pYGvE9Q4Kl7/9gj2SRUWEnUiVtygitrMCOC4OxyWbPMXZqFPo7f
uB6wUGsnEx2kEvbE5bryKYom/wcxlA==
=06Fz
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
