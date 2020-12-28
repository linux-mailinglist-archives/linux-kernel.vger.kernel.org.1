Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8502E3BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407290AbgL1NxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:53:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10083 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406598AbgL1NvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:51:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4JnJ4ngNzMBSy;
        Mon, 28 Dec 2020 21:49:24 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:50:18 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <ssantosh@kernel.org>, <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] drivers: memory: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:50:56 +0800
Message-ID: <20201228135056.28511-1-zhengyongjun3@huawei.com>
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
 drivers/memory/emif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index ddb1879f07d3..f7825eef5894 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -70,7 +70,7 @@ struct emif_data {
 };
 
 static struct emif_data *emif1;
-static spinlock_t	emif_lock;
+static DEFINE_SPINLOCK(emif_lock);
 static unsigned long	irq_state;
 static u32		t_ck; /* DDR clock period in ps */
 static LIST_HEAD(device_list);
@@ -1531,7 +1531,6 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	/* One-time actions taken on probing the first device */
 	if (!emif1) {
 		emif1 = emif;
-		spin_lock_init(&emif_lock);
 
 		/*
 		 * TODO: register notifiers for frequency and voltage
-- 
2.22.0

