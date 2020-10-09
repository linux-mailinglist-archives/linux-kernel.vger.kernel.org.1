Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF580288C66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbgJIPRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389124AbgJIPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:17:18 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE38222C4;
        Fri,  9 Oct 2020 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602256637;
        bh=0DB8b6xztquhZ4g/UG/EC5UK288yLJ8G4+xvKgFSVn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Uz3sPS1RGh6uIj9JCNVXEDdUhVlJH94p07PL3jQknvO/QkBhS7SVhBf1PpKaHjR73
         2DADFwgUdEDc2SpIu9Qzjk30VD+73NAAIA/SiZFrcJ5t2ref80FytgLLo+Y+zhFpfD
         cE0j6g/jlIICPYUmEiZQ9vbx2GSgeyj+yusoPzy4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] tracing: Move is_good_name() from trace_probe.h to trace.h
Date:   Fri,  9 Oct 2020 10:17:08 -0500
Message-Id: <235fe1ca3bac2ab40f069f3e62788fc3ec768fea.1602255803.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
In-Reply-To: <cover.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_good_name() is useful for other trace infrastructure, such as
synthetic events, so make it available via trace.h.

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

