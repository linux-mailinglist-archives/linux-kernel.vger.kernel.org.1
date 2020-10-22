Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3911295FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899559AbgJVNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899491AbgJVNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:44 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E7C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:42 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z22so1015883qtn.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S3zpKFgl6lOQ4xschlXI9IBqFZJcfplQNQgfAvCSd9c=;
        b=A/DzVj6NJxiFJ1FGJ6LmU2ByOvdQoNTbI0xyZCf/l69mGnF7H5keOh0cFSh6PSKDDW
         UHgRUgb4ay+Bz2HtzVeITURs24/VAJzkUUMrbBSiRqCemaRmiituhtSDAnGPjpzUAV7G
         Ei3KV9+HsVFPHC28hTUw4gJGHTaodYigbcSOTvK2AWvQufR2FcbEhGoUMuKdYfzt1MPd
         8nIHmu9UMA1TypVVK3IeFONWs9DUwaoRRERr7So3y4edr6JN5LQblz7M5V0PmuvctKPC
         UoVTtgZE67tor/jqK0uHNZ6etDCPZk14fm7juz+4hjSvuI0gvPWbT+aULiOTmcNYUsdV
         KJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S3zpKFgl6lOQ4xschlXI9IBqFZJcfplQNQgfAvCSd9c=;
        b=VJ5Qr/a2SntfRg2AAq3gMSCYfuXHp/jEbSPJ5eTWw3oT2nYZ9ubnJ1CmU2H1nqJO/S
         oFfCHi1ujbWaJVjMcvHz7ypMGYLET2hc6zezWppzjn3L98BeWcMNppC6w57xSsWxLcJf
         Qc8ETn44d2hMJ/0S6o/RS9spK2TEOYuI5qFyLlpasgGKbSN7NCKQCCMuO/Y6FbeMzUuI
         ys3uCBQgfVq3RsW2GhXQo8VaEy8aeydUlUnUY4HEYGavFhkSzKHBI/Yq+bjB9592UB1W
         jgf8CDQg6FYR4VGKJr8qqzEvAtKDOmlC98aJvT+O/WJ0MqAL4x7lcvsPrkvqJG+x8bG+
         t8oQ==
X-Gm-Message-State: AOAM532UgCHfbobAfgVBAaOjremJMin1O22fEYYH4qMYPLnNsiDonz6L
        IkV1TtD3+YNeRxLsBiixGWI+Ghv3y51YzLYP
X-Google-Smtp-Source: ABdhPJye0iIWFtk9uCN4G57gAraBO0b8dguucuYN00Tzqt7FUHcOAlZwClbYPWiparjNpI11i9pTLLg1NFTsf+gO
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:52c6:: with SMTP id
 p6mr2361291qvs.38.1603372781851; Thu, 22 Oct 2020 06:19:41 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:18:59 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <1d87f0d5a282d9e8d14d408ac6d63462129f524c.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 07/21] kasan, arm64: move initialization message
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

Tag-based KASAN modes are fully initialized with kasan_init_tags(),
while the generic mode only requireds kasan_init(). Move the
initialization message for tag-based modes into kasan_init_tags().

Also fix pr_fmt() usage for KASAN code: generic mode doesn't need it,
tag-based modes should use "kasan:" instead of KBUILD_MODNAME.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Idfd1e50625ffdf42dfc3dbf7455b11bd200a0a49
---
 arch/arm64/mm/kasan_init.c | 3 +++
 mm/kasan/generic.c         | 2 --
 mm/kasan/hw_tags.c         | 4 ++++
 mm/kasan/sw_tags.c         | 4 +++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index b6b9d55bb72e..8f17fa834b62 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -290,5 +290,8 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
+#if defined(CONFIG_KASAN_GENERIC)
+	/* CONFIG_KASAN_SW/HW_TAGS also requires kasan_init_tags(). */
 	pr_info("KernelAddressSanitizer initialized\n");
+#endif
 }
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index de6b3f03a023..d259e4c3aefd 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -9,8 +9,6 @@
  *        Andrey Konovalov <andreyknvl@gmail.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 0128062320d5..b372421258c8 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -6,6 +6,8 @@
  * Author: Andrey Konovalov <andreyknvl@google.com>
  */
 
+#define pr_fmt(fmt) "kasan: " fmt
+
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/memory.h>
@@ -18,6 +20,8 @@
 void __init kasan_init_tags(void)
 {
 	init_tags(KASAN_TAG_MAX);
+
+	pr_info("KernelAddressSanitizer initialized\n");
 }
 
 void *kasan_reset_tag(const void *addr)
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index bf1422282bb5..099af6dc8f7e 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -6,7 +6,7 @@
  * Author: Andrey Konovalov <andreyknvl@google.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt) "kasan: " fmt
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -41,6 +41,8 @@ void __init kasan_init_tags(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
+
+	pr_info("KernelAddressSanitizer initialized\n");
 }
 
 /*
-- 
2.29.0.rc1.297.gfa9743e501-goog

