Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D460C22DD0B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgGZHxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 03:53:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35692 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgGZHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:53:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 04B321C0BD9; Sun, 26 Jul 2020 09:53:28 +0200 (CEST)
Date:   Sun, 26 Jul 2020 09:53:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     corbet@lwn.net, davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
        trivial@kernel.org
Subject: [PATCH] devices.txt: document rfkill allocation
Message-ID: <20200726075327.GA25647@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Document rfkill allocation.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-gu=
ide/devices.txt
index 2a97aaec8b12..763fedd94d7d 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -375,8 +375,9 @@
 		239 =3D /dev/uhid		User-space I/O driver support for HID subsystem
 		240 =3D /dev/userio	Serio driver testing device
 		241 =3D /dev/vhost-vsock	Host kernel driver for virtio vsock
+		242 =3D /dev/rfkill	Turning off radio transmissions (rfkill)
=20
-		242-254			Reserved for local use
+		243-254			Reserved for local use
 		255			Reserved for MISC_DYNAMIC_MINOR
=20
   11 char	Raw keyboard device	(Linux/SPARC only)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXx02dwAKCRAw5/Bqldv6
8tYMAKCH77HsK+KpQmXXqLeVCKRBFiQHcwCeP+QN98gvBnkNNgAwJMgVsmPNLLg=
=W8Ap
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
