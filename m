Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8E2803E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbgJAQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbgJAQ0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:26:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA3F20759;
        Thu,  1 Oct 2020 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601569565;
        bh=rFIiHKx9xR8FwXNa1B0rNzQj97c7/7Pi9wS3NAt0XtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6bqjH/VvT9RK9wsqpZkG9D+2rwnuyjxivA1g+QFgys08fPIsu9GzwB527uaGPCw0
         mHU0FEPLsoBuUrCFhqdtoZZpcBEZBJf2/3eLIy0EkYr1BOkI+HVGF0jpbBo/xP5JtL
         simADQ65xVApAzx1CMTG0D2XkeNtIsgCTDxWz530=
Date:   Thu, 1 Oct 2020 17:25:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: tas2764: Add the driver for the TAS2764
Message-ID: <20201001162505.GO6715@sirena.org.uk>
References: <20200930163809.6978-1-dmurphy@ti.com>
 <20200930163809.6978-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline
In-Reply-To: <20200930163809.6978-2-dmurphy@ti.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 11:38:09AM -0500, Dan Murphy wrote:

This all looks good - a few very minor things below but nothing
substantial:

> +	default:
> +		dev_err(tas2764->dev, "Not supported evevt\n");
> +		return -EINVAL;

evevt -> event

> +static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	int ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
> +						TAS2764_PWR_CTRL_MASK,
> +						mute ? TAS2764_PWR_CTRL_MUTE : 0);
> +
> +	if (ret < 0)
> +		return ret;

This looks weird with the ternery operator and extreme indentation -
could you please at least split the declaration of ret from the call to
make the line length a bit extreme?

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_DSP_A:
> +		tdm_rx_start_slot = 1;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		tdm_rx_start_slot = 0;
> +		break;

I'm not seeing any other handling that distinguishes between the I2S and
DSP modes anywhere - I'm guessing this is because the device is really
only implementing the DSP modes but because it's mono this is compatible
with the I2S modes?  It'd be worth having a comment saying this since
while that would be OK not distinguishing between modes properly is a
common error in drivers so it'd help avoid cut'n'paste issues if someone
uses this code as a reference.

> +static int tas2764_register_codec(struct tas2764_priv *tas2764)
> +{
> +	return devm_snd_soc_register_component(tas2764->dev,
> +					       &soc_component_driver_tas2764,
> +					       tas2764_dai_driver,
> +					       ARRAY_SIZE(tas2764_dai_driver));
> +}

This is a bit odd - can we not just inline the component registration
rather than having this function?

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92AuEACgkQJNaLcl1U
h9BbYAf+OXUXc8a9ucmuF714vCimWP7Xs6JYHxHZlADbWBOC+swlHom2WEPxe8Mc
jXNwUj9mVkeyLKcrMfU5f094l38hnJZfrtnPKlfKbnz/zfwNrC2oXGkzoT4Queyg
1jv4Zwuan1D0ZFIf1kEYh9L+g91RQdLixLwTimYhukN7YcC3cuWj4ybhsfEvqdzu
hEg2WFRpXc4Svtu3jnLGm1hQCjYNj+fr0PGYlIx/+4itiqOYy0WyWlHCyUMjBynM
vW58F577Ipvx3QvdrED5sUhe/7GACoArDCQJgJcpwZY8rulpzQQ8hRkCL819VkeZ
vZJpiu8dPD8Zuhip5E541lNBxknhNA==
=LkeT
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
