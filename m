Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE52B284E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKMWSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgKMWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:54 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F02C061A4B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:48 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y1so4709428wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xaa+VV69xly6NtD9oDw0a4fgTp58XYd2+h3RtuHf6eE=;
        b=CWWbP+CrzKArtLZOHT697dIqhABlh9KFuDkDt6jVUfI1BP70ptWt0ekQM0OeYO5m0S
         APNUU1m1/gJ8g/NqB4fVaTWBJfhdHkuzJsJ0FMlinYFq13lLmMVFEpw2oDF8wrpOzib0
         19ofn1SgHBRtrBHUpRlY0C4w79GZ3dG1m38JQNg3Cv9D3s+EWna3qcOaI9s0fDJexrs7
         kS5gHTAxCc8BvY4GnZyUEHmoFS/r5JKyTGOt3B3cQJ/xIYGs3FD3L8SWeMvE5NqX9V+e
         48AGiSiZKTgy8sK2/RnKMaHHfA3Kn+O6Ee9oqk9knT16CM65kb46rHJ4KVr3X5GmxA5R
         3K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xaa+VV69xly6NtD9oDw0a4fgTp58XYd2+h3RtuHf6eE=;
        b=BvcOXqkrpEXks+BN1UXXVshFDCg2ITqgC9vUnKzNiRVfme+vN7QxigVGRi7Cr7E1xB
         duuf4x1yND4RJ7ppWTnVama3vS4wvhKHl61luPHFSzC+cC+hkZgJ13DCCsAQz8zFjTV3
         QQ29SXylz85w8lR1KBD1i36jtCINlr4neeimjLQYqdqYErory0y2ohRV0UDzEB1XNia2
         E6NQ2Lf2pJ30lbLYtk2dnv2ukfAeAHhe0aw8Kr3Ypy06VoWgVavN5LKGCZOOg3hQ0g1V
         Pd1vnq+OglN6tcGChq6fvQ9IHt2W3x44HFPQQ847RVi1id2CxR16QabfMpvKI6v0nna7
         4+2A==
X-Gm-Message-State: AOAM531/FI1Ln3Kqk0I5HAU4IAS3sHURrgMZa9tLCQ5DCIiLO+mAC8sr
        a06x0nIiFRKi+xIFbQJYYbjqC7TpJyHY9MKZ
X-Google-Smtp-Source: ABdhPJyBDyYC9/PGel4BR1xfmWz+Zxo/sGgPx5xYgIlAE1YLTmCpnV5Ly2Tz5BFPPp6zu5O3ZmwShvUgo7lwtogd
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e983:: with SMTP id
 h3mr5834862wrm.382.1605305866774; Fri, 13 Nov 2020 14:17:46 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:16:06 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <53055673bff17607e42bc518dd31b56cb3e2a3af.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 38/42] kasan, arm64: print report from tag fault handler
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
2.29.2.299.gdc1121823c-goog

