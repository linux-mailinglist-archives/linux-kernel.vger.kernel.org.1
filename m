Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7142F7BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbhAONEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbhAONEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:04:23 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89EC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:43 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id h21so2957842wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0Sfvm3HijLTxMIkalgPZehN/JMQjFZGSx3Id5apZcBk=;
        b=uPrTay/imcPULPNls0Mtk1WZkZoq/HSa2GtNhwnLAZ4/7vKSh6Z2BhjbC16uPDnBJc
         Pyav+84MX3O+j6zJGBdHTfyajgZxnJ4BQUfVVuf2aqP9d4dbdgk9duMPjwLg01VOR2iq
         DBjdYljZlnVpt8G1+MWE5etRwEO/rNMH241Yu0fT9nAMZruspL3O5mH+FzaeN8JP2xLf
         2aOZP2rNIKZB7KViJeesmg1gEo0AabTd6jO/iWd7bbChPKR2P5iGDCoEDkQtrhAIq/bn
         Mzgv3Ci/ZrQan7CtzP7eUnaaHiBx1uyowDA/uCAV3AyKS6oWTCfv/r1IKWo0L6sV6Hx1
         FEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0Sfvm3HijLTxMIkalgPZehN/JMQjFZGSx3Id5apZcBk=;
        b=A3GmVWUS++s77A0pJeDy9qYI20y/8lo8pZHkQcBDcv3K2XZ0o9YaSF2rfcK+kOM8a8
         sU+37lS6GrGYEbZv8NsKy/Jle9jZuVj8HsEfkhh7/gZNFg8+Ut6Y3ncuneHhj/zRAlO1
         YBPphTVP5mq1JVs+Ml9tamf+Djv7cuyog9wwOyTeLkNkQF2czDXBVjRb97uSpBcOA8bo
         ApxGPoS0fyU6y6zaQZQeibII2dTpnK81Y6jxtKjAuRMOQYKswujhGgsS7vqXJU22UTBB
         8yJ0uIOK5ekyljIi3qws0B7URhTbrhY4JKCXkz8pqhpbTcxK73odZGHHJhJQkwG1Duyh
         RqbQ==
X-Gm-Message-State: AOAM533mclEdH7iKsP3V9qeJPQAR66j697J27DhseSGnfTlz+9VX2WTT
        VmOmQJWuGY/G999aEP0Mu94/XMZcRZbnjvk+++ucHi6HPp+Go1mtXw4DA2DdGaK935kAFTkavIJ
        4L2OcLGXj+aQYxRyVjlZmjfEftIp9GvHb8xUcTcw85AUQGcEsTs7XQYgxK9x29mpWTNvWBQ==
X-Google-Smtp-Source: ABdhPJwsPbgtxFhOrkkTGSft6oAz3er3XSA+s50wGbXmAapn6NAssDXnX9QGmjP4AKPQLDC0ZXkaDz5Z28I=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:adf:8342:: with SMTP id 60mr13209464wrd.140.1610715822120;
 Fri, 15 Jan 2021 05:03:42 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:03:32 +0100
In-Reply-To: <20210115130336.2520663-1-glider@google.com>
Message-Id: <20210115130336.2520663-2-glider@google.com>
Mime-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 1/5] tracing: add error_report trace points
From:   Alexander Potapenko <glider@google.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, glider@google.com, linux-mm@kvack.org
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
v2: - change error_report_start and error_report_end prototypes
      to accept enum error_detector instead of char*
      (as suggested by Steven Rostedt)
---
 include/trace/events/error_report.h | 84 +++++++++++++++++++++++++++++
 kernel/trace/Makefile               |  1 +
 kernel/trace/error_report-traces.c  | 11 ++++
 3 files changed, 96 insertions(+)
 create mode 100644 include/trace/events/error_report.h
 create mode 100644 kernel/trace/error_report-traces.c

diff --git a/include/trace/events/error_report.h b/include/trace/events/error_report.h
new file mode 100644
index 000000000000..bbf8543fc31a
--- /dev/null
+++ b/include/trace/events/error_report.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM error_report
+
+#if !defined(_TRACE_ERROR_REPORT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ERROR_REPORT_H
+
+#include <linux/tracepoint.h>
+
+#ifndef __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum error_detector {
+	ERROR_DETECTOR_KFENCE,
+	ERROR_DETECTOR_KASAN
+};
+
+#endif /* __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY */
+
+#define error_detector_list	\
+	EM(ERROR_DETECTOR_KFENCE, "kfence")	\
+	EMe(ERROR_DETECTOR_KASAN, "kasan")
+/* Always end the list with an EMe. */
+
+#undef EM
+#undef EMe
+
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+error_detector_list
+
+#undef EM
+#undef EMe
+
+#define EM(a, b) { a, b },
+#define EMe(a, b) { a, b }
+
+#define show_error_detector_list(val) \
+	__print_symbolic(val, error_detector_list)
+
+DECLARE_EVENT_CLASS(error_report_template,
+		    TP_PROTO(enum error_detector error_detector, unsigned long id),
+		    TP_ARGS(error_detector, id),
+		    TP_STRUCT__entry(__field(enum error_detector, error_detector)
+					     __field(unsigned long, id)),
+		    TP_fast_assign(__entry->error_detector = error_detector;
+				   __entry->id = id;),
+		    TP_printk("[%s] %lx",
+			      show_error_detector_list(__entry->error_detector),
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
+	     TP_PROTO(enum error_detector error_detector, unsigned long id),
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
+	     TP_PROTO(enum error_detector error_detector, unsigned long id),
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

