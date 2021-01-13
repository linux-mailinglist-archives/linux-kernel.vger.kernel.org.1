Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D02F475C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhAMJRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbhAMJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:17:45 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:04 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id j5so645478wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fSzBeKXP0Nh8klQwaoWnqoqW21r9BnvxbYgVEskeqWs=;
        b=UaLVElNBweVx72KvGpJgtpmWaCqmMmu6qvX+GlVI4VwcXD9u7ZBdmq7KJ6cKg7U+Se
         JbSEXj6esp011RsM6SrrBM/Z37oVQzITPDyuGcM05To+x0oATeQSN/7TIcrNixBuGo6Z
         QMG9aV8Vyk/EBGIQ9hxYPGCkJ7ti7qMr8ycqGDIKhGTT3PijEJaVERzOOwwEjccGtlQO
         USXR9lOI7yFayytiGWhg8+YPf+a/C17wiLcGFg7PfTFnIbOHKXvexYfXKt1+gOJBpCPZ
         t6OQniYCIcAhdOsPlGNIwY8dq2Deip0KtYJL0aeRNRHUVD/GnqLQnF49xBSjeAVhI8wE
         dhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fSzBeKXP0Nh8klQwaoWnqoqW21r9BnvxbYgVEskeqWs=;
        b=a8OvGvyAGijQgZkZ6zoDP0O2zvncDFBj22Qp7RBhl8iI05aaouAmOInjy1Znj9Mzvk
         +PLa5ZduZ2yZ/R/wV1upvGstl47Y8pwifbnnPJB231bsY464/InL+Of1XogqtDxefYyM
         +pdR0qUmvuO1bKgQdngXQnzygK+iwvT1PTbiURU4h/HTXb1SNYpuehxHLclkHTdeFb1G
         hqhLjcMYr8lwGiaejbZH2Knn5Hs7xnNoqYeadlv+a1TedRm8aiuRGZX+YZP3jTbRMSH+
         /kethkNMn4qAnmZEVAKSS7vqR9yNE3p5sQIz67PwBOqbGZwyGskju3LOjNOkMp5L0bi0
         bGNg==
X-Gm-Message-State: AOAM531LDaBnaWlu8q64/Q9BcswHqtiNmxX8nXb8I3GvP7W7GBut+HiY
        RUHn4AEQTehLhgw0e0L9UDrT9s8cHrQ=
X-Google-Smtp-Source: ABdhPJw/KuNFkxyyB1KSEKTrztCAmdyBZRpgcGYjCMfnpeJSM7Q7rkVPtp4ci0zlvY3xOwMcFyI1RGqupKA=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a1c:6484:: with SMTP id y126mr1222870wmb.76.1610529423513;
 Wed, 13 Jan 2021 01:17:03 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:16:54 +0100
In-Reply-To: <20210113091657.1456216-1-glider@google.com>
Message-Id: <20210113091657.1456216-2-glider@google.com>
Mime-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/4] tracing: add error_report trace points
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

Introduce error_report_start and error_report_end tracepoints.
Those can be used in debugging tools like KASAN, KFENCE, etc.
to provide extensions to the error reporting mechanisms (e.g. allow
tests hook into error reporting, ease error report collection from
production kernels).
Another benefit would be making use of ftrace for debugging or
benchmarking the tools themselves.

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
 include/trace/events/error_report.h | 51 +++++++++++++++++++++++++++++
 kernel/trace/Makefile               |  1 +
 kernel/trace/error_report-traces.c  | 11 +++++++
 3 files changed, 63 insertions(+)
 create mode 100644 include/trace/events/error_report.h
 create mode 100644 kernel/trace/error_report-traces.c

diff --git a/include/trace/events/error_report.h b/include/trace/events/error_report.h
new file mode 100644
index 000000000000..bae0129031f0
--- /dev/null
+++ b/include/trace/events/error_report.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM error_report
+
+#if !defined(_TRACE_ERROR_REPORT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ERROR_REPORT_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(error_report_template,
+		    TP_PROTO(const char *error_detector, unsigned long id),
+		    TP_ARGS(error_detector, id),
+		    TP_STRUCT__entry(__field(const char *, error_detector)
+					     __field(unsigned long, id)),
+		    TP_fast_assign(__entry->error_detector = error_detector;
+				   __entry->id = id;),
+		    TP_printk("[%s] %lx", __entry->error_detector,
+			      __entry->id));
+
+/**
+ * error_report_start - called before printing the error report
+ * @error_detector:	short string describing the error detection tool
+ * @id:			pseudo-unique descriptor that can help distinguish reports
+ *			from one another. Depending on the tool, good examples
+ *			could be: memory access address, call site, allocation
+ *			site, etc.
+ *
+ * This event occurs right before a debugging tool starts printing the error
+ * report.
+ */
+DEFINE_EVENT(error_report_template, error_report_start,
+	     TP_PROTO(const char *error_detector, unsigned long id),
+	     TP_ARGS(error_detector, id));
+
+/**
+ * error_report_end - called after printing the error report
+ * @error_detector:	short string describing the error detection tool
+ * @id:			pseudo-unique descriptor, matches that passed to
+ *			error_report_start
+ *
+ * This event occurs right after a debugging tool finishes printing the error
+ * report.
+ */
+DEFINE_EVENT(error_report_template, error_report_end,
+	     TP_PROTO(const char *error_detector, unsigned long id),
+	     TP_ARGS(error_detector, id));
+
+#endif /* _TRACE_ERROR_REPORT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 7e44cea89fdc..b28d3e5013cd 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
+obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
 obj-$(CONFIG_TRACEPOINTS) += power-traces.o
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_TRACEPOINTS) += rpm-traces.o
diff --git a/kernel/trace/error_report-traces.c b/kernel/trace/error_report-traces.c
new file mode 100644
index 000000000000..80960c52c705
--- /dev/null
+++ b/kernel/trace/error_report-traces.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Error reporting trace points
+ */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/error_report.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(error_report_start);
+EXPORT_TRACEPOINT_SYMBOL_GPL(error_report_end);
+
-- 
2.30.0.284.gd98b1dd5eaa7-goog

