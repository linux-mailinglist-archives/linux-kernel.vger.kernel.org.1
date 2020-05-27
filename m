Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A01E3EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 12:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgE0K2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 06:28:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbgE0K2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:28:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0562BA029DB6410E33CF;
        Wed, 27 May 2020 18:28:01 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 18:27:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: remove unneeded return value of __insert_discard_tree()
Date:   Wed, 27 May 2020 18:27:52 +0800
Message-ID: <20200527102753.15743-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200527102753.15743-1-yuchao0@huawei.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never use return value of __insert_discard_tree(), so remove it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1c48ec866b8c..ebbadde6cbce 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1221,7 +1221,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	return err;
 }
 
-static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
+static void __insert_discard_tree(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len,
 				struct rb_node **insert_p,
@@ -1230,7 +1230,6 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
-	struct discard_cmd *dc = NULL;
 	bool leftmost = true;
 
 	if (insert_p && insert_parent) {
@@ -1242,12 +1241,8 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 	p = f2fs_lookup_rb_tree_for_insert(sbi, &dcc->root, &parent,
 							lstart, &leftmost);
 do_insert:
-	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent,
+	__attach_discard_cmd(sbi, bdev, lstart, start, len, parent,
 								p, leftmost);
-	if (!dc)
-		return NULL;
-
-	return dc;
 }
 
 static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
-- 
2.18.0.rc1

