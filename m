Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEFE2C2DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbgKXRH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390674AbgKXRH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:56 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D1B20857;
        Tue, 24 Nov 2020 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606237676;
        bh=W7tyEH2c9Wz8tVJ+CN2oLzJ70V6jezJ5X5Wdt4/mKXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVdQ/e0HCKmfCDQgcY1naKkMjYNvREHAFrK4pPdCLL+d75grZpQhAJUdjLFvHKVQP
         5iIQa9VqR62jIlhS5vb3p7mn68JWdD5I/GLkCeHvMhkXx3qLZho/JrJptCtyc/od2W
         +un53fqhGt3bzUh+L6UA6MlPUhDONdTYiYfhKWag=
Date:   Tue, 24 Nov 2020 17:07:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Wen Su <wen.su@mediatek.com>
Subject: Re: [PATCH v3 5/8] regulator: mt6359: Add support for MT6359
 regulator
Message-ID: <20201124170732.GI4933@sirena.org.uk>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1606103290-15034-6-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2xx78T4DcG3O+DJ"
Content-Disposition: inline
In-Reply-To: <1606103290-15034-6-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2xx78T4DcG3O+DJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2020 at 11:48:07AM +0800, Hsin-Hsiung Wang wrote:

> +static int mt6359_get_linear_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct mt6359_regulator_info *info = rdev_get_drvdata(rdev);
> +	int ret, regval;
> +
> +	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev,
> +			"Failed to get mt6359 Buck %s vsel reg: %d\n",
> +			info->desc.name, ret);
> +		return ret;
> +	}
> +
> +	ret = (regval >> info->da_vsel_shift) & info->da_vsel_mask;
> +
> +	return ret;
> +}

This looks like it could just be regmap_get_voltage_sel_regmap()?
Otherwise the driver looks good.

--w2xx78T4DcG3O+DJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+9PdMACgkQJNaLcl1U
h9DDfQf8C8s9n/n3qdfuHW2Kn6XRiTrl88H+miBsBgQRQPKZzHNzh51rQMJiVwAh
jOY47elYyA07c5K+NtqWgpXJiVIwujB0I4jGvhOlDMv601QZ1SuJE0mWmxubHNuF
ZD9QIpzmh/xJRWogoFhoYZkpDOyqkD9lCc1Z22XVVtk5aVCHvk5hRa+u9mZuVF2T
S77qGSSN8yuIhu/1uSR7sYlwvIMwJFdeCyGuanGqkrAvQzh7IGPJ0SAJcTIK7c65
Voz40qO52JKt7Fvdaegh7q4UGKoaKptkGHFCtO7qnr5Gp18zCFqinPzQOaV97uee
8+aE/yewzw8ceYQH80HZTNDguih4UQ==
=eVLl
-----END PGP SIGNATURE-----

--w2xx78T4DcG3O+DJ--
