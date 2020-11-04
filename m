Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5142A715D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbgKDXVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732910AbgKDXUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:41 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AACC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:41 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h16so67017qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=35WbJzPGlJ32SG4OmkQQICRjm1+Un7MaGRWzBQ2gFy8=;
        b=c0vkrlRIsEA2zaSNjedAHzaANOS3KnMfQBq5IN41oqi4DjS7urZr6IPPvJz9UxlmEd
         lW6pqmtub3Nyd6OWE074wEOgDmu0UT4Wg9dLQq1YfyblzwoMhnpPcJPwhNwUztvQe/+s
         0qkSYVBHDeocB/8qWuxyOvRYz4+sCZPsYugh312jIOu5bHNCzzWJke/Mc6ofThSTxC0F
         kHC1EPLi214qaGu9G+uHo4OXCWktBoIvmhhT7MoMSxNbqcFf+PP/FfggLNy6XC2iN0a2
         zLYJ1VgM1TTpUY5pGPAdOJ8/uoocPxBXoBWvqK0k0KAfoNZvU2Yl3nomO/+QsmiXyG1b
         sIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=35WbJzPGlJ32SG4OmkQQICRjm1+Un7MaGRWzBQ2gFy8=;
        b=Pfilegdfk9IdKnI9beSv6VzRU/vQVV/cY5+eDIxXTG+CJaO6AkxL+wAJpzghHeZDAO
         P71aSprzKhPGeHpdXzDCxY9RIW0/matVFaxosGoLy7ahUDU3Pzybn3fyspsQQ/o8bSPU
         gbSjHryQQJCewYowp8/P6S55uAWm1fcFc2zk6pE/WVyu6G6+Z1iY+IHQRik/fsSvCVDd
         3XVMH8pqLhQQmeyR7QXhueD0kmPUWindliskFkz7IXf+qRhViB/HQasyhLRhwku+dvSH
         x9fikX1COK7Abj83j5nLmHp8uJxhehFDgtBxp87FLPdNhxB9gt90Us4Gg5xq4fKzYZku
         nFcA==
X-Gm-Message-State: AOAM531FyeeZ70mgzrTq53ydTTvkBRi/r3hpE4jEttQV4g0qtXOi/UTy
        aE/eirDTU8j9jO/I7NKPrYYcaqfcC6fnXGRc
X-Google-Smtp-Source: ABdhPJyQywfWKbdX68bSu2ZPlot1uOmCpCTLZwOGAs9Gz57V7Cqqkk2XTA2l7zW1C/0FANx/P7/BsExHxmasuAN6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:55ea:: with SMTP id
 bu10mr283554qvb.28.1604532040493; Wed, 04 Nov 2020 15:20:40 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:54 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <4bde28cafd5ef30f4caf2bbeca90a9d7ccb73793.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 39/43] kasan, arm64: print report from tag fault handler
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
index fbceb14d93b1..7370e822e588 100644
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
@@ -297,10 +298,23 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
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
 
 static void do_tag_recovery(unsigned long addr, unsigned int esr,
 			   struct pt_regs *regs)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8afc1a6ab202..ce06005d4052 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -62,9 +62,14 @@ static void print_error_description(struct kasan_access_info *info)
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
2.29.1.341.ge80a0c044ae-goog

