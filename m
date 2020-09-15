Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483FF26B007
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgIOV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B4C061221
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:21 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id jz22so1853484ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uQBUcw70N5/pZNHz2QWMX765YU53M7496uPmAAbH/iU=;
        b=BMgCiDxI+ewSN9duc+vPhe1zL2wKt3c6rQlKYz9QH0ToEvMf9sfoL11ylpKV3yAh4t
         oALaiLPmKJtO5+cn5UwTLE5xrflMtIwwKQQj+kzXXG8bipIoxcKPpay1Pm37fb4lRf0+
         W6NOp5qYE/ik0nutl3QC6yPy5/M4NVt8dzp09IBcnMvPV3OrigakDyyt1sI8LJi+kdKu
         vrK/smCBgTxnx2bBlpJKODNo5p5lX2c20XklJ5LKqv+YYdcyFPtVo+PBEuEQBdesT8l1
         u+qj0kr40IC0Ark3xu2y4Ic/2Y+pTpby0p0pJqKia3b7oH5zmigy+cSlmRQ8HvgTACO5
         ZBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uQBUcw70N5/pZNHz2QWMX765YU53M7496uPmAAbH/iU=;
        b=jPykrRl9eoNDT3DMGINH34NwwoEtGzbeif3F0e+5mil12mj8HVHM9IVTUJuECd/9Pu
         8Xms7LqWGx2Y5lSE41ZGe26f43PeC6dFQydPCERVb/BRKAlVH5clM1fUz3B1OQLCeJMk
         yDDZIfUiq/D2HRrTtQOjzgN20SwuvNmoM58Rw4vYCnmFT207aSM46jpmaA0gfKQO39t2
         ehHBACXrm1y+Ei9rcTzTux5AgvJJD4oqL2iATbZRhDkmPWVJyyNK7r0jJkdY5xFANqAK
         aaOMJ1uUcFocvQeGzG1RRWf6saCZjQ8RYrPjTbFdoCAYx4DITsTpzUkbe0vS7fTYWDQm
         6MvA==
X-Gm-Message-State: AOAM532Cmyl/jp9fSA38ZSs9RmcYgJsXXrjRDV+pbI8Iv771hjlw1GP7
        SKcHT1/DZdLWJ5avUAy+JzZDTxIeRFUj0rmP
X-Google-Smtp-Source: ABdhPJwWctjYlK1i0RQ9U5rwbx1MXyXTqF8P/2W35vyRuLyCkaQtqJgTmv97oJ7dLulE5XOcJgCU96m1Yrxfbnde
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:18d:: with SMTP id
 r13mr23596971edv.267.1600204638418; Tue, 15 Sep 2020 14:17:18 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:05 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <b52bdc9fc7fd11bf3e0003c96855bb4c191cc4fa.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 23/37] arm64: kasan: Add arch layer for memory tagging helpers
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
Sender: linux-kernel-owner@vger.kernel.org
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
---
Change-Id: I42b0795a28067872f8308e00c6f0195bca435c2a
---
 arch/arm64/include/asm/memory.h |  8 ++++++++
 mm/kasan/kasan.h                | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index 1d3c7c6ce771..8b43fc163ed1 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -240,6 +240,25 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
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
+#define set_mem_tag_range(addr, size, tag)	\
+				arch_set_mem_tag_range((addr), (size), (tag))
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.28.0.618.gf4bc123cb7-goog

