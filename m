Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8810E2FD698
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbhATRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391720AbhATRJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:09:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1395C22CE3;
        Wed, 20 Jan 2021 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611162502;
        bh=+EA4BgA9wcRzXp9jCezrlwfgCb16Dxb7OUXiBOuskcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSD7H0nMt0En9yfm1b8BmXstdnlee60tQdKDif4TwbX9p4vDRLZnlw/gqXvO+bo2A
         uOgj9rig1zLJDXc5K51LiiWs1LQa68wSv21DTSEDep5TkN7zuA5G88CncIwUgMOygw
         C6HZ52aqWeX8SlyKwfc61EH8zLtVTAq7Nfj6vrHdizMKyqIRgRT3upzD38SOJ9mAtb
         QHAQHc8XbuyY9eTu89xc9RmHLhyIcsTB9g4GGlPBSFCNVdd8ujAyY/6MZ8vhcSP5mP
         QMRMObXjHV6rx9MyPjw8sRIhtAyYSLk0z1m5gLcpLBtpcMCaODy8ktpVaN4FlDxDQu
         +To9X6FW82p3w==
Date:   Wed, 20 Jan 2021 17:07:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/21] regulator: hi6421v600-regulator: move it from
 staging
Message-ID: <20210120170744.GD6794@sirena.org.uk>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
 <8000252dfd10677c5eb52d498e68de9c65304cf4.1611072387.git.mchehab+huawei@kernel.org>
 <20210119161950.GC4478@sirena.org.uk>
 <20210120000244.2f1862d6@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20210120000244.2f1862d6@coco.lan>
X-Cookie: Beware of Bigfoot!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 20, 2021 at 12:02:44AM +0100, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > Now that the driver has been converted to regmap these are just
> > duplicates of the regmap helpers.  You may also be able to use them for
> > the disable() and is_enabled() operations, I didn't confirm that that's
> > OK with the device using multi-bit enable controls for some reason IIRC.

> True.

> In order to avoid re-submitting 21 patches, I sent such change as
> patch 22/21 .

Unfortunately I can't actually apply the regulator bits as things are as
the MAINTAINERS changes are incremental against the prior patches in the
series.  What's the plan for getting these merged?

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAIY18ACgkQJNaLcl1U
h9DdqQf/RfUqAbZOvJBTUQd3ymBVt6BMSkZE4A8mK93gY9BeI3DSaK4N7x5gztdb
GP57SPko4UprseA+ez9Lckxj+lneFvlS2x4kGYkz4B5rhJRt9IGj1jDFf9tP+viY
iE1rGAoQjbpzxaEremjL/vAY6e/blXMuTkfxrp2N4Hf/Tnyjt/6xYYJw1D0SMOt7
V1OyxUFG1ej1PV6QCkYPN6Pyfe+I9K9xFigB5Z70S916D6IcJzN44zcVDtqAajCO
YirsRUNcSoPm8MXgD2OVS2h+VjIxNTmvHVh1mAATO1TIyGg1mk0E5TizePYKXHbi
qR6jYQMmutb/MykaXvKUMhbuBy5Dlw==
=iwb9
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
