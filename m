Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A143013B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAWH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:26:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11853 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbhAWHZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:25:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DN70l0rq3z7Xjg;
        Sat, 23 Jan 2021 15:24:07 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 15:25:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/rmap: Correct some obsolete comments of anon_vma
Date:   Sat, 23 Jan 2021 02:24:59 -0500
Message-ID: <20210123072459.25903-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2b575eb64f7a ("mm: convert anon_vma->lock to a mutex") changed
spinlock used to serialize access to vma list to mutex. And further, the
commit 5a505085f043 ("mm/rmap: Convert the struct anon_vma::mutex to an
rwsem") converted the mutex to an rwsem for solving scalability problem. So
replace spinlock with rwsem to make comment uptodate.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/rmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e26ae119a131..f6f43620cd97 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -168,7 +168,7 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
  *
  * Anon-vma allocations are very subtle, because we may have
  * optimistically looked up an anon_vma in page_lock_anon_vma_read()
- * and that may actually touch the spinlock even in the newly
+ * and that may actually touch the rwsem even in the newly
  * allocated vma (it depends on RCU to make sure that the
  * anon_vma isn't actually destroyed).
  *
@@ -359,7 +359,7 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 		goto out_error_free_anon_vma;
 
 	/*
-	 * The root anon_vma's spinlock is the lock actually used when we
+	 * The root anon_vma's rwsem is the lock actually used when we
 	 * lock any of the anon_vmas in this anon_vma tree.
 	 */
 	anon_vma->root = pvma->anon_vma->root;
-- 
2.19.1

