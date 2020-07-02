Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC82212E94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGBVQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 17:16:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41800 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBVQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:16:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5D47B1C0C0C; Thu,  2 Jul 2020 23:16:31 +0200 (CEST)
Date:   Thu, 2 Jul 2020 23:16:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Hyrwall <sh@keff.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BTRFS/EXT4 Data Corruption
Message-ID: <20200702211629.GA5787@amd>
References: <f87dcf1e-5a8a-36c2-a864-88099a66d220@keff.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <f87dcf1e-5a8a-36c2-a864-88099a66d220@keff.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> After alot of fiddling around it turned out that the problem goes away if
> doing "cp --sparse=3Dnever"
> when copying the files. This would to me exclude any hardware errors and
> feels more like something
> deeper inside the kernel.

If files contain random data, they are never sparse. It is strange
that sparse=3Dnever would make any difference.

> The box runs Kernel 3.10.105. Version >4 seems unaffected (not 100%
> confirmed, too few testboxes).

I'm afraid relevant developers will not be willing to debug 3.10
kernel.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7+Tq0ACgkQMOfwapXb+vLpNACgvsXmGNyYMHqZkrRJDMMhU7ze
fVcAniCnwvMcrwbFEaMTyHplPoi7X5JO
=PKPz
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
