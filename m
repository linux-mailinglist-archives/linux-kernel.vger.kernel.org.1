Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191751DC7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 09:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgEUHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 03:42:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48498 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgEUHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:42:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0D3031C0290; Thu, 21 May 2020 09:42:00 +0200 (CEST)
Date:   Thu, 21 May 2020 09:41:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200521074110.GA3895@amd.ucw.cz>
References: <20200520110900.GA8203@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20200520110900.GA8203@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> My window manager stopped responding. I was able to recover machine
> using sysrq-k.
>=20
> I started writing nice report, when session failed second time. And
> then third time on next attempt.
>=20
> Any ideas?
>=20
> I'll send this out before this locks up...

Today it crashed again, with similar oops in the log.

My records say:

fb57b1fabcb2 (HEAD, tag: next-20200519, origin/master, origin/HEAD) HEAD@{0=
}: checkout: moving from bdecf38f228bcca73b31ada98b5b7ba1215eb9c9 to next-2=
0200519
bdecf38f228b (tag: next-20200515) HEAD@{1}: checkout: moving from 30e2206e1=
1ce27ae910cc0dab21472429e400a87 to next-20200515

So it is well possible that 0515 worked okay for few
days. Hmm. Perhaps I'll try going to 0516 and see if it is stable?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXsYwxwAKCRAw5/Bqldv6
8ieiAJwJvEvk5R3Jui7qPD9WEIupPnK0OwCgoS/H6iYLcrZPla88CVwjjPemzEY=
=9Wtu
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
