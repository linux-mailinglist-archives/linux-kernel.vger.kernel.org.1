Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD02220F33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGOO1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 10:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgGOO1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:27:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5078B205CB;
        Wed, 15 Jul 2020 14:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594823220;
        bh=2qpN2cOs0v8OgbKiTCEOLREVstlLLC76OJcC/cCHwQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtX+/tccMlVeMNKiozjp+uC/QzIQ1f5ReA3ZExvuVyNGw7we44RduABqcmoZCDDTW
         Yzotqw74bb233t4PKstgZM/1zygsYv/Qh2xv2TfbzbNK1RRDl96p13D4q6Shjmt1T7
         POLd33Hw9krqvH6eIAcns0jJpXABgnfIgVr5iNJ0=
Date:   Wed, 15 Jul 2020 15:26:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling
 of 'exists'
Message-ID: <20200715142651.GA44014@sirena.org.uk>
References: <20200715094447.3170843-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200715094447.3170843-1-lee.jones@linaro.org>
X-Cookie: Minimum charge for booths.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 10:44:47AM +0100, Lee Jones wrote:

>  /*
> - * This dapm route map exits for DPCM link only.
> + * This dapm route map exists for DPCM link only.
>   * The other routes shall go through Device Tree.

This doesn't apply against current code, please check and resend.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8PEioACgkQJNaLcl1U
h9DvQAf/f/u76ASoswKuqEP0xg72QuhZGUj08nlVQnAV1civDdfyjXZEc45CEfoX
SBrMdVIMfvk8oxGZIsgRkhW+QimcJLr5rsyO7RylN6YZsXysfG0GqDbuH9WvgGSJ
yTggaet7yI6gAlbjos476ee+yrzNSssnBzOpxuk5pXCYxDkEf0lgclfQY21oOG/t
8F1tzjQjJ8kXcfYfnBofJFJPqi5EA2DbogxL0bH+7/ndzpuo4BNVb4463SuG7CXy
upIOZq7CFRlVOY4Izb27YyFAeq3SnigakVEBJrkFeKsOECP6gTBHSbZGrydD2NrO
2K6J+fPzeGcdXutqMeP+n2ke/vXxLw==
=viwB
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
