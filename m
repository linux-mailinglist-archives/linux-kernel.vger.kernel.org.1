Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01669271918
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIUCC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:02:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgIUCC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 969C04D159F87F639888;
        Mon, 21 Sep 2020 10:02:55 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:02:47 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <rui.xiang@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH -next 1/5] mm/kmemleak: make create_object return void
Date:   Mon, 21 Sep 2020 02:00:03 +0000
Message-ID: <20200921020007.35803-2-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200921020007.35803-1-chenjun102@huawei.com>
References: <20200921020007.35803-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

No user cares about the return value of create_object,
so make it return void.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/kmemleak.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c0014d3b91c1..b3f603fd9fc3 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -567,8 +567,8 @@ static int __save_stack_trace(unsigned long *trace)
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
  * memory block and add it to the object_list and object_tree_root.
  */
-static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+static void create_object(unsigned long ptr, size_t size, int min_count,
+			  gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
@@ -579,7 +579,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-		return NULL;
+		return;
 	}
 
 	INIT_LIST_HEAD(&object->object_list);
@@ -640,7 +640,6 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 			 */
 			dump_object_info(parent);
 			kmem_cache_free(object_cache, object);
-			object = NULL;
 			goto out;
 		}
 	}
@@ -650,7 +649,6 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
-	return object;
 }
 
 /*
-- 
2.25.0

