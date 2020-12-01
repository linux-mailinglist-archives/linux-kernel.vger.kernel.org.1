Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965A2C996B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgLAIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:24:37 -0500
Received: from mail.v3.sk ([167.172.186.51]:58668 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgLAIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:24:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 069DDE070D;
        Tue,  1 Dec 2020 08:21:00 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YqbJ1WHZMeJ0; Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 392F1E0714;
        Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pPlmEWzgTMJA; Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0BD40E06F5;
        Tue,  1 Dec 2020 08:20:59 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 3/4] Platform: OLPC: Remove regulator_dev from the priv struct
Date:   Tue,  1 Dec 2020 09:23:47 +0100
Message-Id: <20201201082348.1723631-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201082348.1723631-1-lkundrak@v3.sk>
References: <20201201082348.1723631-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need it as it's device-managed. A local variable will do.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 2ad638583cc58..72dbbea0005c5 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -37,7 +37,6 @@ struct olpc_ec_priv {
 	struct mutex cmd_lock;
=20
 	/* DCON regulator */
-	struct regulator_dev *dcon_rdev;
 	bool dcon_enabled;
=20
 	/* Pending EC commands */
@@ -406,6 +405,7 @@ static int olpc_ec_probe(struct platform_device *pdev=
)
 {
 	struct olpc_ec_priv *ec;
 	struct regulator_config config =3D { };
+	struct regulator_dev *regulator;
 	int err;
=20
 	if (!ec_driver)
@@ -433,11 +433,10 @@ static int olpc_ec_probe(struct platform_device *pd=
ev)
 	config.dev =3D pdev->dev.parent;
 	config.driver_data =3D ec;
 	ec->dcon_enabled =3D true;
-	ec->dcon_rdev =3D devm_regulator_register(&pdev->dev, &dcon_desc,
-								&config);
-	if (IS_ERR(ec->dcon_rdev)) {
+	regulator =3D devm_regulator_register(&pdev->dev, &dcon_desc, &config);
+	if (IS_ERR(regulator)) {
 		dev_err(&pdev->dev, "failed to register DCON regulator\n");
-		err =3D PTR_ERR(ec->dcon_rdev);
+		err =3D PTR_ERR(regulator);
 		goto error;
 	}
=20
--=20
2.28.0

