Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433751F7B73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFLQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 12:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLQJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:09:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDFC20836;
        Fri, 12 Jun 2020 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591978165;
        bh=fw3+y3jTQ/X9e2wxCd6+ulf0I5tMAzgBntQiTxh6tj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfM5E2k+jRvOGx5FUPL2TzrsdL03GrvntWrM9UGRM32rWx0PHS3pshPiudTDVkI5s
         JD6RDgKyF/BmXsCdd24KcBopCMSBxZM7/zM2RFpr7d1SgTe4VL6sNmahb+2fAntQS3
         qpj0aMNN0J+M91nYmruvkYk2w9Z6bE85ulhvmi2Q=
Date:   Fri, 12 Jun 2020 17:09:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
Message-ID: <20200612160922.GL5396@sirena.org.uk>
References: <20200612160603.2456-1-dmurphy@ti.com>
 <20200612160603.2456-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Content-Disposition: inline
In-Reply-To: <20200612160603.2456-2-dmurphy@ti.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 11:06:03AM -0500, Dan Murphy wrote:

> -	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
> +	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
>  						      GPIOD_OUT_HIGH);

This also changes the name from shut-down to shutdown which will be
incompatible (IIRC we do try -gpio as well as -gpios).

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jqLEACgkQJNaLcl1U
h9CZ8wf/d5qODxuDpJv7I7DVUFHsWC+TEvljN5BSeNaWD8YPZp7AGUL7Ayfvc8jv
LHN5Bjt52gLgOGS9Sg8n3bCgI6fh72PPzPJcpV7GeniZx+WWU7nUdN9yz1kouS4H
NPPMG9qaWS2hRFtB7IWEH+DBDTCcNQ/piY8DICO4fzw17JcK1uDec0jk1dila3hx
UozPf3Z/icwZHOvrityv25rWt0V6lStgMJTWntynX/TbCVUzgLgmEbhboo5OqQp8
FdM6CJxkqelIG3SsswJyfGESVZLUpLMDfzwwLuGPvdCEzoKlv7VEX7LyEHFaBVID
1QTPOijQpcapd3GyZ1ziauKed7H2MQ==
=vLSK
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--
