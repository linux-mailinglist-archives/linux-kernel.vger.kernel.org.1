Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8682A737C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgKEADA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgKEAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:58 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:58 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id m4so82588wrq.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TVZ5KfDqV4sczuDDUV9gNsUWnBSctv8RhcIj1oMqFVo=;
        b=DWEvy7mMEfr+/axjvw6t2VjDZPS+lO0xs+0DiZYZF+nJ/ZsK5Vhqm1kX0FdXvUY7yG
         7jCjsxmBJd4av9dmmVxOp0gRjRs2QCY5L3otIaMyH7pQ4nKoFxVscyQ9krNdoXU0alvh
         DhuBuZL5pei0BWn8T0hoN4WkbQNcs3/Rb0i/xpksyeduhrc5PXjjCgF0P/3A4mmuVE7V
         Gazmv0f/MfckBnt0ufqq6PUfKCFQTkU73BJsVkhUSWBmR1xBSsc52x/QycRA9GeNSXQZ
         hS0WV28RuFuQLkl6WpqfqAT0/gIyIKYt0um0SMwnhJGYhi5Qc34vqM0lhPtMDl383/Em
         hqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TVZ5KfDqV4sczuDDUV9gNsUWnBSctv8RhcIj1oMqFVo=;
        b=WfOAzZTaA5zlag7EWUvHJy/gyfb6zB4fXwA4VjLAPjXBuzMsgSxgq/PcwxR/w6Hu2x
         HLLAcaRp0UkG5ZyPR0SV2cmlWnXRuDwu4TcUTwotwfljztcxmEZvIyEdDI9m2pn6EdGV
         JNSTjlpr05rWm8fw3rvhcu8D5zgp15nT5+pbzOYiiRBHn354XdTcq5LurFr4gIWLCvLS
         SFmjGbmb12Z11UJNuL0gtzRONjqqMaG+gU8aKnhS9DM48sigNkDBSysTboG78FeB8uxq
         KUbsk4m356Jtl8ljF5L0mxLYs4v1JfGS+KpEEtT9GAAmleNVLy9d/PLbVq6nhdmFtglq
         urpw==
X-Gm-Message-State: AOAM5339rzuYX7qXD/C94sCfo6UU4UolAnQHqHHA+jn9P8EjE2dvLUdR
        najh1T9vCHQ8cAwnP/ZV3sPxQzCsUqe8ituI
X-Google-Smtp-Source: ABdhPJzWht9sgT8VGHbs3poE0UdD+kavb+Z/NCfdyaj2htoI0/JLAcuZvn5uAHlVsbj+IJFNKhvHkMoibdhWjIwx
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4d05:: with SMTP id
 o5mr23559wmh.94.1604534576841; Wed, 04 Nov 2020 16:02:56 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:19 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <7a831f5b5876f468545d637775d5440d49d31400.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 09/20] kasan: inline kasan_poison_memory and check_invalid_free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using kasan_poison_memory() or check_invalid_free() currently results in
function calls. Move their definitions to mm/kasan/kasan.h and turn them
into static inline functions for hardware tag-based mode to avoid
unneeded function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb
---
 mm/kasan/hw_tags.c | 15 ---------------
 mm/kasan/kasan.h   | 28 ++++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index d5824530fd15..9d7b1f1a2553 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -26,27 +26,12 @@ void kasan_init_hw_tags(void)
 		pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void kasan_poison_memory(const void *address, size_t size, u8 value)
-{
-	hw_set_mem_tag_range(kasan_reset_tag(address),
-			round_up(size, KASAN_GRANULE_SIZE), value);
-}
-
 void kasan_unpoison_memory(const void *address, size_t size)
 {
 	hw_set_mem_tag_range(kasan_reset_tag(address),
 			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
-bool check_invalid_free(void *addr)
-{
-	u8 ptr_tag = get_tag(addr);
-	u8 mem_tag = hw_get_mem_tag(addr);
-
-	return (mem_tag == KASAN_TAG_INVALID) ||
-		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
-}
-
 void kasan_set_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d7a03eab5814..73364acf6ec8 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,8 +153,6 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 
-void kasan_poison_memory(const void *address, size_t size, u8 value);
-
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -194,8 +192,6 @@ void print_tags(u8 addr_tag, const void *addr);
 static inline void print_tags(u8 addr_tag, const void *addr) { }
 #endif
 
-bool check_invalid_free(void *addr);
-
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 void metadata_fetch_row(char *buffer, void *row);
@@ -275,6 +271,30 @@ static inline u8 random_tag(void)
 }
 #endif
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+static inline void kasan_poison_memory(const void *address, size_t size, u8 value)
+{
+	hw_set_mem_tag_range(kasan_reset_tag(address),
+			round_up(size, KASAN_GRANULE_SIZE), value);
+}
+
+static inline bool check_invalid_free(void *addr)
+{
+	u8 ptr_tag = get_tag(addr);
+	u8 mem_tag = hw_get_mem_tag(addr);
+
+	return (mem_tag == KASAN_TAG_INVALID) ||
+		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
+}
+
+#else /* CONFIG_KASAN_HW_TAGS */
+
+void kasan_poison_memory(const void *address, size_t size, u8 value);
+bool check_invalid_free(void *addr);
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.1.341.ge80a0c044ae-goog

