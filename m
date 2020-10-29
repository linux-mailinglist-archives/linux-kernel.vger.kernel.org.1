Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6CE29ECAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgJ2NRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgJ2NRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:17:15 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B2C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:17:15 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id l12so474793wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MDxWQURSl79g8vKPdG5uHAVWcBR/CQ6D0GDay6Dns1U=;
        b=kQJZtCyAjs6lBIZl6M96SWe1LnR8kpabQD8Fy+8pAgMgKbEuOFIyCrpy6wfOXCw2/p
         9ZagryngHTQS2HvLFfpcG9gPJ+G1tXFcG2pbAW5wd2iBRpwHNRPdvcatZG3UhMoqpAF2
         ZZiC7KFjIpRZOvWEtiYrwNGwupA73SczxDjpZwhnuaWaN0Ke5NtQM3//jXL9XWjOHmXZ
         MkGZ73JdSkLq+TxhjDetAIxGstREfAbKu7WPvQ231Lv+4LGRoRm3tLfpwZwDIbAnoFkx
         E5kILUZJ60tJnonGxepa3ElL6illiCAPgpl6vE1zbwnzRtEcmGmWRQ+IKAcFRDnvdGuY
         Nj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MDxWQURSl79g8vKPdG5uHAVWcBR/CQ6D0GDay6Dns1U=;
        b=aL39Jlf6pUhZQYysjqiH+0hiJmvfiPlsIDtwHpgdcEGaE+EAe3bRhTMeMeJHV2vhbb
         Jmw5Dg7680p/YGtXG9rXiZerj9TUM4FVM9NLX4R5T8QQmpgC5f2e5ykqqgUyPZmmgfGX
         enUrIJWCoEND4SA24/YwTEBNReA1KEiExJfxScqgvzrAlR01WBUqHSphNdSLOzLpB/Za
         so225HyePwvhQgBS3yhABp2v3u2WqiGXHPNpV1ktCUTtxPyyfx7vRGsB5p+KvFJ3PQ8k
         Fehg94Yox2wgeSt1/7e8PsDgg0MunsizGZghHI/iLiJbJdFGh37zztZ+26isM3787Hg9
         y+/w==
X-Gm-Message-State: AOAM533/X8qUS8hn/Az4kNaJY7FLZxQlLweXxDbpRufvtYYin4sHSMpT
        HPyuLHmPY3fISrvdrvh4CGLFpypKug==
X-Google-Smtp-Source: ABdhPJwtl8iFb0b8559uBiSux7XVBqCBPqzo+++eeYJgPPUGzTPe4wnLZlOGRZttf8xQ8fTS3kLmR6uqjQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:2901:: with SMTP id p1mr4533662wmp.170.1603977433686;
 Thu, 29 Oct 2020 06:17:13 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:16:46 +0100
In-Reply-To: <20201029131649.182037-1-elver@google.com>
Message-Id: <20201029131649.182037-7-elver@google.com>
Mime-Version: 1.0
References: <20201029131649.182037-1-elver@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 6/9] kfence, kasan: make KFENCE compatible with KASAN
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
2.29.1.341.ge80a0c044ae-goog

