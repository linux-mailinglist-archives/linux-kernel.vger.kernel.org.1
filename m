Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113E51F0735
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgFFPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 11:11:49 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56090 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:11:48 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EFF7E1C0BD2; Sat,  6 Jun 2020 17:11:46 +0200 (CEST)
Date:   Sat, 6 Jun 2020 17:11:46 +0200
From:   Pavel Machek <pavel@denx.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        colin.king@canonical.com, jthumshirn@suse.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH] 8250-men-mcb: fix signed/unsigned confusion
Message-ID: <20200606151146.GA10940@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

get_num_ports returns -ENODEV, and the result is stored in int, so it
should not be unsigned. Zero ports does not seem to make sense, so
make that check consistent.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>


diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index 3d0fcf25d8c3..89ff20fd1dd8 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -51,7 +51,7 @@ static u32 men_lookup_uartclk(struct mcb_device *mdev)
 	return clkval;
 }
=20
-static unsigned int get_num_ports(struct mcb_device *mdev,
+static int get_num_ports(struct mcb_device *mdev,
 				  void __iomem *membase)
 {
 	switch (mdev->id) {
@@ -140,7 +140,7 @@ static void serial_8250_men_mcb_remove(struct mcb_devic=
e *mdev)
 		return;
=20
 	num_ports =3D get_num_ports(mdev, data[0].uart.port.membase);
-	if (num_ports < 0 || num_ports > 4) {
+	if (num_ports <=3D 0 || num_ports > 4) {
 		dev_err(&mdev->dev, "error retrieving number of ports!\n");
 		return;
 	}

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7bsjIACgkQMOfwapXb+vKcIACfQAcxBp7dDRP4WnmL5OpgkbcU
LokAnRoGiHx3PYQyffNlCxTBWG+s3isT
=hykO
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
