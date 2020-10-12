Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148CE28C225
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgJLUSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgJLUSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:18:17 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA7321D81;
        Mon, 12 Oct 2020 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602533896;
        bh=W4KQ+Y2wW3gz49IeWayddSXsmF60Q6fCDuI0p+XVnOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gHnLMX6U7KOSresKUKBvyFOuuA/f8ZPYTCp02n3Nnc8rOFYO8rlaySyZmJvpFVRSo
         nPhtK+6MSIJPtTfVkPu9kqv0m9Rogxr03srvC0bEGTHgNOtzuggwsHAk4OHjoSggSG
         gevyHKqcF/OiDNbP3pw06uDb6HMmnoYU6R7VFIDo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] tracing: Move is_good_name() from trace_probe.h to trace.h
Date:   Mon, 12 Oct 2020 15:18:04 -0500
Message-Id: <cc6d6a2d7da6957fcbe1e2922e76d18d2bb459b4.1602533267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_good_name() is useful for other trace infrastructure, such as
synthetic events, so make it available via trace.h.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h       | 13 +++++++++++++
 kernel/trace/trace_probe.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5b0e797cacdd..a94852838491 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -19,6 +19,7 @@
 #include <linux/glob.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/ctype.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -2090,4 +2091,16 @@ static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
 	iter->pos = -1;
 }
 
+/* Check the name is good for event/group/fields */
+static inline bool is_good_name(const char *name)
+{
+	if (!isalpha(*name) && *name != '_')
+		return false;
+	while (*++name != '\0') {
+		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
+			return false;
+	}
+	return true;
+}
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 04d00987da69..2f703a20c724 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -16,7 +16,6 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/ctype.h>
 #include <linux/ptrace.h>
 #include <linux/perf_event.h>
 #include <linux/kprobes.h>
@@ -348,18 +347,6 @@ bool trace_probe_match_command_args(struct trace_probe *tp,
 #define trace_probe_for_each_link_rcu(pos, tp)	\
 	list_for_each_entry_rcu(pos, &(tp)->event->files, list)
 
-/* Check the name is good for event/group/fields */
-static inline bool is_good_name(const char *name)
-{
-	if (!isalpha(*name) && *name != '_')
-		return false;
-	while (*++name != '\0') {
-		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
-			return false;
-	}
-	return true;
-}
-
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
-- 
2.17.1

