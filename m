Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7928F558
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgJOOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbgJOOza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:55:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E100622256;
        Thu, 15 Oct 2020 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602773729;
        bh=JuI0+whuWWdpA9fXLSqAkUlHRbVV2U1yWDWx1KgyrDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjtbaP6nY3a7nLiih1JDei5QPEzLV7NE4nRVOSrG+N6r6LwDHiBZYWzwl2RhsIhIa
         JXVEaa1AjL3031YaJ+41OzmNG3GYXONIOzjdXU85hbVMzu7RN9vAJRJQJTpZiHQLh5
         qiy55pSjBeAn1yvSyf0gUppKqWh1bPybscH7eALA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 3/3] tracing: Add ptr-hash option to show the hashed pointer value
Date:   Thu, 15 Oct 2020 23:55:25 +0900
Message-Id: <160277372504.29307.14909828808982012211.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160277369795.29307.6792451054602907237.stgit@devnote2>
References: <160277369795.29307.6792451054602907237.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracefs/options/hash-ptr option to show hashed pointer
value by %p in event printk format string.

For the security reason, normal printk will show the hashed
pointer value (encrypted by random number) with %p to printk
buffer to hide the real address. But the tracefs/trace always
shows real address for debug. To bridge those outputs, add an
option to switch the output format. Ftrace users can use it
to find the hashed value corresponding to the real address
in trace log.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/ftrace.rst |    6 ++++++
 kernel/trace/trace.c           |    3 +++
 kernel/trace/trace.h           |    1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 87cf5c010d5d..62c98e9bbdd9 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1159,6 +1159,12 @@ Here are the available options:
 	This simulates the original behavior of the trace file.
 	When the file is closed, tracing will be enabled again.
 
+  hash-ptr
+        When set, "%p" in the event printk format displays the
+        hashed pointer value instead of real address.
+        This will be useful if you want to find out which hashed
+        value is corresponding to the real value in trace log.
+
   record-cmd
 	When any event or tracer is enabled, a hook is enabled
 	in the sched_switch trace point to fill comm cache
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 75395293d8df..b88cccf224cd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3543,6 +3543,9 @@ const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
 	if (WARN_ON_ONCE(!fmt))
 		return fmt;
 
+	if (iter->tr->trace_flags & TRACE_ITER_HASH_PTR)
+		return fmt;
+
 	p = fmt;
 	new_fmt = q = iter->fmt;
 	while (*p) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 524502d1f60a..c34187bd22a9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1347,6 +1347,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
+		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\

