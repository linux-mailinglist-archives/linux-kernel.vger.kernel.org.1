Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5327228D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgIULal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:30:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35902 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIULal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:30:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF8711C0B81; Mon, 21 Sep 2020 13:30:39 +0200 (CEST)
Date:   Mon, 21 Sep 2020 13:30:39 +0200
From:   Pavel Machek <pavel@denx.de>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, johan@kernel.org,
        tomasz@meresinski.eu, jonathan@jdcox.net, kerneldev@karsmulder.nl,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: quirks: simplify quirk handling.
Message-ID: <20200921113039.GA19862@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify quirk handling.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f232914de5fd..167b6ac428a3 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -56,18 +56,13 @@ static int quirks_param_set(const char *value, const st=
ruct kernel_param *kp)
 		if (val[i] =3D=3D ',')
 			quirk_count++;
=20
-	if (quirk_list) {
-		kfree(quirk_list);
-		quirk_list =3D NULL;
-	}
-
+	kfree(quirk_list);
 	quirk_list =3D kcalloc(quirk_count, sizeof(struct quirk_entry),
 			     GFP_KERNEL);
 	if (!quirk_list) {
 		quirk_count =3D 0;
-		mutex_unlock(&quirk_mutex);
-		kfree(val);
-		return -ENOMEM;
+		err =3D -ENOMEM;
+		goto unlock;
 	}
=20
 	for (i =3D 0, p =3D val; p && *p;) {
@@ -153,7 +148,7 @@ static int quirks_param_set(const char *value, const st=
ruct kernel_param *kp)
 	mutex_unlock(&quirk_mutex);
 	kfree(val);
=20
-	return 0;
+	return err;
 }
=20
 static const struct kernel_param_ops quirks_param_ops =3D {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2iO3wAKCRAw5/Bqldv6
8vwSAJwOXFVGsbOUYjR9k1gNqz+YYCNksgCfQ2QxZWEU2bWe4x6HL22QjO5mjP8=
=A++X
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
