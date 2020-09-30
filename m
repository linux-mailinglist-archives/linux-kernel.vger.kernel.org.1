Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6668827E66B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgI3KTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:19:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729215AbgI3KTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:19:37 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C18C8E410828AA328DD;
        Wed, 30 Sep 2020 18:19:35 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 18:19:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <darrick.wong@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: Fix potential memory leak in sys_swapon
Date:   Wed, 30 Sep 2020 06:18:03 -0400
Message-ID: <20200930101803.53884-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we failed to drain inode, we would forget to free the swap address space
allocated by init_swap_address_space() above.

Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2b0c5fc1b0e6..4522b458a814 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3342,7 +3342,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	error = inode_drain_writes(inode);
 	if (error) {
 		inode->i_flags &= ~S_SWAPFILE;
-		goto bad_swap_unlock_inode;
+		goto free_swap_address_space;
 	}
 
 	mutex_lock(&swapon_mutex);
@@ -3367,6 +3367,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = 0;
 	goto out;
+free_swap_address_space:
+	exit_swap_address_space(p->type);
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
-- 
2.19.1

