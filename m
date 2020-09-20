Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3C27130E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 05:08:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33614 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 05:08:31 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CD2B91C0B82; Sun, 20 Sep 2020 11:08:28 +0200 (CEST)
Date:   Sun, 20 Sep 2020 11:08:26 +0200
From:   Pavel Machek <pavel@denx.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzbot+96414aa0033c363d8458@syzkaller.appspotmail.com,
        koulihong@huawei.com, marcel@holtmann.org
Subject: [PATCH] 6lowpan: Add missing locking
Message-ID: <20200920090826.GA5983@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I believe set_lock should be taken in exit function, too.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>


diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cff4944d5b66..1420734394e9 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1301,10 +1301,12 @@ static void __exit bt_6lowpan_exit(void)
 	debugfs_remove(lowpan_enable_debugfs);
 	debugfs_remove(lowpan_control_debugfs);
=20
+	mutex_lock(&set_lock);
 	if (listen_chan) {
 		l2cap_chan_close(listen_chan, 0);
 		l2cap_chan_put(listen_chan);
 	}
+	mutex_unlock(&set_lock);
=20
 	disconnect_devices();
=20
   =20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9nHAoACgkQMOfwapXb+vIXvgCcCZh9bR+Gy9I+CdcEpWEuJxTm
XvMAn14wZkG66pzftuGLz2e/ZPJVuwvT
=XiyC
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
