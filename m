Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EE62F2C47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392956AbhALKHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390366AbhALKHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:07:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DD922310A;
        Tue, 12 Jan 2021 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610446030;
        bh=DxYt+mYx8c0tVX8A42/mQ1TijaD2I/tH+KiF9B0oDhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2tZgQRBulvlz77JQDqCufd/2c7muJOQyBYXhyu+Xi6oENnqG708IwFP7GRYhSsOc
         RvvuhRdGd5h/f/dH0TOhwNTIPw1Ls9Hi8EB2dPMmUDbHybon4wz4SMhjxVAtUx9012
         I64JhOpJieRbsE8B7SbKhDBsEW14h5w+XM9EOrKUx/u+zaQj6M1wO+g2GQFL7B6Q1J
         YLMnhmS9M5JuBftwTYZIo+7gD1LS7YCcUpjgw4Hjur2I7374mZ8BpdnBx/lzH4sMED
         Wl8EOj4BTxjcHYiB59i0K5Yxb/xxQhr7WqF3/9VLJprLFk1V454e4keJWERROvDaFz
         4kamh0By/fgGQ==
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
Subject: [PATCH v3 2/2] regulator: mt6323: Add OF match table
Date:   Tue, 12 Jan 2021 11:06:58 +0100
Message-Id: <20210112100659.19350-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112100659.19350-1-matthias.bgg@kernel.org>
References: <20210112100659.19350-1-matthias.bgg@kernel.org>
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

Changes in v3: None
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

