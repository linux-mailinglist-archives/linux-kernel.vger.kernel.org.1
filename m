Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC926B000
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgIOVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgIOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69858C0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 125so4109398qkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D8sG/cEP7djDLTapvipoPil4TaVPwtS1uBYZ8/rqMfU=;
        b=JLHBY9AgkNxAqLTKFWQdxcgJcgqdPUV3TxpRVzNYHFqfab1asZTfQTMH+AqvVnwgCH
         BnUUjUz0j3cp5q50TzevAEZDIAJ0lOMhBCpOnwtBSEh0VnSduULw/f/WRSJ73y/PSR3g
         wAtqSI76OkKjfWf3WP25K5JUjRztC3SdAV4hoFEGhsvOomwFaXZfyUboATVZWnH9zU6D
         TQIjujxm5SaToqhiVOXT9DXzAt8rmJsm0fOCCNW7HoJrb4YrW0Q0m8CDIdPkQBW+HfF8
         vXzn130goo1cQM6GpPk5iZ4YGlPC9oVunx0rEnt4NZEdRJcb4DVF1GJSyIHZDe5/ruiQ
         l/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D8sG/cEP7djDLTapvipoPil4TaVPwtS1uBYZ8/rqMfU=;
        b=hgJN2qiuxeUmZV+jcQaHxCfnypBKUxAQal3apLuHBJmjpOFK3lH7LQTLg44tR7QCyx
         KJErUcaN8okKonz1AyArm1P97vZCecQQwS3cfPv+BF9hBYNe/Sv6eMg4nn7unkUJG72Z
         zRaLTFu1akXX34BNdIplN2HwTjSoh99Z+1YJU0oJLSn+UBEv867fdt5k4YvA6dbifDPp
         n6wxOe5jBg6GWlzUzsQG2UxXQtGjw95aZEsajlDxXhwwchfn9KNH9WRY4jLJg4v+uq3w
         h+V1P1O/0Gw2qCLtoa717ab/K5AO8DI15R4sHTRvMCelMtBLMWOQoWt31M0VV1kDq5nM
         kCLw==
X-Gm-Message-State: AOAM531mHiBp9NWtSb6ntXB6wYC4fB6dEdL4X+8Iw0Uyw3+rxpyvy7XU
        ViqCjNHioZ3tJwqZgqAjggwx9QLGikDXLUmC
X-Google-Smtp-Source: ABdhPJzlRX414ae6dY3KcWoPCkTBwkZK3ld5YB1kdMEENNAIrBphNAvoJTIWKdIYK4+jfcGWQyTwv8zsQNqqfSmk
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:58e3:: with SMTP id
 di3mr3798476qvb.54.1600204665622; Tue, 15 Sep 2020 14:17:45 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:16 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <fb70dc86ccb3f0e062c25c81d948171d8534ee63.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 34/37] kasan, arm64: print report from tag fault handler
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

Add error reporting for hardware tag-based KASAN. When CONFIG_KASAN_HW_TAGS
is enabled, print KASAN report from the arm64 tag fault handler.

SAS bits aren't set in ESR for all faults reported in EL1, so it's
impossible to find out the size of the access the caused the fault.
Adapt KASAN reporting code to handle this case.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I3780fe7db6e075dff2937d3d8508f55c9322b095
---
 arch/arm64/mm/fault.c | 19 +++++++++++++------
 mm/kasan/report.c     | 11 ++++++++---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index cdc23662691c..ac79819317f2 100644
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
@@ -295,17 +296,23 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	do_exit(SIGKILL);
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
 static void report_tag_fault(unsigned long addr, unsigned int esr,
 			     struct pt_regs *regs)
 {
-	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
+	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
 
-	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
-	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
-	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
-			mte_get_ptr_tag(addr),
-			mte_get_mem_tag((void *)addr));
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
index c904edab33b8..34ef81736d73 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -65,9 +65,14 @@ static void print_error_description(struct kasan_access_info *info)
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
2.28.0.618.gf4bc123cb7-goog

