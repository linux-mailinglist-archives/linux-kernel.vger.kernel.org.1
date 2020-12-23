Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2F2E1D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgLWOPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:15:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9919 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgLWOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:15:09 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1FYd2F3Rz7Dn5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:13:41 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:14:16 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <khalasa@piap.pl>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] soc: ixp4xx: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 23 Dec 2020 22:14:53 +0800
Message-ID: <20201223141453.1000-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 8c968382cea7..dde3b668eb40 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -16,7 +16,7 @@
 static struct qmgr_regs __iomem *qmgr_regs;
 static int qmgr_irq_1;
 static int qmgr_irq_2;
-static spinlock_t qmgr_lock;
+static DEFINE_SPINLOCK(qmgr_lock);
 static u32 used_sram_bitmap[4]; /* 128 16-dword pages */
 static void (*irq_handlers[QUEUES])(void *pdev);
 static void *irq_pdevs[QUEUES];
@@ -434,7 +434,6 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 	}
 
 	used_sram_bitmap[0] = 0xF; /* 4 first pages reserved for config */
-	spin_lock_init(&qmgr_lock);
 
 	dev_info(dev, "IXP4xx Queue Manager initialized.\n");
 	return 0;
-- 
2.22.0

