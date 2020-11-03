Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4B2A4DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgKCR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgKCR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:59:12 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75265C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:59:12 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 8so48989wmg.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=70mBaMGWcMxAe6qN8e5SHtOekmUUKIQfft9QsNU8who=;
        b=hXt8NWmxp2NWSi+n/aj+jqz8EKGqGxXtwdnrlhF70R3IOybRQPLgc2Q88TavGE7bSP
         2kTEH4CXYdklAuqgZE7heBtWiHOBjIpCr0E9tb0cH1K7m2fnGHGDYJ9hQO/mfU7BcDKP
         Nchg+70BSnqWuYq2Id5slxNELHOd3mceXPaMMxvC0X+0HkbQUf6X/3tWQgbTluXZXFGu
         bEvNAw12s5lQIwFlLWx6R22UbHACSeo3HpcA1jT7Z5LVmJy5hvkfaP2xs4Rs9J3IA8fQ
         BmaAs1ajt45VESw8vTFNn+ayE6qmnXKnF+M3pYXPQU9546qTas8TYMSvbLwzzjjgZ7WO
         9evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=70mBaMGWcMxAe6qN8e5SHtOekmUUKIQfft9QsNU8who=;
        b=ovT/59gLpIA/8aR93CAXaXmzrFAFmye/DFPxt4cNp+l8179wrOCTCKVcC/oDe2gHkb
         s3KCZFondKnZnWjP6804rTotGQMBB+bh/cDQP/xJKSpN9cL1xW5zrIU1mNZLS3vFNFD1
         jmxLZCU1/rHAY/CjIDkg5Sl9w9cs+iFJZSXrA2gD93HgRCgHKSokagWuA8grqlNlkOk0
         Gy2VgMLZ/xseDzPLt5fiaUxtV9MV64ZMGxM2awKQ2h4tPU2umdlDfXBoEMtDfJaGjRFm
         7lZMDHwQSu6BFWGGYMzXfM173KbSjIZNqpJRbRlyoB33SG4rYSKdxDMJmf0zFQEx9/70
         FSPQ==
X-Gm-Message-State: AOAM531taB63LQTlok3iS+s+VZuV0AArN2+gczUZbQxz3bwIw2wyHj4Z
        Hs5EJwrzpAx0SWvz/9hVLDDPcwtNQQ==
X-Google-Smtp-Source: ABdhPJxQOxO/mWm5IeK+xVRBFdwnPlgTk4OY0A47lDbMK06j9Kw8UFYg64htAhW+J3v4r+ct64yB0hNE2A==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:b157:: with SMTP id a84mr381970wmf.34.1604426351021;
 Tue, 03 Nov 2020 09:59:11 -0800 (PST)
Date:   Tue,  3 Nov 2020 18:58:38 +0100
In-Reply-To: <20201103175841.3495947-1-elver@google.com>
Message-Id: <20201103175841.3495947-7-elver@google.com>
Mime-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 6/9] kfence, kasan: make KFENCE compatible with KASAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Make KFENCE compatible with KASAN. Currently this helps test KFENCE
itself, where KASAN can catch potential corruptions to KFENCE state, or
other corruptions that may be a result of freepointer corruptions in the
main allocators.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v7:
* Remove EXPERT restriction for enabling KASAN+KFENCE. In future, MTE-based KASAN
  without stack traces will benefit from having KFENCE (which has stack
  traces). Removing EXPERT restriction allows this for production
  builds. The Kconfig help-text should still make it clear that in most
  cases KFENCE+KASAN does not make sense.
* Also skip kasan_poison_shadow() if KFENCE object. It turns out that
  kernel/scs.c is a user of kasan_{poison,unpoison}_object_data().
* Add Jann's Reviewed-by.

v5:
* Also guard kasan_unpoison_shadow with is_kfence_address(), as it may
  be called from SL*B internals, currently ksize().
* Make kasan_record_aux_stack() compatible with KFENCE, which may be
  called from outside KASAN runtime.
---
 lib/Kconfig.kfence |  2 +-
 mm/kasan/common.c  | 19 +++++++++++++++++++
 mm/kasan/generic.c |  3 ++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index b209cd02042b..d2e3c6724226 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -5,7 +5,7 @@ config HAVE_ARCH_KFENCE
 
 menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
-	depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
+	depends on HAVE_ARCH_KFENCE && (SLAB || SLUB)
 	depends on JUMP_LABEL # To ensure performance, require jump labels
 	select STACKTRACE
 	help
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..de92da1b637a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/linkage.h>
 #include <linux/memblock.h>
@@ -124,6 +125,10 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 	 */
 	address = reset_tag(address);
 
+	/* Skip KFENCE memory if called explicitly outside of sl*b. */
+	if (is_kfence_address(address))
+		return;
+
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
 
@@ -141,6 +146,14 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 	 */
 	address = reset_tag(address);
 
+	/*
+	 * Skip KFENCE memory if called explicitly outside of sl*b. Also note
+	 * that calls to ksize(), where size is not a multiple of machine-word
+	 * size, would otherwise poison the invalid portion of the word.
+	 */
+	if (is_kfence_address(address))
+		return;
+
 	kasan_poison_shadow(address, size, tag);
 
 	if (size & KASAN_SHADOW_MASK) {
@@ -396,6 +409,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	tagged_object = object;
 	object = reset_tag(object);
 
+	if (is_kfence_address(object))
+		return false;
+
 	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
 	    object)) {
 		kasan_report_invalid_free(tagged_object, ip);
@@ -444,6 +460,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	if (unlikely(object == NULL))
 		return NULL;
 
+	if (is_kfence_address(object))
+		return (void *)object;
+
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_SHADOW_SCALE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 248264b9cb76..1069ecd1cd55 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/linkage.h>
 #include <linux/memblock.h>
@@ -332,7 +333,7 @@ void kasan_record_aux_stack(void *addr)
 	struct kasan_alloc_meta *alloc_info;
 	void *object;
 
-	if (!(page && PageSlab(page)))
+	if (is_kfence_address(addr) || !(page && PageSlab(page)))
 		return;
 
 	cache = page->slab_cache;
-- 
2.29.1.341.ge80a0c044ae-goog

