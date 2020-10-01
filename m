Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E0280B24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgJAXL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbgJAXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A33C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o13so94972qtl.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y9SVZYHYHpZATyjbHTG3PyiS7DYM984ggxAJRWK49Xc=;
        b=TW/FPr4bRXcTE+SIHUqBlHMs70Yc9mmh6JYFCJfqs41ChKeY3CRKavpPA//t51oFqy
         Xj99ugFnw/USktQuipsr8Umi9CTu1+kixpXq+QQUjIAdOOPV0dQqMtccScYM4b30s4zz
         caa8gBdYza1jWLroGsPBHjDxm49kvd9+vJim0hoyc/wKibkj5yIqg3JllnBZPvbp4z0M
         SMZoT73+8sN+LsCo8VGhq+nPA3AQjX/mW+A0RDIG41f6np2PvHN0LcYL1yv4MUSfJNLO
         mX1g1lbrW7IBBT0ZpscOKYub5VgWb7WK5Fi4uVBWMw8nRvlG2LXmyQVOwA07BYi4qXpO
         PihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y9SVZYHYHpZATyjbHTG3PyiS7DYM984ggxAJRWK49Xc=;
        b=tgBnCEHQoXJDJp7nxNpVMAAa9FiEHQ3I5QJ14vcOpgZtjLCoQfPwSVNWXozI8IZR2l
         9CtCqwJ+k6m60E/WYO/wYJLygplBUH3/U5ZzgeQbxtHDL3+QOXbWQp0DkcS5zAsbcLMB
         2zGIHevQX6rLGvkG8jcoZhMfnqdLeoD/xyVxJ0F2oN9OmnUiAgDfE+WkX8pG3xUcb7ih
         Q9UDH7ecJwhAJDtcOsfK78y1UMmlguY4ukD61NH+6UmMxmYnjz74VyChpwKDOM/T/xdj
         ur68n4+jabWXaSedRvvmLZaWiwMZAvbGY/tbs6noO+sXRp+0L0aoaC/WLPrc9dfDx39D
         3XfQ==
X-Gm-Message-State: AOAM531jZhYCmGK/ap2qSmFM4WN0Ttje5/f7UUPWbFN9sKEVHqsYcTYP
        PGsugZzU323axlWjBEAVOfobGvVL2GMEAN8n
X-Google-Smtp-Source: ABdhPJyuYeXrb+lxkI5uKlF3PsWC1Ouy1RZKPcMRy75kLywx8iOx61KDDRgnjeAemKA8udGpe3nW4j0crYsqLUiI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr10157533qvx.48.1601593904745; Thu, 01 Oct 2020 16:11:44 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:26 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <b0873fbe914dc46cae079acc9687d914792d850a.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 25/39] arm64: kasan: Add arch layer for memory tagging helpers
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

This patch add a set of arch_*() memory tagging helpers currently only
defined for arm64 when hardware tag-based KASAN is enabled. These helpers
will be used by KASAN runtime to implement the hardware tag-based mode.

The arch-level indirection level is introduced to simplify adding hardware
tag-based KASAN support for other architectures in the future by defining
the appropriate arch_*() macros.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I42b0795a28067872f8308e00c6f0195bca435c2a
---
 arch/arm64/include/asm/memory.h |  8 ++++++++
 mm/kasan/kasan.h                | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e424fc3a68cb..268a3b6cebd2 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -231,6 +231,14 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 	return (const void *)(__addr | __tag_shifted(tag));
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#define arch_init_tags(max_tag)			mte_init_tags(max_tag)
+#define arch_get_random_tag()			mte_get_random_tag()
+#define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
+#define arch_set_mem_tag_range(addr, size, tag)	\
+			mte_set_mem_tag_range((addr), (size), (tag))
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 50b59c8f8be2..9c73f324e3ce 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -241,6 +241,24 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
+#ifndef arch_init_tags
+#define arch_init_tags(max_tag)
+#endif
+#ifndef arch_get_random_tag
+#define arch_get_random_tag()	(0xFF)
+#endif
+#ifndef arch_get_mem_tag
+#define arch_get_mem_tag(addr)	(0xFF)
+#endif
+#ifndef arch_set_mem_tag_range
+#define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
+#endif
+
+#define init_tags(max_tag)			arch_init_tags(max_tag)
+#define get_random_tag()			arch_get_random_tag()
+#define get_mem_tag(addr)			arch_get_mem_tag(addr)
+#define set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.28.0.709.gb0816b6eb0-goog

