Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12612277BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgIXWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgIXWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:53 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5392FC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k14so464185qvw.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0jztYvLtNDJTI+Li9nzFVZCFMRi2vX4Swz42H1b3+CE=;
        b=TATkXEfBuXx8POxghcsvnhPg/Ppe5qlIFWUMsPy/7MJdyT6Zg3mWK9cJR5BDXuKKWU
         lVdlTmQkU3DtKV64iPmplPxNViyG/jfBWAmRD1h96NInmRQynNRWNhwuQpQwSwkcDlMa
         l3sexWbnfWBKB3WrJ4YLK6W+xLA1Ht+FigjwaQvYt9Jub7aTkDFTT5Y9U6F4bj1tRwNq
         BOLMQ8ahFv+kOVr7L6nTg+jtlI8ouOa45HFaoYqrUSX5mqRQzVx3V1LYerYOL5OMIVam
         MSydCeaJiUYnF/qraHQRQVj/PpP226+GN6/BWOre1/+4NOVqQbC5h/JXBzJJVwV2aydb
         vN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0jztYvLtNDJTI+Li9nzFVZCFMRi2vX4Swz42H1b3+CE=;
        b=AEEt2uQVlU5ouDLICnmy7fsJKvGFFOsz4l59rKCTj2tqTNEHqNX5aADS5bofWdpIP5
         VeR8Q8v8tH/pUkESBsoyPaYxcmkMsW5EyVwm5XKDROxJNbXniBaESOmOM/FjHqoikoPQ
         SjsiL/MICEqMuEjYutg42ayxQwy9U1sv0jkTinA8U9+pHeq67ZtLodAsjvpf/cWEeGCv
         GjpvYEMguvI22FJhqJKGGU+Q+AcI5lU1fjnd4XGtNv/1UxZgJGWcnXrYJPeAZKnFSD8B
         MJbuwYXD/MoABpZzaHH4LdPGpyX9jitEJ36dcwLN6E1P2ZxGfzzYkzAE98jpcFeds1DA
         QF3Q==
X-Gm-Message-State: AOAM533HvMjuyW74AX7+TTyoGdLTfH4QnoN7RVe4RtYImBYQphzthpsN
        zwJ2t43bksgJXemDQCqyfivmPmZCC/RMXsKG
X-Google-Smtp-Source: ABdhPJwoMR0xEqUVOBwjA4EzvV3B9Mt/BV5b/SvOxhCiK3Y6w/N1LrceyVpM0jW4TsqTz3/hGCQu7Bq4A+EsI69c
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:e5cf:: with SMTP id
 u15mr1552253qvm.14.1600987912449; Thu, 24 Sep 2020 15:51:52 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:32 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <176c7b60cb2711559450839242a0f6fade769c3f.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 25/39] arm64: kasan: Add arch layer for memory tagging helpers
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
2.28.0.681.g6f77f65b4e-goog

