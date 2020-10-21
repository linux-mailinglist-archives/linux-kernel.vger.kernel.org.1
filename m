Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17031294AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438216AbgJUJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403998AbgJUJll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:41:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8287A21D6C;
        Wed, 21 Oct 2020 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603273301;
        bh=siJzHcRRa4KFW8mbtewNQ0VwcnQmGW8vm6PQQtUwqQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgAbg2FieVVn/zLLhFc75BZ61Uhak3BDPQbyYk+p4SASrDumbeFaeRXG4PX2PzRGF
         byq43QZBbBO6N3GetLDXYLPut8XG/0J65osDeZr8lJlnUrUn//2e+zQMfVPohlbPgw
         KHz43NdCE339fNCA8XtfZJnTWSbIxBXAHgiotvqw=
Date:   Wed, 21 Oct 2020 10:41:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Defang Bo <bodefang@126.com>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        Vishnuvardhanrao.Ravulapati@amd.com, akshu.agrawal@amd.com,
        weiyongjun1@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: amd: move the call to devm_kzalloc below
 platform_get_resource()
Message-ID: <20201021094129.GA4497@sirena.org.uk>
References: <broonie@kernel.org>
 <1603263867-8754-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <1603263867-8754-1-git-send-email-bodefang@126.com>
X-Cookie: That does not compute.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2020 at 03:04:27PM +0800, Defang Bo wrote:

> Just as the commit <4cb79ef9c6c4>("ASoC: amd: Fix potential NULL pointer dereference"),it makes no sense to allocate any resources if platform_get_resource fails,so move the call to devm_kzalloc() below the mentioned code.

As I said on my previous mail:

| Please keep your commit message wrapped at below 80 columns.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

>  	}
> +
>  	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data), GFP_KERNEL);
>  	if (!adata)
>  		return -ENOMEM;
> +
>  	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,

This appears to add new whitespace, it doesn't seem to do what the
commit log says?

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+QAkgACgkQJNaLcl1U
h9BgQAf+JOwEXFuMzMDzjpL/SJstQqvXa6N4Sxd6iMSbuUka+npx/xEAcRW6OZYe
/61Xayeulywoe7DyncM23aB77FTXZ6UgJXvfMxURFa1Q6a1PJzClKriGLlkFgNbN
8/UkeUjsur/Lg1zckfGA0K7Nrhjj/BS+n5DF9cKDSdtsQEhRn+FQjPnZth/Vfjvv
xClrvK9CNQ5Y5xCrMMeUwh9obKeRbN9Pi3eQG+MFfzci0kKul1SkBZUff+PFbgML
KNYMkHnwcff23/VboGncsbyY6J0z9TWQjqKzPfD4ub1Kco0sPmBp20JCvIQtssoz
vG6caxw+Hkp9U+vmK36Rex04RGQQUw==
=ThGY
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
