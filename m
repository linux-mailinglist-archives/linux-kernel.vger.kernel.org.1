Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F622EFF2D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 12:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhAIL1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 06:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhAIL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 06:27:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 424F123A58;
        Sat,  9 Jan 2021 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610191580;
        bh=6GN7kj+RoSZ2m6uLCL8sHki+5OJWmv4cnpxhwevCVRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGmINWBjz8c2GpjrFDL6ZZ2f9Dn4P8DCj1G1xmdvlDyjtT3ySCXyGtQ7BPqo+4VUw
         FvozlS555RlT0QbFq9ZCDsBsmSJJw2dmJtN98qHl9zuYnc6wuuHtOJ1JkOL5YFoVel
         pqeCc8U1Eig5Fcs0GFX95DYhIcu6NCnlT7GeCLr7i1TkCQhUJQpWhaVPnr8JOxBpjX
         5rzsuVqgFVgaZaCojVfgA+8z8w4e+05wZICYYa3afcczl7gnzwJgJU930VIcQNkWqW
         Ijb+XaDuI8aPOSkoDaJ9X6wI7wXXjQB4RPxeORPldX9SDDJEXqdJa0GAVQrEAJBTBI
         BVmZ2cxtd5KiA==
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
Subject: [PATCH v2 2/3] regulator: mt6358: Add OF match table
Date:   Sat,  9 Jan 2021 12:26:10 +0100
Message-Id: <20210109112612.1221-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109112612.1221-1-matthias.bgg@kernel.org>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
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

