Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712BD28D00B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgJMOSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgJMOSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:05 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A1624802;
        Tue, 13 Oct 2020 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598684;
        bh=W4KQ+Y2wW3gz49IeWayddSXsmF60Q6fCDuI0p+XVnOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=jlL/Bx1j8jRcAGJMuXCZCPgs5Xm6xFzvwZ2pFAp3HvD/fke44BU9B/tkFWd3ODm+r
         neqgD+3q9GS1WebIBr4f9a8OUiIvVUyvAg832/A5HzeTPGlNPuJdZLnLxv6OgU+u/3
         6vkVUqjacBYLwGxxlPbwtCDlS3nJcTqzbVQ+K+Xw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] tracing: Move is_good_name() from trace_probe.h to trace.h
Date:   Tue, 13 Oct 2020 09:17:53 -0500
Message-Id: <cc6d6a2d7da6957fcbe1e2922e76d18d2bb459b4.1602598160.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
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

