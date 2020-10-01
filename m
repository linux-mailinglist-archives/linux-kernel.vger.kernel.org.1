Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E063280B36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbgJAXMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbgJAXMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:12:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61262C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:12:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 99so258535qva.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C+iBtL4ZEIj4wTVvYUlhj1NgYSWcn9LosnxdDa1AU0o=;
        b=XXVH4kQG55Khi2Z7jL9kW2Fdqip0R4t0cH/RnmwrPuJyOQikLRcY12Day24OAyiT/m
         5h/ZlINyy6z+lqFF5JyfSJVEG0jppJvkE7JW+22pMjbR6lz2HvZDp9lzsyofaymXppjJ
         QbHFZ4HWdzdZ7eqEXmBEyBFcsy6jAY16pwKJ/6f5Ktx+cknzjH/MDl53I4mdl7lci8xX
         ZP01U3F/pGbdvBtUWxsw5Czmc/mX7XSr8WCrqmxSFqDwCnqTUPbiPxhenx77r5QC/a2x
         B2TTEWcUZ+O1DRB7zQuZfRJTKbtqPed78yy+aijDc7OYHUxMb31FAcrD6JqC6EWk9tbE
         P0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+iBtL4ZEIj4wTVvYUlhj1NgYSWcn9LosnxdDa1AU0o=;
        b=cI2+y6/W2cG2IIg+MCvBKjtlyOoEiFoc+6fjBRb3l+x3bE4XtjxQMDta0kHOb8m0xW
         Z9R93RPjZxmKfqZFXx7XTD+ZQRxHTEfuG1G3YpF/vM7UTVxBdAqgKGvmhd12oww0DBHq
         ZpNvMSk7OxYy3jnm4r5mlzApLghpwW86Tp042a/Ojw8M6Im5yQazCTdfA6yfhriNxRHc
         dHXbdpnkOftnEP/p382anOeZ1b+Uqq/IxE0C5IgzPEG3NhUri5MjLdcYydXv6mGL6AnE
         Xc/VVW5uqGMrlUOWmkzjWJeo6qUBEtyuI7zroJfJJAZ0khlXdQe5RfNVudK8OPzIP9aU
         xjLg==
X-Gm-Message-State: AOAM533D7EAzaE6Fc9mdW6Yw/J9lJEW0WWZtwOh9Ku93X/iE/eCOKSNJ
        t+m0UDXL83cCVhEeHuGCNFijkGD8mEr5B/pJ
X-Google-Smtp-Source: ABdhPJyg885EXfX3ouWrDZ3tzzRkhHvwow5BEJWu4RDHIMFNE96T5+bOe2UvHHZj/o2vT0rg7CrqANiTCXY4pz99
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:8f2:: with SMTP id
 dr18mr10070980qvb.49.1601593930474; Thu, 01 Oct 2020 16:12:10 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:37 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <10120a10ca12074ff3172c90e63678c27224b024.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 36/39] kasan, arm64: print report from tag fault handler
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
2.28.0.709.gb0816b6eb0-goog

