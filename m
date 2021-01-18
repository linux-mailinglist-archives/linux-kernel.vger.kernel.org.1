Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D682F9FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbhARMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391598AbhARMdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:33:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12DF822B40;
        Mon, 18 Jan 2021 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610973156;
        bh=NOzKU5hLhxWt9+Tdt0zw013lkk75mG+c9I2CZ6dYVcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAnPAPV4f7cXji1Hnb6t23mg6r3uPfwqKVqwRu1EzwuD95okjqfkQFthGnp98ie6g
         +r6cvzQGOsSUJn+AACkK4RV/NmAgu9T1scviiJMzvkJ+iQe1PBQMcYreTSjpVx7IzM
         spnUCwpcW5Ko60zxeOUcEpspu49uGS3hkmJAAe+fjjtBpNPUEDSAV0oD3+QixKQSjJ
         L2R+Yd8M2onLKV9+B1qVygZ7A/VqAinvdGeF0/IWg18huB6JwKroAr/NY9nZ0ZFmKL
         2b23FxKC9Uq6hqw0+I49IE+DuaFl4OuOPn2IMe8bgD9um04noQkPBWcwMMSNth+hvN
         kf7Kxz5z3dhyg==
Date:   Mon, 18 Jan 2021 12:31:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH 4/6] regulator: Initial commit of sy7636a
Message-ID: <20210118123158.GE4455@sirena.org.uk>
References: <20210117042539.1609-1-alistair@alistair23.me>
 <20210117042539.1609-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20210117042539.1609-4-alistair@alistair23.me>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 16, 2021 at 08:25:37PM -0800, Alistair Francis wrote:

> --- /dev/null
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Functions to access SY3686A power management chip voltages
> + *

Please make the entire comment a C++ one so things look more
intentional.

> + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> + *
> + * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>

This probably needs an update.

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

This boilerplate is redundant and should be removed.

> +static int get_vcom_voltage_op(struct regulator_dev *rdev)
> +{
> +	int ret = get_vcom_voltage_mv(rdev->regmap);
> +

Why is this get_vcom_voltage_mv() function not in the regulator driver,
and why is it not just inline here?  It also needs namespacing.

> +static int disable_regulator(struct regulator_dev *rdev)
> +{
> +	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
> +	int ret = 0;
> +
> +	mutex_lock(&sy7636a->reglock);
> +	ret = regulator_disable_regmap(rdev);
> +	usleep_range(30000, 35000);
> +	mutex_unlock(&sy7636a->reglock);

Why do you need this delay here, and what purpose is this lock intended
to serve?  I can't understand what it's intended to protect.

> +	mutex_lock(&sy7636a->reglock);
> +	ret = regulator_is_enabled_regmap(rdev);
> +	mutex_unlock(&sy7636a->reglock);

This lock usage in particular looks confused.

> +	ret = regulator_enable_regmap(rdev);
> +	if (ret)
> +		goto finish;

> +	if (!pwr_good) {
> +		dev_err(&rdev->dev, "Power good signal timeout after %u ms\n",
> +				jiffies_to_msecs(t1 - t0));
> +		ret = -ETIME;
> +		goto finish;
> +	}

This doesn't undo the underlying enable, leaving the regulator in a
partially enabled state.

> +static const struct regulator_ops sy7636a_vcom_volt_ops = {
> +	.get_voltage = get_vcom_voltage_op,
> +	.enable = enable_regulator_pgood,
> +	.disable = disable_regulator,
> +	.is_enabled = sy7636a_regulator_is_enabled,
> +};

The namespacing for functions is very random and prone to clashes.
Given the power good signal I'd also expect a get_status() operation.

> +static int sy7636a_regulator_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct sy7636a *sy7636a = dev_get_drvdata(dev->parent);
> +
> +	ret = get_vcom_voltage_mv(sy7636a->regmap);
> +
> +	if (ret > 0)
> +		sy7636a->vcom = (unsigned int)ret;
> +
> +	return 0;
> +}

What's going on here, and if you are going to store this value over
suspend why not store it in a variable of the correct type?  In general
it's surprising to need a suspend operation for a regulator.

> +	sy7636a->pgood_gpio = gdp;
> +	dev_info(sy7636a->dev,
> +		"Power good GPIO registered (gpio# %d)\n",
> +		desc_to_gpio(sy7636a->pgood_gpio));

This print is just adding noise to the boot process.

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFf70ACgkQJNaLcl1U
h9DVcAf/X6NYcyt4N0xL4hg5lqm/UFmFafUgWal2fks4I/U4186CC0iiRUbkq8Fi
HTp0il0ioR1Ge784/jvWyfyF9/l3vp/71hOkElEcc2G1i1iPEqFsiL0PE0wYqrqS
1s3naymf9tvNT1pFHWwv4JKmNf7LY/oG10BjtX9dz7Xtd7Mm/BJnIf95j1QcmRnT
3APl4k7F6tXVWNbzAWl3CB9CHJW9+BR/YcUECAKW9P/7YuHs7EXvo0y7SEsPn48W
nqHj5EJqB+NKJTn3plkRUKLbgff7QGeTxUo/QshqnVARwshQ6axJ12Pns0TTg0Rp
i64ZAuwI5XPz/3a4d+rI/rpWZ6cLwQ==
=ii0P
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
