Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2913228C33A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbgJLUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbgJLUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:46:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879AEC0613DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:19 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u17so11428464qvt.23
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4P0nIsUWr4hug9uTHV4YbGNkHcxo9uGG3eroRt4rLtQ=;
        b=tK2nFqlN57/q71Tot88KthjVsgp3ftylfLLdqBnRG5+1mHcgjCLO7yEozlYm/HGAzF
         u0T1T8+6O/jAGiiOdff2OL13p/fvCzhmemS5M5WOLXtnqclFoxVh9BoKG4MYDsv1efJf
         ZsitIrLaug+l0v4LIv7Iy5zhvhrHmsANIYyA7UH4HvkvZicF/hxY76glhGOYHi4WLBae
         FRwSWk9yaH9yu3NuuowqoVK7V0Yaz7/rT3Oa/pGHSIkn0GZCGa9VS2XuyPXdlqI4huoa
         2Y6oCMJdSjlXFwTHyBp7kpYVxMdLDO3j58PXc97yv2iiO3wx3nBYt8JNMvr3st2uePSy
         VkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4P0nIsUWr4hug9uTHV4YbGNkHcxo9uGG3eroRt4rLtQ=;
        b=nn34usjbz/Sw2p/cYftkWFU5/sNYhSCepge2W/SIsTWncxFWkY9Nt2SBsvXI7xsfL0
         amV5yOCeU4SYPxAAwrgNRPzW3oXzQhPTcoHi1UMeG9jZPext54fbXQ9SL95VZlvlqRsJ
         bsvRiQBplKYyzeFwnLYd275AxNqz5ORZUXysSQxbr265AwxDo0Zyif/bErKaxeBUMT6B
         9Ki/MTJDBsxlTBwfIwcy73B0ct9Cv8iCfhVK+RHUIfuB9Fg5GSDNGnIyzshQLE53HsLh
         TE+Q564Sabv70DOxiAAK9SqyznD4oumoNwoOv+eoat3f8RDVDFB2N6AiWKLkWLpzaZ6h
         7q6w==
X-Gm-Message-State: AOAM531Al3ooKjuWRjU03bQqKaxhkHw0YXBL1+eBEltZoV0ZqIMA+ZLs
        ugla7Krr1IZ2HJbbAiR3ZQrfIT4O6N0U9fX0
X-Google-Smtp-Source: ABdhPJz77TKrsxVAoOnXQO0jvWsuPcjw3BjnjrDnfdxih5v5g1MOG1VkqmdyD3DmVZGH0OxARZCVtuug9rxwjQLW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr27782436qvb.17.1602535578726; Mon, 12 Oct 2020 13:46:18 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:42 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <7c8b0dcdf1cebeb0a596c7aa4be48863cc8b2c9b.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 36/40] kasan, arm64: print report from tag fault handler
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error reporting for hardware tag-based KASAN. When CONFIG_KASAN_HW_TAGS
is enabled, print KASAN report from the arm64 tag fault handler.

SAS bits aren't set in ESR for all faults reported in EL1, so it's
impossible to find out the size of the access the caused the fault.
Adapt KASAN reporting code to handle this case.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I3780fe7db6e075dff2937d3d8508f55c9322b095
---
 arch/arm64/mm/fault.c | 14 ++++++++++++++
 mm/kasan/report.c     | 11 ++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d110f382dacf..1c314e6f7918 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/kasan.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
@@ -295,10 +296,23 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	do_exit(SIGKILL);
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
 static void report_tag_fault(unsigned long addr, unsigned int esr,
 			     struct pt_regs *regs)
 {
+	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
+
+	/*
+	 * SAS bits aren't set for all faults reported in EL1, so we can't
+	 * find out access size.
+	 */
+	kasan_report(addr, 0, is_write, regs->pc);
 }
+#else
+/* Tag faults aren't enabled without CONFIG_KASAN_HW_TAGS. */
+static inline void report_tag_fault(unsigned long addr, unsigned int esr,
+				    struct pt_regs *regs) { }
+#endif
 
 static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3924127b4786..f8817d5685a7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -60,9 +60,14 @@ static void print_error_description(struct kasan_access_info *info)
 {
 	pr_err("BUG: KASAN: %s in %pS\n",
 		get_bug_type(info), (void *)info->ip);
-	pr_err("%s of size %zu at addr %px by task %s/%d\n",
-		info->is_write ? "Write" : "Read", info->access_size,
-		info->access_addr, current->comm, task_pid_nr(current));
+	if (info->access_size)
+		pr_err("%s of size %zu at addr %px by task %s/%d\n",
+			info->is_write ? "Write" : "Read", info->access_size,
+			info->access_addr, current->comm, task_pid_nr(current));
+	else
+		pr_err("%s at addr %px by task %s/%d\n",
+			info->is_write ? "Write" : "Read",
+			info->access_addr, current->comm, task_pid_nr(current));
 }
 
 static DEFINE_SPINLOCK(report_lock);
-- 
2.28.0.1011.ga647a8990f-goog

