Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BA2712F4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgITIo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 04:44:58 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60326 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 04:44:58 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 75C0B1C0B94; Sun, 20 Sep 2020 10:44:53 +0200 (CEST)
Date:   Sun, 20 Sep 2020 10:44:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        johan@kernel.org, gustavoars@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: yurex: Rearrange code not to need GFP_ATOMIC
Message-ID: <20200920084452.GA2257@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Move prepare to wait around, so that normal GFP_KERNEL allocation can
be used.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
Acked-by: Alan Stern <stern@rowland.harvard.edu>

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index b2e09883c7e2..071f1debebba 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -489,10 +489,10 @@ static ssize_t yurex_write(struct file *file, const c=
har __user *user_buffer,
 	}
=20
 	/* send the data as the control msg */
-	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
 	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
 		dev->cntl_buffer[0]);
-	retval =3D usb_submit_urb(dev->cntl_urb, GFP_ATOMIC);
+	retval =3D usb_submit_urb(dev->cntl_urb, GFP_KERNEL);
+	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
 	if (retval >=3D 0)
 		timeout =3D schedule_timeout(YUREX_WRITE_TIMEOUT);
 	finish_wait(&dev->waitq, &wait);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9nFoQACgkQMOfwapXb+vKL4wCfb5pGRIBqRi7ONwprgp2K3KZC
AjEAn1qDoc6lK0L/cG1cBbUl98JdHs8P
=VryQ
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
