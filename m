Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB64295FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899671AbgJVNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899564AbgJVNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:48 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20684C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dd7so1001385qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2LAxUi3Z+b/LyEBabYwH/SVI831szHE0G1gzyusivfA=;
        b=FpiS6ya9dima3cGFv2ElWjEzGn/AjgIOjjA4nCJucaeUIGickhtOh9Bys9UiRtSADE
         fjopvPyI20DFOwopcIT5lUJlbZcMF4DbGfWV51sjg9G4uSGmBjo9k71EyAqpVLZlocmc
         RZuzjb+QS/uWksRQdms/OIEEQtSHAP1YCrtaxsPDUhddEQl/Tm449I9yrgBZ6gyhzmEx
         Z+YYNrCbQs0F1iFLDro2B5zKIPve2PJYP+8EChCsz8ppySMSulg21A7GMsmWXlwY9ZJl
         Gw/zTKPaB0G881vyNGTjYBcUivggDHvOEkXXyh1Y3bNv+t+M6vkHWtge1bYsrivUKKLZ
         UHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2LAxUi3Z+b/LyEBabYwH/SVI831szHE0G1gzyusivfA=;
        b=bAlwBiA0dc+IHArDRyzlXWVjz02V8busGmatvF+zM+BycmMjV+zwuzYmKtboOs7kPG
         2s1f5CjTiEA2IO1Y+jmKcsMj077iyNeshUJiL01IhskQ+stjnH3Gl651z/SxHzrk3v5F
         gdZAQ9FOVM4kpdU+ECRqZJFfGrWfFdQnmb7u8iCAuAyKJQduMYF39tYkx07S549S4jnk
         PbFSBIyk3sQYlWNLMEHyfd4RooLYQFzyZAkFjM9xLAIN7DM9iRkvs2Ytw7c+wwvVLP4e
         6RdzIE9TYDFgF1ZSqV3XLORxn1HqCe3v5LpF5Fh4IbNuGDjjApI3jBZwqQzDXDdrRCgu
         ZBLA==
X-Gm-Message-State: AOAM530//lVMWksRS6dTur8SexhyyQ3j3+H8YbLgnSKdUR/XL/zT8W7d
        ahNtNdxHz8zpqNTPG0QZc1UCVrKjJICUjMlU
X-Google-Smtp-Source: ABdhPJxIP3IGzvps/ztZVCxylxxW3pDrg7OAYIS67bKz5QYods1FZnmEDxL5RuFvtWUriGc+3ulAxeTDdpoAifDt
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:45ed:: with SMTP id
 q13mr2255535qvu.55.1603372786206; Thu, 22 Oct 2020 06:19:46 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:01 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <b75b7fe2842e916f5e39ac5355c29ae38a2c5e0a.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 09/21] kasan: inline kasan_reset_tag for tag-based modes
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

Using kasan_reset_tag() currently results in a function call. As it's
called quite often from the allocator code this leads to a noticeable
slowdown. Move it to include/linux/kasan.h and turn it into a static
inline function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I4d2061acfe91d480a75df00b07c22d8494ef14b5
---
 include/linux/kasan.h | 5 ++++-
 mm/kasan/hw_tags.c    | 5 -----
 mm/kasan/kasan.h      | 6 ++----
 mm/kasan/sw_tags.c    | 5 -----
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 93d9834b7122..6377d7d3a951 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -187,7 +187,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 void __init kasan_init_tags(void);
 
-void *kasan_reset_tag(const void *addr);
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)arch_kasan_reset_tag(addr);
+}
 
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index b372421258c8..c3a0e83b5e7a 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -24,11 +24,6 @@ void __init kasan_init_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void *kasan_reset_tag(const void *addr)
-{
-	return reset_tag(addr);
-}
-
 void kasan_poison_memory(const void *address, size_t size, u8 value)
 {
 	set_mem_tag_range(reset_tag(address),
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 456b264e5124..0ccbb3c4c519 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -246,15 +246,13 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 	return addr;
 }
 #endif
-#ifndef arch_kasan_reset_tag
-#define arch_kasan_reset_tag(addr)	((void *)(addr))
-#endif
 #ifndef arch_kasan_get_tag
 #define arch_kasan_get_tag(addr)	0
 #endif
 
+/* kasan_reset_tag() defined in include/linux/kasan.h. */
+#define reset_tag(addr)		((void *)kasan_reset_tag(addr))
 #define set_tag(addr, tag)	((void *)arch_kasan_set_tag((addr), (tag)))
-#define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
 #ifndef arch_init_tags
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 099af6dc8f7e..4db41f274702 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -67,11 +67,6 @@ u8 random_tag(void)
 	return (u8)(state % (KASAN_TAG_MAX + 1));
 }
 
-void *kasan_reset_tag(const void *addr)
-{
-	return reset_tag(addr);
-}
-
 bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
-- 
2.29.0.rc1.297.gfa9743e501-goog

