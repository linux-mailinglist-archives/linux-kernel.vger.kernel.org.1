Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4D2DC084
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgLPMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgLPMtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:49:07 -0500
Date:   Wed, 16 Dec 2020 12:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608122906;
        bh=I2RXJuZVaBdYqyNFhrNGMiFxtnaDICcJLQbR4uuu/Vw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmLjvThZ+fmNU1KOFK5yU2ZY27eBh4BLeMXWgSN4xj1/g9DaNXo8DnpEEwpgcbBwU
         w+yHxP6+hh9criBMRf0zy2gpzWEBiELOrvasOFOOlxuWQZD4E5/EN4h0DtMc0fVOQF
         xLMmZ20Mxf0hiXolD08zZe1nYZMI356+/qPeZuGTkQHBSa3+vXRuhjei4IcBGtOTNQ
         BdTsKftBo46Cq0jR7sejZWFTQSZWoqCRYJzuEke7JOft93wb0BHOIPMp0rC5tahucB
         hRvq29EvHeiyJMz3dOll6e7SX/mY4tSRaEKsrPIF3jDPw8oqaKG9/Ux1A/EW7nMbVs
         MOhsOcoAWLHdw==
From:   Mark Brown <broonie@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>
Subject: Re: [PATCH 1/1] regulators: bd718x7: Add enable times
Message-ID: <20201216124814.GA4861@sirena.org.uk>
References: <cover.1608116704.git.agx@sigxcpu.org>
 <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
 <7d4903f67ff81a9a749e75f24af0aea903213c43.camel@fi.rohmeurope.com>
 <20201216124133.GA31109@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20201216124133.GA31109@bogon.m.sigxcpu.org>
X-Cookie: Why are you so hard to ignore?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2020 at 01:41:33PM +0100, Guido G=FCnther wrote:
> On Wed, Dec 16, 2020 at 12:29:20PM +0000, Vaittinen, Matti wrote:

> > > +			.enable_time =3D 144,

> > Where are these values obtained from? I have a feeling they might be
> > board / load specific. If this is the case - can the "regulator-enable-
> > ramp-delay" from device-tree be used instead to avoid hard-coding board
> > specific values in the driver? Although, sane defaults would probably
> > not be a bad idea - if I read code correctly then the constrains from
> > DT can be used to override these values.

> They're the 'typical values' from the data sheet and it's basically all
> about setting a default for "regulator-enable-ramp-delay" to avoid
> having every board do the same. If that's not the right thing todo let
> me know and i add these to each of our boards (which is where i
> basically started from but then figured that this would be busywork
> and every board would hit that problem).

If it's a DCDC they're *probably* generic values rather than board
specific, they tend to be more predictable as they're regulating much
more actively than LDOs.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/aAg0ACgkQJNaLcl1U
h9Cw4Af/b+jlrUhFYORWueTn4r4j6Oci8BvjZHp+zFMQXl80PX7yfyJD8+qU9S9o
jd7nG0M+YkCqbzcqQLVBEuFfVJpy0xEFR09a/ScTz5HVvtANuxGec+1rUubww1+s
eh37NA+xpKLh1SVogtwok7q4Ubj2bBCx590kCxB1hPSx4+LpovV5zQ566+rGWYku
NsJM04YVOImDr65rza441AF2b5cEBWlNK+zokTcrVJf/J4ue8KquddsV5l/Dln/+
PAN7zMu/PmDAk8avjfIE9GhXH6BbDRxnzyY7APxQTaZgpkWbeLMhoCT0nLzWuz25
4X0IuYMoV8RsXP6zOZ8vbyimE7IFyw==
=zhwQ
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
