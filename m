Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158FF295FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899681AbgJVNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899664AbgJVNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:54 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF93C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:52 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id be19so649043edb.22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZDpLws4WWjszeBZt7nTlIzp0p338D/8ILsPCgH/ymC0=;
        b=g6JwnRNLjkaRFkpFVHgLjZOQIQP4rh4rnIwcyms2N78ZDOmBQSYZP56ZAmgxHWUXcm
         IUxQSQ2WjpTQOfUa8ywDBIZo1cjnWs8RIdmAIYR9BmY3f8dJANNQmkqPsknBrdP0mTKd
         7pCLzIjmPAiHrKFfW7/HdqypIdOXRxYiU0A/P2X0gH4z/L+QRN+nb/l+nlJ8Ry9HIATi
         yOztfvRbuWiGoiuYr/982JFzJxS8rVLWNALBOnthgIh/rCbjPQo4UQOn0uk+zjVYB9Qu
         tUcKGvDXUfdIG3nRrZ6DpILb3BTK4YSl1/12TJvrVWROGFqZHPvDO3fClAxHO5QiQ5ok
         hAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZDpLws4WWjszeBZt7nTlIzp0p338D/8ILsPCgH/ymC0=;
        b=SbLF4gIJDoVVlmrNoxV9bpxOJqnWC+HS0e4HDUM49/YAv1pMRz88+PKJlhwRuHBpwc
         APUz0wtRnZlMnE3GcuaXWRqpeisDBpFvilnm57pqMGI9AObWdmWmw5xyOGKjqfF7bluq
         te0FDLUmqkfEzXz7tW7yVOTK25QFzT02JxyVFIHdTfqhGqMAcMgadU2wgSJqujMq8eXI
         BqKaDJpTWTIQsA1ulU3C0MDzuyH+DGAqKrNErtLjArGgZuhXhbpMX/Jj024pTNFZb0Gc
         q+2+/8Ud5lgqneOaNguvD9DhSJHZOyUvR3PXoMpTyXwAuDwivZCALGiGOAwk9WhS/q71
         B7mQ==
X-Gm-Message-State: AOAM532JJ6+Gi+nMlV/bFJOA4HLFHZAspHh5U3zXoTyHHgxH4fnBtj1Q
        8+uua5sSsWw5pMGDItbTCBLVxAYKs5owRIjG
X-Google-Smtp-Source: ABdhPJxu3Fj1qguz52Emo3v2IYFJxBR6Ao7egY4U/BdH3m+sfImkhBYYfIlca1OIixc7Du21Hd+WcdpgheaEGhNu
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a50:fb06:: with SMTP id
 d6mr2197662edq.312.1603372790776; Thu, 22 Oct 2020 06:19:50 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:03 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <a3cd7d83cc1f9ca06ef6d8c84e70f122212bf8ef.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 11/21] kasan: inline kasan_poison_memory and check_invalid_free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
into static inline functions for hardware tag-based mode to avoid uneeded
function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb
---
 mm/kasan/hw_tags.c | 15 ---------------
 mm/kasan/kasan.h   | 28 ++++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 4c24bfcfeff9..f03161f3da19 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -24,27 +24,12 @@ void __init kasan_init_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void kasan_poison_memory(const void *address, size_t size, u8 value)
-{
-	set_mem_tag_range(reset_tag(address),
-			  round_up(size, KASAN_GRANULE_SIZE), value);
-}
-
 void kasan_unpoison_memory(const void *address, size_t size)
 {
 	set_mem_tag_range(reset_tag(address),
 			  round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
 
-bool check_invalid_free(void *addr)
-{
-	u8 ptr_tag = get_tag(addr);
-	u8 mem_tag = get_mem_tag(addr);
-
-	return (mem_tag == KASAN_TAG_INVALID) ||
-		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
-}
-
 void kasan_set_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 94ba15c2f860..8d84ae6f58f1 100644
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
@@ -276,6 +272,30 @@ static inline u8 random_tag(void)
 }
 #endif
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+static inline void kasan_poison_memory(const void *address, size_t size, u8 value)
+{
+	set_mem_tag_range(reset_tag(address),
+			  round_up(size, KASAN_GRANULE_SIZE), value);
+}
+
+static inline bool check_invalid_free(void *addr)
+{
+	u8 ptr_tag = get_tag(addr);
+	u8 mem_tag = get_mem_tag(addr);
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
2.29.0.rc1.297.gfa9743e501-goog

