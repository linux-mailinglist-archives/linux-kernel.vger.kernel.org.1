Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60A2B5407
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKPWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgKPWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:00:49 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDCAC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:00:47 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so21881121ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81Ia4Jwsp53vRxqStiMdH77b+FaNNjG0LJemMzqrtEA=;
        b=fIhhci2Umlz/JAysKvwWA3sXuzC1AMaLfJ1tk13v0Il/5BsxBGd9DjlK6r6DAw375Z
         WMNM6f2Z5T6P3STfFpEBkYpjeDZ+n8fDhFkYC6yhZ0NsDCEaz3dAWZ5/Iapq8eRY1RK3
         RF9ZnmSpl8eL8Moy5qMyhiLxxiu515th0dmFJbOH/EghOuqdnGIX5QSRgjNdFiGYiIVW
         sIR+wXO4CFbsGJtoHMEjCUJv1yMGWYa6ekdm4Bbe6G/5ZgxKBmK2TXubSSyuRFnMTVze
         kzEuzeRAxEp6+zFSDMehMauJy98P3kyy/rnqn6PY6RX2n+9U+Y+VWuwIJ/40Ar596+Sj
         mmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81Ia4Jwsp53vRxqStiMdH77b+FaNNjG0LJemMzqrtEA=;
        b=bBSzKE1ge3ftd80UkZQVjxQRGkLT+p/RbRzrpZ8fxPBPWGoWDZUoxbxuHDgFdzCvPO
         7Sl4FkntDALb1ctlYqEiC+gRZd76WiOQnUGf5ijo4pJ8dxrkDMveB5nqSsVRFnCA3GEn
         27FEj4YHMBJPb4WjEb5GO7N62152rchMObbX+UnMrSxJR3zMgf34z78aKRnl8LFuVnQJ
         U7WYcLyv6o/vzpSYmYov96XgVe1aO9c0Fh2iaE+LfByxkxhVp3UQKw6oGdui8pV44NWR
         o8wgvNH0WsgUEfgBOL4AzxjHSObrz+VkilKMWz2nKK7zogrYgmdI52moxMGwWCi1Z9LV
         u0Pg==
X-Gm-Message-State: AOAM531Qbd1hFM6IHJ16lc+aXnXb5wl9H/g+WMQ1GyEQAKE1qqkloSQd
        aBb3zV8SlC7RH/E4qhARww8=
X-Google-Smtp-Source: ABdhPJxIR7DYwAxIpSUVkV5VgxGUO45ub8vjSIuoejwUH/HlHAyemE8eVeQBzsLPiwuTmqamuQ7EJQ==
X-Received: by 2002:a05:651c:1052:: with SMTP id x18mr510480ljm.208.1605564045752;
        Mon, 16 Nov 2020 14:00:45 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v130sm2870160lfa.283.2020.11.16.14.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:00:45 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] mm/vmalloc: rework the drain logic
Date:   Mon, 16 Nov 2020 23:00:33 +0100
Message-Id: <20201116220033.1837-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116220033.1837-1-urezki@gmail.com>
References: <20201116220033.1837-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A current "lazy drain" model suffers from at least two issues.

First one is related to the unsorted list of vmap areas, thus
in order to identify the [min:max] range of areas to be drained,
it requires a full list scan. What is a time consuming if the
list is too long.

Second one and as a next step is about merging all fragments
with a free space. What is also a time consuming because it
has to iterate over entire list which holds outstanding lazy
areas.

See below the "preemptirqsoff" tracer that illustrates a high
latency. It is ~24 676us. Our workloads like audio and video
are effected by such long latency:

<snip>
  tracer: preemptirqsoff

  preemptirqsoff latency trace v1.1.5 on 4.9.186-perf+
  --------------------------------------------------------------------
  latency: 24676 us, #4/4, CPU#1 | (M:preempt VP:0, KP:0, SP:0 HP:0 P:8)
     -----------------
     | task: crtc_commit:112-261 (uid:0 nice:0 policy:1 rt_prio:16)
     -----------------
   => started at: __purge_vmap_area_lazy
   => ended at:   __purge_vmap_area_lazy

                   _------=> CPU#
                  / _-----=> irqs-off
                 | / _----=> need-resched
                 || / _---=> hardirq/softirq
                 ||| / _--=> preempt-depth
                 |||| /     delay
   cmd     pid   ||||| time  |   caller
      \   /      |||||  \    |   /
