Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA732AA454
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgKGKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 05:03:23 -0500
Received: from mail.loongson.cn ([114.242.206.163]:59546 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727890AbgKGKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 05:03:22 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx79PgcKZfrT0IAA--.19813S2;
        Sat, 07 Nov 2020 18:03:13 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] dma-pool: no need to check return value of debugfs_create functions
Date:   Sat,  7 Nov 2020 18:03:12 +0800
Message-Id: <1604743392-21601-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx79PgcKZfrT0IAA--.19813S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryfZr17Ar1DGFWrur13XFb_yoWfWrb_K3
        4Iq348KwsI9a42qayxCrWfXFZ2g398KF4093Z3XrW5Kan8GFZ8Jr4xZ395Wrnxu34ktFWY
        9a4DJFZrJr1fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4D
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjhL0UUUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/dma/pool.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index d4637f7..5f84e6c 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -38,9 +38,6 @@ static void __init dma_atomic_pool_debugfs_init(void)
 	struct dentry *root;
 
 	root = debugfs_create_dir("dma_pools", NULL);
-	if (IS_ERR_OR_NULL(root))
-		return;
-
 	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
 	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
 	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
-- 
2.1.0

