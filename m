Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79ED280B33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgJAXMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387642AbgJAXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:12:14 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD48C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:12:14 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id v5so135138wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1uiZUrDOH4l2Wn9/hfxprEz0p4Pem0sURNuAWOypjqo=;
        b=TAltGYGwIMueo85+ofT2jWpElXax2Q2iwtw+Z9Ak5PX1mEaCduRO+2KmjXIkC5C8a0
         OyPnMiBtDM0BnJNsHgnLPDJCCuHz2C0BHRUCVJ4jd9Hz+6vAn6OqGIAepMUQOcFIl/X4
         75Leew7VUuHMVPwTiS1eCHrY+Pfho/rK1saOxm3sBF3TmGL9UMlMYH0fjZ05NTv4aQ+Y
         bgF+P6fP84dkQIyKTHK3DCgmUTyfF9aq/DtFwhCbo3e1v2xtBIocR0qqgjmcjwb6ei3c
         qNtdtOnDsTGwvps3Opw6/5moIdG9AOPHFjC6vmYW8kLX74vgIjW3WLmmutYwmfG6ygrp
         wCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1uiZUrDOH4l2Wn9/hfxprEz0p4Pem0sURNuAWOypjqo=;
        b=rm8SU8eLj11uJkT9jp8YEKGUh5uqUY0K+9CuqXF7vdqVoIX0DTYVPgvZFHpu7IBtBh
         KzkqMB3CZOYnxLjb+htnDqob5y5mc6Zo+jvtXY5OKhbadXzvQ9W5fyl9/9hAbBP/NpsP
         3c2mDZy1KHt9YYmPXqwNCZgFlKRzz1mueVJapXK5NEj24wu6EutioNoUCo1R9NBM7Gzd
         gtoH6nCw4K2QbmLUKL3P2k3MQboXPz7HZxEZNMI7A+kCN7iGCoa+LiQUBR5hYswVbBEy
         kBAJ0NGakW6stiphafyVfnZy6jFu69XD37pUaH/8KBwBPFn1u42eRPgyoXJmDoq2tWNP
         QYSQ==
X-Gm-Message-State: AOAM532uQmTRd/klKKfJp8cDtO4dhIwf6kCr9UMVePKEUI6Au0xD6D6y
        2ONMwRI0F4Cn6yuvzmWyNtORwlv+O1iejoqz
X-Google-Smtp-Source: ABdhPJxM0YWDhurJs1WpBKLMoaxPoJ/qqd11MbVTf9JdahHt7NiSAMtDQztj8x8XtcyYgZ7wjDj+Qmy/cGouumYD
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:204e:: with SMTP id
 p14mr2206470wmg.182.1601593932715; Thu, 01 Oct 2020 16:12:12 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:38 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <9243986ea34154dd41240ae0e0797a87c42c3106.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 37/39] kasan, mm: reset tags when accessing metadata
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
---
Change-Id: I39f3c4d4f29299d4fbbda039bedf230db1c746fb
---
 mm/page_alloc.c  |  4 +++-
 mm/page_poison.c |  2 +-
 mm/slub.c        | 29 ++++++++++++++++-------------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..e2195602fb38 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1159,8 +1159,10 @@ static void kernel_init_free_pages(struct page *page, int numpages)
 
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
index 34b9181ee5d1..d90d342a391f 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -43,7 +43,7 @@ static void poison_page(struct page *page)
 
 	/* KASAN still think the page is in-use, so skip it. */
 	kasan_disable_current();
-	memset(addr, PAGE_POISON, PAGE_SIZE);
+	memset(kasan_reset_tag(addr), PAGE_POISON, PAGE_SIZE);
 	kasan_enable_current();
 	kunmap_atomic(addr);
 }
diff --git a/mm/slub.c b/mm/slub.c
index 68c02b2eecd9..1d3f2355df3b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -249,7 +249,7 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
 {
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	/*
-	 * When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
+	 * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tagged.
 	 * Normally, this doesn't cause any issues, as both set_freepointer()
 	 * and get_freepointer() are called with a pointer with the same tag.
 	 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
@@ -275,6 +275,7 @@ static inline void *freelist_dereference(const struct kmem_cache *s,
 
 static inline void *get_freepointer(struct kmem_cache *s, void *object)
 {
+	object = kasan_reset_tag(object);
 	return freelist_dereference(s, object + s->offset);
 }
 
@@ -304,6 +305,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 	BUG_ON(object == fp); /* naive detection of double free or corruption */
 #endif
 
+	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
 	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
 }
 
@@ -538,8 +540,8 @@ static void print_section(char *level, char *text, u8 *addr,
 			  unsigned int length)
 {
 	metadata_access_enable();
-	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS, 16, 1, addr,
-			length, 1);
+	print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
+			16, 1, addr, length, 1);
 	metadata_access_disable();
 }
 
@@ -570,7 +572,7 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 
 	p = object + get_info_end(s);
 
-	return p + alloc;
+	return kasan_reset_tag(p + alloc);
 }
 
 static void set_track(struct kmem_cache *s, void *object,
@@ -583,7 +585,8 @@ static void set_track(struct kmem_cache *s, void *object,
 		unsigned int nr_entries;
 
 		metadata_access_enable();
-		nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
+		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
+					      TRACK_ADDRS_COUNT, 3);
 		metadata_access_disable();
 
 		if (nr_entries < TRACK_ADDRS_COUNT)
@@ -747,7 +750,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
 {
-	u8 *p = object;
+	u8 *p = kasan_reset_tag(object);
 
 	if (s->flags & SLAB_RED_ZONE)
 		memset(p - s->red_left_pad, val, s->red_left_pad);
@@ -777,7 +780,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 	u8 *addr = page_address(page);
 
 	metadata_access_enable();
-	fault = memchr_inv(start, value, bytes);
+	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
 	metadata_access_disable();
 	if (!fault)
 		return 1;
@@ -873,7 +876,7 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 
 	pad = end - remainder;
 	metadata_access_enable();
-	fault = memchr_inv(pad, POISON_INUSE, remainder);
+	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
 	metadata_access_disable();
 	if (!fault)
 		return 1;
@@ -1118,7 +1121,7 @@ void setup_page_debug(struct kmem_cache *s, struct page *page, void *addr)
 		return;
 
 	metadata_access_enable();
-	memset(addr, POISON_INUSE, page_size(page));
+	memset(kasan_reset_tag(addr), POISON_INUSE, page_size(page));
 	metadata_access_disable();
 }
 
@@ -1570,10 +1573,10 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
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
@@ -2884,10 +2887,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 		stat(s, ALLOC_FASTPATH);
 	}
 
-	maybe_wipe_obj_freeptr(s, object);
+	maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
 
 	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
-		memset(object, 0, s->object_size);
+		memset(kasan_reset_tag(object), 0, s->object_size);
 
 	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
 
-- 
2.28.0.709.gb0816b6eb0-goog

