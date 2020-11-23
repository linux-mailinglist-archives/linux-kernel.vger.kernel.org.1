Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D42C1638
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgKWUM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbgKWUJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:58 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DDC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:58 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id y1so151344wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a641qLXzuR11g6BMkmBPCphI45HnOtEuvC8VFs/i0oY=;
        b=neCUGBfUlBvzHcri54FWSxW9eFHJEi3CWU5DBAF4zPMCbuvfGwsZupN3DKSl4x2YO2
         7vqXobhxBlVc4efQ67niDqzzonPG6CmZ8lKtswsRFtHRB5S6KJ9BL9qLX1SY6jVRlK2J
         c8bK+1m7/xA2Uu4LJZyF6EdW29LWsdhb0mdcbLbKb1ISATTP9DZ4EW5trIjboNyfd7aC
         HYttI9r53xvHWS0nxs6X+83N2tlN7sqRPVBmyAHG05TyuIsDwicUrV8NPu7KlN4y34LU
         +ZxMuRL8VspB5gYyX/oM2BumjWXcbDi+SbTROi1rcPb8rDabu7K1Hw9NMV7Isx7hQ28t
         wgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a641qLXzuR11g6BMkmBPCphI45HnOtEuvC8VFs/i0oY=;
        b=f3lyczG3iBykLh4Gqg5fz/3s7O7c1cWdlsiodCJbtcQMFWkBueFdatOR17x0YEHGU/
         bTG/1HqKkChHS0/ll+xfsAT/o5AceahnrxfA+1f4pjOE3TVGYrue3ulCN8OqefOgs2/R
         H5M9DoXk7NKdbdkDw8kRBIm7tng9Vl4VnApEjgyMmEBGZ3RHFUQ85uaPc3VG1U018VXA
         +hCE1slX2qPAgyFMPR4sA+0oSZFdlshuK3MEjinaE2S85O2V6Wx0kO9PWtmnVltGZ+Xp
         ILie6fVIUDopF2UXN66r7ek3cfWsA3yxrOQw/KJk/gx3DJGaSusloIzAThmcVASnCXRL
         kP7w==
X-Gm-Message-State: AOAM532Cg2mdsq3pi2BNk72ofjlUEIywoQdPOr1oxDPzelH7eo5yrpzc
        Ual/P3vN8+ACvDtcDis4lOJ1xSRwbBS3zmEo
X-Google-Smtp-Source: ABdhPJzbUN3oGIDfvcDJArPlcXQTm+qdElAwFv2IDBGPxqRS3v2vpJpKfw3cPWg5H2l2qDnAYZ5sX0jh1Pa8TG1/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:bd0b:: with SMTP id
 n11mr580484wmf.111.1606162197472; Mon, 23 Nov 2020 12:09:57 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:08:02 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <b559c82b6a969afedf53b4694b475f0234067a1a.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 38/42] kasan, arm64: print report from tag fault handler
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
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
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I3780fe7db6e075dff2937d3d8508f55c9322b095
---
 arch/arm64/mm/fault.c | 14 ++++++++++++++
 mm/kasan/report.c     | 11 ++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1e4b9353c68a..3aac2e72f81e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/kasan.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
@@ -298,10 +299,23 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
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
index 2c503b667413..a69c2827a125 100644
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
2.29.2.454.gaff20da3a2-goog

