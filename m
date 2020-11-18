Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4542B7D12
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgKRLzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgKRLzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:55:22 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6AD241A5;
        Wed, 18 Nov 2020 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605700521;
        bh=8DteGFEDHExLDuA2v7dru1yYiDWrXBvYbEkB7IOOx9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xwgJeEmynziAthU9g53yekIIrUgIiH1bzwT5ku+fxYAdOC0VUSZ43YFiHKPSTxLt8
         aiu93QGtGgxup7uDjot+smpTAaYzfmYVWErfrzB6utEY7ZZgIxcEH7E17aVVC80QtA
         Ex8ONgua+/RD2B8RxpEQUpxp5Onxui+iiK9lQLnM=
Date:   Wed, 18 Nov 2020 11:55:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
Message-ID: <20201118115500.GB4827@sirena.org.uk>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
 <20201117173901.GH5142@sirena.org.uk>
 <VI1PR0401MB2272061C958E91FCAA239EB892E20@VI1PR0401MB2272.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB2272061C958E91FCAA239EB892E20@VI1PR0401MB2272.eurprd04.prod.outlook.com>
X-Cookie: A nuclear war can ruin your whole day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 06:17:36PM +0000, Viorel Suman wrote:
> > On Tue, Nov 17, 2020 at 12:20:36AM +0200, Viorel Suman (OSS) wrote:

> > One thing I'm not clear on is if there's some way to ensure that we don=
't have
> > different instances of the device resetting each other without them not=
icing?
> > Shouldn't be an issue in practice for the use here.

> The way to ensure that we don't have different instances of the device re=
setting each
> other is to rely on the way the "shared" reset is handled by reset API:=
=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +	ak4458->reset =3D devm_reset_control_get_optional_shared(ak4458->dev, N=
ULL);
> +	if (IS_ERR(ak4458->reset))
> +		return PTR_ERR(ak4458->reset);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Flip side of that then, how do we know when a reset has actually
happened?

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+1C5QACgkQJNaLcl1U
h9BTlwf/VhlrRagEG7wN6OlxHYPd9OiV954EhacCfzyEMonXn3zC5VRRohOBUsQb
RTRkVI3IDqwU9hgyexr2FvTl0zEmAUi01oqn8GiYGZ3xafVfswktws12UOx2zs9b
bj76W6qVi8Ufv9A0HMuIiF/PmsLt7JgvPI4EooIpBYDr/GfLsWyA+GHizzspHHbZ
wdTpt1/9+R3wwpVI9yyGMdkr2NOLw6v5AmRg9gKx+dhPkcfT9Fz24DS6/I96fyKS
bKhdhYs/92fKvYewx9JBP8903r0guzgKtcasrXw91Y8Nd0PMhjrI1ey37vFD8gnR
5OqW54VyBThSlYDN3p9iwZYif8hHAA==
=W4/r
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
