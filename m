Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82A82A962C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgKFM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgKFM0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:26:46 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2014F2071A;
        Fri,  6 Nov 2020 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604665605;
        bh=9V54Jr5H0EdeTkVkxoMOzaxfGCPypxqBxjaZGL7Cm0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYs4+EV9t/i7hajNy4K6BMmfClq3akssETZ5FGnkl1Bz74kMf3QK3ypU5VbkJuPKI
         WITwP9TSJ5JIDC86DozewaI5KFy0ONn9K2/+Oj9teymV2hrgSLy6T3YfMp7VP2D2vJ
         dDxIgjcFQINek/iwsif4jj1chN/dZZwRY4+qoqms=
Date:   Fri, 6 Nov 2020 12:26:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shane Chien <shane.chien@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        jiaxin.yu@mediatek.com, chipeng.chang@mediatek.com
Subject: Re: [PATCH] ASoC: Fix vaud18 power leakage of mt6359
Message-ID: <20201106122633.GD49612@sirena.org.uk>
References: <1604643517-3527-1-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <1604643517-3527-1-git-send-email-shane.chien@mediatek.com>
X-Cookie: When does later become never?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2020 at 02:18:37PM +0800, Shane Chien wrote:

> +static int mt_vaud18_event(struct snd_soc_dapm_widget *w,
> +			   struct snd_kcontrol *kcontrol,
> +			   int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mt6359_priv *priv = snd_soc_component_get_drvdata(cmpnt);
> +	int ret = 0;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		ret = regulator_enable(priv->avdd_reg);
> +		if (ret)
> +			dev_err(priv->dev, "regulator_enable err: %d\n", ret);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		ret = regulator_disable(priv->avdd_reg);
> +		if (ret)
> +			dev_err(priv->dev, "regulator_disable err: %d\n", ret);
> +		break;

This is just a SND_SOC_DAPM_REGULATOR_SUPPLY widget as far as I can see
- why not use one of those rather than open coding?

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+lQPgACgkQJNaLcl1U
h9ATgAf+MT1NV/U76nz6AUWoZkMQhuvyA3qL76F+YzE1WOVNx0KUfjs4EkbXahvJ
+UAo0/iy/ZxtVGfKB2yGpdNb3rCVPhi4kjoUHx+o3qKdXqf9Eq4Ax45OKzTJF1PS
3FtGEnGsOEyJuhCDomp9MTdWDQq7LlypB9Qv7BnNjU/XHt7KRZEUGAiQv4EwuwYq
qg/H+tqFg9zozQFj2tXP7gvvsFcRZfTUqqhnlgob33RUvVKT3Uyiw8voNbeFuXby
NQym7YshcBcIv8EiS3Tvo3t5/FOx0/+/4EPQU53Mtxv4PQafMqQlseEUaN7U83ou
E9gWxWQ6vcKW3HNgGcDFLfUmnURj+g==
=IN8z
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
