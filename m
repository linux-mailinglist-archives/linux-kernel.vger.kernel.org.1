Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73B29EF92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgJ2PS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgJ2PSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:18:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5527620719;
        Thu, 29 Oct 2020 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603984733;
        bh=z1AwC15Mf354okdz08ulp+IEkHhyaUMTMrlzzjYtWEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyAmasQVhUOtumuVJuJrx5U+6G7BKmameHT7zYJDqVJ3wwsGF6VTWQfgrHdf3G4l/
         GGsk1DsQmXvuGVQcbWmiVXubGDx3/GZk2OYbsFDwLtVs7HS65GTra/gtr6jNqWVajp
         9ODTO8ns9nuuLJ5aB4c03zau6KIuotzxJ2+fknkY=
Date:   Thu, 29 Oct 2020 15:18:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] regmap: provide regmap_assign_bits()
Message-ID: <20201029151847.GB5042@sirena.org.uk>
References: <20201026151015.15527-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20201026151015.15527-1-brgl@bgdev.pl>
X-Cookie: Monotheism is a gift from the gods.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 04:10:15PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add another bits helper to regmap API: this one sets given bits if value
> is true and clears them if it's false.

What's the use case?

> +static inline int regmap_assign_bits(struct regmap *map, unsigned int re=
g,
> +				     unsigned int bits, bool value)

I don't have a great suggestion but this naming feels prone to confusion
with _update_bits(). =20

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+a3VYACgkQJNaLcl1U
h9B6xAf8DDMFo0lHS3pNCplZ7ZWsD+c+W8C/MHr37yNTGyq25T59sgl1/iVdXmZW
mYyerCqrVCwQZLPMerhIwuhaprTRHjBHTb6rQQTCn9YAWLaimEkrZsIH87Jgu5QZ
e/IAx3K9GGAJNV2NMBw5kGg83tmLWf7w43XMrbt3xr1BnIO7qblPNC4SYu/WG22/
94+8oozjIvbjJjZrOxTcCK2CzwvHqbBf9m7ppNIEUccBvd8LHLoZPPA/w1x3T+T5
0o39NkPyK2dCgAU8wWanmVzQeEWjwqHSnJRS95ZFVl6chCtXm77ZoLcrbqTLayDa
GHqZ5TmEGutHs19h7z7wWv0pefc4Ag==
=YOvd
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
