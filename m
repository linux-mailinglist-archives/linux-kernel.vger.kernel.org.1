Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54628E803
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgJNUpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbgJNUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:45:00 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA62C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:59 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id r8so256793wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=K2o7M+jwCbfe3UtigR/EtRx8zIOq967XZxvWYmUAylE=;
        b=Hb9Kmil4v2SRhfkLDhDTagXl/nUN+fP8O3bsS45+El5zffAxebkKT6UVz7yTdYw86B
         alBCvfMBfSlR/6368v5eeWKz7rNvS2N/tnxS+BLZfPMaKeK8AS1fmRI2uaZhQStUIydF
         +1F141nJhz+yIg4AE1xMg6goNYuw6TDadDeAkQuvlrc0LfUWkUchqQJDEDV5VLsRWDHJ
         KumZSGP9LGAPAcAcWgec5zOHknwtaFEiS4Xbdmyf2O+nOlfzicZP88Sypn4sryTN5pep
         lBjrz7hUrlJ0Rosjc/tA7JyQ5yJh4nVtqsH5VMzpuFtjXv26a6Ba9NR3vZaUX+bXuafb
         IzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2o7M+jwCbfe3UtigR/EtRx8zIOq967XZxvWYmUAylE=;
        b=ZRihSl1+u1fSR6bC1ILOZoO0+6h3fnFMzvinLBsIDXaKSp8TdnAvWofRImAt20bikX
         RIrb8eD/LRevI9113EOyaZvEhtOUrORQlnl3pBEw9pitiBRAxrIyhvDkIgDMn+Zq6BdG
         a+QMTSc2sVu3RTF7mv8/77PCyv276JOtzkIjs/gxzHBwcxoZNx1/jYjF78khEhl2K5SK
         Y1UQjqa5XKhxa/bVRP/oXFcu9Zcx0f5ucmg5HmMns/ftecrdXifkmKDSX+tB+9H6by6f
         JJNgLbNKHF71sKxiHtEk/1e7bgc4wLC2JR4Vb69pUpy4UZySgkG111ch2gcpMX5qXJOr
         sVwQ==
X-Gm-Message-State: AOAM532aiHFHiEF6RYsqYPlLKGUffozfoSCIGSLdWf7l2TXKpIRkDYMy
        1hTjJMNEJhEHc60HRnANha18FTcnn/6LdO1e
X-Google-Smtp-Source: ABdhPJwQT6qyJg9cLSo78MJu0YBvn+rcvMrgvB9xVXQSC0C/QLaTYurLAZzP0oypJNr4rTmkZPMPUUPTK8SKG06/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e1d7:: with SMTP id
 y206mr622854wmg.48.1602708298576; Wed, 14 Oct 2020 13:44:58 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:34 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <4e018edd628802e8454e80fb308e220e1ce2113a.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 6/8] kasan, arm64: move initialization message
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

Tag-based KASAN modes are initialized with kasan_init_tags() instead of
kasan_init() for the generic mode. Move the initialization message for
tag-based modes into kasan_init_tags().

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
2.28.0.1011.ga647a8990f-goog

