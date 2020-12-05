Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEBF2CFEFA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLEU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:58:29 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:38512 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:58:28 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7EB0C1C0B7C; Sat,  5 Dec 2020 21:57:44 +0100 (CET)
Date:   Sat, 5 Dec 2020 21:57:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201205205744.GD8578@amd>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-11-30 15:13:02, Sven Van Asbroeck wrote:
> Hi Nikolaus, thank you for reaching out !
>=20
> On Mon, Nov 30, 2020 at 2:06 PM H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
> >
> > But reverting your patch brings back the display. So it appears as if i=
t does not
> > fix a breakage, rather breaks a previously working setup.
>=20
> The patch in question fixes an important breakage: before the patch, lite=
rally
> hundreds of SPI drivers no longer worked - only if the SPI bus master
> driver was using gpio descriptors.
>=20
> We knew that there was a chance that our fix would break something else.
> But hopefully "it fixes more than it breaks"

If the patch causes regression it will ultimately need to be
reverted... no matter how much it fixes.

									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/L9EgACgkQMOfwapXb+vL2fwCgo5zigUkxc/oCVfM0ejb5HbIG
OcYAoKaDlIR7tPY6jkLHFM+Dr10IbzE7
=VO34
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
