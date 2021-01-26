Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00FA304564
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbhAZRdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:33:54 -0500
Received: from mail.v3.sk ([167.172.186.51]:48106 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389447AbhAZHip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:38:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7CDC7E0B00;
        Tue, 26 Jan 2021 07:33:44 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G4dx_yet5KKS; Tue, 26 Jan 2021 07:33:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9D7EDE0838;
        Tue, 26 Jan 2021 07:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bH9cakOCdFqc; Tue, 26 Jan 2021 07:33:43 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 98AEFE0AE3;
        Tue, 26 Jan 2021 07:33:42 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/3] Platform: OLPC: Specify the enable time
Date:   Tue, 26 Jan 2021 08:37:40 +0100
Message-Id: <20210126073740.10232-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126073740.10232-1-lkundrak@v3.sk>
References: <20210126073740.10232-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determined empirically.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-ec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 3c852d573e9b4..72dbbea0005c5 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -393,11 +393,12 @@ static struct regulator_ops dcon_regulator_ops =3D =
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
2.29.2