crtc_com-261     1...1    1us*: _raw_spin_lock <-__purge_vmap_area_lazy
[...]
crtc_com-261     1...1 24675us : _raw_spin_unlock <-__purge_vmap_area_lazy
crtc_com-261     1...1 24677us : trace_preempt_on <-__purge_vmap_area_lazy
crtc_com-261     1...1 24683us : <stack trace>
 => free_vmap_area_noflush
 => remove_vm_area
 => __vunmap
 => vfree
 => drm_property_free_blob
 => drm_mode_object_unreference
 => drm_property_unreference_blob
 => __drm_atomic_helper_crtc_destroy_state
 => sde_crtc_destroy_state
 => drm_atomic_state_default_clear
 => drm_atomic_state_clear
 => drm_atomic_state_free
 => complete_commit
 => _msm_drm_commit_work_cb
 => kthread_worker_fn
 => kthread
 => ret_from_fork
<snip>

To address those two issues we can redesign a purging of the
outstanding lazy areas. Instead of queuing vmap areas to the
list, we replace it by the separate rb-tree. In hat case an
area is located in the tree/list in ascending order. It will
give us below advantages:

a) Outstanding vmap areas are merged creating bigger coalesced
   blocks, thus it becomes less fragmented.

b) It is possible to calculate a flush range [min:max] without
   scanning all elements. It is O(1) access time or complexity;

c) The final merge of areas with the rb-tree that represents a
   free space is faster because of (a). As a result the lock
   contention is also reduced.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/vmalloc.h |  8 ++--
 mm/vmalloc.c            | 90 +++++++++++++++++++++++------------------
 2 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 938eaf9517e2..80c0181c411d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -72,16 +72,14 @@ struct vmap_area {
 	struct list_head list;          /* address sorted list */
 
 	/*
-	 * The following three variables can be packed, because
-	 * a vmap_area object is always one of the three states:
+	 * The following two variables can be packed, because
+	 * a vmap_area object can be either:
 	 *    1) in "free" tree (root is vmap_area_root)
-	 *    2) in "busy" tree (root is free_vmap_area_root)
-	 *    3) in purge list  (head is vmap_purge_list)
+	 *    2) or "busy" tree (root is free_vmap_area_root)
 	 */
 	union {
 		unsigned long subtree_max_size; /* in "free" tree */
 		struct vm_struct *vm;           /* in "busy" tree */
-		struct llist_node purge_list;   /* in purge list */
 	};
 };
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b08b06a8cc2a..f16a71fb0624 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -413,10 +413,13 @@ static DEFINE_SPINLOCK(vmap_area_lock);
 static DEFINE_SPINLOCK(free_vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
-static LLIST_HEAD(vmap_purge_list);
 static struct rb_root vmap_area_root = RB_ROOT;
 static bool vmap_initialized __read_mostly;
 
+static struct rb_root purge_vmap_area_root = RB_ROOT;
+static LIST_HEAD(purge_vmap_area_list);
+static DEFINE_SPINLOCK(purge_vmap_area_lock);
+
 /*
  * This kmem_cache is used for vmap_area objects. Instead of
  * allocating from slab we reuse an object from this cache to
@@ -820,10 +823,17 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	if (!merged)
 		link_va(va, root, parent, link, head);
 
-	/*
-	 * Last step is to check and update the tree.
-	 */
-	augment_tree_propagate_from(va);
+	return va;
+}
+
+static __always_inline struct vmap_area *
+merge_or_add_vmap_area_augment(struct vmap_area *va,
+	struct rb_root *root, struct list_head *head)
+{
+	va = merge_or_add_vmap_area(va, root, head);
+	if (va)
+		augment_tree_propagate_from(va);
+
 	return va;
 }
 
@@ -1138,7 +1148,7 @@ static void free_vmap_area(struct vmap_area *va)
 	 * Insert/Merge it back to the free tree/list.
 	 */
 	spin_lock(&free_vmap_area_lock);
-	merge_or_add_vmap_area(va, &free_vmap_area_root, &free_vmap_area_list);
+	merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
 	spin_unlock(&free_vmap_area_lock);
 }
 
