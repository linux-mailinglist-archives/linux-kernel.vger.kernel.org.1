Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62A11C6EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEFKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 06:42:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725824AbgEFKmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:42:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A981B7F4B966CBE7C6E2;
        Wed,  6 May 2020 18:42:43 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 18:42:33 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: shrink spinlock coverage
Date:   Wed, 6 May 2020 18:42:18 +0800
Message-ID: <20200506104218.121804-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_try_to_free_nids(), .nid_list_lock spinlock critical region will
increase as expected shrink number increase, to avoid spining other CPUs
for long time, it's better to implement like extent cache and nats
shrinker.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4da0d8713df5..a0cf66ace41e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2488,7 +2488,6 @@ void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
 	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
@@ -2498,14 +2497,22 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 		return 0;
 
 	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 ||
-				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
+	while (nr_shrink) {
+		struct free_nid *i;
+
+		if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 			break;
 
+		i = list_first_entry(&nm_i->free_nid_list,
+					struct free_nid, list);
+		list_del(&i->list);
+		spin_unlock(&nm_i->nat_list_lock);
+
 		__remove_free_nid(sbi, i, FREE_NID);
 		kmem_cache_free(free_nid_slab, i);
 		nr_shrink--;
+
+		spin_lock(&nm_i->nid_list_lock);
 	}
 	spin_unlock(&nm_i->nid_list_lock);
 	mutex_unlock(&nm_i->build_lock);
-- 
2.18.0.rc1

