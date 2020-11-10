Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619B22AE2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbgKJWNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732920AbgKJWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:31 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF825C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:30 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id y5so8511113qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S5GVREd9VqHHCaX+FFNS+NOU5hd6lun6S29ewqSBNuk=;
        b=XwoM493DRsmqkt6xilLOyWrlTKG+10CwtsIBXxiDYuysKqe8W1Z8yNzJpaiGtL0MlU
         OWJrAqOrqNYMQ+lv2x31StrZZXWduCh74/scNJxfqh8vvZtc6/VPdbpCXECbSXH6pC2B
         86vNnKsKhkGGffR3jZMvjiN8v8HswomR/jNftid5/d1foLR4W2rGS0l5FHwMA9V9vvND
         BX/vS7NtcWtbRw0G6eVGWCWGaltAtv6BcT8+uKK5P5VQRswRCaGUu+JcIb2sgmNFcqR/
         EtQMxGqZTbB40bLtokcITZ7Vd6BDyJCCaLZuUeXyCwNKdayj2S3NQ/veNLGxus+qAW4s
         ZUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S5GVREd9VqHHCaX+FFNS+NOU5hd6lun6S29ewqSBNuk=;
        b=X19w3NuQvZljFOuYNMCGm3zfCiFtFC1dmSVn/hyqZGfmQBkRzEt0NWpHwtEpP1sZoI
         5GDGCBP3COA5yvPr2qdb1aIy+Gm8z8qIPsfeaqgF1ShgzN6OrAnMav8gj43FUorc/zbB
         yfSlXHjQ+LSxbXI/sa46n9+bX+2lFIkxl5lSkmAgatUqGziLO22uf0cfcv4MoZFVjM7g
         EPVpVHHaF9lhp8/Jgyy+A2VAMMGMMEkdyBjOs50sSEbovRfVa+9LqJAF852nSz5p8xk+
         Gz1SM2Fe3nDtYaC5yWyEa3VFDI9HfM5XBt2+yPqcN2gSTJ7rD3mphIpUIufDq/CUXq5M
         qDUA==
X-Gm-Message-State: AOAM532X9aalOqFKRBs4q7H0pStCEIogdH1NIazZtDmATW4aacGplc9r
        vOOtTz2DymOghfnMj7M7p3gez7q5YLAWG0Bq
X-Google-Smtp-Source: ABdhPJzC2wAi5b1T1w3VlZYh7/z1S2yPnXtdLFrf+n0SJcixeF++pJ8B/DF1WTwAjZwEDicG+91irs4hKnWppdtB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4142:: with SMTP id
 z2mr8829724qvp.48.1605046350079; Tue, 10 Nov 2020 14:12:30 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:32 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <b484d6cece68422a6cc5399dc7ceb69ecbdeeb22.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 35/44] arm64: kasan: Add arch layer for memory tagging helpers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
index cd61239bae8c..419bbace29d5 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -230,6 +230,15 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 	return (const void *)(__addr | __tag_shifted(tag));
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#define arch_enable_tagging()			mte_enable()
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
index b5b00bff358f..ae7def3b725b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -241,6 +241,32 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
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
2.29.2.222.g5d2a92d10f8-goog

