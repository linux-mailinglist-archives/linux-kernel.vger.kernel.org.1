Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5627257C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgIUN1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgIUN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:26:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC67C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:26:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 7so12784820qtp.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=k1T9dYB7DJoZ+u+nVe3kaxMkFtqFlEoHZfLN0p/pvEE=;
        b=h0DABlibHB7v95H3LhOc4lIx2a+JuJCaG5dCjxY69vhbTwo2OewB2jqrcfxfSAWImf
         0rilrwD74EdgNZkNctrYhdK0BKQa1IFxA96Sn77Ss9MbjCIxt55LT+Db94EGESOvWC61
         FNhFsNV1l+s2LYwjRiVeyI/gY07VtoOl0G4eY13mJqePxG7L0c4mXQ3OowvJ26BmA67c
         26EMpkQ2n7OL6XdtoU4I2iAZTKdgLhn27yeHPdjeTgGW4u+Pr5ofUSUfQP/ixCP+f2or
         3yp/zGKOxnf1szBrwX417xIk13JJ29F0GqtqSoNssPh6hTcAf0X+yRRllGTo8pXmlpeV
         KA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k1T9dYB7DJoZ+u+nVe3kaxMkFtqFlEoHZfLN0p/pvEE=;
        b=GxRsBcanqEqny64HFxXzeMlydFs/IPTRI4YpKAhSRzKO+bz2E//zEq/vItNhTyl7o1
         eEdMwNrkOB/on9B/8aZACSiXvHpdiLYxhTvatUJHZLXdSqGt7l72eEUS7eM+S6dYvbuO
         FlZ3vm2g+ySl7VbRhZUW4HrcGveaU5wOA/afvxGelEJgyphlZVBXD/KluTB3FURiU6XL
         IzMpZOWnaklhoyF8KEz8JUlVeyxBhRe+AbysU1uLO7m2bhxXPZNbpHSm5z1sZzn71lS8
         lp4RzKbUV1rybzbNo0XTQm+4AuI9SM4mkNZhyxGgKI8EPsaSniVbpacTqyRx9QpseVO1
         tUBw==
X-Gm-Message-State: AOAM530WSDgGXT4B2f+Xg9k4In0aqqF5C21tLbtHoLf4kV7MbHOXZCin
        PPz6tvcTV1aAP/3iJaiM+q9ftnDOQQ==
X-Google-Smtp-Source: ABdhPJxI5BBppzUwl+FURSlYJ/XsuSII2/6RzrI0Ei9BEoIUMUq9N7cECIXnXgK6ZUjbLhwm9DwnPw5xLg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:4af4:: with SMTP id cp20mr30110353qvb.40.1600694811561;
 Mon, 21 Sep 2020 06:26:51 -0700 (PDT)
Date:   Mon, 21 Sep 2020 15:26:07 +0200
In-Reply-To: <20200921132611.1700350-1-elver@google.com>
Message-Id: <20200921132611.1700350-7-elver@google.com>
Mime-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 06/10] kfence, kasan: make KFENCE compatible with KASAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
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
 lib/Kconfig.kfence | 2 +-
 mm/kasan/common.c  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 4c2ea1c722de..6825c1c07a10 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -10,7 +10,7 @@ config HAVE_ARCH_KFENCE_STATIC_POOL
 
 menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
-	depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
+	depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
 	depends on JUMP_LABEL # To ensure performance, require jump labels
 	select STACKTRACE
 	help
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..f5c49f0fdeff 100644
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
@@ -396,6 +397,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	tagged_object = object;
 	object = reset_tag(object);
 
+	if (is_kfence_address(object))
+		return false;
+
 	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
 	    object)) {
 		kasan_report_invalid_free(tagged_object, ip);
@@ -444,6 +448,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	if (unlikely(object == NULL))
 		return NULL;
 
+	if (is_kfence_address(object))
+		return (void *)object;
+
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_SHADOW_SCALE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
-- 
2.28.0.681.g6f77f65b4e-goog

