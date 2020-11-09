Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71992AC6BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgKIVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgKIVPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:15:31 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84563206CB;
        Mon,  9 Nov 2020 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604956530;
        bh=oYr2JaLR22iQHfcymOzeBfdwEdiH+YRlgs4KPxWwOTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aB6NCU9QwvpONEX/1Io7pQXX8zJsOMlPiu+rhJiTw7WRQ58MaJxTPiq4oxqDFkwXk
         wR3jHAewHNE/T3mGhckgcb7r7KsFUAq+ZzEb7VdntGfAAf34MU1lqxR2C6IgGZhsWM
         AUjTq9ON5xnHnYhNsaJ7/hCxj2m82s0NpmRzmIVc=
Date:   Mon, 9 Nov 2020 21:15:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: ASoC: Question regarding device-tree multi-lane I2S for
 Allwinner SoC
Message-ID: <20201109211515.GO6380@sirena.org.uk>
References: <CAJiuCcfBOHhniDQOaB8ixU0pY9u0GVivkj7po-kozBV8LqmB6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da9oBGf5DLtF9ehv"
Content-Disposition: inline
In-Reply-To: <CAJiuCcfBOHhniDQOaB8ixU0pY9u0GVivkj7po-kozBV8LqmB6A@mail.gmail.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--da9oBGf5DLtF9ehv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2020 at 06:30:15PM +0100, Cl=E9ment P=E9ron wrote:

Sorry about the delay here.

>     dai-tdm-slot-tx-mask-0 =3D <1 1>;
>     dai-tdm-slot-tx-mask-1 =3D <1 1>;
>     dai-tdm-slot-tx-mask-2 =3D <1 1>;
>     dai-tdm-slot-tx-mask-3 =3D <1 1>;

=2E..

> This kind of representation gives the information that 2 slots should
> be enabled as TX per lane but don't give which slot to map.

The way the above should be interpreted is as a bitmask of slots to use,
I'm hoping that the above is for a system with 4 TX data wires each
using two slots (such designs get used for things like surround sound
amps). =20

> I was thinking about a representation per lane but maybe it's a bit
> complicated  ?

>     dai-format =3D "dsp_a";
>     dai-tdm-slot-width =3D <32>;
>     // Lane 0 : Output 8 channels 0-7 using TDM
>     dai-tdm-slot-tx-mask-0 =3D <1 1 1 1 1 1 1 1>;
>     dai-tdm-slot-chmap-0 =3D <0 1 2 3 4 5 6 7>;
>     // Lane 1 : Output 3 channels 5-7 using TDM
>     dai-tdm-slot-tx-mask-1 =3D <1 1 1>;
>     dai-tdm-slot-chmap-1 =3D <5 6 7>;

I'd expect lane 1 to end up as

     dai-tdm-slot-tx-mask-1 =3D < 0 0 0 0 0 1 1 1 >;

>     // Lane 0 : Output channels 0,1
>     dai-tdm-slot-tx-mask-0 =3D <1 1>;
>     dai-tdm-slot-chmap-0 =3D <0 1>;
>     // Lane 1: Output channels 2,3
>     dai-tdm-slot-tx-mask-1 =3D <1 1>;
>     dai-tdm-slot-chmap-1 =3D <2 3>;
>     // Lane 2: Output channels 4,5
>     dai-tdm-slot-tx-mask-2 =3D <1 1>;
>     dai-tdm-slot-chmap-2 =3D <4 5>;
>     // Lane 3: Output channels 6,7
>     dai-tdm-slot-tx-mask-3 =3D <1 1>;
>     dai-tdm-slot-chmap-3 =3D <6 7>;

> What do you think? Do you have any remark / idea about this ?

I can see the use for the chmap binding, I can see that we might have a
system which has for example outputs labelled in some unusual order and
we'd want to remap them.  I'm less sure about defining a channel map in
a way that changes the meaning of the masks though, that seems like it'd
lead to incompatibilities.  How about making chmap also an array like
the mask is with the bits set in the mask indicating which slots in the
chmap are valid, that way your -3 would end up as:

      dai-tdm-slot-tx-mask-3 =3D <0 0 0 0 0 0 0 1 1>;
      dai-tdm-slot-chmap-3   =3D <0 0 0 0 0 0 0 6 7>;

and something that only understands the mask would at least get the
correct channels even if in a jumbled order?

--da9oBGf5DLtF9ehv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+psWMACgkQJNaLcl1U
h9DxiAf+LcdNMSzFM9UDPRKWBo7YMMEa3rZBYdJiTYFos60njDZu9mygoU302a4j
1zY+3h4+36iMWuL1M6Kg3+roJuRBPBiWCIDLMsiKBcyN8rmpSKzv3Ki8na/QqpcD
Pi6eu9MyPH/68CElJ2KYDbMhmNGXgVzPKhQ2Vmpx9f4NdTuCDE9Cs6f4ibFVzBIp
j3V6YV/+gLNvDxpghKmfsbew/6qYtxq5ouXW/lF3zvor6W/Ez+zem1/dKFj8sqGh
8+oWQvThKGtoz8jYjxfz3oe7C7Syvsq8ejUmPD2tlNOaYaaiXYK8wzZyDSghKdua
UpXzlsrLN+HXuLOVpu1ShjiCPNj4wQ==
=TwOU
-----END PGP SIGNATURE-----

--da9oBGf5DLtF9ehv--
