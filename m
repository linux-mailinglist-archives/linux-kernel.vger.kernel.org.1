Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E9280B23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgJAXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbgJAXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:50 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE706C0613E7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 99so257975qva.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xi5PXBDKSbfXQXlBbsevZkyVwMa3nBoVlbAwrLjnULM=;
        b=oXpZiZjCVysz1T7D6B2NPc2BR9HmgkrYkcXU5jtlKD0fu1tQWG+3nTj4tRpKCFJGE1
         sw3gwZhoHyvY0c63rx7e3hxjIyf+ZxMDsEnC5/R2ZrZysG63iu7UsjMi3zxuaZQ/5LVC
         UCTbrJzz22Q68LagJ9X/Ha1/etS/rXuMDRNcQmY4qv2bQb/RFBDQ+Pya9MOh48EfY5jx
         LSYMUL+LOybnr3lYOCxSYl11sa2+rLeioX/vVbFBDYo73iUdG0fQc9dI/SwTOPqjqU4N
         +cbdtMMYAmxJvijNYPHp0x3UQLL90ZkIFRkfArP6w017Lh9xj8U+mshSy4AigB2MDXho
         xjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xi5PXBDKSbfXQXlBbsevZkyVwMa3nBoVlbAwrLjnULM=;
        b=oKKjOqr5SSznK7oGpxwzx9ecRMLgHglYlQRQ62tJv4fruILlaAcYL1KFng3sEkk7L8
         kjpmkw4Nx5hLDOtbOIUeN4JyrPgPDQxqu56Vh20OWJcClSnwkcX4hg/4/WZwB4/IuTZf
         2/S3BECWDyRO/j156k2TSNtz9Bg7aBP0kCfiwtuneqVEyn/gQokGYC9GLyN5Q8VlZXRd
         oWCS6EbZQAOPH9LXcVYRONl3q4dA6aVKyQF8eD3iXDUHsjaWvgmMesfkx9dLA2rBk/ns
         vyw1F/Ozd8c6lTzCuDW31UK54sWAgZGgEcSSLE7Wvale99GSnu5PuYRF6nyD41SlIb8x
         LBqQ==
X-Gm-Message-State: AOAM532aK37dfcw5XFzy8jAC5yRSFwLxXKKvcOYIkH/4j6kF5n2jeurr
        Kg5fTjXmuWCU+BcbNT5/+WAVx3b8nVhn5o/V
X-Google-Smtp-Source: ABdhPJwOLLy57aoFTySFQ2lUaailhzuK4DZkkauxAS2dvvNhCm7Rcg457kjyjCJ5NnrRoaWBRzcrneMoL18ZePzo
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr10157699qvx.48.1601593907080; Thu, 01 Oct 2020 16:11:47 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:27 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <1466ded7cb14ef17258b12a17129d2ca62f81911.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 26/39] arm64: mte: Add in-kernel tag fault handler
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add the implementation of the in-kernel fault handler.

When a tag fault happens on a kernel address:
* MTE is disabled on the current CPU,
* the execution continues.

When a tag fault happens on a user address:
* the kernel executes do_bad_area() and panics.

The tag fault handler for kernel addresses is currently empty and will be
filled in by a future commit.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I9b8aa79567f7c45f4d6a1290efcf34567e620717
---
 arch/arm64/include/asm/uaccess.h | 23 +++++++++++++++++++
 arch/arm64/mm/fault.c            | 38 +++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 991dd5f031e4..c7fff8daf2a7 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -200,13 +200,36 @@ do {									\
 				CONFIG_ARM64_PAN));			\
 } while (0)
 
+/*
+ * The Tag Check Flag (TCF) mode for MTE is per EL, hence TCF0
+ * affects EL0 and TCF affects EL1 irrespective of which TTBR is
+ * used.
+ * The kernel accesses TTBR0 usually with LDTR/STTR instructions
+ * when UAO is available, so these would act as EL0 accesses using
+ * TCF0.
+ * However futex.h code uses exclusives which would be executed as
+ * EL1, this can potentially cause a tag check fault even if the
+ * user disables TCF0.
+ *
+ * To address the problem we set the PSTATE.TCO bit in uaccess_enable()
+ * and reset it in uaccess_disable().
+ *
+ * The Tag check override (TCO) bit disables temporarily the tag checking
+ * preventing the issue.
+ */
 static inline void uaccess_disable(void)
 {
+	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(0),
+				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
+
 	__uaccess_disable(ARM64_HAS_PAN);
 }
 
 static inline void uaccess_enable(void)
 {
+	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(1),
+				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
+
 	__uaccess_enable(ARM64_HAS_PAN);
 }
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a3bd189602df..d110f382dacf 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -33,6 +33,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/kprobes.h>
+#include <asm/mte.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
@@ -294,6 +295,11 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	do_exit(SIGKILL);
 }
 
+static void report_tag_fault(unsigned long addr, unsigned int esr,
+			     struct pt_regs *regs)
+{
+}
+
 static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
@@ -641,10 +647,40 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 0;
 }
 
+static void do_tag_recovery(unsigned long addr, unsigned int esr,
+			   struct pt_regs *regs)
+{
+	static bool reported = false;
+
+	if (!READ_ONCE(reported)) {
+		report_tag_fault(addr, esr, regs);
+		WRITE_ONCE(reported, true);
+	}
+
+	/*
+	 * Disable MTE Tag Checking on the local CPU for the current EL.
+	 * It will be done lazily on the other CPUs when they will hit a
+	 * tag fault.
+	 */
+	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_NONE);
+	isb();
+}
+
+
 static int do_tag_check_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
-	do_bad_area(addr, esr, regs);
+	/*
+	 * The tag check fault (TCF) is per EL, hence TCF0 affects
+	 * EL0 and TCF affects EL1.
+	 * TTBR0 address belong by convention to EL0 hence to correctly
+	 * discriminate we use the is_ttbr0_addr() macro.
+	 */
+	if (is_ttbr0_addr(addr))
+		do_bad_area(addr, esr, regs);
+	else
+		do_tag_recovery(addr, esr, regs);
+
 	return 0;
 }
 
-- 
2.28.0.709.gb0816b6eb0-goog

