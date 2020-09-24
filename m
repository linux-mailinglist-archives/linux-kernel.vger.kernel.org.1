Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C682277C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgIXWwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIXWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:52:20 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEEC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:20 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so525246qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IS9ZsYB9v/N3vPDTIy5S5K93CUEmQWaPqYVbAcaV4Fc=;
        b=jrGnJ+BLVX2DGeyV3v1JNQNDzlUC17f3kY9X6E5RpjLJaLydCEzWkmgMXL0NsSaMxB
         PmjpePhqkc8O7JGOg7a6NQfB+IZDPSQ4LD9CwPpS3FkXgq5v/znChPI7qtlIDxJeSvje
         OuwMKk7NReJsxwEya6goAAcsIlJ+lsHec36JjNazWenTOBEDg+uh+fWkCiuPwpA8LiFR
         Odc+DD6rIi564nxV49JjESGZrSsVEeMyEejB4zM5z25sWjiRA6GYBQBsVjvdl0L7TcCN
         bX43rDpoYpxL3H84n4MF1/YUy1L/snlCH+tnLhbk6z2FiIMZdW/TTLOit2etkMZiDdws
         ehoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IS9ZsYB9v/N3vPDTIy5S5K93CUEmQWaPqYVbAcaV4Fc=;
        b=Wek5oC1oXyUnM8Jrq39EeJpGThBMt1Agx6Lw8F5eNGGlNfUHQ4VgJEj/ondo2NzsFD
         5g/ldWHK9cDTRuzm7+bizn7XE8R3iV3syudcTk0M0/niJPdFlmdS1gMZOHpqMHU9+R62
         Q4rQ23Xx088qdG3RMcr+oKj238Ah9sxl/pcGMifetWRcZ2lhDMXQjLI0WuU39dLU0D90
         wUK9aXf1+ptGEeMhfDySyKES1SoPzW87afD8og7uyXqxoYNUvK1IaA4rKvDXVaXYgh3m
         UiOJyksexn+iB74ZflLvXY1dRs8+7EE0nlmBpv9x0zRM7wFUPhkP7qlytDDX82WSW5Gi
         +wUw==
X-Gm-Message-State: AOAM531QWWkEAxXgcGeiwOxUYnOW5jRTETBvSdRlsCOnrKK2bxHeVqXs
        alu7YkNSDdrvaPtFrUmgmAObOvw9REaXnYtk
X-Google-Smtp-Source: ABdhPJxQ/I/jNcEo109DKYg6gHkYf5VlZZ9VYPUndBBhET15221vHySVXVhrSGq40bJcQH8Myf9ofF95KOD8rC3a
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b31c:: with SMTP id
 s28mr1643871qve.17.1600987939311; Thu, 24 Sep 2020 15:52:19 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:43 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <6296d106e480eed388f86e3c8fce10a14bead75a.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 36/39] kasan, arm64: print report from tag fault handler
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
2.28.0.681.g6f77f65b4e-goog

