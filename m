Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0C72C996C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgLAIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:24:39 -0500
Received: from mail.v3.sk ([167.172.186.51]:58690 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgLAIYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:24:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A3CA1E0713;
        Tue,  1 Dec 2020 08:21:00 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ubVOuqaG8Te8; Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C3508DF9A4;
        Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D0pQnOlGi1nR; Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7F5B2E0719;
        Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 4/4] Platform: OLPC: Register regulators for all power lines to DCON
Date:   Tue,  1 Dec 2020 09:23:48 +0100
Message-Id: <20201201082348.1723631-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201082348.1723631-1-lkundrak@v3.sk>
References: <20201201082348.1723631-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC switches three power lines for the display controller:

  2.5V for the self-refresh frame SDRAM
  3.3V for the digital I/O pins
  1.8V for the controller core and also the DETTL display interface
    pins.

Note that all lines can be either disabled or enabled together.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 92 +++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 72dbbea0005c5..2ab57ffb3d63e 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -5,6 +5,7 @@
  * Author: Andres Salomon <dilinger@queued.net>
  *
  * Copyright (C) 2011-2012 One Laptop per Child Foundation.
+ * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
  */
 #include <linux/completion.h>
 #include <linux/debugfs.h>
@@ -17,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/regulator/driver.h>
 #include <linux/olpc-ec.h>
+#include <linux/of.h>
=20
 struct ec_cmd_desc {
 	u8 cmd;
@@ -37,7 +39,7 @@ struct olpc_ec_priv {
 	struct mutex cmd_lock;
=20
 	/* DCON regulator */
-	bool dcon_enabled;
+	unsigned int dcon_enable_count;
=20
 	/* Pending EC commands */
 	struct list_head cmd_q;
@@ -352,38 +354,45 @@ static struct dentry *olpc_ec_setup_debugfs(void)
 static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
 {
 	unsigned char ec_byte =3D state;
-	int ret;
=20
-	if (ec->dcon_enabled =3D=3D state)
-		return 0;
-
-	ret =3D olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
-	if (ret)
-		return ret;
-
-	ec->dcon_enabled =3D state;
-	return 0;
+	return olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
 }
=20
 static int dcon_regulator_enable(struct regulator_dev *rdev)
 {
 	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+	int ret;
=20
-	return olpc_ec_set_dcon_power(ec, true);
+	if (ec->dcon_enable_count =3D=3D 0) {
+		ret =3D olpc_ec_set_dcon_power(ec, true);
+		if (ret)
+			return ret;
+	}
+
+	ec->dcon_enable_count++;
+	return 0;
 }
=20
 static int dcon_regulator_disable(struct regulator_dev *rdev)
 {
 	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+	int ret;
=20
-	return olpc_ec_set_dcon_power(ec, false);
+	if (ec->dcon_enable_count =3D=3D 1) {
+		ret =3D olpc_ec_set_dcon_power(ec, false);
+		if (ret)
+			return ret;
+	}
+
+	ec->dcon_enable_count--;
+	return 0;
 }
=20
 static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
 {
 	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
=20
-	return ec->dcon_enabled ? 1 : 0;
+	return ec->dcon_enable_count ? 1 : 0;
 }
=20
 static struct regulator_ops dcon_regulator_ops =3D {
@@ -392,13 +401,36 @@ static struct regulator_ops dcon_regulator_ops =3D =
{
 	.is_enabled	=3D dcon_regulator_is_enabled,
 };
=20
-static const struct regulator_desc dcon_desc =3D {
-	.name		=3D "dcon",
-	.id		=3D 0,
-	.ops		=3D &dcon_regulator_ops,
-	.type		=3D REGULATOR_VOLTAGE,
-	.owner		=3D THIS_MODULE,
-	.enable_time	=3D 25000,
+static const struct regulator_desc regulators[] =3D {
+	{
+		.name		=3D "v2_5_dcon",
+		.of_match	=3D of_match_ptr("v2_5_dcon"),
+		.regulators_node =3D of_match_ptr("regulators"),
+		.n_voltages	=3D 1,
+		.fixed_uV	=3D 2500000,
+		.ops		=3D &dcon_regulator_ops,
+		.type		=3D REGULATOR_VOLTAGE,
+		.owner		=3D THIS_MODULE,
+	}, {
+		.name		=3D "v3_3_dcon",
+		.of_match	=3D of_match_ptr("v3_3_dcon"),
+		.regulators_node =3D of_match_ptr("regulators"),
+		.n_voltages	=3D 1,
+		.fixed_uV	=3D 3300000,
+		.ops		=3D &dcon_regulator_ops,
+		.type		=3D REGULATOR_VOLTAGE,
+		.owner		=3D THIS_MODULE,
+	}, {
+		.name		=3D "v1_8_dcon",
+		.of_match	=3D of_match_ptr("v1_8_dcon"),
+		.regulators_node =3D of_match_ptr("regulators"),
+		.n_voltages	=3D 1,
+		.fixed_uV	=3D 1800000,
+		.ops		=3D &dcon_regulator_ops,
+		.type		=3D REGULATOR_VOLTAGE,
+		.owner		=3D THIS_MODULE,
+		.enable_time	=3D 25000,
+	}
 };
=20
 static int olpc_ec_probe(struct platform_device *pdev)
@@ -406,6 +438,7 @@ static int olpc_ec_probe(struct platform_device *pdev=
)
 	struct olpc_ec_priv *ec;
 	struct regulator_config config =3D { };
 	struct regulator_dev *regulator;
+	int i;
 	int err;
=20
 	if (!ec_driver)
@@ -432,12 +465,17 @@ static int olpc_ec_probe(struct platform_device *pd=
ev)
=20
 	config.dev =3D pdev->dev.parent;
 	config.driver_data =3D ec;
-	ec->dcon_enabled =3D true;
-	regulator =3D devm_regulator_register(&pdev->dev, &dcon_desc, &config);
-	if (IS_ERR(regulator)) {
-		dev_err(&pdev->dev, "failed to register DCON regulator\n");
-		err =3D PTR_ERR(regulator);
-		goto error;
+	ec->dcon_enable_count =3D ARRAY_SIZE(regulators);
+
+	for (i =3D 0; i < ARRAY_SIZE(regulators); i++) {
+		regulator =3D devm_regulator_register(&pdev->dev,
+				&regulators[i], &config);
+		if (IS_ERR(regulator)) {
+			dev_err(&pdev->dev, "failed to register %s regulator\n",
+					regulators[i].name);
+			err =3D PTR_ERR(regulator);
+			goto error;
+		}
 	}
=20
 	ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
--=20
2.28.0

