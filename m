Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39D82A4DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgKCR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgKCR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:59:05 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D50C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:59:04 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h8so8117096wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EipKG0yUMWWV8YDScCe0e6tWyMQpyXBYPjRJqBhcvjE=;
        b=rhyK8dmeE4dr53sE/uFWlN822DH2Ol7TeauJlUCwqh+ZLQsbWqThh2kjRX2zk/paPH
         syHVvKdmaEtyOfdrMpsJQweFzziLkIb/Hk12rHvcTXldeC5fZki04zFMcZBI1sAEFD5Z
         XCwrDGuPC+IWcrKKBHAxkj+JLHrWsy+pe436HAI2geGW2qXuNbmqfoVnyyEaKMO0PJWV
         HGfir6YJZVg7TAUN8YD8wsnNaH5hZO/2fMYWREJQ02X8h+UyBFFZaJ2xlOSQqKoYHCw/
         Zw995f0aCY225MLi+FnNDAOWrKur5U9VO6RaMD0Wdpg3x8fCsj+qfoIyN5AvgqTEUJH9
         xTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EipKG0yUMWWV8YDScCe0e6tWyMQpyXBYPjRJqBhcvjE=;
        b=oM7NMtQeO6wc/GckhyEeMEX1zm+dCVjuCoJCjjEL3ZMmwEWa15E2N/6ZCKvIl5BEJw
         tttEAvPQFwumPb9oqvIFGpcphyOedJKaWPFkqif4N98RbrjIGEYHBcPI5jEy0qIHerSi
         ktj492VPWlX6i5Jf1mwUpn1xmU1JWni3+5qrHUcuNMJQNr48S//4Qwyiq51il82jJ+nx
         5plZSrxHxRo3OsjvYgJH6eOGQhV0IhpUVmKGrd0sFuiR5NJsrspKpXNxwqcyCdyYQSzP
         g/C2TWvmfPq285v81YPAfUOFWgAj346lPOVFv3DC88wcTghrzVNAoIx29DFNo0dUQBtX
         ndOQ==
X-Gm-Message-State: AOAM532RHFWSAoO0tQlE0I6GhqGYacg7kwBswUDkerEjFa2AcAsCMxl2
        TJjcRjaZsfeDXDyGQAI/5DTnfwSTTw==
X-Google-Smtp-Source: ABdhPJyhqKceIRNwBh1BUeRkNhloGmf2vhHYB+pCac/9CNlh5VLKBpOkM4qnvi8yfN9phagGWV06vmmobA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:c401:: with SMTP id k1mr353453wmi.120.1604426343066;
 Tue, 03 Nov 2020 09:59:03 -0800 (PST)
Date:   Tue,  3 Nov 2020 18:58:35 +0100
In-Reply-To: <20201103175841.3495947-1-elver@google.com>
Message-Id: <20201103175841.3495947-4-elver@google.com>
Mime-Version: 1.0
References: <20201103175841.3495947-1-elver@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 3/9] arm64, kfence: enable KFENCE for ARM64
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific implementation details for KFENCE and enable
KFENCE for the arm64 architecture. In particular, this implements the
required interface in <asm/kfence.h>.

KFENCE requires that attributes for pages from its memory pool can
individually be set. Therefore, force the entire linear map to be mapped
at page granularity. Doing so may result in extra memory allocated for
page tables in case rodata=full is not set; however, currently
CONFIG_RODATA_FULL_DEFAULT_ENABLED=y is the default, and the common case
is therefore not affected by this change.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v7:
* Remove dependency on page size [reported by Mark Rutland].
* fault normally on permission faults [reported by Jann Horn].

v5:
* Move generic page allocation code to core.c [suggested by Jann Horn].
* Remove comment about HAVE_ARCH_KFENCE_STATIC_POOL, since we no longer
  support static pools.
* Force page granularity for the linear map [suggested by Mark Rutland].
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/kfence.h | 19 +++++++++++++++++++
 arch/arm64/mm/fault.c           |  4 ++++
 arch/arm64/mm/mmu.c             |  7 ++++++-
 4 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kfence.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d466addb078..e524c07c3eda 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
new file mode 100644
index 000000000000..5ac0f599cc9a
--- /dev/null
+++ b/arch/arm64/include/asm/kfence.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_KFENCE_H
+#define __ASM_KFENCE_H
+
+#include <asm/cacheflush.h>
+
+#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"
+
+static inline bool arch_kfence_init_pool(void) { return true; }
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
index 1ee94002801f..2d60204b4ed2 100644
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
@@ -322,6 +323,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	} else if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
 	} else {
+		if (kfence_handle_page_fault(addr))
+			return;
+
 		msg = "paging request";
 	}
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1c0f3e02f731..86be6d1a78ab 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1449,7 +1449,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
 {
 	int ret, flags = 0;
 
-	if (rodata_full || debug_pagealloc_enabled())
+	/*
+	 * KFENCE requires linear map to be mapped at page granularity, so that
+	 * it is possible to protect/unprotect single pages in the KFENCE pool.
+	 */
+	if (rodata_full || debug_pagealloc_enabled() ||
+	    IS_ENABLED(CONFIG_KFENCE))
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-- 
2.29.1.341.ge80a0c044ae-goog

