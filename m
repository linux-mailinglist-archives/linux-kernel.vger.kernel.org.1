Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502542B5AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgKQIDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:03:12 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48032 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKQIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:03:12 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C558E1C0B8D; Tue, 17 Nov 2020 09:03:09 +0100 (CET)
Date:   Tue, 17 Nov 2020 09:03:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     mripard@kernel.org, wens@csie.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: BananaPi M2 support
Message-ID: <20201117080309.GB6275@amd>
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-11-14 20:20:54, Sergey Suloev wrote:
> Hi,
>=20
> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have sav=
ed
> boot logs for both versions https://pastebin.com/DTRZi8R7=A0 and=A0
> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
> kernel with default config, u-boot v2020.10.
>=20
> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
> The versions 5.8.18 and above all fail (5.9 and 5.10).
>=20
> Could you look at the problem or provide an advice about further
> investigation, please ?

git bisect is usually next step if you can't get better help...

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+zg70ACgkQMOfwapXb+vJj2ACfWdutBUdk73ItxJut7hkK+RIg
zN0AnRtZUWjT9il7rf5VgRMMzvF4amNa
=foyj
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
