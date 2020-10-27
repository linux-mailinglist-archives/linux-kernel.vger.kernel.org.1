Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175829C543
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824902AbgJ0SGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:06:42 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:51807 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757229AbgJ0OQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:16:54 -0400
Received: by mail-wm1-f73.google.com with SMTP id l16so394155wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oPFfGVLWPpZQZIz4b/Fi+mHq5Y/nLTEYGP5aTsEDf08=;
        b=WvM8gQFbf7hExYYvuYCluc2rf2M0u0JpWaH/APaB+8WdUq1I2tc3TgYuI3a1tDa+Rp
         TaGigth8amdmgXcfgP2uGAGZZ5q1zOjVIlD8ESj0O/XIgCZxq7OMfQsvzOcpkHF4OsEz
         emuqykceAr14s5Wxv+yXWYRdtCnr9BXti/+NqVXeIhs/wLjJdNmoOwQJ+PKZMm+g9nod
         b7s158PVNJTGqKQqsVyJGi4c3OwD6zBlFL8OtAe4OdZjwhYTykhmZpZQ+spes3xOGNr8
         8ZNaWf7TvvP8mXinfX3hLZemqUZmkkFPyP62rjNqNIuXfD4axofSgMPZv+NrXozZKHrn
         uw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oPFfGVLWPpZQZIz4b/Fi+mHq5Y/nLTEYGP5aTsEDf08=;
        b=H2wEwEMqN7+bfvUI+f2/V+dTasslwdxLszV6xDqorIBj+HmTz3oDzFZAh33jIYh4pI
         ufo86J0f1R6N82rbNc/+xYEp8FnO0dfcQ0k3IPiQuhl6Hb/2hVTiXyiZRuOUVFTDlv7U
         VQDt0LlOe4R6IRPGSiKNsPKsGLDvhTq+hO3HY0D4UlOnY8FjyfvfwSvQGHu72JJiaX1c
         H0/S3m/8PrIpSiXqxk98W3hhtqhwMIZgbixcA8xQvX04Z1LM9PFyZgR48ClG47yNi/2K
         VZwch6znQXRIx6Pw0k7dO0XVHBrkrqQantHtKcwDdJ6/HKHSsuEmG+Yop/36RsT5C+5I
         YSLg==
X-Gm-Message-State: AOAM532BeNHfcx2TFICWMI4fPKB0TN97LIjsVTyeEU8O4JDxRQk2O3tz
        x4WaiTQe+ywM+m1DvMFwaTSRpvQvGg==
X-Google-Smtp-Source: ABdhPJxVJUigVZ2QBz6cGaNUTYI7Yim1OoP468XqmmZaiE6Wjk4wK9EbyW9ZfOGkrWM5A9vGZof7emGHUA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:c4cb:: with SMTP id g11mr2986340wmk.88.1603808211201;
 Tue, 27 Oct 2020 07:16:51 -0700 (PDT)
Date:   Tue, 27 Oct 2020 15:16:03 +0100
In-Reply-To: <20201027141606.426816-1-elver@google.com>
Message-Id: <20201027141606.426816-7-elver@google.com>
Mime-Version: 1.0
References: <20201027141606.426816-1-elver@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v5 6/9] kfence, kasan: make KFENCE compatible with KASAN
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

We make KFENCE compatible with KASAN for testing KFENCE itself. In
particular, KASAN helps to catch any potential corruptions to KFENCE
state, or other corruptions that may be a result of freepointer
corruptions in the main allocators.

To indicate that the combination of the two is generally discouraged,
CONFIG_EXPERT=y should be set. It also gives us the nice property that
KFENCE will be build-tested by allyesconfig builds.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v5:
* Also guard kasan_unpoison_shadow with is_kfence_address(), as it may
  be called from SL*B internals, currently ksize().
* Make kasan_record_aux_stack() compatible with KFENCE, which may be
  called from outside KASAN runtime.
---
 lib/Kconfig.kfence |  2 +-
 mm/kasan/common.c  | 15 +++++++++++++++
 mm/kasan/generic.c |  3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index d24baa3bce4a..639b48cc75d4 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -5,7 +5,7 @@ config HAVE_ARCH_KFENCE
 
 menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
-	depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
+	depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
 	depends on JUMP_LABEL # To ensure performance, require jump labels
 	select STACKTRACE
 	help
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..ac1d404fb41e 100644
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
@@ -141,6 +142,14 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 	 */
 	address = reset_tag(address);
 
+	/*
+	 * We may be called from SL*B internals, such as ksize(): with a size
+	 * not a multiple of machine-word size, avoid poisoning the invalid
+	 * portion of the word for KFENCE memory.
+	 */
+	if (is_kfence_address(address))
+		return;
+
 	kasan_poison_shadow(address, size, tag);
 
 	if (size & KASAN_SHADOW_MASK) {
@@ -396,6 +405,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	tagged_object = object;
 	object = reset_tag(object);
 
+	if (is_kfence_address(object))
+		return false;
+
 	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
 	    object)) {
 		kasan_report_invalid_free(tagged_object, ip);
@@ -444,6 +456,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
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
2.29.0.rc2.309.g374f81d7ae-goog

