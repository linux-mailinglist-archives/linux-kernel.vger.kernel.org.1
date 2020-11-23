Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C32C15FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgKWUKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbgKWUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:10:01 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3133C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:10:00 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id a130so315720wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xPncFRf4Ib9dqqrvVPPr1Kkbz3E0xEx6JscY8zPs/c0=;
        b=QNShjMEwTO4Bc5z5VfDLQwOFYsT0YDsRb0c2waKUZV+JAMjfUxZknFjx6oSY7b6GtL
         maPqHrgh+KOjiObR36P4O+M33xOdQ0JczgudLW7SoVBdTiRpINSyc+eC9NGhR4lgNxGU
         ONqxhOfBzveb3fWb5SblHJgtG+weLXc0/i34Ntw9a0PpNvCaQ2v5AwhwdS1dabbsG356
         t3hFOsZEohmFyNGy5vvSFvrIcQFE3xa2sfOPvB5trhjMoxC554C9UPm24zFtvlSGwX5n
         GjuXW1H8gO5e9QCSrpGN/bbT96auepJCebUd8U85TosX1cm/IR+iYcGdHK2EO9jsv2fr
         VY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xPncFRf4Ib9dqqrvVPPr1Kkbz3E0xEx6JscY8zPs/c0=;
        b=qNZM2/o/9YZRtyA9Z0Xggq/6Sz+b2b+rlNBJlm1+s+qt59Mgj+vz+pvHedp2MWGR6a
         ZlGydtHVUqsuJRY4bdiUarYS0yKxZEsMtcaKP/bHZ7MlGFcAICBPK8PxBmtwIE01CVbJ
         kAqEVwynQ7iFxV4mcSXTbaFfvv7mqefp78j6pIghe3aYZ91ah28clGNB0cSqBqdWd8GL
         toM4tRh3LHnVEfLyFGV7EgGu64wECavifTlwImbMEYfW5YlQxCnvb7myknyIMiI/5H5D
         wskE691ExOyhd6wXkrxgOfL38S6p4NRv7L40qY41Hs9M6U+8TxZXNLyU4YEsxefPuD9b
         vcLg==
X-Gm-Message-State: AOAM531CLQ9/nG0c+NSYqo2LNYVjpK6LnEubEUAoUfcklPysti+reE+/
        cJ+fIs0PL/UdoWpRiUFxI1pGZwVLhsYwdTBl
X-Google-Smtp-Source: ABdhPJx8SYjpCFSQdMtx3jmOSuDFXYe2QL9/BX1SKH97JFpL/WJ1DX/+KeW8DktlelaOD7WJh3/kIz+n3o4VvEkf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:fec5:: with SMTP id
 q5mr1402044wrs.245.1606162199707; Mon, 23 Nov 2020 12:09:59 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:08:03 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <a0f3cefbc49f34c843b664110842de4db28179d0.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 39/42] kasan, mm: reset tags when accessing metadata
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

Kernel allocator code accesses metadata for slab objects, that may lie
out-of-bounds of the object itself, or be accessed when an object is freed.
Such accesses trigger tag faults and lead to false-positive reports with
hardware tag-based KASAN.

Software KASAN modes disable instrumentation for allocator code via
KASAN_SANITIZE Makefile macro, and rely on kasan_enable/disable_current()
annotations which are used to ignore KASAN reports.

With hardware tag-based KASAN neither of those options are available, as
it doesn't use compiler instrumetation, no tag faults are ignored, and MTE
is disabled after the first one.

Instead, reset tags when accessing metadata (currently only for SLUB).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I39f3c4d4f29299d4fbbda039bedf230db1c746fb
---
 mm/page_alloc.c  |  4 +++-
 mm/page_poison.c |  2 +-
 mm/slub.c        | 29 ++++++++++++++++-------------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 236aa4b6b2cc..f684aeef03cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1202,8 +1202,10 @@ static void kernel_init_free_pages(struct page *page, int numpages)
 
 	/* s390's use of memset() could override KASAN redzones. */
 	kasan_disable_current();
-	for (i = 0; i < numpages; i++)
+	for (i = 0; i < numpages; i++) {
+		page_kasan_tag_reset(page + i);
 		clear_highpage(page + i);
+	}
 	kasan_enable_current();
 }
 
