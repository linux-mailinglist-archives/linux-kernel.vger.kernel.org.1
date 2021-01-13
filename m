Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765DE2F4764
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbhAMJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbhAMJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:18:18 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9946C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:11 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v7so651315wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pMSZunVusBFa2srMdPuW53fXoOwDSFeZUvebF05YN08=;
        b=d4C0PW5sZc0HlVWTO9j0oxt1OwJCzegOR6uDyERunOBnLuzZup+teT4aMNmJkI0FDn
         YRedWuQrB8arw/Jt5f8VUq/+QPbJDWhLsUjf1ZxaiubNyBX1+XCSQbCj1uQDXMeQkhp5
         GOvnj696GHLj2reYj7W8v95JYL5Vxhix7bSbLO6+LFHeyzUutxwmps9ehUheOdsomQdq
         fLmcjcKFWYgCaPfrwh4ypvmCy3SGwBt5fgt6xepe9j3qHUOtjqEkW3xbA/EILaM2WqSg
         W3Ni7DYvcAe0Z6iOax0ObnSz4PSTOvl4dBpwTNHucMLpFH1ZAnrA1c4dDYuhwm/E3rA2
         YgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pMSZunVusBFa2srMdPuW53fXoOwDSFeZUvebF05YN08=;
        b=ZzbjSEQHOmsQAlT+S1fdi05Baz2xBshiOp7aTe9cCgS1qh814thG3X8gcJAXE5Bqvm
         uMgFE1utBLqS9/oHOm4ycZlGMD4y4HMX23DNMgQZ7GoLIybTHBD876NNiIwh9rIeYy/S
         wQS4bEukd6I7VRMeTbGuV5QxzIxlKhMzqhPWVX0rh/OXz7vjVj1xMkV0X4rRXENpcxmL
         KF1xBZqfmd8b3AApeT8Mnop1nmpuuEcCyW8HHlaZam1bUcSUuHM0uRGPAbihcNbrTFxa
         UumuVYUrFyZ1HXFsL5U98CHpV1ojopqfpGp1vM7y1fT4FZDUe7LHLxsPlkm+VMWntL2K
         g32w==
X-Gm-Message-State: AOAM532FyI4fTX7rNC/aTto2OBczrxNY0eddGQnt81wU/A6CNtB5r+Im
        XelyoIgzwNlmN8zzDVaj8iNP5/ZtswY=
X-Google-Smtp-Source: ABdhPJz3jt64c/gcj+wvuQCEziz78fmMWTAdkDanZ1a8Y5QATUBLbztfMzxaMeklY7WCE2FLqh5B8RbPUvY=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a1c:5644:: with SMTP id k65mr1225748wmb.62.1610529430509;
 Wed, 13 Jan 2021 01:17:10 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:16:57 +0100
In-Reply-To: <20210113091657.1456216-1-glider@google.com>
Message-Id: <20210113091657.1456216-5-glider@google.com>
Mime-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 4/4] kasan: use error_report_start and error_report_end tracepoints
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to trace KASAN error reporting (in particular, for
compatibility with CONFIG_ERROR_REPORT_NOTIFY).

Suggested-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kasan/report.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c0fb21797550..fd015dd5dd39 100644
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
+	trace_error_report_start("kasan", addr);
 }
 
-static void end_report(unsigned long *flags)
+static void end_report(unsigned long *flags, unsigned long addr)
 {
+	trace_error_report_end("kasan", addr);
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

