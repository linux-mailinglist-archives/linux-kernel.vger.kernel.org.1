Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2903045FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394063AbhAZSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405981AbhAZQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:35:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 307BE22228;
        Tue, 26 Jan 2021 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611678878;
        bh=0iyjx9boFIh74MC5/l/2Yp8BztMttqvXyEtvQewHavA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ek4sZI8aCOq02qRSkkAah5D3YfuYGj9sge2KMt6yowtj6N0AE605A/AFr+Dtq69n3
         3BnzIcR8LoG5gejwnhlGMZehSA02+zTsnBkxAQNJJOYkVPXy3qe1ORHyNpodqL55vQ
         Ec+9XxyG8Wizd40+eFXuPj9ALr4B+JOMLptgjdQzX2aLbQvAekXpVqcXKZuM64525g
         iFSmbjqtzq4lLJuPO7J4iaSbXqOl5P8mibuTX5hyb6/RpB1WMaWSc3JaqoiDDa/D/u
         c2J9jwsppZwW+MyhO/8z7HefwoG0YD4NdGJAHWhxhDiDiJHQ659zo5xT44s3nFeQk2
         inn5zy0EHBhgQ==
Date:   Tue, 26 Jan 2021 16:33:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: [RFC PATCH 1/2] ASoC: soc-component: add
 snd_soc_component_read/write_field()
Message-ID: <20210126163356.GD4839@sirena.org.uk>
References: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
 <20210126133612.GB4839@sirena.org.uk>
 <6816a9fe-9b71-6a39-485e-1b6ce2b732ed@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <6816a9fe-9b71-6a39-485e-1b6ce2b732ed@linaro.org>
X-Cookie: I don't understand you anymore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 26, 2021 at 02:03:29PM +0000, Srinivas Kandagatla wrote:

> Does that look okay to you?

Yes, your proposed versions look good.

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAQRHMACgkQJNaLcl1U
h9ADwwf+JT6mbAuIukTVeyd/KxuU+4ZK6Kq36Lwy7d+pRUHdwy/6sJ3z2fwr6EA3
Km7ACyvU6uWpCbmTZkVbHbaIUnz5S+sqfGKXWJCLs9/5aNHsJr1hYa3C/nAe43fK
aZ3oxmzq5tqisBS+M/4RpsrpRbgCmDLV4oeC8YQ7BcJSTZ3Y4FYSlNEaRaEtBK2L
qJSB6cVIwHs1nEpTI/8nL7MYgv/MYvlsaOhRUR92csp/h3pNB+FAOjnkXMWN8Yyj
RNWfLjYdH6sX3t8hUoSedWNFqQ6NsEZ+JeJ4k8GjP1fS0o0UoMR/3XfkkxmNm4eP
ONn79xWMP5K/tbcJ/ERQyMXrugYHiA==
=IBI4
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
