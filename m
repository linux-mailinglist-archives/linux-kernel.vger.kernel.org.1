Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FAF2C16FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgKWUky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgKWUky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:40:54 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC74E204FD;
        Mon, 23 Nov 2020 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606164053;
        bh=l4oI3EJf9twL417qKLDDDLHkuxNIhLOKXfN3lkF6Kxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dI6Y/FEBhMomP9yXJDZL18c5N1fJUnSufmLsfsEErCEx1I73uujBVn+VmR2nTBil2
         7st2qM1JoV+aEr2XQJCNbg/JTowpnkJOkAAUW5m9jaxq8C/w1ZUMTqrjWm7inA4kgh
         US9uOR3tP2rC+WdSErFnKjZ9+DgugTP0ToQkJ/y8=
Date:   Mon, 23 Nov 2020 20:40:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/4] ASoC: meson: depend on COMMON_CLK to fix compile
 tests
Message-ID: <20201123204030.GA21709@sirena.org.uk>
References: <20201116175133.402553-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20201116175133.402553-1-krzk@kernel.org>
X-Cookie: Will stain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2020 at 06:51:30PM +0100, Krzysztof Kozlowski wrote:
> The Meson SoC sound drivers use Common Clock Framework thus they cannot
> be built on platforms without it (e.g. compile test on MIPS with RALINK
> and SOC_RT305X):

This doesn't apply against current code, please check and resend.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+8Hj0ACgkQJNaLcl1U
h9BQUQf/Zb+qnudCOxcpsy60ses8As7w+FYZS80ubduXvGWgILbXemT1oMzbNgmK
OBkiqTnFNc6tff+PV8KL223IYl0NE87wbj+TZtPLS2kwcmLzGYN5Nk6tOJ/BqNaL
NZGwQweuvCXNOZgVaqRuCp2am79NZzjniDlGELtbcdX1bnrbKQqrpfl+OQYOXBxs
u/xwWXzpd63eM4B4tN8a4S3TsUzJvuypdWshYHELUV5vsxSCXp1NWiire0N1SPO7
bnkqkZUg10ymAq75x5OE6laeMbsDfwWnS9tRnOJxnN4H8oTMcmzxTQiFD0922P0s
w0Jrqx6xOb9ZoR7U22kR1FHwhkpH8Q==
=Zs8x
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
