Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698582A0EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJ3Twb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3Twa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:52:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07C220729;
        Fri, 30 Oct 2020 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604087494;
        bh=9ZRCCkWjnZUueRC68oDdNBqS1TZdbPgE5YZdnDRB3/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTHOmNUYOEfKVnR1QCvHebYO0x6lLtMcGFbixpY00xTMVVFOPc1vAwJDHa6tZ11RA
         bUb93qwcWheji5sX/+n/pBmwmijYJsVttdKxHVEaXsB9j3aD0njQdRUrx3oZytSock
         rhikceoV39pm7hIacRRfTyi/g/4tZ0SpgTxah6qc=
Date:   Fri, 30 Oct 2020 19:51:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 14/15] dt-bindings: sound: sun4i-i2s: Document H3
 with missing RX channel possibility
Message-ID: <20201030195127.GM4405@sirena.org.uk>
References: <20201030144648.397824-1-peron.clem@gmail.com>
 <20201030144648.397824-15-peron.clem@gmail.com>
 <20201030181935.GJ4405@sirena.org.uk>
 <CAJiuCccAjEHX4BmL9A81EwM_xnHTPVyHu3BOPGKKUQ=1HNaZGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QqzFzR/RUlLahzby"
Content-Disposition: inline
In-Reply-To: <CAJiuCccAjEHX4BmL9A81EwM_xnHTPVyHu3BOPGKKUQ=1HNaZGw@mail.gmail.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QqzFzR/RUlLahzby
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 08:05:31PM +0100, Cl=E9ment P=E9ron wrote:

> But basically for the next dt-bindings change you will prefer somethings =
like:
> "ASoC: dt-bindings: sun4i-i2s: Document H3 with missing RX channel possib=
ility"

Yes.

--QqzFzR/RUlLahzby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cbr4ACgkQJNaLcl1U
h9AqCQf9E93+zMG/HSEdhPKPqXgjzUt1swTeI7YiMio/V6bPjwLCeRSCS0UAwmQc
JEAcRVumyz7G4UhJFyHpbqdVhoXWJXKScO9yw7YfddlWjFfPUd4L3yQWsM1tIwyh
mHqxntSNQFqxetoi1joWEfT0y4n7t5zU/CZw747lwj8yJiv/L37FD4Y4KTXVSh9D
c7nElGLJdxSw4oSztS2sdbZp9QoZQRmIrcIjq4HCYhpRh2vvKm6WhBR0cSIE6sle
mEwrO2rH6Wu8Wb1H77WBB7apG2VAzp0nczFXEj14Zr+OyQcnHwHHMqkBk06l+XbH
iO7qVPiQIlNQKYGvC0ToiHDGrFcZYQ==
=BIOs
-----END PGP SIGNATURE-----

--QqzFzR/RUlLahzby--
