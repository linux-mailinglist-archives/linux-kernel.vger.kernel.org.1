Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93EC27573E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIWLjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:39:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34882 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:39:17 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3F1BC1C0BB3; Wed, 23 Sep 2020 13:39:15 +0200 (CEST)
Date:   Wed, 23 Sep 2020 13:39:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fbcon scrollback broken was Re: Linux 5.9-rc6
Message-ID: <20200923113914.GA18149@duo.ucw.cz>
References: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The one thing that does show up in the diffstat is the softscroll
> removal (both fbcon and vgacon), and there are people who want to save
> that, but we'll see if some maintainer steps up. I'm not willing to
> resurrect it in the broken form it was in, so I doubt that will happen
> in 5.9, but we'll see what happens.

Could you... like try not to make the job harder by merging miriad of
"let's kill the documentation" patches?

I needed the feature twice already this month, once during fsck, and
then five minutes ago, when oops scrolled by me during system
shutdown. Unfortunately, shift-pageup was not available to take a look
what is going on there.

Unfortunately, Greg backported your "fix" to all the stable releases,
so resulting damage will not be easy to repair.

For the record, making the security problem unexploitable should be as
simple as patch below.

Unfortunately, Linus' changelog does not exactly tell me what all the
known problems are. Willy Tarreau pointed me to
https://www.openwall.com/lists/oss-security/2020/09/15/2 , which has
some information, but all I can reproduce are transient screen
artefacts. If someone has more detailed information, that would be
helpful.

Best regards,
								Pavel

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 19cd4a4b1939..cb2d3e7eeac8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3211,6 +3212,9 @@ int tioclinux(struct tty_struct *tty, unsigned long a=
rg)
 			ret =3D fg_console;
 			break;
 		case TIOCL_SCROLLCONSOLE:
+			ret =3D -EPERM;
+			break;
+		 =20
 			if (get_user(lines, (s32 __user *)(p+4))) {
 				ret =3D -EFAULT;
 			} else {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2sz4gAKCRAw5/Bqldv6
8o95AJ9Lf7Gsm80W0HzA9xnppbRKIaZH4ACgjZaGBXrzHpn3ExarPgEGnQVTRg0=
=IkHg
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
