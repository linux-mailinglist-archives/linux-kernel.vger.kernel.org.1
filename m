Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605872830AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgJEHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:13:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:10321 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJEHNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:39 -0400
IronPort-SDR: 4uwCJQp12IEVRp16vWotJD/bawqYlhiVYwyt9NQjD8WKvInHhL2Zjkn8JFQewLdXvBC2wOScTF
 +8Z8Fq4ga02g==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227479266"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227479266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:13:39 -0700
IronPort-SDR: WyCUaNSURm5gSYIIMIwN9N7IhHp3jGvsXmVta0jVXbmHlWWfqBatJPQiKR9iuSkzXbtTVAYSX4
 iPS8SYkgZDLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="309718089"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 00:13:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4/8] tracing: Add trace_export support for trace_marker
Date:   Mon,  5 Oct 2020 10:13:15 +0300
Message-Id: <20201005071319.78508-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
References: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Add the support to route trace_marker buffer to other destination
via trace_export.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/linux/trace.h | 1 +
 kernel/trace/trace.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 86033d214972..886a4ffd9d45 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -6,6 +6,7 @@
 
 #define TRACE_EXPORT_FUNCTION	BIT(0)
 #define TRACE_EXPORT_EVENT	BIT(1)
+#define TRACE_EXPORT_MARKER	BIT(2)
 
 /*
  * The trace export - an export of Ftrace output. The trace_export
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a40ee413123c..6048fba2f590 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -271,6 +271,7 @@ static struct trace_export __rcu *ftrace_exports_list __read_mostly;
 
 static DEFINE_STATIC_KEY_FALSE(trace_function_exports_enabled);
 static DEFINE_STATIC_KEY_FALSE(trace_event_exports_enabled);
+static DEFINE_STATIC_KEY_FALSE(trace_marker_exports_enabled);
 
 static inline void ftrace_exports_enable(struct trace_export *export)
 {
@@ -279,6 +280,9 @@ static inline void ftrace_exports_enable(struct trace_export *export)
 
 	if (export->flags & TRACE_EXPORT_EVENT)
 		static_branch_inc(&trace_event_exports_enabled);
+
+	if (export->flags & TRACE_EXPORT_MARKER)
+		static_branch_inc(&trace_marker_exports_enabled);
 }
 
 static inline void ftrace_exports_disable(struct trace_export *export)
@@ -288,6 +292,9 @@ static inline void ftrace_exports_disable(struct trace_export *export)
 
 	if (export->flags & TRACE_EXPORT_EVENT)
 		static_branch_dec(&trace_event_exports_enabled);
+
+	if (export->flags & TRACE_EXPORT_MARKER)
+		static_branch_dec(&trace_marker_exports_enabled);
 }
 
 static void ftrace_exports(struct ring_buffer_event *event, int flag)
@@ -6687,6 +6694,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	} else
 		entry->buf[cnt] = '\0';
 
+	if (static_branch_unlikely(&trace_marker_exports_enabled))
+		ftrace_exports(event, TRACE_EXPORT_MARKER);
 	__buffer_unlock_commit(buffer, event);
 
 	if (tt)
-- 
2.28.0

