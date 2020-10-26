Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD00298DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780049AbgJZNaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780033AbgJZNaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:30:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB0624641;
        Mon, 26 Oct 2020 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603719008;
        bh=47xZnNmgaWb2Nvry34Wr0Gg1IlbyBbZg6E0TRu2Og8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYC1/7QI8zplIgXIdmH+wo8zWU0rdI7LtnjUjK9PriIjHJka+pxMljrbGIEGcjpJ0
         HDpl8AcGB6iuB+R8Q1SwfdWqvIymNTn4VmxiY0kDQei4uVUCjqj96VDBcnOv36RiTH
         NlNQV4mCEqg64Iv5xk3NrhwW3oTlHPWK4Ccl+LOY=
Date:   Mon, 26 Oct 2020 13:30:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
Message-ID: <20201026133003.GD7402@sirena.org.uk>
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
 <1603708855-2663-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <1603708855-2663-2-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 06:40:55PM +0800, Shengjiu Wang wrote:

> +static int fsl_aud2htx_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *cpu_dai)
> +{
> +	struct fsl_aud2htx *aud2htx = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	/* DMA request when number of entries < WTMK_LOW */
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_DT_MASK, 0);
> +
> +	/* Disable interrupts*/
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> +			   AUD2HTX_WM_HIGH_IRQ_MASK |
> +			   AUD2HTX_WM_LOW_IRQ_MASK |
> +			   AUD2HTX_OVF_MASK,
> +			   AUD2HTX_WM_HIGH_IRQ_MASK |
> +			   AUD2HTX_WM_LOW_IRQ_MASK |
> +			   AUD2HTX_OVF_MASK);
> +
> +	/* Configur watermark */
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_WL_MASK,
> +			   AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> +	regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> +			   AUD2HTX_CTRE_WH_MASK,
> +			   AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);
> +	return 0;
> +}

This doesn't look like a hw_params operation - it doesn't appear to
reference the params at all, or even containt any conditional
statements.  Shouldn't this be configured just once at driver load?

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Wz1sACgkQJNaLcl1U
h9BRkgf9GJDUVG/3LsgNUi10w457aA3PPnnK/cZnW28xpxfqtNNpZ2+HycVG+ky1
qwJAezTyWBG+OP2aZy3h8F68htNT3KqgkybywSCjdE8/wSqvTT42KTRDbqJuhr1F
Mnx1+Opres2oQkJqcTUqUkcnIc4gSSZYR9vzzUF7oRPgxF6AKTFLwFfDSsve8Nds
b1oJ6xeiAXrNZM+S1+ESvuaSlZzrK3fL00OxgFG0IjELhy+Wcasf+5QKbiego3BK
2PcYrQjRLqXCqXOw9ABpKZWUqruNAf6JuRryoGETL+OPP2uXRuwh5lXIhUKfNosa
tv1qtawmZN4dyUUGxBPWVV44Lf1FPw==
=1hAM
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
