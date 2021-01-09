Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090312EFF28
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbhAIL1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 06:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhAIL1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 06:27:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5970523A5B;
        Sat,  9 Jan 2021 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610191584;
        bh=ZwGNlLT0V28L32lhKP8fkz8Phifx/G7ELAZXT2Co0Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az0G+ArNGOjGqZkD4UYAEJr/rNp6bRSLJYMtRkLEmhGcM/oLASeNvOJLKUUDscvoE
         /mhE0gEiDhDaKl49MMjQa5gcXnJKSUv0XF2euS8FLfg8Bh/G6S+/EHQ2xHpVfcy1LO
         zvRFuiMIGqdZosB+7V76saB4vS2nR+SUnFEWi0TDerr//3tPc+vb+vlIjYSElowKOX
         +QXuI9mG+9xKCiZkhnz1WApJA3aaJsdrfUWL9oGt48dWNtVJoDcALPqbq9Y710ik7q
         knKdYgIqzg+bzRSaf8DwWjZCKq+uykYjSpU3YDaJsZysVfpWQf5kZeIgm/Vy90bsfB
         GqvidVQ5MB4sg==
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
        Matthias Brugger <mbrugger@suse.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 3/3] regulator: mt6323: Add OF match table
Date:   Sat,  9 Jan 2021 12:26:11 +0100
Message-Id: <20210109112612.1221-3-matthias.bgg@kernel.org>
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
MT6323 device node. But the driver does not provide a OF match table.
This way auto-loading is broken as the MFD driver that registers the
device has a .of_compatible set which makes the platform .uevent
callback report a OF modalias, but that's not in the module.

Fixes: 2fdf82923618 ("regulator: mt6323: Add support for MT6323 regulator")
Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v2:
- check for CONFIG_OF
- add Fixes tag

 drivers/regulator/mt6323-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index ff9016170db3..646742d4db74 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -406,9 +406,18 @@ static const struct platform_device_id mt6323_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6323_platform_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id mt6323_of_match[] = {
+	{ .compatible = "mediatek,mt6323-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6323_of_match);
+#endif
+
 static struct platform_driver mt6323_regulator_driver = {
 	.driver = {
 		.name = "mt6323-regulator",
+		.of_match_table = of_match_ptr(mt6323_of_match),
 	},
 	.probe = mt6323_regulator_probe,
 	.id_table = mt6323_platform_ids,
-- 
2.29.2

