Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAB72145C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGDMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 08:22:25 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44918 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgGDMWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:22:24 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2ACD31C0BD2; Sat,  4 Jul 2020 14:22:23 +0200 (CEST)
Date:   Sat, 4 Jul 2020 14:22:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
Message-ID: <20200704122222.GB15530@amd>
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Are there some potentially serious problems that I should be aware of
> if I totally disable the CONFIG_ACPI option on the X86_64 platform?
>=20
> Would it do harm to the hardware?
>=20
> Thank you for your attention to this matter.

These machines are still mostly IBM-PC compatible, so it is likely to
somehow work. You'll likely get worse power and thermal
management. Try it.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8AdH4ACgkQMOfwapXb+vIHTwCfQ9c9KX3/EY85Gm9wwa7Aeroq
ZeYAnjmKW+l83cm4l1HFOWZTiiC/wwOU
=/TjJ
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
