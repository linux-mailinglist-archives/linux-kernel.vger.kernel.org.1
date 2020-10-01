Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156B527FF8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgJAMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbgJAMyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:54:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6D920B1F;
        Thu,  1 Oct 2020 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601556879;
        bh=TpoJ4UrV06C1KGmQmOOR2twdwBBcZrG1wMGgjgt7b0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSZP8QDHcWogvbqaO3LeErUFzl8VzCbAIe63RMkVs7dPR1au1uZB2gsc3yCX22dss
         KGYIukWd0AeU5EER/wWNgiaCK3pABgC9DHoMK7IDAujzRHy7boxX5KMOyglfXMdDc/
         iTeOvus7eOuoHyeh3S2vJWMd6caxP5Q2HnlaMcq4=
Date:   Thu, 1 Oct 2020 13:53:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: pca9450: Add SD_VSEL GPIO for LDO5
Message-ID: <20201001125339.GF6715@sirena.org.uk>
References: <20201001123447.1610-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <20201001123447.1610-1-frieder.schrempf@kontron.de>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 02:34:31PM +0200, Schrempf Frieder wrote:

> +	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);

We need a patch adding this to the binding document too.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl910VMACgkQJNaLcl1U
h9DWLwf+MOLjAxrA/lNrj4PpWUmdW8Gu02d3ZQj1WvUc3ZUToExz4H28Sy3LEzW9
UO+8NxzPPsp5ZVZF7hBjwLK0pFLGfGZO0A7gbc/YetYq3F26FEZ0iu65sZRMM/zi
4s3EXdL/UZHgRZiAlKdUGf0G06cFpuSueYC6devwJhivS43zvLJGfbnKhsALW8n9
829a9r2xtp3iutcT6L6tF700f4NQWObveknCakwgDCBXOiZmls99X0Udgblcp10p
jgsF1ZczX5o1YBhtxpQ/ArepTbW1gcF0m2OcN9nwVm2/0qFMNe3ySn3mrO1N6tHK
RhRLcxL1tUXbfGOuoyHIPwO55GZbrQ==
=4jRA
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
