Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1022EFF27
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 12:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbhAIL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 06:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhAIL06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 06:26:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A57623A23;
        Sat,  9 Jan 2021 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610191577;
        bh=STRnszbJDiMCR1dFP63SP57c2zY2aY54/4HtRf2kO0A=;
        h=From:To:Cc:Subject:Date:From;
        b=k9T+k17RJDnLBntW8S4DF+qQBhHYQSAiqhanrh8ksHpWU9FTRU2iTUnxiPSwZavFD
         kioJBXGt6eQyOZEhN7uYLN1scf3fW3FVmhJ8DkREypjE5H85OESszxJGd9JlbqyL9i
         /7mJLrHYk3SjMhsjteVYJ3AxroxVTCMiskBL9yIuviRq5fD4RxjSW67yWF/lGXfVTi
         c1e3TV9Gcg8rDocxjQAs0Ar+fUWYalzC0rG/bu7Jzc5Uv7asw3eIjwv7mrul579ZRF
         4B9llOwaNNfDH5MQit+1zwWdkc33dgfZtzPTHe+8AkE3kR3yW/tF6Rs86l3usOSvI9
         PvlRysC7G42+Q==
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
Subject: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Date:   Sat,  9 Jan 2021 12:26:09 +0100
Message-Id: <20210109112612.1221-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Binding documentation mentions that a compatible is required for the
MT6360 device node, but the driver doesn't provide a OF match table.

Fixes: d321571d5e4c ("regulator: mt6360: Add support for MT6360 regulator")
Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v2:
- check for CONFIG_OF
- add Fixes tag

 drivers/regulator/mt6360-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 15308ee29c13..f7b2514feabf 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -445,9 +445,18 @@ static const struct platform_device_id mt6360_regulator_id_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6360_regulator_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id mt6360_of_match[] = {
+	{ .compatible = "mediatek,mt6360-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6360_of_match);
+#endif
+
 static struct platform_driver mt6360_regulator_driver = {
 	.driver = {
 		.name = "mt6360-regulator",
+		.of_match_table = of_match_ptr(mt6360_of_match),
 	},
 	.probe = mt6360_regulator_probe,
 	.id_table = mt6360_regulator_id_table,
-- 
2.29.2

