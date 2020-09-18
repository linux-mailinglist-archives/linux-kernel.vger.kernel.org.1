Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283632700D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRPUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgIRPUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:20:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E9620717;
        Fri, 18 Sep 2020 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600442454;
        bh=fHdy2jgIL1gT8eHlMhxL5qzlAZKIso5bkMdmqKFANCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHVKBgUMSO00ctM08cOUUSoNTfkDuOLL7/22rOM01uTF7AXeQQ8gRbAoi5767i7wB
         dj6OPjX4HmjlgJuxcJhpzalHzL7M3gdVDj1Z54sOnM06KgI5gf3YJdHfv/0c1v7CF5
         IP8DVBlE5snSVSIZ/SyJQhcgnUlqRdnsAsqoWWgU=
Date:   Fri, 18 Sep 2020 16:20:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
Message-ID: <20200918152004.GJ5703@sirena.org.uk>
References: <1600247876-8013-1-git-send-email-viorel.suman@oss.nxp.com>
 <1600247876-8013-2-git-send-email-viorel.suman@oss.nxp.com>
 <20200917135306.GF4755@sirena.org.uk>
 <VI1PR0401MB22726CC099099547A0502C27923F0@VI1PR0401MB2272.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB22726CC099099547A0502C27923F0@VI1PR0401MB2272.eurprd04.prod.outlook.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 03:02:39PM +0000, Viorel Suman (OSS) wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > > +	regmap_read(regmap, FSL_XCVR_EXT_ISR, &isr);
> > > +	regmap_write(regmap, FSL_XCVR_EXT_ISR_CLR, isr);

> > This will unconditionally clear any interrupts, even those we don't und=
erstand - it
> > might be better to only clear bits that are supported so the IRQ core c=
an
> > complain if there's something unexpected showing up.

> The ARM core registers itself in "fsl_xcvr_prepare" (the code below) just=
 for a subset of all supported interrupts:=20
> =3D=3D=3D=3D=3D
> 	ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> 				 FSL_XCVR_IRQ_EARC_ALL, FSL_XCVR_IRQ_EARC_ALL);
> =3D=3D=3D=3D=3D
> FSL_XCVR_IRQ_EARC_ALL - this mask represents all the interrupts we are in=
terested in and we handle in interrupt handler,
> But this is just a subset of all interrupts the M0+ core is able to asser=
t. Not very intuitive, I think I need to reword it somehow.

That's not the issue, the issue is that if we get into the ISR we just
ack all the bits that are flagged by the hardware regardless of if we
actually handled them.  This won't work if there are ever systems that
share the interrupt and it works against safety/debugging features that
the interrupt has in case something goes wrong and we get spurious
interrupts.

> > > +	if (isr & FSL_XCVR_IRQ_FIFO_UOFL_ERR)
> > > +		dev_dbg(dev, "RX/TX FIFO full/empty\n");

> > Should this be dev_err()?

> The interrupt may be asserted right before DMA starts to fill the TX FIFO=
 if I recall correctly.
> I've added it just to debug the IP behavior, will check and change it to =
err it in next version if it is the case.

If it does come up normally then a comment or something to explain why
this happens normally would probably be good.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9k0CMACgkQJNaLcl1U
h9DcBgf+Mec3OgimxY8yiVXyrZUIW0gGGPBXQrAkJUznWhSE7X28lGpkKn3aYFA0
Ywc1L43catYkwLHqYo0yTeOHxOsSmsT91+59bNq+DQdrGlaS2VSn929TPSTuBS0P
MrxaWOCZrXVZGhnAM4EbDDiXxwpB6Z0NQ62KFDRPpzov/K3lNHNpKu2vocEO3Wp9
1yND+bQGnXrdBbdnMMSPwAVdstUjh1NjuFTEJFWM/WnYxqTbhlKpe5RJnVhebpip
t+rRT2GJcQzQzL/fU/19eqPQvEBoc5EewDRtbfd6Cnkw4Ej0XLtbwxXEJWVkBj+5
jlIwADk7NAla1AraL4grDGLJvM/Y+Q==
=riPP
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
