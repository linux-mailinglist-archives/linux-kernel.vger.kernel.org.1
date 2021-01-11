Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4F2F1B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbhAKQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbhAKQmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:42:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33B7820B1F;
        Mon, 11 Jan 2021 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610383310;
        bh=pHdL6r7FXXGNXM3Ebqp+Wf6OKYp1jUSbChLOvGSj6Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vkwn0fuTvm7Tdoy3qtROvRL14dXnX6MebEsWVEc8u3sIzFAAGtuTcNUkdudrCV38h
         kZGJxZsTBhcVU8jUGrt0IGsa3EZ3kTzV0FpbkXnvK/VuEVQz+gSzP1RuO9TqK3YtKF
         vaV10TEeoZpHnka5OGoymIlillJ7/jCg1BWc7l7u4CO0y04KknnVCfIjkAD2VeeGrt
         UFkoL+ljFOYIKtq4QBn4xrePx3hf0GOzBqIqnwBGzXrgqEYae0OM8+Xgxbq3F7g2E+
         HKaELmSvaVkhkGTAlkbwvypKlTdW6uzyFF7GjUUZa8bH+y7Bk7yu86v1CM/oSTuOdh
         UkjbiYcgej/Vw==
Date:   Mon, 11 Jan 2021 16:41:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Axel Lin <axel.lin@ingics.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Message-ID: <20210111164118.GE4728@sirena.org.uk>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <20210109112612.1221-1-matthias.bgg@kernel.org>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 09, 2021 at 12:26:09PM +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
>=20
> Binding documentation mentions that a compatible is required for the
> MT6360 device node, but the driver doesn't provide a OF match table.

The binding should be fixed to remove the requirement for a compatible
here, this is both redundant since we already know we have a mt6380 from
the core MFD and encoding details of how Linux implements things into
the DT bindings.

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8f60ACgkQJNaLcl1U
h9DuAwf9HMf6KGCC1zeqywtZhlKTB1cStvN7IwhVumnBs7s6MfljXhjvSeg0dwhu
OuPqKnBkputwxVuLUcxVBeS8gOlcmNigypgGCWi4NgbJWnDtRGBEwbJ6Dz3UNQYN
tnNzP/Jd5yk+wQlFS4FM0FMX8Q2Bpl/nLbGliTL9xnrfgBGRLevBTChBOahtLFxo
de12GMYwf5pCOgSknPwmuGKXF1gGAbk3aE3XKO5HaRYgyQY3v4LN9i5kj7Z7Z8f2
h4pF/HhZRm0EMuc1nhEv8bJgsC4A6TIyLbEA8xHP9SixXREANTyGaRg49kWlaeH5
4lRvhhOfHOOXtgpMSdBLqK7MLac80g==
=OgE8
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
