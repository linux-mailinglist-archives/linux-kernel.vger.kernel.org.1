Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FA325453E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgH0MrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgH0Ma1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:30:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5365F22CB2;
        Thu, 27 Aug 2020 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598530850;
        bh=4/JCZZZKd3GAf8uGJdQVfmYilwVSlF/9voYKJmjwsUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2NbpzukTEt73j72RQ+t6LucIKcDF2zHs3wQClU8BR5wA1osb/Tc581/HNuxt+P4HF
         LksM0gHFR7jPzu+tu3LGQjshUqN0MdYqCka2EppA7FMsiuJHtDEIf0wbuWURuWM2le
         p7gCHA523n3rzTx2U7n/uVFgH9E1jAyaffEk29q0=
Date:   Thu, 27 Aug 2020 13:20:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        hao.wu@intel.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com, trix@redhat.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH v4 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200827122013.GB4674@sirena.org.uk>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <159846941049.39902.15220563960562003689.b4-ty@kernel.org>
 <20200827065647.GQ3248864@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20200827065647.GQ3248864@dell>
X-Cookie: Causes moderate eye irritation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2020 at 07:56:47AM +0100, Lee Jones wrote:
> On Wed, 26 Aug 2020, Mark Brown wrote:

> > [2/2] mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
> >       commit: 53be8bbc2f4058d4a6bfff3dadf34164bcaafa87

> Que?  This is yet to be reviewed.

Sorry, meant to only fetch the first patch.  Dropped now.

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9HpP0ACgkQJNaLcl1U
h9Ab+wf/cLWjo0P4b+tIGlW0ybqnP9R85uWysei9vdgfeX/ZOcbpEhay0/1rTNwR
qmkptpzH3IXdT1A1UmBo10WW12oDJMx979W2XfFhpooJh9GlkTq497ioZFLd6rFI
1Ftl8Y8igT+OsKMS/BQdyvMtjgggCoKZgSPt6akPKB1zlAhDyskEk/80f4Xy9A3M
ZsDJAnqVUrN8xesIyj6T9FrHgDKaW2RbXXmOOX4hQqn+XYImi43qmpqoeLqfTjNM
0D5jGHM6RHFiJX3cMma4O5xub5ciAWiVy858hznKwRsDPfGMKB1nSscaPcfjidR5
s37EB8K+XcvZ22H5YnpRP24WQxgAcg==
=dGJr
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