diff --git a/mm/page_poison.c b/mm/page_poison.c
index 06ec518b2089..65cdf844c8ad 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -25,7 +25,7 @@ static void poison_page(struct page *page)
 
 	/* KASAN still think the page is in-use, so skip it. */
 	kasan_disable_current();
-	memset(addr, PAGE_POISON, PAGE_SIZE);
+	memset(kasan_reset_tag(addr), PAGE_POISON, PAGE_SIZE);
 	kasan_enable_current();
 	kunmap_atomic(addr);
 }
diff --git a/mm/slub.c b/mm/slub.c
index e50ddb6e842f..f23bc1feb3d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -250,7 +250,7 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
 {
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	/*
-	 * When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
+	 * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tagged.
 	 * Normally, this doesn't cause any issues, as both set_freepointer()
 	 * and get_freepointer() are called with a pointer with the same tag.
 	 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
@@ -276,6 +276,7 @@ static inline void *freelist_dereference(const struct kmem_cache *s,
 
 static inline void *get_freepointer(struct kmem_cache *s, void *object)
 {
+	object = kasan_reset_tag(object);
 	return freelist_dereference(s, object + s->offset);
 }
 
@@ -305,6 +306,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 	BUG_ON(object == fp); /* naive detection of double free or corruption */
 #endif
 
+	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
 	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
 }
 
@@ -539,8 +541,8 @@ static void print_section(char *level, char *text, u8 *addr,
 			  unsigned int length)
 {
 	metadata_access_enable();
-	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS, 16, 1, addr,
-			length, 1);
+	print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
+			16, 1, addr, length, 1);
 	metadata_access_disable();
 }
 
@@ -571,7 +573,7 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 
 	p = object + get_info_end(s);
 
-	return p + alloc;
+	return kasan_reset_tag(p + alloc);
 }
 
 static void set_track(struct kmem_cache *s, void *object,
@@ -584,7 +586,8 @@ static void set_track(struct kmem_cache *s, void *object,
 		unsigned int nr_entries;
 
 		metadata_access_enable();
-		nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
+		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
+					      TRACK_ADDRS_COUNT, 3);
 		metadata_access_disable();
 
 		if (nr_entries < TRACK_ADDRS_COUNT)
@@ -748,7 +751,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
 {
-	u8 *p = object;
+	u8 *p = kasan_reset_tag(object);
 
 	if (s->flags & SLAB_RED_ZONE)
 		memset(p - s->red_left_pad, val, s->red_left_pad);
@@ -778,7 +781,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 	u8 *addr = page_address(page);
 
 	metadata_access_enable();
-	fault = memchr_inv(start, value, bytes);
+	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
 	metadata_access_disable();
 	if (!fault)
 		return 1;
@@ -874,7 +877,7 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 
 	pad = end - remainder;
 	metadata_access_enable();
-	fault = memchr_inv(pad, POISON_INUSE, remainder);
+	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
 	metadata_access_disable();
 	if (!fault)
 		return 1;
@@ -1119,7 +1122,7 @@ void setup_page_debug(struct kmem_cache *s, struct page *page, void *addr)
 		return;
 
 	metadata_access_enable();
-	memset(addr, POISON_INUSE, page_size(page));
+	memset(kasan_reset_tag(addr), POISON_INUSE, page_size(page));
 	metadata_access_disable();
 }
 
@@ -1572,10 +1575,10 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 			 * Clear the object and the metadata, but don't touch
 			 * the redzone.
 			 */
-			memset(object, 0, s->object_size);
+			memset(kasan_reset_tag(object), 0, s->object_size);
 			rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad
 							   : 0;
-			memset((char *)object + s->inuse, 0,
+			memset((char *)kasan_reset_tag(object) + s->inuse, 0,
 			       s->size - s->inuse - rsize);
 
 		}
@@ -2891,10 +2894,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 		stat(s, ALLOC_FASTPATH);
 	}
 
-	maybe_wipe_obj_freeptr(s, object);
+	maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
 
 	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
-		memset(object, 0, s->object_size);
+		memset(kasan_reset_tag(object), 0, s->object_size);
 
 out:
 	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
-- 
2.29.2.454.gaff20da3a2-goog

