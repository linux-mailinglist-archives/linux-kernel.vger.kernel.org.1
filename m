Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2900B277BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgIXWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgIXWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:03 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA64C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:02 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id a12so285217wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=o+5muahIyzBsCSQYTa2yEzLZS8Az5j3CfnIGZXwP7nI=;
        b=kXKqNW8E1mov7NpuLnK47U4pBbnLrdaxpw+5SAN0ltF5XUY0lFHMBL3W7EChB4zCQL
         QQFIk/6iv+ghmYhrNImHBqmmnRih4Zok72+1NsHqbj9q2ALs9hwUX9mNLJyEHpToqgWh
         tFUAqd3A0JxQ6N/uzYcU5IxlzfLN/5V0hsgFxp7EYzA5mKyOPdjJfvxvnJaZaQSGKY8g
         UXfXKhmVviLGaHWh6ftOKsSfXgT9bxcf2XOtxMWstc6u6xRosbEwHezA7MI2fW0rO4TM
         r8sFxm2VdRxzYH3O+EUoYDnRiL8nn/Xh9J54aDEAtcMuhzclKGM2hRemfaCT9XoaX2Q5
         CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o+5muahIyzBsCSQYTa2yEzLZS8Az5j3CfnIGZXwP7nI=;
        b=PwoYP3u3ti1owF8ymrMRKsfbdUDVkj3+Je4UU5yE9wM5uXP1+aYmKA23h9XTXY+NBA
         xVxg4g2rms4dPAs6Y5BbzHOn2y/KIRp/5FvRywDPAYyjTJexDAR0LHrWv/xKGWycBEZV
         GwuoUMX9nQUi42+oZxjwRv206xfdDIJXf7jaDzOuaOhwBxgFEKhbSNL0hR3kNuqebXVo
         DlyNZklSiCDquoC6Om2wuiOykUI3+vIa3+XKXkRm4q41JFVlPkem3l3BFvNvgIKa64yX
         BbV5Ph4CLB3+WWe27dRoCBTx7yorM0w5Quou9htbBUwjpr1a2FrgKlN2vu582sTjsUcm
         KTXw==
X-Gm-Message-State: AOAM533SzWNJTOh8QIKOw4sGUDNegK32I1eUnd8Ag5U64nkSVqBgZzCP
        zwSnX67i1kOxVAsQSMHavHTlGBS4iIgow/vz
X-Google-Smtp-Source: ABdhPJyehUeiSJg+kXRxdeDQ0lGhmutHtVinnAroN/FF5UMTOjOh25DNFbXLwa+fkNeTRy0ybwFRHtyLRI1oOeSB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:750d:: with SMTP id
 o13mr918934wmc.54.1600987861205; Thu, 24 Sep 2020 15:51:01 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:11 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <9de4c3b360444c66fcf454e0880fc655c5d80395.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 04/39] kasan: shadow declarations only for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Group shadow-related KASAN function declarations and only define them
for the two existing software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I864be75a88b91b443c55e9c2042865e15703e164
---
 include/linux/kasan.h | 44 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bd5b4965a269..44a9aae44138 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -3,16 +3,24 @@
 #define _LINUX_KASAN_H
 
 #include <linux/types.h>
+#include <asm/kasan.h>
 
 struct kmem_cache;
 struct page;
 struct vm_struct;
 struct task_struct;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
-#include <asm/kasan.h>
+
+/* Software KASAN implementations use shadow memory. */
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_SHADOW_INIT 0xFF
+#else
+#define KASAN_SHADOW_INIT 0
+#endif
 
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
@@ -29,6 +37,23 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 		+ KASAN_SHADOW_OFFSET;
 }
 
+int kasan_add_zero_shadow(void *start, unsigned long size);
+void kasan_remove_zero_shadow(void *start, unsigned long size);
+
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+static inline int kasan_add_zero_shadow(void *start, unsigned long size)
+{
+	return 0;
+}
+static inline void kasan_remove_zero_shadow(void *start,
+					unsigned long size)
+{}
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+#ifdef CONFIG_KASAN
+
 /* Enable reporting bugs after kasan_disable_current() */
 extern void kasan_enable_current(void);
 
@@ -69,9 +94,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-int kasan_add_zero_shadow(void *start, unsigned long size);
-void kasan_remove_zero_shadow(void *start, unsigned long size);
-
 size_t __ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr)
 {
@@ -137,14 +159,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline int kasan_add_zero_shadow(void *start, unsigned long size)
-{
-	return 0;
-}
-static inline void kasan_remove_zero_shadow(void *start,
-					unsigned long size)
-{}
-
 static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
@@ -152,8 +166,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_SHADOW_INIT 0
-
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
@@ -168,8 +180,6 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-#define KASAN_SHADOW_INIT 0xFF
-
 void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
-- 
2.28.0.681.g6f77f65b4e-goog

