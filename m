Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555022C996A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLAIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:24:36 -0500
Received: from mail.v3.sk ([167.172.186.51]:58650 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbgLAIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:24:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7507FE06F5;
        Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5p17-b3zC8un; Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CA653DF9A4;
        Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c0Dpb-dcLFk6; Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 986BEE06F5;
        Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 2/4] Platform: OLPC: Fix handling of regulator registration error
Date:   Tue,  1 Dec 2020 09:23:46 +0100
Message-Id: <20201201082348.1723631-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201082348.1723631-1-lkundrak@v3.sk>
References: <20201201082348.1723631-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We wouldn't reset ec_priv previously. Let's handle handle the errors in
a single spot to fix this.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index faecb73bd8430..2ad638583cc58 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -427,11 +427,8 @@ static int olpc_ec_probe(struct platform_device *pde=
v)
=20
 	/* get the EC revision */
 	err =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ec->version, 1);
-	if (err) {
-		ec_priv =3D NULL;
-		kfree(ec);
-		return err;
-	}
+	if (err)
+		goto error;
=20
 	config.dev =3D pdev->dev.parent;
 	config.driver_data =3D ec;
@@ -441,12 +438,16 @@ static int olpc_ec_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(ec->dcon_rdev)) {
 		dev_err(&pdev->dev, "failed to register DCON regulator\n");
 		err =3D PTR_ERR(ec->dcon_rdev);
-		kfree(ec);
-		return err;
+		goto error;
 	}
=20
 	ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
=20
+	return 0;
+
+error:
+	ec_priv =3D NULL;
+	kfree(ec);
 	return err;
 }
=20
--=20
2.28.0

