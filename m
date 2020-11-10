Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741E62AE2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbgKJWNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733008AbgKJWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:46 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB10C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:44 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z13so240797wrm.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/sxzdyvi8KkfW5gspThP8KvseoTY7ROsnu5nrXDzCag=;
        b=Y/jR1dsz3MoDl81vp14eGReV4TFu4RPTWCiE9VTJYP+0EekPQ8C5H9S7rFJJO/fXaO
         kOEoYEtNVzGjZJ4o6dPnzIdEY9RHhVrMNRMZ8WclGzjHjFziL+WhwREtWD5faj2mztzV
         X2AYk88MyNLjRHStKHJ1brWfHeQVj36mZeXFNHZ3Cq0LnArt1MkCynqe9pXOSy1/VH3y
         dBPasok/sdJerOrwJ/8YpnPoeknOs1o6yh9zC/hc5bpWNoNbxC+FBZ7y4J8+WWeCId1h
         CNPgzY93DllUdq5tiTBubK5vlT9b4hHaVAW8RooWas7C7NM4PwE6e3mm3K8sD8Vck1mc
         vwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/sxzdyvi8KkfW5gspThP8KvseoTY7ROsnu5nrXDzCag=;
        b=j4Sj/eiPJ+YAfvxbDMpVBSGeyAHKpsZ2NKezk3C7o5bo+wH0RNcUqMnkHJ9Xda8DhU
         xXF9dX1y2FEoE9l3boKtK1mcL0AQm/uMvCduGrBFsFVwPcJLH/iOnUe1kvnlQYNQSYPD
         gNIoAhst3U7mMbFE0IzNbXiID+Q6qK2DoXHh5u4hZvUIxiMhNSHRU7wvSNRfq7FgDB55
         oeh4qxckCjL3RO9pmZ5ZClAc44J11XFfxm3LxNwoLCwIg3isPdGP2lNrCU6r7kX9XqGd
         S2ZIO/pdMbehe7bpNV37r5szCanAv/M0WHEGoAbc2X8XECc40TiKQhWLvlKSnD9j5+/F
         TW7w==
X-Gm-Message-State: AOAM531w22Qzp4BZ8NDLvjSFIGWCBeWSjDkImNShBSOn+bQqVmJaQWq0
        4f36F2XaMmwhZwSHHymg64nXr3zA8ua6BSUa
X-Google-Smtp-Source: ABdhPJwjLitPJuje4TriI9elVnHCZf9lAYnOrAzCOl08HXbRqejuwd4uq00Z5f6BYQz4oYR+we+b5AqvJh7lXdOX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:109:: with SMTP id
 o9mr25232534wrx.240.1605046362785; Tue, 10 Nov 2020 14:12:42 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:37 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <fe78d723ba64456d68754a944fa93fe4a25c730f.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 40/44] kasan, arm64: print report from tag fault handler
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
2.29.2.222.g5d2a92d10f8-goog

