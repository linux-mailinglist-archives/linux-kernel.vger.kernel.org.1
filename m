Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9A28E802
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgJNUpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388361AbgJNUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:44:58 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l8so321102qvz.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qyL7M+3Aw1Hsa4EXSDAwQDJZSRSVnrXpMPSsUVjsP1o=;
        b=bzlkU+ha2j5IMvYERbVrlYgB00EukUPvLEt66Mr1s/Y8dbNwHoJlkkZVkMUk2+MdrA
         WOryapXokLVKwks3pvV/uGMsCcJk6/W29LQzqo3jIBbi5zZ6IJXy30XwXrjoYRvPT/1x
         hS+91Lx2l74FLbf5wEzRsRpdvVLUj6BNxRAazJyfDOVRCVHSROUnOUDa0oluqFJpRgMB
         PkaE0K2rjxj2aI6hA5ARRe17gVi9X08JytoKm39Yvb7rCVbaBBZIBaDiwMqKMmGiy0Y3
         OAtl6BBYGjuoGj3Y610CUhzDWF8OxVGS+I+0Esaz5LB8vjxs0+IiVgIdzaP8a/sCAa6a
         FA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qyL7M+3Aw1Hsa4EXSDAwQDJZSRSVnrXpMPSsUVjsP1o=;
        b=bPNCY3ocHJKeAXCe9dAb31o3GXsodQT3VTEULjam/Tq2tGWFlg/JqN6BvwexOjAEpo
         Jhocl2X0fMqxC7Ra9gkhlzge8yFZ9UT5HIMAYSPMjK2QqJoZWPxNmMIiRN9/8Jpu8RcM
         lJkEJagfuMyllyonCKwbzdvHeUZHmt5OZSTiLKw87+ePmLaQ9Bk+7dKhXDEqhf9GxATg
         2/wBQpDgHAgJP0GlWGKblGEsRRF5otv33lrrk5/GZVedaSwyrsW6+lWuJmoTrF9SWpNx
         /aJqZ0AGpBVHylYUbZuiTvTuufxHCCe/aTCeo7cKT30aT6x52EFdqtLhPBRJxv/j4Ph9
         lFng==
X-Gm-Message-State: AOAM531t1k5UfSQkBSPc7K0sohwQKm86mVkghZPHNpsrmrI3G+Oc47tr
        vouzi07mikjJlcwvzwzi8rJMA5slbkyuzxTE
X-Google-Smtp-Source: ABdhPJx+MX3k/4A7LJTPC0D1MdwX4KJoCVu0Zz+9M1HMMB/8PfvBo211e6dcDjtAycJYLilp+w8VGDv57XzsQIFW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5547:: with SMTP id
 v7mr1394691qvy.9.1602708296087; Wed, 14 Oct 2020 13:44:56 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:33 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <8fe7b641027ea3151bc84e0d7c81d2d8104d50d7.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 5/8] kasan: mark kasan_init_tags as __init
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Similarly to kasan_init() mark kasan_init_tags() as __init.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I8792e22f1ca5a703c5e979969147968a99312558
---
 include/linux/kasan.h | 4 ++--
 mm/kasan/hw_tags.c    | 2 +-
 mm/kasan/sw_tags.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 7be9fb9146ac..af8317b416a8 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -185,7 +185,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
-void kasan_init_tags(void);
+void __init kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
@@ -194,7 +194,7 @@ bool kasan_report(unsigned long addr, size_t size,
 
 #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
-static inline void kasan_init_tags(void) { }
+static inline void __init kasan_init_tags(void) { }
 
 static inline void *kasan_reset_tag(const void *addr)
 {
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 2a38885014e3..0128062320d5 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -15,7 +15,7 @@
 
 #include "kasan.h"
 
-void kasan_init_tags(void)
+void __init kasan_init_tags(void)
 {
 	init_tags(KASAN_TAG_MAX);
 }
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index c10863a45775..bf1422282bb5 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -35,7 +35,7 @@
 
 static DEFINE_PER_CPU(u32, prng_state);
 
-void kasan_init_tags(void)
+void __init kasan_init_tags(void)
 {
 	int cpu;
 
-- 
2.28.0.1011.ga647a8990f-goog

