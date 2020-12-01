Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FF12C996D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgLAIYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:24:42 -0500
Received: from mail.v3.sk ([167.172.186.51]:58680 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728577AbgLAIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:24:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 56AD3E0714;
        Tue,  1 Dec 2020 08:21:00 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t3npV6SHtMie; Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5BEC3E0713;
        Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kcCNg4SbJz8o; Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 23433DF9A4;
        Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 1/4] Platform: OLPC: Specify the enable time for DCON power
Date:   Tue,  1 Dec 2020 09:23:45 +0100
Message-Id: <20201201082348.1723631-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201082348.1723631-1-lkundrak@v3.sk>
References: <20201201082348.1723631-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It takes some significant time between when we ask the EC to enable the
DCON power and when we can access the DCON registers.

FIXME: Maybe some of the delay is caused on the DCON side once the power
is good. Need to check with a scope I suppose.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index f64b82824db28..faecb73bd8430 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -394,11 +394,12 @@ static struct regulator_ops dcon_regulator_ops =3D =
{
 };
=20
 static const struct regulator_desc dcon_desc =3D {
-	.name	=3D "dcon",
-	.id	=3D 0,
-	.ops	=3D &dcon_regulator_ops,
-	.type	=3D REGULATOR_VOLTAGE,
-	.owner	=3D THIS_MODULE,
+	.name		=3D "dcon",
+	.id		=3D 0,
+	.ops		=3D &dcon_regulator_ops,
+	.type		=3D REGULATOR_VOLTAGE,
+	.owner		=3D THIS_MODULE,
+	.enable_time	=3D 25000,
 };
=20
 static int olpc_ec_probe(struct platform_device *pdev)
--=20
2.28.0