@@ -1326,32 +1336,32 @@ void set_iounmap_nonlazy(void)
 static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 {
 	unsigned long resched_threshold;
-	struct llist_node *valist;
-	struct vmap_area *va;
-	struct vmap_area *n_va;
+	struct list_head local_pure_list;
+	struct vmap_area *va, *n_va;
 
 	lockdep_assert_held(&vmap_purge_lock);
 
-	valist = llist_del_all(&vmap_purge_list);
-	if (unlikely(valist == NULL))
+	spin_lock(&purge_vmap_area_lock);
+	purge_vmap_area_root = RB_ROOT;
+	list_replace_init(&purge_vmap_area_list, &local_pure_list);
+	spin_unlock(&purge_vmap_area_lock);
+
+	if (unlikely(list_empty(&local_pure_list)))
 		return false;
 
-	/*
-	 * TODO: to calculate a flush range without looping.
-	 * The list can be up to lazy_max_pages() elements.
-	 */
-	llist_for_each_entry(va, valist, purge_list) {
-		if (va->va_start < start)
-			start = va->va_start;
-		if (va->va_end > end)
-			end = va->va_end;
-	}
+	start = min(start,
+		list_first_entry(&local_pure_list,
+			struct vmap_area, list)->va_start);
+
+	end = max(end,
+		list_last_entry(&local_pure_list,
+			struct vmap_area, list)->va_end);
 
 	flush_tlb_kernel_range(start, end);
 	resched_threshold = lazy_max_pages() << 1;
 
 	spin_lock(&free_vmap_area_lock);
-	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
+	list_for_each_entry_safe(va, n_va, &local_pure_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
 		unsigned long orig_end = va->va_end;
@@ -1361,8 +1371,8 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 		 * detached and there is no need to "unlink" it from
 		 * anything.
 		 */
-		va = merge_or_add_vmap_area(va, &free_vmap_area_root,
-					    &free_vmap_area_list);
+		va = merge_or_add_vmap_area_augment(va, &free_vmap_area_root,
+				&free_vmap_area_list);
 
 		if (!va)
 			continue;
@@ -1419,9 +1429,15 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
 				PAGE_SHIFT, &vmap_lazy_nr);
 
-	/* After this point, we may free va at any time */
-	llist_add(&va->purge_list, &vmap_purge_list);
+	/*
+	 * Merge or place it to the purge tree/list.
+	 */
+	spin_lock(&purge_vmap_area_lock);
+	merge_or_add_vmap_area(va,
+		&purge_vmap_area_root, &purge_vmap_area_list);
+	spin_unlock(&purge_vmap_area_lock);
 
+	/* After this point, we may free va at any time */
 	if (unlikely(nr_lazy > lazy_max_pages()))
 		try_purge_vmap_area_lazy();
 }
@@ -3351,8 +3367,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	while (area--) {
 		orig_start = vas[area]->va_start;
 		orig_end = vas[area]->va_end;
-		va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
-					    &free_vmap_area_list);
+		va = merge_or_add_vmap_area_augment(vas[area], &free_vmap_area_root,
+				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
 				va->va_start, va->va_end);
@@ -3401,8 +3417,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	for (area = 0; area < nr_vms; area++) {
 		orig_start = vas[area]->va_start;
 		orig_end = vas[area]->va_end;
-		va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
-					    &free_vmap_area_list);
+		va = merge_or_add_vmap_area_augment(vas[area], &free_vmap_area_root,
+				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
 				va->va_start, va->va_end);
@@ -3482,18 +3498,15 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 
 static void show_purge_info(struct seq_file *m)
 {
-	struct llist_node *head;
 	struct vmap_area *va;
 
-	head = READ_ONCE(vmap_purge_list.first);
-	if (head == NULL)
-		return;
-
-	llist_for_each_entry(va, head, purge_list) {
+	spin_lock(&purge_vmap_area_lock);
+	list_for_each_entry(va, &purge_vmap_area_list, list) {
 		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
 			(void *)va->va_start, (void *)va->va_end,
 			va->va_end - va->va_start);
 	}
+	spin_unlock(&purge_vmap_area_lock);
 }
 
 static int s_show(struct seq_file *m, void *p)
@@ -3551,10 +3564,7 @@ static int s_show(struct seq_file *m, void *p)
 	seq_putc(m, '\n');
 
 	/*
-	 * As a final step, dump "unpurged" areas. Note,
-	 * that entire "/proc/vmallocinfo" output will not
-	 * be address sorted, because the purge list is not
-	 * sorted.
+	 * As a final step, dump "unpurged" areas.
 	 */
 	if (list_is_last(&va->list, &vmap_area_list))
 		show_purge_info(m);
-- 
2.20.1

