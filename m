Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED072776FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgIXQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbgIXQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:40:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04DD923741;
        Thu, 24 Sep 2020 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600965612;
        bh=a+1LX1DnCur49Aq500Kist/V+ukd+P/EHhzeF/Zvxsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wvw8WZo23M62Szih8LrxyXURQ4kPRHKhmwddrgv9XjmVLmEz+grtlar3fe1vxRZCR
         38yqAxy6iS8i5wxpShUigNdlZtHvm0O2Dtd4u8WdL6cCCxEw5fV+bOjSJfLvDtEW4N
         czun17Qo2jD8Rpou/YWZdK/G1erwMlIm5g8dr0WY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/boot: Initialize per-instance event list in early boot
Date:   Fri, 25 Sep 2020 01:40:08 +0900
Message-Id: <160096560826.182763.17110991546046128881.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924085214.f2e901534037bede0bb55447@kernel.org>
References: <20200924085214.f2e901534037bede0bb55447@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize per-instance event list in early boot time (before
initializing instance directory on tracefs). This fixes boot-time
tracing to correctly handle the boot-time per-instance settings.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |    3 ++-
 kernel/trace/trace.h        |    1 +
 kernel/trace/trace_events.c |   30 ++++++++++++++++--------------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f7696db52e7d..400ed1ec3b64 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8700,7 +8700,8 @@ static struct trace_array *trace_array_create(const char *name)
 		ret = trace_array_create_dir(tr);
 		if (ret)
 			goto out_free_tr;
-	}
+	} else
+		__trace_early_add_events(tr);
 
 	list_add(&tr->list, &ftrace_trace_arrays);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e1b3061ce06d..5b887cfbe5ec 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1658,6 +1658,7 @@ extern void trace_event_enable_tgid_record(bool enable);
 extern int event_trace_init(void);
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
+extern void __trace_early_add_events(struct trace_array *tr);
 
 extern struct trace_event_file *__find_event_file(struct trace_array *tr,
 						  const char *system,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 720b0d72ea52..8ce334297bf3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3131,14 +3131,13 @@ static inline int register_event_cmds(void) { return 0; }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 /*
- * The top level array has already had its trace_event_file
- * descriptors created in order to allow for early events to
- * be recorded. This function is called after the tracefs has been
- * initialized, and we now have to create the files associated
- * to the events.
+ * The top level array and trace arrays created by boot-time tracing
+ * have already had its trace_event_file descriptors created in order
+ * to allow for early events to be recorded.
+ * This function is called after the tracefs has been initialized,
+ * and we now have to create the files associated to the events.
  */
-static __init void
-__trace_early_add_event_dirs(struct trace_array *tr)
+static void __trace_early_add_event_dirs(struct trace_array *tr)
 {
 	struct trace_event_file *file;
 	int ret;
@@ -3153,13 +3152,12 @@ __trace_early_add_event_dirs(struct trace_array *tr)
 }
 
 /*
- * For early boot up, the top trace array requires to have
- * a list of events that can be enabled. This must be done before
- * the filesystem is set up in order to allow events to be traced
- * early.
+ * For early boot up, the top trace array and the trace arrays created
+ * by boot-time tracing require to have a list of events that can be
+ * enabled. This must be done before the filesystem is set up in order
+ * to allow events to be traced early.
  */
-static __init void
-__trace_early_add_events(struct trace_array *tr)
+void __trace_early_add_events(struct trace_array *tr)
 {
 	struct trace_event_call *call;
 	int ret;
@@ -3290,7 +3288,11 @@ int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
 		goto out;
 
 	down_write(&trace_event_sem);
-	__trace_add_event_dirs(tr);
+	/* If tr already has the event list, it is initialized in early boot. */
+	if (unlikely(!list_empty(&tr->events)))
+		__trace_early_add_event_dirs(tr);
+	else
+		__trace_add_event_dirs(tr);
 	up_write(&trace_event_sem);
 
  out:

