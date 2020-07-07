Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F3216A90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGGKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgGGKkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:40:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A242064C;
        Tue,  7 Jul 2020 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594118422;
        bh=61A6erdDeB8jrWfvMNGi7dKemTfgdHKOCeXNQhFVShE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hw55PYBzLRgZk41iON4wdaNO/2h9uFNjSs1oNSBjnlLu3EjOOV3JRyNBQNsXJ1ix
         VM7lFdmln9imZELUPRCMYbL+0ydckQrsBNyTZ6xcsN6DK3iZfgu7nldWfIRCgEKlFS
         1qi+Xsy1ESKUwtHUyihG+5yLQKE9QhIhti0mtvNk=
Date:   Tue, 7 Jul 2020 11:40:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
Message-ID: <20200707104017.GG4870@sirena.org.uk>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101915.GC4870@sirena.org.uk>
 <20200707103735.GG3500@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20200707103735.GG3500@dell>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 11:37:35AM +0100, Lee Jones wrote:

> Some of these issues have been present for years.  It's quite the
> coincidence that we both submitted these this week!

I'm guessing you've both been inspired by the 0day bot turning W=1
warnings on without having first done a cleanup run :/

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8EUREACgkQJNaLcl1U
h9ADyggAgTKMerlBwe/6a+3hugV8TxE6uP5Yh+jiu2rmA9pJiv9mLr+Bj5gfiYiA
fkchufKwPxxTbQ5hgqMzm7EZo+b1Qu2yrQpUl6erraD3sj26eNR6UGQ4oNNSMXO9
STju5lVt4w7rW4MeLx9Vk7qyTUPmnDuc1RICSW6UKFshC6LfJfUE9ogNTDEjj3Hm
5yxmdzPp87WcVIF1bzeNtE8kAwamOSPMlr5Br0O/DhgMYzvR74obtDoq5fcgketA
fsSRZGUnKljFlwAn/WA0d46QgGMkgVxBkt4vwhxVoUwusQImsaJogzFnTHQlpjHC
q1sygTqdTJOtB2VjyfoxYIAEfmRksQ==
=nkLM
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
