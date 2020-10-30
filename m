Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55B22A0D41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgJ3STn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3STn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:19:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A3520729;
        Fri, 30 Oct 2020 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604081982;
        bh=DrO9rPPWe7yx2o/HYgXvtOmqEqLUOzIreLpRvG6OK3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wU8MnfZn0r9WZ7MSs4KtDlRCtLRj8URezg836exJfCE6Vhc1S2TSv1aTFY7lXScvJ
         M6sO9r83fWp48vJbvoz0NKV228kCOSLD/EHw9VSw3Gq5gZkiagfYQsLdo1b82ncFYO
         tpbMtXUv5jiVrnckcuQWJQWfR7nv6D7iYx5gYwnw=
Date:   Fri, 30 Oct 2020 18:19:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 14/15] dt-bindings: sound: sun4i-i2s: Document H3
 with missing RX channel possibility
Message-ID: <20201030181935.GJ4405@sirena.org.uk>
References: <20201030144648.397824-1-peron.clem@gmail.com>
 <20201030144648.397824-15-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
In-Reply-To: <20201030144648.397824-15-peron.clem@gmail.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 03:46:47PM +0100, Cl=E9ment P=E9ron wrote:
> Like A83T the Allwinner H3 doesn't have the DMA reception available for
> some audio interfaces.

Please if you're going to mix dts updates in with subsystem changes like
this keep the bits for different subsystems grouped, this makes it much
easier to handle things.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cWTYACgkQJNaLcl1U
h9AyXwf7BSDWwTiF7Jtj3QLLD/yBskzrynLALio7KhuzLph2YZtmmDVoIW63VgJw
9ZpYqNu7iFdaSumpaOdukhHNRvB61XKOmhyFAUXjBER7X6AIA+fPCXoJi3JmqnfN
jxEehlb9wJJ5Fg74VASMsIuZo9et0xUtuNkU3rsmlwdIpE29EEGQVZYfMUkcDqIF
XluxWNIT6a4xQlsqan6n6do7kPz3OAVfQaZnnm4vzahnG7QhsGKob6BrBEYCdyLQ
PfC3SAIsXO+l6c/5+gRmLn/JOVWZdFdVxBz2FAd8rhgXmgxL1nbZRcBBU7IDnptb
0snc+vze5mOnvk7EFwTDHKNbUvwAOw==
=ngof
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
