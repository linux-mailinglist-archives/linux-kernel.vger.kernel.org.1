Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7A2F4761
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbhAMJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbhAMJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:17:49 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B12C06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:08 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i20so961527qvk.18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XzfaCNHUB3u0Xi2wro/cbX3HxJgdcymLpFgEMQn1EeM=;
        b=D/ltpYSY2gXKcSOhoEH+7aMmW9DFoOQBGhBEMDJ4QS9njGGEQ+UgvD50OFm7WCJiX5
         yGRfXzWPCiK/OxgUzjueN77kQfLhClaYsYkiLF4d4L8qq/oN4MTL7Bj4whF0lwwdFXGq
         vOeiKV0hfSHjks3r0uQ9MblnKoAcmMen4f7t4QSzOwJEJyc8damdK2f/AhX4tS06ga4N
         zJ3WzEbGl/Sgny/4jWxtwrIMobAkEb9bzIn99LBFf1J7S5EyhQJcLBsnf8NA6hJYHUY/
         fgeOqaVP7Ahwr3dgE/izElEMBlXWOOSfC8lhgm4M7rpAT3oqaTqSgAcxngL/L3UrLx/3
         h3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XzfaCNHUB3u0Xi2wro/cbX3HxJgdcymLpFgEMQn1EeM=;
        b=HEzf8jBQMAQZwvFctD7hXH4O8lk01BJTO8aYQPs5LLzSu9rfpc0TgUnTBLXOznftUU
         1lSVcPN/GhkvXDUTU/qrKGVcJu/VOU/79qWypksri/4hfSSJEOLBtaMZcC+TLHCGU+yu
         cnlPBOaUdOHS36YMG52T13VwWLakulIltn1fWV0qpcquxV4jADfwS7Bq9MZ72+s7GU4Z
         3lNlYdVZAArlvW25HZMhJ5mPk+ZhQlptTmEfNJr8tfFzX+MpTewbKu45MC2ui14czVCL
         HDO8Cd2VheAnQNaNDmZWE565a5hAPpaZ7OUlQAGoyxPz3T0mJ7Tt+GgBK16g7jSFrcey
         1pMg==
X-Gm-Message-State: AOAM532AGCCNkC7ZL/pM9OQyKkCkjWbyAvAYMJEqug6MEQezgey3m4c2
        Gczhg2zbznZDk+qDyeS3IItZ7c/ZZqo=
X-Google-Smtp-Source: ABdhPJxGEXOWLz12zW+XK9vcOJrU+ahfdiUUJDRxxYmBlkX4/voTJwUyqsSxNEb1r/QpLIRbF9BTV/M43LM=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a05:6214:a14:: with SMTP id
 dw20mr1243999qvb.43.1610529427925; Wed, 13 Jan 2021 01:17:07 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:16:56 +0100
In-Reply-To: <20210113091657.1456216-1-glider@google.com>
Message-Id: <20210113091657.1456216-4-glider@google.com>
Mime-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/4] kfence: use error_report_start and error_report_end tracepoints
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

Make it possible to trace KFENCE error reporting (in particular, for
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
 mm/kfence/report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 4dedc2ff8f28..5c063b5b2227 100644
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
+	trace_error_report_start("kfence", address);
 	/* Print report header. */
 	switch (type) {
 	case KFENCE_ERROR_OOB: {
@@ -232,6 +234,7 @@ void kfence_report_error(unsigned long address, struct pt_regs *regs,
 		show_regs(regs);
 	else
 		dump_stack_print_info(KERN_ERR);
+	trace_error_report_end("kfence", address);
 	pr_err("==================================================================\n");
 
 	lockdep_on();
-- 
2.30.0.284.gd98b1dd5eaa7-goog

