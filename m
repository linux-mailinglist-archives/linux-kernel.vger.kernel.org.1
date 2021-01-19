Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C12FC585
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbhATARD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394551AbhASNrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:47:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF27D2250E;
        Tue, 19 Jan 2021 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611064020;
        bh=x3Nf2PHRn9TwCsGFAWZvhYd7uIrj1x5RZr9UBFNVJvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRtWhGL1UcgDyQqM/m9RtVxZGLZTxGdjkFunj+TAhpCLnecQy5vaei/eZCiA0ckLn
         A3NgGUUZzwkuMmtLooMWt7LzaogkfIrenb/WeqHQ7mTxXwOcGp5K1w5zs3qf6n1YD3
         tL87yZ4LlXOlnqvldr4acw34XgwhEb68B64vToLmy4foHDvRUDGKE+8E3uh9rx9JqE
         P1iMOmlQqlq7v9zwFA7oF881FFTMtenUU1ZF9Cg3udLzA/TZroHSX2XJuTkQsT6NxA
         C3q8Mo1org1pLAMf8AbsCYopDazNeJSYJo4wnGGD52O5DDiT+8M3OBGfaWunr3LLBw
         dAxQlFxMSSw7g==
Date:   Tue, 19 Jan 2021 13:46:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/18] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210119134622.GB4478@sirena.org.uk>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
 <aa17f0fee8cfcd654e107897d350cb3b0438763b.1611048785.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <aa17f0fee8cfcd654e107897d350cb3b0438763b.1611048785.git.mchehab+huawei@kernel.org>
X-Cookie: Yow!  Am I in Milwaukee?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 19, 2021 at 11:14:20AM +0100, Mauro Carvalho Chehab wrote:

> +int hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg)
> +{
> +	struct spmi_device *pdev;
> +	u8 read_value = 0;
> +	u32 ret;
> +
> +	pdev = to_spmi_device(pmic->dev);
> +	if (!pdev) {
> +		pr_err("%s: pdev get failed!\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	ret = spmi_ext_register_readl(pdev, reg, &read_value, 1);
> +	if (ret) {
> +		pr_err("%s: spmi_ext_register_readl failed!\n", __func__);
> +		return ret;
> +	}
> +	return read_value;
> +}
> +EXPORT_SYMBOL(hi6421_spmi_pmic_read);

The I/O here looks a lot like regmap_spmi_ext.

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAG4q0ACgkQJNaLcl1U
h9Bu+gf/QL/7v3L34aIxXW3kud1F+4veVCvL3XD1ZfuYTqQp907pWqUKpPqGQbec
mG66jEV1IR/iRNjHwbrZYak3VC/SJHREm6/NDANQKNH28IL6AG0nLiCPpGW3ejJP
f4dUMyzVs79uMNEOVXGwOejOLtKt8eHvZM4ESbbUFXUR3aeelLsNoKYdWwKgC2Kx
hnbC8aSIw+wugd/AjS5MhDngdCgN9J0JoIIhrIqW252iiKFaqD+4hXFZrkXOiOVe
WcTyBgpXqsocPPrTlOGHbHOEjah3Yl4DP1otSN+9WbLGjBP6CU472HvcDHXNYzs8
PzFPUxDqDBSQGyz3QAEw4Me3yxFzGg==
=H1ya
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
