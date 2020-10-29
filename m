Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C829F525
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgJ2T2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgJ2T1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1ACC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:35 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f9so2439605qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=A1ZDaKpC4XtGkLWbudlzWpby5nqFzQhbh548tIdxUT8=;
        b=fUnZ1HtLbb9IeH/WuZhF4kh/mpuV8GKZ4sfaw8gmpT3DtXn+eoOW6t5MtadjXyPBJA
         GbuwW72HDLVL/LBIpln1Y/FmdBa7hDinu/zBSArs/8xTzYU8QrQhLlN/FmpTcFr6R7wS
         Azo3Zk8BD8zYRiutNjHHEERhzxExiO0ZXduvWzgjtIytdct5UAbqqvEk6j/mxjffxWY8
         PZlo80tAsl+CdMScVidW9jzP2ZORihNd5NcsEOStsdjESDkbcDfpZL2mLnRfB+ZnT3xC
         YF3jtpPdeO/e7l2/MY9Fk6f69zcAO8IoHMVDFFN8jaNXG5Z+D1aJ46OUwKDiciDUAsBr
         mKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A1ZDaKpC4XtGkLWbudlzWpby5nqFzQhbh548tIdxUT8=;
        b=E9jcGkjqjmZ1XoOjTdlhdL5uPe5KboH3Kh5xsK0gDBVvK1FEzBMzZmon+GcsQCmszy
         RgIgcvqrH2eKpA060SU/Ny3fByvAqRvdlGnt/yPWi0vzrO8TcxvOz+EaLjhL3ANA0bSo
         Igdz7DBVr4D+F7BUvat/Wg77tGk6Xzs2vhNvzJfEph+eSqAx0NVQVyxUU6mZcqlV5Hp3
         9MOMEp2O5UuP+2Uwo55KeFfGRhrHR1nXwHr0CSDf9WIEYrNiCuiT+2DPHv6Etkg9aiTC
         Aq9w+VhcnhRcE6j1bMlyZ6K7b4C8Ff00TU0ni43PVwtbwjPO6JEGUCBi/e0D/2VLjC6N
         tdWg==
X-Gm-Message-State: AOAM532vn+gOVogMC3WMkxugP+udQkRhJidiTHp1SenpQ3GSG9u38k1v
        xAuXzARvcXnq5DQd4wOlTNf4r3sk27eg7cCm
X-Google-Smtp-Source: ABdhPJwHRtPyg4bynF4sOBBjCvEnrbWrbasDBEMWkJpSpQPilWl0rTB11giuF1s9Zi0lLuvUYnUKtBzNoIx02X2Q
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:40c6:: with SMTP id
 x6mr5883701qvp.20.1603999655065; Thu, 29 Oct 2020 12:27:35 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:57 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <d489548329132c789b86059e916c7996d07d3513.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 36/40] kasan, arm64: print report from tag fault handler
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
index 7be8f3f64285..e1be919f7f55 100644
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

