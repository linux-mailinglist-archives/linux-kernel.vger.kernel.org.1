Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C401923DEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgHFReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0563C22DBF;
        Thu,  6 Aug 2020 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717466;
        bh=jL9tYWE9iw+uSM7TMvqp3lXSaJ38TCtcHbCBzrH9URk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTKNqPDOSoDVsrkVCQRBkhh82E5jMj1JeoqvMgmSvt/r52lW6IP0hCZe5xb6yX1XW
         Fc8UcvHlqyqILzqf79rqJaDtp8Yb62k7F06R3KpYF6ZDrdDO38gupAtHWt5GOOVQgy
         nVmjkYs7ZtApS1RJ24E/VGn1ob8gmyOC0Nm9rgi4=
Date:   Thu, 6 Aug 2020 13:37:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200806123721.GC6442@sirena.org.uk>
References: <1596699585-27429-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <1596699585-27429-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Hedonist for hire... no job too easy!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 03:39:45PM +0800, Shengjiu Wang wrote:

>  	} else if (of_node_name_eq(cpu_np, "esai")) {
> +		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> +
> +		if (!IS_ERR(esai_clk)) {
> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> +			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
> +			clk_put(esai_clk);
> +		}

This should handle probe deferral.  Also if this clock is in use
shouldn't we be enabling it?  It looks like it's intended to be a
crystal so it's probably forced on all the time but sometimes there's
power control for crystals, or perhaps someone might do something
unusual with the hardware.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8r+YEACgkQJNaLcl1U
h9AgUQf/RsD8CeWYDbaeEKFdJGHhIhdtwKO8qRAL1Z0U+AS4lEQwWdvppChPN90d
SjiFV8GtE1TIQ3IrzShwKjq4ZU1Kg8qWKcuqnTiqjQDoMJ11Fj6bWXqdwPSGioZ1
3mKOsJKQihgFHiXY+Xm1R3VuwpJiq19qSM94KYTy+K4p1NcS9Usdr5da5007rE/d
2RiyA2UvQjMtbCgOU8ZhM2XCRzwBUyFSGgmHvifONQIX0Sacr85m5SxW7teUVz36
5//kIoJlF/aOpi0dvugXYBPu1Ic8TVAAYWsIxVthtSvmV2dwKlorbO2X/VCJjbgS
V3SZRTvuY8ZlZdkOdxOSlCA8DNgtTA==
=nUjz
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
