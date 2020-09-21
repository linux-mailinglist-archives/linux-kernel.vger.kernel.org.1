Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F020327191A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIUCC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:02:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbgIUCC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 91434B8DB0F749D7C350;
        Mon, 21 Sep 2020 10:02:55 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:02:48 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <rui.xiang@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH -next 3/5] mm/kmemleak: Add support for percpu memory leak detect
Date:   Mon, 21 Sep 2020 02:00:05 +0000
Message-ID: <20200921020007.35803-4-chenjun102@huawei.com>
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

Currently the reporting of the percpu chunks leaking problem
are not supported. This patch introduces this function.

Since __percpu pointer is not pointing directly to the actual chunks,
this patch creates an object for __percpu pointer, but marks it as no
scan block, only check whether this pointer is referenced by other
blocks.

Introduce two global variables, min_percpu_addr and max_percpu_addr,
to store the range of valid percpu pointer values, in order to
speed up pointer lookup when scanning blocks.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/kmemleak.c | 71 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c09c6b59eda6..feedb72f06f2 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -170,6 +170,8 @@ struct kmemleak_object {
 #define OBJECT_NO_SCAN		(1 << 2)
 /* flag set to fully scan the object when scan_area allocation failed */
 #define OBJECT_FULL_SCAN	(1 << 3)
+/* flag set to percpu ptr object */
+#define OBJECT_PERCPU		(1 << 4)
 
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
@@ -212,6 +214,9 @@ static int kmemleak_error;
 /* minimum and maximum address that may be valid pointers */
 static unsigned long min_addr = ULONG_MAX;
 static unsigned long max_addr;
+/* minimum and maximum address that may be valid percpu pointers */
+static unsigned long min_percpu_addr = ULONG_MAX;
+static unsigned long max_percpu_addr;
 
 static struct task_struct *scan_thread;
 /* used to avoid reporting of recently allocated objects */
@@ -283,6 +288,9 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
+	if (object->flags & OBJECT_PERCPU)
+		ptr = this_cpu_ptr((void __percpu *)object->pointer);
+
 	/* limit the number of lines to HEX_MAX_LINES */
 	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
 
@@ -563,17 +571,32 @@ static int __save_stack_trace(unsigned long *trace)
 	return stack_trace_save(trace, MAX_TRACE, 2);
 }
 
+static void __update_address_range(struct kmemleak_object *object)
+{
+	unsigned long ptr = object->pointer;
+	size_t size = object->size;
+	unsigned long untagged_ptr;
+
+	if (object->flags & OBJECT_PERCPU) {
+		min_percpu_addr = min(min_percpu_addr, ptr);
+		max_percpu_addr = max(max_percpu_addr, ptr + size);
+	} else {
+		untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
+		min_addr = min(min_addr, untagged_ptr);
+		max_addr = max(max_addr, untagged_ptr + size);
+	}
+}
+
 /*
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
  * memory block and add it to the object_list and object_tree_root.
  */
-static void create_object(unsigned long ptr, size_t size, int min_count,
-			  gfp_t gfp)
+static void __create_object(unsigned long ptr, size_t size, int min_count,
+			    unsigned int obj_flags, gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
 	struct rb_node **link, *rb_parent;
-	unsigned long untagged_ptr;
 
 	object = mem_pool_alloc(gfp);
 	if (!object) {
@@ -587,7 +610,7 @@ static void create_object(unsigned long ptr, size_t size, int min_count,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED;
+	object->flags = OBJECT_ALLOCATED | obj_flags;
 	object->pointer = ptr;
 	object->size = size;
 	object->excess_ref = 0;
@@ -619,9 +642,7 @@ static void create_object(unsigned long ptr, size_t size, int min_count,
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
-	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
-	min_addr = min(min_addr, untagged_ptr);
-	max_addr = max(max_addr, untagged_ptr + size);
+	__update_address_range(object);
 	link = &object_tree_root.rb_node;
 	rb_parent = NULL;
 	while (*link) {
@@ -651,6 +672,19 @@ static void create_object(unsigned long ptr, size_t size, int min_count,
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
 
+static void create_object(unsigned long ptr, size_t size, int min_count,
+			  gfp_t gfp)
+{
+	__create_object(ptr, size, min_count, 0, gfp);
+}
+
+static void create_object_percpu(unsigned long ptr, size_t size, int min_count,
+				 gfp_t gfp)
+{
+	__create_object(ptr, size, min_count, OBJECT_PERCPU | OBJECT_NO_SCAN,
+			gfp);
+}
+
 /*
  * Mark the object as not allocated and schedule RCU freeing via put_object().
  */
@@ -912,10 +946,12 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	 * Percpu allocations are only scanned and not reported as leaks
 	 * (min_count is set to 0).
 	 */
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
 		for_each_possible_cpu(cpu)
 			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
 				      size, 0, gfp);
+		create_object_percpu((unsigned long)ptr, size, 1, gfp);
+	}
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -991,10 +1027,12 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
-	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr)) {
 		for_each_possible_cpu(cpu)
 			delete_object_full((unsigned long)per_cpu_ptr(ptr,
 								      cpu));
+		delete_object_full((unsigned long)ptr);
+	}
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 
@@ -1224,6 +1262,17 @@ static int scan_should_stop(void)
 	return 0;
 }
 
+static bool is_valid_address(unsigned long ptr)
+{
+	unsigned long untagged_ptr;
+
+	if (ptr >= min_percpu_addr && ptr < max_percpu_addr)
+		return true;
+
+	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
+	return (untagged_ptr >= min_addr && untagged_ptr < max_addr);
+}
+
 /*
  * Scan a memory block (exclusive range) for valid pointers and add those
  * found to the gray list.
@@ -1235,7 +1284,6 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
-	unsigned long untagged_ptr;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
@@ -1250,8 +1298,7 @@ static void scan_block(void *_start, void *_end,
 		pointer = *ptr;
 		kasan_enable_current();
 
-		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
-		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
+		if (!is_valid_address(pointer))
 			continue;
 
 		/*
-- 
2.25.0

