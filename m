Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFF20A406
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406814AbgFYR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 13:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406806AbgFYR2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:28:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBA720789;
        Thu, 25 Jun 2020 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593106095;
        bh=+cLEMVjTku86MUcyGtnbvMhIVdtdfpWtlg8bHe0HxS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0cyfFj7v5iSRT89cZq8Y9xYLAAk8mLVxDviIpgkIJlZxvK4KK5OlK5huFnye9MS47
         ZwxWovMm0Vr0C66ep/ca4Z26xPMNfPRsCZT1bXJeAK7vrFk3mU7nV2OR5gcoQnjcjC
         MTqUm/V1aUluuVyZMdqQmTlo/Pl2/aIkXJXWWtUU=
Date:   Thu, 25 Jun 2020 18:28:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] regulator: devres: Fix issues with kerneldoc
 headers
Message-ID: <20200625172813.GD5686@sirena.org.uk>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20200625163614.4001403-3-lee.jones@linaro.org>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2020 at 05:36:06PM +0100, Lee Jones wrote:

>  /**
>   * devm_regulator_register - Resource managed regulator_register()
> + * @dev: device for regulator "consumer"
>   * @regulator_desc: regulator to register
>   * @config: runtime configuration for regulator
>   *

That's an odd style you're using in your "change" here - why the quotes?

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl703qwACgkQJNaLcl1U
h9CPzwf/f6B18e6dGjmBa+8dJyb5hUKJgu2+kk5vswg3ivYrjYrAxbcncwebfftP
YDOydKCVr4S8SO57d8X9hHYlp3cOHt0zXkBGrPPdz54ndy7fa6nPOjlWxyR1Ry8j
YuDJW9VgtF1oVuVrSL1nR/AXCMo31Oz67DTdGfvoAeVKsVZTJ/9EbcGT4aBQRKG8
FapFIYQ7efRCXG5vjBsQo9NGFxwVmwYO1IvKLTvNb0AK8Lr5Ss3pWti2p4XJIr3W
oBpWJmVW+x/1j1wJG84fCyK4XcLkaN+eOi8rUM4kBxIqBxwzf+DbDsQll7znCNVR
0jcdkr4ZPT6f2B+bTb+aVmvcafR4ww==
=oM5u
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
