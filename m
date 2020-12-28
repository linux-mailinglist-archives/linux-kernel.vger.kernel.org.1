Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D89F2E3B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406862AbgL1NvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:51:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10369 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406511AbgL1NvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:51:03 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D4JnS2TnQz7KSm
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:49:32 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:50:13 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] drivers: most: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:50:48 +0800
Message-ID: <20201228135048.28456-1-zhengyongjun3@huawei.com>
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
 drivers/most/most_cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 044880760b58..8b69cf3ca60b 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -45,7 +45,7 @@ struct comp_channel {
 
 #define to_channel(d) container_of(d, struct comp_channel, cdev)
 static struct list_head channel_list;
-static spinlock_t ch_list_lock;
+static DEFINE_SPINLOCK(ch_list_lock);
 
 static inline bool ch_has_mbo(struct comp_channel *c)
 {
@@ -495,7 +495,6 @@ static int __init mod_init(void)
 		return PTR_ERR(comp.class);
 
 	INIT_LIST_HEAD(&channel_list);
-	spin_lock_init(&ch_list_lock);
 	ida_init(&comp.minor_id);
 
 	err = alloc_chrdev_region(&comp.devno, 0, CHRDEV_REGION_SIZE, "cdev");
-- 
2.22.0

