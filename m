Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7442F7BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbhAONFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388203AbhAONFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:05:02 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB87C061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:52 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m8so7581045qvk.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hLav+6cEwiPVPNQ10H8mUnfXDXSTPqRFsNjQotE+jzA=;
        b=Sh2HR2ssv22qj/Ox0Y413CCPV307dbT5KXC2u/9JMQT47kKYkHhqe+TBznrMD4j545
         zwfZJu/moFJjgslO5+Z7LAOidJv6WifGvAYC/7O4n9t6th4ICiC0SvHHnnCfnPF8gY+0
         0/vyBQtKyVn2YEGQ2MU95deZJIvVOgVPz5W0KVc8OCqTyv3V5UOECCjA2LYhdyxphVg8
         7PsWmj//xJCAdfcM/cpfBMzQD/jP4Ondyz4a5K1SXb9h1Trm/kOFV2OmmXzkmbq7ACwV
         27N3pJtJHvUV/aSDWZqoQMgMRQJdenMHlImacDTD1pXymW4TyqHp9jgfrUibN88WBRKv
         2F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hLav+6cEwiPVPNQ10H8mUnfXDXSTPqRFsNjQotE+jzA=;
        b=intmz49HbaBsjW49PUr26tempnRGNYsX7+8uVh+/aoKW+KqFJCqxmuXBqZX88QBMmC
         46eViR1r7NLJpnrUsABrIhgEMn/Ro3eGz37zHMsgt8AH4qroOABztbkIALOfZl+SFxw/
         3yjIK6f9dG0X1/00d4+61VP6hQCCdTVOk2k2zryfZzQkUSNyF5Zu3eSPRrC0mbCPnnL2
         z1u5/Eif7ak+CNBDywFL/gl8iZaUhK8RNefV63S2esm9EgincqeRhHMnpIy0pz34Sjex
         Qu67eqG9pBGfnwsCGk0UjbrHdE6AMdsaYffbZRkCqyNDzj9OCcpL54BleTaMOWBTi/YZ
         p4YA==
X-Gm-Message-State: AOAM530aC4obhIFMEy2w5umocb5o/sAzfDS1nrjR5ZBj4Aj/aWl+K9fN
        zTskjUXkEeSDmsKSIUNTcG0ln51Iir3VgE81aueWvLJ2slTDz2+HCwJaUmwfXJCzKd80TJRFGR7
        BUYQcqFHXkKw9f0EMJloxoslS5bIKzTB9GBnfWS+n69tKMKZaS9UZx+s8mWSJ7cCDpE512g==
X-Google-Smtp-Source: ABdhPJwcxbW4F0oXAeIpK+OvuTtdxUQ7SsZtruNCXPi/u8cr2SIDC13l6xM4zNss2rTVBUqx4VJstHIKwJ8=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a05:6214:140d:: with SMTP id
 n13mr11772979qvx.45.1610715831400; Fri, 15 Jan 2021 05:03:51 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:03:36 +0100
In-Reply-To: <20210115130336.2520663-1-glider@google.com>
Message-Id: <20210115130336.2520663-6-glider@google.com>
Mime-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 5/5] kasan: use error_report_start and error_report_end tracepoints
From:   Alexander Potapenko <glider@google.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, glider@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to trace KASAN error reporting (in particular, for
compatibility with CONFIG_ERROR_REPORT_NOTIFY).

Suggested-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 - change error_report_start and error_report_end prototypes
   to accept enum error_detector instead of char*
   (as suggested by Steven Rostedt)
---
 mm/kasan/report.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c0fb21797550..78b8bbc84dc2 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
+#include <trace/events/error_report.h>
 
 #include <asm/sections.h>
 
@@ -74,7 +75,7 @@ static void print_error_description(struct kasan_access_info *info)
 
 static DEFINE_SPINLOCK(report_lock);
 
-static void start_report(unsigned long *flags)
+static void start_report(unsigned long *flags, unsigned long addr)
 {
 	/*
 	 * Make sure we don't end up in loop.
@@ -82,10 +83,12 @@ static void start_report(unsigned long *flags)
 	kasan_disable_current();
 	spin_lock_irqsave(&report_lock, *flags);
 	pr_err("==================================================================\n");
+	trace_error_report_start(ERROR_DETECTOR_KASAN, addr);
 }
 
-static void end_report(unsigned long *flags)
+static void end_report(unsigned long *flags, unsigned long addr)
 {
+	trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
@@ -348,14 +351,14 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 		kasan_update_kunit_status(current->kunit_test);
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
 
-	start_report(&flags);
+	start_report(&flags, (unsigned long)object);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	print_tags(tag, object);
 	pr_err("\n");
 	print_address_description(object, tag);
 	pr_err("\n");
 	print_memory_metadata(object);
-	end_report(&flags);
+	end_report(&flags, (unsigned long)object);
 }
 
 static void __kasan_report(unsigned long addr, size_t size, bool is_write,
@@ -385,7 +388,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	info.is_write = is_write;
 	info.ip = ip;
 
-	start_report(&flags);
+	start_report(&flags, addr);
 
 	print_error_description(&info);
 	if (addr_has_metadata(untagged_addr))
@@ -400,7 +403,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 		dump_stack();
 	}
 
-	end_report(&flags);
+	end_report(&flags, addr);
 }
 
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

