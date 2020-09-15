Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB526AFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgIOVfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgIOV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:27:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B24C061222
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:21 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j5so4092506qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8gCy5LzCrZ4Ippif5C2Kr6pI1Q8A3vPTLrXylwHP5Is=;
        b=vmOgCDX4Ovlo+g3q/YjlH2gzNXCBg6oYk1uHca7WFAJy0wEyxCaO7diA4/HQFhbfTm
         vZCxg8qtkEXtSmNVkwvmd3y9aPHfb1O3HzVcCMYG5GkvRSxpNmSqOEo731jm0j0k1tVu
         OEKw5b06tRh6HL9jAeFZXqBsP1qLSDni5lS66o6K10BKTIu2Gh3yDizNmuHcNyx++XHH
         tHYzDWRe+6TQkK1QpWT99yOl6ce7cDGFlAIEDlSgVkns9356jlEzO60Y5PwCulcoS0Vx
         tVwDbjoZHJktHkYmPTJ4GRQBmCpdAnlxFId4luoMymcP63yZ58/CEn/wg3c6xs89g66t
         gxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8gCy5LzCrZ4Ippif5C2Kr6pI1Q8A3vPTLrXylwHP5Is=;
        b=HcL1buzXo1nus8OxDjvvK9xNQ8aX6BRxyhOuu46zlu7VTd32XcABfFEQAzybnfRd73
         BbBpEfkz1HzhOdzRMVG6kMsWIQi7hcktodUa+LWll6nliUqbvR1stYkxPhNMHVZrG9Fz
         SAmEavnfgi7inC2MYkm9K8JsARjne7ACRrgmHEGwQMv0NX3Q8ABI6Cd8TxE82hRQUg3t
         J9JSPMsgMdtKwuGnlahzCwk3HUCIaKniqkn3CKF/1HxaPcKod71ToQA12IR0M/UU4v5/
         BdCsebyijMjHN8ZW5Zt/1DWppsrAzaB192AoIxvkpOKoGI6v67smljpOibJRsYEWDheM
         YJAw==
X-Gm-Message-State: AOAM5328Obt4ElXqz5nHYI6V88WPhvtMZ5R63J7YnA/WOcc9LFAAZZs7
        BizC/jVyPw3dW6/NPXHhtCwKAtMhB+VhLZDi
X-Google-Smtp-Source: ABdhPJx1hOhDWmjDE0HlzEorlVjxg9QmeE8fIeKQfK3gTvzMzRC6zTbmaUqg7dVWWCVncgIssdu5E4KU6Pu81Z6R
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5745:: with SMTP id
 q5mr19950252qvx.29.1600204640737; Tue, 15 Sep 2020 14:17:20 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:06 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <7866d9e6f11f12f1bad42c895bf4947addba71c2.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 24/37] arm64: mte: Add in-kernel tag fault handler
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add the implementation of the in-kernel fault handler.

When a tag fault happens on a kernel address:
* a warning is logged,
* MTE is disabled on the current CPU,
* the execution continues.

When a tag fault happens on a user address:
* the kernel executes do_bad_area() and panics.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I9b8aa79567f7c45f4d6a1290efcf34567e620717
---
 arch/arm64/mm/fault.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a3bd189602df..cdc23662691c 100644
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
@@ -294,6 +295,18 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	do_exit(SIGKILL);
 }
 
+static void report_tag_fault(unsigned long addr, unsigned int esr,
+			     struct pt_regs *regs)
+{
+	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
+
+	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
+	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
+	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
+			mte_get_ptr_tag(addr),
+			mte_get_mem_tag((void *)addr));
+}
+
 static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
@@ -641,10 +654,31 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 0;
 }
 
+static void do_tag_recovery(unsigned long addr, unsigned int esr,
+			   struct pt_regs *regs)
+{
+	report_tag_fault(addr, esr, regs);
+
+	/*
+	 * Disable Memory Tagging Extension Tag Checking on the local CPU
+	 * for the current EL.
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
+	/* The tag check fault (TCF) is per TTBR */
+	if (is_ttbr0_addr(addr))
+		do_bad_area(addr, esr, regs);
+	else
+		do_tag_recovery(addr, esr, regs);
+
 	return 0;
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

