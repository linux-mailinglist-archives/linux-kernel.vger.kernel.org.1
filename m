Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A342D2B32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgLHMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:38:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9397 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:38:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cr0726V24z7BK7;
        Tue,  8 Dec 2020 20:37:02 +0800 (CST)
Received: from linux-tejb.huawei.com (10.90.53.232) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 20:37:27 +0800
From:   Fangping Liang <liangfangping@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>
CC:     <liangfangping@huawei.com>, <wangfangpeng1@huawei.com>
Subject: [PATCH] ubifs:Fixed print foramt mismatch in ubifs
Date:   Tue, 8 Dec 2020 21:58:11 +0800
Message-ID: <20201208135811.92321-1-liangfangping@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/ubifs/super.c: function mount_ubifs:
the format specifier "lld" need arg type "long long",
but the according arg "old_idx_sz" has type
"unsigned long long"

Signed-off-by: Fangping Liang <liangfangping@huawei.com>
---
 fs/ubifs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index cb3acfb7dd1f..06612ca8a291 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1572,7 +1572,7 @@ static int mount_ubifs(struct ubifs_info *c)
 	dbg_gen("main area LEBs:      %d (%d - %d)",
 		c->main_lebs, c->main_first, c->leb_cnt - 1);
 	dbg_gen("index LEBs:          %d", c->lst.idx_lebs);
-	dbg_gen("total index bytes:   %lld (%lld KiB, %lld MiB)",
+	dbg_gen("total index bytes:   %llu (%llu KiB, %llu MiB)",
 		c->bi.old_idx_sz, c->bi.old_idx_sz >> 10,
 		c->bi.old_idx_sz >> 20);
 	dbg_gen("key hash type:       %d", c->key_hash_type);
-- 
2.12.3

