Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2722F7BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbhAONFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388204AbhAONFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:05:02 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF7C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:50 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id h25so277250wmb.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=954/Z+Hv6LNpyU9utqCctaUUru/bs3BWptIPfUnFtmI=;
        b=pm4+xcjwk+Pr+UXPk5mF0s3bJV0j+KWfPkIsrbpPDRrSGfSXWBhGeKkX90a+jelTbP
         KobHEq/XLzDeNe8BVOYEBsHJt+9fd4Fe6SXeDxDdH8twkCSYLrd6w5n9kb5cNWd2An61
         tGxF3QVINmmir4xsF/oOxOBZHJt6pgFg/Y/5XUxgAvDAH27gJb8dnxRW1eXv22rxVshe
         yiK42IHcUltxQuoaL3rkds8EwUjK149viM/GwhS7MDBL2Yv5nMWcUrRmeKkK/x6mUTSs
         TWyfFxXakDmtc0W2MI8DMYz5U3IuCtGiId61uFrkRxKcC/N8C8JsJAfp5Gp28rVv312K
         TOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=954/Z+Hv6LNpyU9utqCctaUUru/bs3BWptIPfUnFtmI=;
        b=FyJLPUYmM2VRHxD1bDXv1sp9JVwC9IwwIvGjwys6QkKBVwmvCRv34W0guMY5chC7A7
         m1qef3guz0PzJi0HvnCjHYuZiov7u/VjTsDYlkbYtw4OHGzTS4ZSyy1o4dhFE+o7cVHX
         G8A27KyX0ZLt5COWq9A/s+mSh8NcVf12gxdxst8CXoshLi+xZOqAefD3Cyyf6f+y6zlH
         26BY9w5Xy8LOWwFOYrhP3l91lHKDecYDFFHBBlXgSErfjxy4w/e4kTM1p4D8GfEIg8uG
         pzeCXamRVkFMxDJu0Y/NcvaGfZ0r2smw8IMccKjaaWQcSfB8JujMGE8dv5OR1xzTz9uo
         zl/A==
X-Gm-Message-State: AOAM533uKWkMreOGLRjzgcyxRSoYTZ3bC0mH8K4LKcFedVhmZx7dABjU
        cAiOqSXHtyGcfg3MqKGL3DHJnd/aoi3G8pNnkuO3fTiH/USDe9Lm2qUNv+2ENzahk6uXa91IowE
        nkwlmHrPOCsJZo1YgBXV/L+6MOVYXu5NOqo9BJyYwHHsxPY7/cngsu6EVzGGD4d/M90T+Ww==
X-Google-Smtp-Source: ABdhPJxtwFBxiD7OEYrh/qyl7LW2IZQ1kWN66X1jJsjmKqpZeYgm33eaNA3UEIbQL3cBZ7Drz1VxX8M5jug=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a1c:2c89:: with SMTP id s131mr934969wms.0.1610715829142;
 Fri, 15 Jan 2021 05:03:49 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:03:35 +0100
In-Reply-To: <20210115130336.2520663-1-glider@google.com>
Message-Id: <20210115130336.2520663-5-glider@google.com>
Mime-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 4/5] kfence: use error_report_start and error_report_end tracepoints
From:   Alexander Potapenko <glider@google.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, glider@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to trace KFENCE error reporting (in particular, for
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
 mm/kfence/report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 4dedc2ff8f28..bbe7dad5f249 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
+#include <trace/events/error_report.h>
 
 #include <asm/kfence.h>
 
@@ -184,6 +185,7 @@ void kfence_report_error(unsigned long address, struct pt_regs *regs,
 	lockdep_off();
 
 	pr_err("==================================================================\n");
+	trace_error_report_start(ERROR_DETECTOR_KFENCE, address);
 	/* Print report header. */
 	switch (type) {
 	case KFENCE_ERROR_OOB: {
@@ -232,6 +234,7 @@ void kfence_report_error(unsigned long address, struct pt_regs *regs,
 		show_regs(regs);
 	else
 		dump_stack_print_info(KERN_ERR);
+	trace_error_report_end(ERROR_DETECTOR_KFENCE, address);
 	pr_err("==================================================================\n");
 
 	lockdep_on();
-- 
2.30.0.284.gd98b1dd5eaa7-goog

