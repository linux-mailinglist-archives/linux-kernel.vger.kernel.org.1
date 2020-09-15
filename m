Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8F26B7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgIPAaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIONrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:47:53 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC6FC061220
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:14 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id l15so1218477wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SxvDeyNmcNMA+Gji2vA/rr03EMZqbUrEGQF/tm1mQmw=;
        b=o71HNdv6DA6PlBzIM+uaF8z2m3O6QnjR7fFrIwTk8hGwPsQoHPNfBsi4j6RVOTV6rB
         QGcF2GHmu301W9XcwzPaoDPBszh7HLN2r1OIiFtQRGVFZnqyA2WsrMM1zgh6JFiNCqJr
         NvzWd/WwOgV6fmMR5uq/A4qmXqraWPjGFNRE6s/puLWVA8MCLDtoQoDvPZ0kQxE1qChb
         IOCBoE3v1vWdNeoekoIvAvNugpkzCPHfHoTpQXIAxPwGsvUJdJlFijp3tI0jQ0k3V4t2
         0FXj8e4gRWaJ3ZkSy6Yet3Tywb4OQfFmJbFzAps6z9Hko0ZQIsPi6+rl+DUaj1LgN5Wt
         MyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SxvDeyNmcNMA+Gji2vA/rr03EMZqbUrEGQF/tm1mQmw=;
        b=g4I4w3BYKylt9xNCTqWb9LWqkEUmXmJuHZ0BRfM+I3cWuEw8XHohoSboSRdBQvJlay
         Hk27HJSmntk5AGNqpf2QczX06VkPL1Fl0J+QXhS2Z6/vmwt1byRZYTyPmLwYA2I0ZfKL
         AZqogSBFCxMWzCNKofiHNde8eSI5aN8hCtarrKxiQ6Gj0Mq8kRROsJNvLnCcmYwLxRD7
         2TqCN0TLJmWqiWtzg1BrDgOIh3HSbGSI8viAV5aKX2NjzBae/8MOPZcZwRn+NM4XS4gV
         UxLWHodK+neZj3U2lr4pmAzfFQokvLUm6qpAIyaaDx1gHUF8kMEab0MOLntSZ2VNF/A7
         gUBA==
X-Gm-Message-State: AOAM532F81/f9FRzC43AbBIvgsU5OFfj9nkeaQuveCjHeEro8kulfcNz
        v4jXaB7ohKQDo5FUvXJAbYS0QRHNTA==
X-Google-Smtp-Source: ABdhPJwl0RFLWfJGwXPTH8kxWe6H1Id6npGQWxX1hTs9KXzpJGcEjMyA8kMwTptUfAmNgcKzKeCOFQa4gQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:adf:8b1d:: with SMTP id n29mr20637102wra.383.1600176065852;
 Tue, 15 Sep 2020 06:21:05 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:20:39 +0200
In-Reply-To: <20200915132046.3332537-1-elver@google.com>
Message-Id: <20200915132046.3332537-4-elver@google.com>
Mime-Version: 1.0
References: <20200915132046.3332537-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 03/10] arm64, kfence: enable KFENCE for ARM64
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, jannh@google.com,
        Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        cai@lca.pw, tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific implementation details for KFENCE and enable
KFENCE for the arm64 architecture. In particular, this implements the
required interface in <asm/kfence.h>. Currently, the arm64 version does
not yet use a statically allocated memory pool, at the cost of a pointer
load for each is_kfence_address().

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
2.28.0.618.gf4bc123cb7-goog

