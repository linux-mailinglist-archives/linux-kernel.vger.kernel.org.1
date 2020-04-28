Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA51BC5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgD1Q5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 12:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgD1Q5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:57:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE42320757;
        Tue, 28 Apr 2020 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588093068;
        bh=QaFdvwQtNCzuxJiiAPZ3ZOFvDXcpwjoLKDRZlvc+JTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vraqZ0wEcRphTU3lPtLyXChwnLcRHayEWGgLHdrwesblGo/42zUJF4jLqaKz47xEb
         ORmefUppK8xFN675aFR0gcO4VVqr2YyuuyxKCpPYfzSeapY4vntKXugE6AbXyEFfgo
         yJ+sGuNxbqA2Hi26mqqt5ODXt97n7b9DRXqC2cRI=
Date:   Tue, 28 Apr 2020 17:57:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: Audio sound card name [was [PATCH 4/7] arm64: dts: allwinner:
 a64: Add HDMI audio]
Message-ID: <20200428165745.GM5677@sirena.org.uk>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
 <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan>
 <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Content-Disposition: inline
In-Reply-To: <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:49:10PM +0200, Cl=E9ment P=E9ron wrote:

> I have a question regarding the simple-audio-card,name.
> In this patch, I would like to introduce a simple-audio-card for the
> Allwinner A64 HDMI.

> What should be the preferred name for this sound card?
> "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?

The former is more idiomatic for ALSA.

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oYIkACgkQJNaLcl1U
h9CxAgf7BWIci8LznrR1sMDBntaJK2/0G/U8xmAKYRllkCNU+ygWiMh4kJP0s8Xt
kwdFyZZIgLgcsjFiKBtUmSOtJtQklUyVMyYfN4Fuxspk0tuoZ55f7XfLkZelcMin
pDhjmgvcSRMfLrcLovinmN0tAR6rWlNzUbDEs2J1bkxyoBsp1+9JbIadgU0+HVwC
7/EYkpQG5niUXnDqe5puy9aeR9ml20pg8+DYnjTjgTUqGQTBbvdrd9PIwjsh7R0t
RK9k8vuWd94brTyA0W4z8PbDHCIVpz/noDHFOBeUUjR2tP0sPAfYZkh5TlpDM/pG
9CbD0IlbKTXi0BXgBg1H8zN+XLKCyA==
=5lUy
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
