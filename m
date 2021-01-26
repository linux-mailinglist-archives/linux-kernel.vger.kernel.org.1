Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69678304561
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbhAZRdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:33:24 -0500
Received: from mail.v3.sk ([167.172.186.51]:48082 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389342AbhAZHio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:38:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A5EF0E0B03;
        Tue, 26 Jan 2021 07:33:43 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u4fMlcvWkBjT; Tue, 26 Jan 2021 07:33:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AFFE4E0B05;
        Tue, 26 Jan 2021 07:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1w52DoKF2SmU; Tue, 26 Jan 2021 07:33:42 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B8731E0B00;
        Tue, 26 Jan 2021 07:33:41 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/3] Platform: OLPC: Fix probe error handling
Date:   Tue, 26 Jan 2021 08:37:38 +0100
Message-Id: <20210126073740.10232-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126073740.10232-1-lkundrak@v3.sk>
References: <20210126073740.10232-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset ec_priv if probe ends unsuccessfully.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index f64b82824db28..2db7113383fdc 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -426,11 +426,8 @@ static int olpc_ec_probe(struct platform_device *pde=
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
@@ -440,12 +437,16 @@ static int olpc_ec_probe(struct platform_device *pd=
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
2.29.2

