Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68182C1657
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbgKWUP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbgKWUO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:14:59 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E993C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:14:59 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id v134so15526897qka.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Q1jnDs8w1xeJeKoumjoM2fj7KFzVMx2xpTSCdfWMzaI=;
        b=fk9aLtChmZLGIQyf1PGVZC+ap8+7GNwfffNMv2tS8vb/gOtKMdeGo5YqeOWsEpyOSm
         Neb++K0kvvdN0iT1Py3tI94wV+P3UByw2Pkdq+j5rHnQagsY5EDC9sQ+wypnvD57TCiO
         V7usRRTD4uEJnPui7yUKbb7BSpb/EwiZhBdN9RAxmF4I0UqcqcEOhq9RXW3YV93gBqzX
         VYjTAEoBIlhzRs2KS1nXiHA4WZzs7Mpwqz4cds/ERGbcQKZK7COwjCA/0zy4SN+njdRk
         vlNs+svG+PoA2nvCvfKr5h18bdeWjwVwm2GcargM2+/rW6mpvSzzwUT9e3OTWx3ksAAW
         RnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q1jnDs8w1xeJeKoumjoM2fj7KFzVMx2xpTSCdfWMzaI=;
        b=JkYjk2gyhCeGVJf9iWrdFVHc71eir7ZZgKsSC4qH2WtdCPLKolmvREkkNzBiKNze8J
         jdpTEGHuNARma+EBwjhD9Y1JMYlC2Bzgd5eLo2JonzWHQbVsYlPR5dBXqDUl5X9wPj2K
         LqrNUwGR2jALQA+QiE3r1hJ4wGDUxdgFmLDvvMIvASvff9QfdPYUWTIRjtdzaXUQtLsm
         PMAYCNLXytG3D/ANc4cV3UDo+S87SQW7xh26KAvE9wrBu1d96DKEYCL9gMAIO1vn4Tuq
         sdftcBr7NLgfGFcLpwRXbvDwpk5XC0QKhdFJa+G17tsfe4adMlVtc0V21Y+pIaX2esBl
         bxHA==
X-Gm-Message-State: AOAM533lLQZnUMmrarqA3x3Mm5ogX9rKhbJ8hsL8Yzl6CsQRVeKxQIeI
        7zX/AxL5kyla+eAtFhCuZCHgUYtms2OX/Fp8
X-Google-Smtp-Source: ABdhPJxjiFxKuAWSU1YsZDwHLjMfXbzEG5ZQcQMsjj1BidAS/Q15I+apkubUzqdOI3UP5PWbwtrwjfV5MgEM+dRc
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f981:: with SMTP id
 t1mr1155145qvn.60.1606162498261; Mon, 23 Nov 2020 12:14:58 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:32 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <27b7c036b754af15a2839e945f6d8bfce32b4c2f.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 02/19] kasan: rename get_alloc/free_info
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename get_alloc_info() and get_free_info() to kasan_get_alloc_meta()
and kasan_get_free_meta() to better reflect what those do and avoid
confusion with kasan_set_free_info().

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Ib6e4ba61c8b12112b403d3479a9799ac8fff8de1
---
 mm/kasan/common.c         | 16 ++++++++--------
 mm/kasan/generic.c        | 12 ++++++------
 mm/kasan/hw_tags.c        |  4 ++--
 mm/kasan/kasan.h          |  8 ++++----
 mm/kasan/quarantine.c     |  4 ++--
 mm/kasan/report.c         | 12 ++++++------
 mm/kasan/report_sw_tags.c |  2 +-
 mm/kasan/sw_tags.c        |  4 ++--
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e11fac2ee30c..8197399b0a1f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -181,14 +181,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
 		sizeof(struct kasan_free_meta) : 0);
 }
 
-struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
-					const void *object)
+struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
+					      const void *object)
 {
 	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
 }
 
-struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
-				      const void *object)
+struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
+					    const void *object)
 {
 	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
 	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
@@ -265,13 +265,13 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
 void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 						const void *object)
 {
-	struct kasan_alloc_meta *alloc_info;
+	struct kasan_alloc_meta *alloc_meta;
 
 	if (!(cache->flags & SLAB_KASAN))
 		return (void *)object;
 
-	alloc_info = get_alloc_info(cache, object);
-	__memset(alloc_info, 0, sizeof(*alloc_info));
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	__memset(alloc_meta, 0, sizeof(*alloc_meta));
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		object = set_tag(object, assign_tag(cache, object, true, false));
@@ -357,7 +357,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 		     KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
-		kasan_set_track(&get_alloc_info(cache, object)->alloc_track, flags);
+		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
 
 	return set_tag(object, tag);
 }
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index da3608187c25..9c6b77f8c4a4 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -329,7 +329,7 @@ void kasan_record_aux_stack(void *addr)
 {
 	struct page *page = kasan_addr_to_page(addr);
 	struct kmem_cache *cache;
-	struct kasan_alloc_meta *alloc_info;
+	struct kasan_alloc_meta *alloc_meta;
 	void *object;
 
 	if (is_kfence_address(addr) || !(page && PageSlab(page)))
@@ -337,13 +337,13 @@ void kasan_record_aux_stack(void *addr)
 
 	cache = page->slab_cache;
 	object = nearest_obj(cache, page, addr);
-	alloc_info = get_alloc_info(cache, object);
+	alloc_meta = kasan_get_alloc_meta(cache, object);
 
 	/*
 	 * record the last two call_rcu() call stacks.
 	 */
-	alloc_info->aux_stack[1] = alloc_info->aux_stack[0];
-	alloc_info->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
+	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
+	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
 }
 
 void kasan_set_free_info(struct kmem_cache *cache,
@@ -351,7 +351,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
 {
 	struct kasan_free_meta *free_meta;
 
-	free_meta = get_free_info(cache, object);
+	free_meta = kasan_get_free_meta(cache, object);
 	kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
 
 	/*
@@ -365,5 +365,5 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 {
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_KMALLOC_FREETRACK)
 		return NULL;
-	return &get_free_info(cache, object)->free_track;
+	return &kasan_get_free_meta(cache, object)->free_track;
 }
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 3f9232464ed4..68e77363e58b 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -75,7 +75,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
 {
 	struct kasan_alloc_meta *alloc_meta;
 
-	alloc_meta = get_alloc_info(cache, object);
+	alloc_meta = kasan_get_alloc_meta(cache, object);
 	kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
 }
 
@@ -84,6 +84,6 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 {
 	struct kasan_alloc_meta *alloc_meta;
 
-	alloc_meta = get_alloc_info(cache, object);
+	alloc_meta = kasan_get_alloc_meta(cache, object);
 	return &alloc_meta->free_track[0];
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 13c511e85d5f..0eab7e4cecb8 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -149,10 +149,10 @@ struct kasan_free_meta {
 #endif
 };
 
-struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
-					const void *object);
-struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
-					const void *object);
+struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
+						const void *object);
+struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
+						const void *object);
 
 void poison_range(const void *address, size_t size, u8 value);
 void unpoison_range(const void *address, size_t size);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index a0792f0d6d0f..0da3d37e1589 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -166,7 +166,7 @@ void quarantine_put(struct kmem_cache *cache, void *object)
 	unsigned long flags;
 	struct qlist_head *q;
 	struct qlist_head temp = QLIST_INIT;
-	struct kasan_free_meta *info = get_free_info(cache, object);
+	struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
 
 	/*
 	 * Note: irq must be disabled until after we move the batch to the
@@ -179,7 +179,7 @@ void quarantine_put(struct kmem_cache *cache, void *object)
 	local_irq_save(flags);
 
 	q = this_cpu_ptr(&cpu_quarantine);
-	qlist_put(q, &info->quarantine_link, cache->size);
+	qlist_put(q, &meta->quarantine_link, cache->size);
 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
 		qlist_move_all(q, &temp);
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index a69c2827a125..df16bef0d810 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -164,12 +164,12 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 static void describe_object(struct kmem_cache *cache, void *object,
 				const void *addr, u8 tag)
 {
-	struct kasan_alloc_meta *alloc_info = get_alloc_info(cache, object);
+	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
 
 	if (cache->flags & SLAB_KASAN) {
 		struct kasan_track *free_track;
 
-		print_track(&alloc_info->alloc_track, "Allocated");
+		print_track(&alloc_meta->alloc_track, "Allocated");
 		pr_err("\n");
 		free_track = kasan_get_free_track(cache, object, tag);
 		if (free_track) {
@@ -178,14 +178,14 @@ static void describe_object(struct kmem_cache *cache, void *object,
 		}
 
 #ifdef CONFIG_KASAN_GENERIC
-		if (alloc_info->aux_stack[0]) {
+		if (alloc_meta->aux_stack[0]) {
 			pr_err("Last call_rcu():\n");
-			print_stack(alloc_info->aux_stack[0]);
+			print_stack(alloc_meta->aux_stack[0]);
 			pr_err("\n");
 		}
-		if (alloc_info->aux_stack[1]) {
+		if (alloc_meta->aux_stack[1]) {
 			pr_err("Second to last call_rcu():\n");
-			print_stack(alloc_info->aux_stack[1]);
+			print_stack(alloc_meta->aux_stack[1]);
 			pr_err("\n");
 		}
 #endif
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index aebc44a29e83..317100fd95b9 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -46,7 +46,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	if (page && PageSlab(page)) {
 		cache = page->slab_cache;
 		object = nearest_obj(cache, page, (void *)addr);
-		alloc_meta = get_alloc_info(cache, object);
+		alloc_meta = kasan_get_alloc_meta(cache, object);
 
 		for (i = 0; i < KASAN_NR_FREE_STACKS; i++)
 			if (alloc_meta->free_pointer_tag[i] == tag)
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index a518483f3965..6d7648cc3b98 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -174,7 +174,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
 	struct kasan_alloc_meta *alloc_meta;
 	u8 idx = 0;
 
-	alloc_meta = get_alloc_info(cache, object);
+	alloc_meta = kasan_get_alloc_meta(cache, object);
 
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	idx = alloc_meta->free_track_idx;
@@ -191,7 +191,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 	struct kasan_alloc_meta *alloc_meta;
 	int i = 0;
 
-	alloc_meta = get_alloc_info(cache, object);
+	alloc_meta = kasan_get_alloc_meta(cache, object);
 
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
-- 
2.29.2.454.gaff20da3a2-goog

