Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E895D2712EA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgITIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 04:37:51 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59764 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgITIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 04:37:51 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 893A71C0B9B; Sun, 20 Sep 2020 10:37:46 +0200 (CEST)
Date:   Sun, 20 Sep 2020 10:37:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: fix memory leak in error path
Message-ID: <20200920083745.GA1186@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix memory leak in error path.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index 6798addabd5a..785270ee337c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -994,8 +994,10 @@ static int watchdog_cdev_register(struct watchdog_devi=
ce *wdd)
 	wd_data->wdd =3D wdd;
 	wdd->wd_data =3D wd_data;
=20
-	if (IS_ERR_OR_NULL(watchdog_kworker))
+	if (IS_ERR_OR_NULL(watchdog_kworker)) {
+		kfree(wd_data);
 		return -ENODEV;
+	}
=20
 	device_initialize(&wd_data->dev);
 	wd_data->dev.devt =3D MKDEV(MAJOR(watchdog_devt), wdd->id);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9nFNkACgkQMOfwapXb+vLdywCgnFLCnxHVctMo7+9IbLVDqk59
u14AnjQxnSyuJm9frlrtWQEkFWq7L7yh
=gAoN
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
