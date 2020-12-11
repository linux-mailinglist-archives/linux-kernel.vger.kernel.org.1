Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5D2D7218
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437125AbgLKIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:46:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9595 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437101AbgLKIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:45:41 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cskps6PRjzM2kx;
        Fri, 11 Dec 2020 16:44:05 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:44:40 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] regulator: mc13892-regulator: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:45:10 +0800
Message-ID: <20201211084510.2264-1-zhengyongjun3@huawei.com>
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
 drivers/regulator/mc13892-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index a731e826a037..5221f7a9df91 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -582,8 +582,8 @@ static int mc13892_regulator_probe(struct platform_device *pdev)
 	/* update mc13892_vcam ops */
 	memcpy(&mc13892_vcam_ops, mc13892_regulators[MC13892_VCAM].desc.ops,
 						sizeof(struct regulator_ops));
-	mc13892_vcam_ops.set_mode = mc13892_vcam_set_mode,
-	mc13892_vcam_ops.get_mode = mc13892_vcam_get_mode,
+	mc13892_vcam_ops.set_mode = mc13892_vcam_set_mode;
+	mc13892_vcam_ops.get_mode = mc13892_vcam_get_mode;
 	mc13892_regulators[MC13892_VCAM].desc.ops = &mc13892_vcam_ops;
 
 	mc13xxx_data = mc13xxx_parse_regulators_dt(pdev, mc13892_regulators,
-- 
2.22.0

