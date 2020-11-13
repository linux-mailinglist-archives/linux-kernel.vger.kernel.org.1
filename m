Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51DF2B2857
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKMWS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:51 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575FAC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:35 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id z14so6625029qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=03ZVTANVMndAKxBTmMPKTeOd5fHJJQ7JXgAuJEAynpY=;
        b=Irv9DM0UsFmGy7ycpfksKZPxPunSrUwyrgROaAlP4JHh1CM806pobQwjXPDjkjMLYu
         Tq/jrkTfcZROzhXczIWaV8Elw+J8z3dnSxYlgf7ODC6FqBVoKUU1EJufDopynxdzUMXX
         oEG9EQkz35isWhsi7GBMbioHHVtQhZYN/ML9dSwXuFOI+0OyXJYQb7rnYHnAV/vLtcZo
         crDYrcmb69AOdmR0kt0n0AYZsNVctwb/jrkqOfxQ2ZzmXKTMSK2ckFl7Cpfd1Ml9ZdDV
         130EiUyc0IZt1GuTRPtIFMomwkDMm1fpFt6wCA1ZZscVlA4SrxOzpEklei1UrZLTYuFT
         Mg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=03ZVTANVMndAKxBTmMPKTeOd5fHJJQ7JXgAuJEAynpY=;
        b=i/cNhKTpzxkYntW13hYKN39fsUw+UQDwl/Dsibo66DRIJiIiK8hANATSP+rhjZI7Wa
         Z320ctuKOwdVZ9D6H4FoI6+6VJtjPmgdy4UKmvR0VNQZGptZvGsIjOLlzk9RnfW0D69v
         glG671dSVtOpIa3M87evQIdbPR/x6PILko52WLMct5TZa0lpz7fCEzwBikZiQt9f6yU2
         9vWVSHzjx1JYl4KWoNc5efLqkbjrPQmNdYXrTroaroQSZCCxAXEECJTs0ut5JYrcOnAD
         iZMC0Pz5/plV5G6EPHT4+mfHX5EgLpfXm9OvaDcWX49Pn+K3fL6QZf0pOdqEaviuQuYc
         6V0Q==
X-Gm-Message-State: AOAM5304YQlK0mrL+UuXWDMyI/Lnqi5VNUiYvRfVaytLP1gO9DBTc+a/
        1mxYEKl8oal2IXHWwp2gUCUiswu4xYD+uALY
X-Google-Smtp-Source: ABdhPJxPrdklPOIoefBKRwfkTEjY5SIiFeAp3x6m0FK3ZXk20c36zYo+UiCHZufgZlMbZaHRuOFGyD9W4i9Te5n/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:56ee:: with SMTP id
 cr14mr4795372qvb.15.1605305854497; Fri, 13 Nov 2020 14:17:34 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:16:01 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <69ccb75b7fc7ec766e05ac62335e14e5bf0c50e2.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 33/42] arm64: kasan: Add arch layer for memory tagging helpers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
 arch/arm64/include/asm/memory.h |  9 +++++++++
 mm/kasan/kasan.h                | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 556cb2d62b5b..3bc08e6cf82e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -230,6 +230,15 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 	return (const void *)(__addr | __tag_shifted(tag));
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#define arch_enable_tagging()			mte_enable_kernel()
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
index 3b349a6e799d..bc4f28156157 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -243,6 +243,32 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+#ifndef arch_enable_tagging
+#define arch_enable_tagging()
+#endif
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
+#define hw_enable_tagging()			arch_enable_tagging()
+#define hw_init_tags(max_tag)			arch_init_tags(max_tag)
+#define hw_get_random_tag()			arch_get_random_tag()
+#define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
+#define hw_set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.2.299.gdc1121823c-goog

