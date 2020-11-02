Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7C2A2F40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgKBQGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgKBQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:59 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FAC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:57 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w3so4492418wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=35WbJzPGlJ32SG4OmkQQICRjm1+Un7MaGRWzBQ2gFy8=;
        b=ReVmikUfyD35ZPa7hA8zZkwvxwA/5N8OqN4auSKNEZ9rVVWtp0EJoTybi+VzCtP2jp
         CPDFfxl55PnOIfXvOv37raQxHz8p9i2WhNdFvmcS1mpk13Y4mFxSGZPsa4PyNuUEC08p
         FEeFqir9iq0/DJYfPuAGWbHqFyrioDYpUXvjZ6XT4I/MnNU2KKkimPKlzRfBaNjatEYG
         zK4op1Kj6AIqZ/MJwI1j0Iar0T2h/5lcdIXXU9U8i//1Yj73pBnI0m2o3ZTtkH0YTce+
         3iS+OtmdE179QKxzlpL6R1UwUdrxgAUsBh+sma29bCsxbiMBVjd+rtoY/F/eL+wmifiQ
         dpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=35WbJzPGlJ32SG4OmkQQICRjm1+Un7MaGRWzBQ2gFy8=;
        b=LuN0zLFxFd4aUgtufFdSx+0K0abtb2/1Yq72I9chATKyxhiFM3Yr7LHeHSwU7z1Ed+
         SKtfcFxLt4bD+jR3ufGWD4SGIyHgitgM8QsljsSbt8vgQ9oLV08Ad6Tik6df94y1nZWJ
         xdMk5w9JSoxpqXBmskNMZm59Gw/ewVAEbxYZu+U/IyOZsceTUAMt60P5JlzRG3L1L/aQ
         qQmjMYGowKyGVkNW0SUo05LHH/Awyq0AoZpvbh7nRcilqTXaJiIEhBURA4iwAjvNXAJZ
         kGPhyR/05ojQ5MPooiJ2pMOpEG50eXa1Wf3zBs8on1e5nn1u8NeXtmBz8hF5YUneDKAr
         XDXw==
X-Gm-Message-State: AOAM533r/BiXaGlF0do+kKEgIpTdWJfzyIU2Pb0dKnZNz8oYCBy6/5uo
        2pxfVVP21HRigMj6V1w7FAa6YLlqIZ46GDAO
X-Google-Smtp-Source: ABdhPJxQI7fzcN6hDMp0RmZiP40ZK8WVYR15Oo87hSsXTGEB+onI1lJ/cn8A6qvfXvoM+/C+Z9vvyYf6Ghc12Kxq
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c845:: with SMTP id
 c5mr7825433wml.135.1604333156027; Mon, 02 Nov 2020 08:05:56 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:17 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <f31c5b0e68d839382d3dfb8c879ffb34cf5457fb.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 37/41] kasan, arm64: print report from tag fault handler
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

