Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E927B40C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1SFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgI1SFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:05:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF63E208D5;
        Mon, 28 Sep 2020 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601316310;
        bh=qagNYqw//kTIIn78EAVwkXcLEopm38BJCO59neO8MpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFnBOyy6PLz836AwXHmdioVK8NXMuv7VOrVrmDGlVwWPiLm+ZIELMQh6siWssMmmE
         Z+x6QiDhFX4OHfghPOgVaqtrGmY1BluZzG0kl6QRU4lpgxc8jkPNeKJQDez9FuspY2
         nAKLRxlCtOpBVppyMevfiv5naY3N/sDLk3f2TbmE=
Date:   Mon, 28 Sep 2020 19:04:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: sound/soc/ti/j721e-evm.c:528:34: warning: unused variable
 'j721e_audio_of_match'
Message-ID: <20200928180412.GA4827@sirena.org.uk>
References: <202009271553.4OjMpGkX%lkp@intel.com>
 <76cae106-b643-57a9-e82e-48e46ebf1b70@ti.com>
 <CAKwvOdnsQY6S+3zAH6_SD0ifbUaSDFj9mBdhF4GVq6VB=tjFsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <CAKwvOdnsQY6S+3zAH6_SD0ifbUaSDFj9mBdhF4GVq6VB=tjFsA@mail.gmail.com>
X-Cookie: He who hates vices hates mankind.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2020 at 10:52:54AM -0700, Nick Desaulniers wrote:
> On Mon, Sep 28, 2020 at 12:27 AM 'Peter Ujfalusi' via Clang Built

> > Right, in the attached .config:
> > # CONFIG_OF is not set

> > There must be a clean way to handle this without extensive ifedfery...

> Pretty sure I just saw a patch go by wrapping another device table
> definition in #ifdef CONFIG_OF, so it's not unusual.

It's the standard solution, it's just not as clean as would be ideal :/

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9yJZwACgkQJNaLcl1U
h9BuEgf9GLtR9vsNRYBAfZMzoLDPaz6thKWLo0VpdLYh3TDUReu4Qaofsw3tSTfS
crdQCtuhd6xRwc5WaOmDTnSGS5qMzr7fPa1gWscMnbyRNX91H06P1d7TB2ldNwN7
LV4ktWH3CDTWnvjaZ8rBCHZUbMMdboyjFUpyycFZM28OV50DWtl5GwfAFQwgqitr
NgAjgphMBewJZv3tKApunGNukwU/4SddRSVQkHaTgigdJEciffIdlvF9eqUDGhy7
PQR7VuzbNwKpfFnbCN2VO5J6i6UNvDaW48ytgDo/TiZWukcO0A7O3RVHfYt57uYT
h77Caa/qZteXghnaDmBl/O4LBofxkg==
=/fBh
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
