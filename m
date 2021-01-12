Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209A82F2C45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392942AbhALKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390366AbhALKHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:07:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28AB923107;
        Tue, 12 Jan 2021 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610446026;
        bh=vdwmtnjiAMvviv26hOvbYr6Ik1Q7vOUq5UUucWiEegc=;
        h=From:To:Cc:Subject:Date:From;
        b=EdL2vLx3V3nkkoVBN39WY2dZbTEsYPI7oeFJd/yzffxDzveGK4Pq71jmTWpdGN98K
         ypzt/DPi8AkAYmHcyOR8Tz4Wmu5IBW5L4+V/PgXL3A4EdJeON8vq+3LyV1rQKxjmoW
         rjFkH274nXB8FGArd1sKLcfkVzjJFcURfchKqhDDzjhSvHQtGne19SG099O7YE88zP
         m2YhxHaQdzREhXVYlwkGvgtWLTU8W+qXjOFiLk86RfsaBSa+inZNPSBFw3ibTM9DHk
         X1Ks4jTEaI7IL/ZJ0yeShaemKro4DGilTDJPBciLV4jb8C+lU8PkhHjBRkDPbcYpN8
         AEqJBDSWNPYgg==
From:   matthias.bgg@kernel.org
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Axel Lin <axel.lin@ingics.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v3 1/2] regulator: mt6358: Add OF match table
Date:   Tue, 12 Jan 2021 11:06:57 +0100
Message-Id: <20210112100659.19350-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The binding documentation mentions that a compatible is required for the
MT6358 device node. But the driver does not provide a OF match table.
This way auto-loading is broken as the MFD driver that registers the
device has a .of_compatible set which makes the platform .uevent
callback report a OF modalias, but that's not in the module.

Fixes: f67ff1bd58f0 ("regulator: mt6358: Add support for MT6358 regulator")
Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v3:
- drop mt6360 patch

Changes in v2:
- check for CONFIG_OF
- add Fixes tag

 drivers/regulator/mt6358-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 13cb6ac9a892..a4ed19a54ec6 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -534,9 +534,18 @@ static const struct platform_device_id mt6358_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6358_platform_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id mt6358_of_match[] = {
+	{ .compatible = "mediatek,mt6358-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6358_of_match);
+#endif
+
 static struct platform_driver mt6358_regulator_driver = {
 	.driver = {
 		.name = "mt6358-regulator",
+		.of_match_table = of_match_ptr(mt6358_of_match),
 	},
 	.probe = mt6358_regulator_probe,
 	.id_table = mt6358_platform_ids,
-- 
2.29.2

