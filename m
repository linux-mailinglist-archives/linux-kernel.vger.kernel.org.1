Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23926AFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIOVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgIOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:16 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F2C061352
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:49 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id y3so1697690wrl.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OJ/8AnntxXTECtkQTOaxjfZECPzBTRORy6i2yS83kOo=;
        b=fsTRc89Y8Zxhcw1t5FHcT2l04+Vs91ABV7dJ+vBPhhaHv+cdI42HIqPxytva99Oc/f
         tEF8Ajhet3GGkGV0lxMNdANtx58YTLh2raBV++EuvcTDG4lfRtVuBPZ3dhERXQrVolz5
         qR6ht87ldpJ+K6V9qf/aTiaHgi3Rtj8MoV5qm6W2Yu0VKdVnI/+pNvbLjwyDqlInDyuy
         ixzwUN/j7DQ1s685G6q7r/X917lEDMjNnDlwT5fg2nngAWAgJG608O+mBfOBdT4/IE+Y
         +oA5tacqx8skGTtNElJzGeTixoBhDz1eN9lgftdMtVlInLtvMnDII+IeqTWP3nfZ3K5e
         Mfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OJ/8AnntxXTECtkQTOaxjfZECPzBTRORy6i2yS83kOo=;
        b=V5H5rLk6S6ku1NVNcwB60UE8JJWt6YyI83n4NoCbolmqLRyp+uGbvsjIIsAqfLzdKB
         fhLExopEsWMOpIa3V+StRrw1DNgfWFbCM1/vt079ctw9GAVVKbvHLxfhLtyxSsTf00SP
         SusiXpoVWYTwMVZLPEwQU4I1Smmg+1zaJrWIsOckBhsk5LXcz5d5z0px0En4LCfQVY50
         bTzq6lkxeto4QJQMdEDaLhlHbVfAEey3hLJ+p8LUN3nX4UvYweZN+hw5pjaTxjnwCo19
         aGPoy4Dv8ga9SReoMkagmCqtDxkaKj815gp32tAkZCDc2cLtxMnI1AqN6MbkzqjDPsok
         SMmQ==
X-Gm-Message-State: AOAM531n7degasdgp4UgPdSYAwWqtH5MqGrvmGKXIFZAX4MAHdNRmRoY
        NRszOXFwJMFXlCwgnpqY/jqO0kPLrz9//nUG
X-Google-Smtp-Source: ABdhPJyB2fgN/4avIQbsrVPagRenog1bi9DkyzuhYeFDKwQHiHl1iiiqiRJ8H6iw/7DwoI0ckDpr8Mm/2qsFUGd0
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2283:: with SMTP id
 3mr1188256wmf.37.1600204668051; Tue, 15 Sep 2020 14:17:48 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:17 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <f511f01a413c18c71ba9124ee3c341226919a5e8.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 35/37] kasan, slub: reset tags when accessing metadata
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB allocator accesses metadata for slab objects, that may lie
out-of-bounds of the object itself, or be accessed when an object is freed.
Such accesses trigger tag faults and lead to false-positive reports with
hardware tag-based KASAN.

Software KASAN modes disable instrumentation for allocator code via
KASAN_SANITIZE Makefile macro, and rely on kasan_enable/disable_current()
annotations which are used to ignore KASAN reports.

With hardware tag-based KASAN neither of those options are available, as
it doesn't use compiler instrumetation, no tag faults are ignored, and MTE
is disabled after the first one.

Instead, reset tags when accessing metadata.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I39f3c4d4f29299d4fbbda039bedf230db1c746fb
---
 mm/page_poison.c |  2 +-
 mm/slub.c        | 25 ++++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

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
index 68c02b2eecd9..8e134ca3a6fb 100644
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
+						TRACK_ADDRS_COUNT, 3);
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
2.28.0.618.gf4bc123cb7-goog

