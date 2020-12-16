Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED92DC135
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgLPN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:26:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9625 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLPN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:26:34 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cwwpx5QfMz15ZnH;
        Wed, 16 Dec 2020 21:25:13 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:25:43 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] char: ipmi: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:26:15 +0800
Message-ID: <20201216132615.15529-1-zhengyongjun3@huawei.com>
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
 drivers/char/ipmi/bt-bmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index a395e2e70dc5..6e3d247b55d1 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -462,9 +462,9 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	mutex_init(&bt_bmc->mutex);
 	init_waitqueue_head(&bt_bmc->queue);
 
-	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR,
-	bt_bmc->miscdev.name	= DEVICE_NAME,
-	bt_bmc->miscdev.fops	= &bt_bmc_fops,
+	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR;
+	bt_bmc->miscdev.name	= DEVICE_NAME;
+	bt_bmc->miscdev.fops	= &bt_bmc_fops;
 	bt_bmc->miscdev.parent = dev;
 	rc = misc_register(&bt_bmc->miscdev);
 	if (rc) {
-- 
2.22.0

