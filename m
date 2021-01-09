Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8602EFD13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbhAICLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbhAICLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:11:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DC6C23A60;
        Sat,  9 Jan 2021 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610158260;
        bh=J8F9GtnOw2YbAF+emi5C/TcN+YhRipufocVzCIIaAFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNxX+FGCIjAzQrWyPmXiZ8aIr1rFK2coB0JV+SW1iZx/WddvGjrji9i/XFkMHw40S
         4Nj3NiqNvnAa+AG/gA61O0CDpFq1kuAqWRf4HnEerjnKyNZ1Eewkm32a9ccNkDKpv2
         yZPxjQKo4y7dbe9C2Zw4xwWZGxiK1o8FI4oaFPlu3p4938ZLtw8eyxybttHYg77nQa
         nh8//v2RGfizZ0gX8n7zd7Yw0q3rPgdh6G3uvRZrUvuM/7XK80H3Lukd++Mqs7vAeZ
         KKXi+0+Dx+Nq1nRNRhEhF59SjiaFN1k4a/7utJeOeqgTrvHZsuLSHLD374JO2wNZ12
         9C4oDVpiUp4dg==
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
Subject: [PATCH 2/3] regulator: mt6358: Add OF match table
Date:   Sat,  9 Jan 2021 03:10:45 +0100
Message-Id: <20210109021046.21907-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109021046.21907-1-matthias.bgg@kernel.org>
References: <20210109021046.21907-1-matthias.bgg@kernel.org>
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

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---

 drivers/regulator/mt6358-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 13cb6ac9a892..6cadb6d4dfe4 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -534,9 +534,16 @@ static const struct platform_device_id mt6358_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6358_platform_ids);
 
+static const struct of_device_id mt6358_of_match[] = {
+	{ .compatible = "mediatek,mt6358-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6358_of_match);
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

