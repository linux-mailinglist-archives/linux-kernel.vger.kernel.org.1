Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C22299A38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395494AbgJZXLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395447AbgJZXLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:11:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E66D20759;
        Mon, 26 Oct 2020 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603753902;
        bh=MRx2pBBqNPPfjwNb906kXs5hP1/uC56QOW9EGdn3PIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iroCn2XGPTOZbcWO9zqylWO0Z5a2xG0/amHaI4/LeFmHV1wvJYcgwUpKlAmF88xsn
         uPVdqzdJJVfpoGLv0tdgb3JLXiXXyNdjRugo+NTkZrAbNCVcVsLnxJ7BWASsKq9Ebs
         1/G5GkX3PEgA9dqVRFN3YbalBIVxfvYic0fb2hdk=
Date:   Mon, 26 Oct 2020 23:11:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Message-ID: <20201026231137.GA46087@sirena.org.uk>
References: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
X-Cookie: Positively no smoking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2020 at 02:02:54PM +0100, Srinivas Kandagatla wrote:
> make use of devm_of_platform_populate to remove some redundant code!

This doesn't apply against current code, please check and resend.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+XV6kACgkQJNaLcl1U
h9BzLgf8DAWyEk1h1XRBvNnSUDsTNffEVpxFffPmHUbEWIBd4zOJR6lkPSqj7/Ka
+Wag2B3/tHXZmo3VqXJhHILqeOusboC2/6AFNDWEgRMzqPEkCi7k8vEPY0jHx8uq
uSn1gzWFceGhroynl7cklAlrfDQGF64K3tif4u4RVmXt9mO+ZldU3RTDai05u4gq
2sgLj9K3lvkABbDOsNMhS9TZNM8pExLCJKmLOPVDagaa3KSJx/ew5fJ6GREVWehr
7xPu2yPLzNNDfmsQw2ciCqBmEdftXGCL42wys92UuBqBgnImGLF+tfe4u6baj/0x
It14csewGM7Ts8x2euOs6EjiR11RxA==
=GnyX
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
