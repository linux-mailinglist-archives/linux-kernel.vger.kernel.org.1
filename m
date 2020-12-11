Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D562D7248
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392911AbgLKIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:52:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9870 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437165AbgLKIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:51:45 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CskyB0Rbvz7C81
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:50:26 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:50:49 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ti/phy-j721e-wiz: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:51:19 +0800
Message-ID: <20201211085119.2654-1-zhengyongjun3@huawei.com>
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
 drivers/phy/ti/phy-j721e-wiz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index c9cfafe89cbf..73eb92b5817b 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -922,8 +922,8 @@ static int wiz_probe(struct platform_device *pdev)
 
 	phy_reset_dev = &wiz->wiz_phy_reset_dev;
 	phy_reset_dev->dev = dev;
-	phy_reset_dev->ops = &wiz_phy_reset_ops,
-	phy_reset_dev->owner = THIS_MODULE,
+	phy_reset_dev->ops = &wiz_phy_reset_ops;
+	phy_reset_dev->owner = THIS_MODULE;
 	phy_reset_dev->of_node = node;
 	/* Reset for each of the lane and one for the entire SERDES */
 	phy_reset_dev->nr_resets = num_lanes + 1;
-- 
2.22.0

