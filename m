Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3162C2EFD12
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAICLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbhAICLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:11:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC761238EC;
        Sat,  9 Jan 2021 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610158257;
        bh=EDiuihkI2zHL3YX+YyvVNrWe26jYFlwF8QTuQEZCbkw=;
        h=From:To:Cc:Subject:Date:From;
        b=QygVfo2nV59Sajx3EWeE0ByXrAMFCYRfmPB9WAX072niACBy4umZ1FtX0N+B33xjr
         5oQdrZcBwIxnGE3Q2wlH52ow98pTlepl2c5O/NF+/sAWETV7P2IijEWoZhallGIGX7
         u9lD17bqxEacfJxZT8/Y2S9n3ftcg7D6Q0BZtFBYQvzxR6NteNtTobwhyCUqYjPqKy
         lrRlMISTXIwWN02VjH6wEt/gMul4dxghy4pwDu0aNgTygG4tbgkBQrVJYUri9Bmw71
         t5U0gTppjRwuysce9jqeH1sTmBSo1e7QLapQVGo2tZLvxYHfJdv+IlK4BkcWHO8gz7
         4MA+TCFvPPumA==
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
Subject: [PATCH 1/3] regulator: mt6360: Add OF match table
Date:   Sat,  9 Jan 2021 03:10:44 +0100
Message-Id: <20210109021046.21907-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Binding documentation mentions that a compatible is required for the
MT6360 device node, but the driver doesn't provide a OF match table.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---

 drivers/regulator/mt6360-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 15308ee29c13..07cbb9bb3c09 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -445,9 +445,16 @@ static const struct platform_device_id mt6360_regulator_id_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6360_regulator_id_table);
 
+static const struct of_device_id mt6360_of_match[] = {
+	{ .compatible = "mediatek,mt6360-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6360_of_match);
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

