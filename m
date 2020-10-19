Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7449929286F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgJSNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgJSNn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:43:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E679B22268;
        Mon, 19 Oct 2020 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603115008;
        bh=W8PX6rOXCaKRqHspJHuuS7rqx2nHYinSDG9OKP9m+1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1bPtZ3TZtgL/qyYpE+WMjTFWRKX+0oNkQQpfWmu6NjNO5QxufZ/T+NZaQfQiZ6v4
         2et9xXNslnjaD1KUnXbpwG/kl204cVr0p+jl+IMi7bG5qmQXDhVlaYe2OLVKJHscyd
         t3ndVCFFh+sYs5arfI331jvs3Zyhe0Yrs4iQQnb4=
Date:   Mon, 19 Oct 2020 14:43:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Defang Bo <bodefang@126.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Vishnuvardhanrao.Ravulapati@amd.com, akshu.agrawal@amd.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: move the call to devm_kzalloc below
 platform_get_resource()
Message-ID: <20201019134318.GB4904@sirena.org.uk>
References: <1603110689-5015-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <1603110689-5015-1-git-send-email-bodefang@126.com>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2020 at 08:31:29PM +0800, Defang Bo wrote:

> Just as the commit <4cb79ef9c6c4>("ASoC: amd: Fix potential NULL pointer dereference"),it makes no sense to allocate any resources if res = platform_get_resource(pdev, IORESOURCE_MEM, 0); fails,so move the call to devm_kzalloc() below the mentioned code.

Please keep your commit message wrapped at below 80 columns.

> -	if (!adata)
> -		return -ENOMEM;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>  		return -ENOMEM;
>  	}
> +	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data), GFP_KERNEL);

This is missing a blank line between the two code blocks.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Nl/UACgkQJNaLcl1U
h9AlZQf4pIMSukqFAwur78kup/5uO0nSFrFowcRxx3ePupdTIvBQz3RPjMHiaSsO
ZoRY4654+ve5XZYMY54Dit+XKvjpEEhLCBlwo2AZ2JyzXxvgO3KApGv5OLwiTXgm
eWnCeJ6dwCBAcvwGVVznjbQGy7fZunyeplPlSxXZ31MM+eOxcnlnNKhl41gGln5B
p7jizhAwxPCPWrSd9H6OL8QyOcuYtNhZwi7vCeAGPhQHYBka3iyX3JjuUekYc3GN
6tgo4j19n/vhQ5ew+WiP9pwaIZmCxqRHc/BALE5fs4hsLm0zZeHVOTKiux+sNAKB
Q7LYO2QLGbNisfknv3x9c9P5of1r
=oX0M
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
