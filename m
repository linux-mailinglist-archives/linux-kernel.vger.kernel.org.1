Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA355272568
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgIUN0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgIUN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:26:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD1FC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:26:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g1so12769617qtc.22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ix66qFhKSgSVrZqQyJftp2TjE15R0Twg+sH9CEm53D4=;
        b=CTsRusC0VpfrH6AP4frLdYd+UeeyjPQTPYZLk3YPw3dPpyo7SVxAO26BpWE11ZWSPQ
         uSC4T0QWzrWUS2WxaRekysQJlBp37jl2hGNZJyQiHllh7tx90+s6iCZvxCt/Hw4sdLkj
         u2SP6GCtU9pcT3lGTbYBmTyFmj+ooqG0galP6OV/pxSrwP3s+/NDH1w5Y247XTomei5m
         PCP6mD1gKGwqIwMDIO6OhwY/Qq2TJK2Avxj5GH0yF9w8VlxUxiPzKbIM1b2V2nh3NnuU
         KMg8ZakQBuHdW6HsF2NcpHVedeue1I4YGmMMVdgF+74bp98dlDO3TxRI3rmhxBWz3k/X
         Z81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ix66qFhKSgSVrZqQyJftp2TjE15R0Twg+sH9CEm53D4=;
        b=nhocRUHNuNOtxIn72C7mfTrR+ZjZ8qmYacqOZ/frjPHkcLzj8BP6UF10/T3EURoyND
         cpXOnuoiaDgGzwuQUk78gBMMNeAtETiksAlaVjSZ7034j/2qYpoyl6qh+OjnjWYc7Chk
         PKPzM3izYoVKocfoSPIanT9giHAo5NUAKAA7NZHwdeNnTz5LBxI5MmBweZIMPwbuCc+S
         kAyvCV4BxqOS0dAREOR14BE6WlZmWbUcVg+TLUPzws8JLrOKT/RBppZQ+kb0RkM/K0j/
         qRok4H1LOKUSPN1Dz1DKjq4tVSKqkZ212jNl52wxcH5swssJNBzjSdKd599OfR7KqAvN
         E4BQ==
X-Gm-Message-State: AOAM532FLDm4TfvZTJZDYG6L1YmVgjC5kGBhEzQWVjst7IRU3P65IM7E
        HJ0fye+GRPqiGDGwecOHEdZDS5zenA==
X-Google-Smtp-Source: ABdhPJxr8iWU9tcA8f9QiW5hksbb0r4GfT178XXuYvyfsn71Bb1lS4SgSL5HWA6YlCdJxbWk836ueVS2jg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:4b34:: with SMTP id s20mr30490550qvw.51.1600694803653;
 Mon, 21 Sep 2020 06:26:43 -0700 (PDT)
Date:   Mon, 21 Sep 2020 15:26:04 +0200
In-Reply-To: <20200921132611.1700350-1-elver@google.com>
Message-Id: <20200921132611.1700350-4-elver@google.com>
Mime-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific implementation details for KFENCE and enable
KFENCE for the arm64 architecture. In particular, this implements the
required interface in <asm/kfence.h>. Currently, the arm64 version does
not yet use a statically allocated memory pool, at the cost of a pointer
load for each is_kfence_address().

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
For ARM64, we would like to solicit feedback on what the best option is
to obtain a constant address for __kfence_pool. One option is to declare
a memory range in the memory layout to be dedicated to KFENCE (like is
done for KASAN), however, it is unclear if this is the best available
option. We would like to avoid touching the memory layout.
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/kfence.h | 39 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c           |  4 ++++
 3 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/include/asm/kfence.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..1acc6b2877c3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KFENCE if (!ARM64_16K_PAGES && !ARM64_64K_PAGES)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
new file mode 100644
index 000000000000..608dde80e5ca
--- /dev/null
+++ b/arch/arm64/include/asm/kfence.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_KFENCE_H
+#define __ASM_KFENCE_H
+
+#include <linux/kfence.h>
+#include <linux/log2.h>
+#include <linux/mm.h>
+
+#include <asm/cacheflush.h>
+
+#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"
+
+/*
+ * FIXME: Support HAVE_ARCH_KFENCE_STATIC_POOL: Use the statically allocated
+ * __kfence_pool, to avoid the extra pointer load for is_kfence_address(). By
+ * default, however, we do not have struct pages for static allocations.
+ */
+
+static inline bool arch_kfence_initialize_pool(void)
+{
+	const unsigned int num_pages = ilog2(roundup_pow_of_two(KFENCE_POOL_SIZE / PAGE_SIZE));
+	struct page *pages = alloc_pages(GFP_KERNEL, num_pages);
+
+	if (!pages)
+		return false;
+
+	__kfence_pool = page_address(pages);
+	return true;
+}
+
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	set_memory_valid(addr, 1, !protect);
+
+	return true;
+}
+
+#endif /* __ASM_KFENCE_H */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f07333e86c2f..d5b72ecbeeea 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/extable.h>
+#include <linux/kfence.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
@@ -310,6 +311,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	    "Ignoring spurious kernel translation fault at virtual address %016lx\n", addr))
 		return;
 
+	if (kfence_handle_page_fault(addr))
+		return;
+
 	if (is_el1_permission_fault(addr, esr, regs)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
-- 
2.28.0.681.g6f77f65b4e-goog

