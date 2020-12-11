Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD632D7216
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437111AbgLKIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:45:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9186 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437081AbgLKIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:45:05 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CskpM5yyyzkpNr;
        Fri, 11 Dec 2020 16:43:39 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:44:12 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <lgirdwood@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] regulator: wm831x-isink: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:44:40 +0800
Message-ID: <20201211084440.2210-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/regulator/wm831x-isink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index eade3ae3e333..76d9b0434c70 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -146,10 +146,10 @@ static int wm831x_isink_probe(struct platform_device *pdev)
 	isink->desc.ops = &wm831x_isink_ops;
 	isink->desc.type = REGULATOR_CURRENT;
 	isink->desc.owner = THIS_MODULE;
-	isink->desc.curr_table = wm831x_isinkv_values,
-	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values),
-	isink->desc.csel_reg = isink->reg,
-	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK,
+	isink->desc.curr_table = wm831x_isinkv_values;
+	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values);
+	isink->desc.csel_reg = isink->reg;
+	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK;
 
 	config.dev = pdev->dev.parent;
 	config.init_data = pdata->isink[id];
-- 
2.22.0

