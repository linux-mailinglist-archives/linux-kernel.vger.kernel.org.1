Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA02757A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIWMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:03:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37934 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:03:50 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 49DEA1C0BB1; Wed, 23 Sep 2020 14:03:48 +0200 (CEST)
Date:   Wed, 23 Sep 2020 14:03:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbcon scrollback broken was Re: Linux 5.9-rc6
Message-ID: <20200923120347.GA23810@duo.ucw.cz>
References: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
 <20200923113914.GA18149@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200923113914.GA18149@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The one thing that does show up in the diffstat is the softscroll
> > removal (both fbcon and vgacon), and there are people who want to save
> > that, but we'll see if some maintainer steps up. I'm not willing to
> > resurrect it in the broken form it was in, so I doubt that will happen
> > in 5.9, but we'll see what happens.
>=20
> Could you... like try not to make the job harder by merging miriad of
> "let's kill the documentation" patches?
>=20
> I needed the feature twice already this month, once during fsck, and
> then five minutes ago, when oops scrolled by me during system
> shutdown. Unfortunately, shift-pageup was not available to take a look
> what is going on there.
>=20
> Unfortunately, Greg backported your "fix" to all the stable releases,
> so resulting damage will not be easy to repair.
>=20
> For the record, making the security problem unexploitable should be as
> simple as patch below.
>=20
> Unfortunately, Linus' changelog does not exactly tell me what all the
> known problems are. Willy Tarreau pointed me to
> https://www.openwall.com/lists/oss-security/2020/09/15/2 , which has
> some information, but all I can reproduce are transient screen
> artefacts. If someone has more detailed information, that would be
> helpful.

I can now reproduce it. C code from
https://www.openwall.com/lists/oss-security/2020/09/15/2 + this patch
makes the issue easy to see.

Best regards,
								Pavel

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5f1183b0b89d..5a8a43c0b546 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1209,6 +1209,7 @@ static int vc_do_resize(struct tty_struct *tty, struc=
t vc_data *vc,
 	rlth =3D min(old_row_size, new_row_size);
 	rrem =3D new_row_size - rlth;
 	old_origin =3D vc->vc_origin;
+	vc->vc_origin =3D NULL;
 	new_origin =3D (long) newscreen;
 	new_scr_end =3D new_origin + new_screen_size;
=20
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fb=
con.c
index 75ebbbf0a1fb..6ceae7ea1ccc 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2818,6 +2818,11 @@ static void fbcon_scrolldelta(struct vc_data *vc, in=
t lines)
 	struct display *disp =3D &fb_display[fg_console];
 	int offset, limit, scrollback_old;
=20
+	if (!vc->vc_origin) {
+		printk("scrolldelta races with resize?!\n");
+		return;
+	}
+
 	if (softback_top) {
 		if (vc->vc_num !=3D fg_console)
 			return;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2s5owAKCRAw5/Bqldv6
8p3ZAJ9gGwUfB5alUaJ/JY3soU+5Iazg8gCfXlLUkd1hoNIgg4KxhtNkQ0affyU=
=uKEW
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
