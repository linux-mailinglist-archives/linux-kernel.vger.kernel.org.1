Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4F29F070
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgJ2Psn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbgJ2Psl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:48:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C536220790;
        Thu, 29 Oct 2020 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603986520;
        bh=lZXkXvB++kN3Ce92JpUsetI/oA9F8LhgtrtJ4ZSH0Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjF89X4c8iu9Gr1X6jkPXD/6Ow9dnj+bvdmIX/+byj2y+RHbNxUbQOy00VyamfrA7
         fAJ3MohYUJY2juUuQwmLoPu7N8ZAbnfR1lwqCnwtuMn48zCTAALbZdka92RuGQ2+Is
         +3qXrpCgumddFSjk2JEGLT4V1/7DOS/61g4AjJTc=
Date:   Thu, 29 Oct 2020 15:48:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] regmap: provide regmap_assign_bits()
Message-ID: <20201029154833.GD5042@sirena.org.uk>
References: <20201026151015.15527-1-brgl@bgdev.pl>
 <20201029151847.GB5042@sirena.org.uk>
 <CAMRc=MctRhVzmJwquO5pQDjnNP5HTXrG7qLN7r9Ky+aEuSCBDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <CAMRc=MctRhVzmJwquO5pQDjnNP5HTXrG7qLN7r9Ky+aEuSCBDw@mail.gmail.com>
X-Cookie: Monotheism is a gift from the gods.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2020 at 04:44:16PM +0100, Bartosz Golaszewski wrote:
> On Thu, Oct 29, 2020 at 4:18 PM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Oct 26, 2020 at 04:10:15PM +0100, Bartosz Golaszewski wrote:

> > > Add another bits helper to regmap API: this one sets given bits if value
> > > is true and clears them if it's false.

> > What's the use case?

> Basically what the function does: set bits if a condition is true,
> clear them if false. I think this is a common enough use-case to
> warrant a helper.

I can tell what the function does, I can't tell why you'd want it and
simply stating that it's common isn't helping me here :(

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+a5FEACgkQJNaLcl1U
h9AJhwf/W1iI16NraXvHR2uK20BtteEA5s+Bn7m4bye3sxOVBEf2g1DRz0I6UzE2
hrmaR/M7ufyJ9K/Gr/8Ox/qmYDxOiQrU7856A1WTIDbOpDV0flacdcxnpRsMyXXR
VMZNlvBhXkSuhWb8IlVCVPNMFaC8gccTIJFNOlXBrd9TWQSMUTeHuFFOlYY7YtMq
62Jkn1JAVZVzJPswB0wGmd7si1j4vYwREkbjbkXrNgdhm8LOqeRjU4CsZ08GiPkZ
qqJw36aKX3yeS03E4LbG6+nX2Vg4A096wH7SnCElVglXs5LT4HNbwIdMohW/b8tp
zLExU6JRX2ABdIPTu/52SDqI3ZExAg==
=SITy
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
