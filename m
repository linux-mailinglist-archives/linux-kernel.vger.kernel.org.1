Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D318C2737E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgIVBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591B123A9C;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sKj-D4; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012451.287690722@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [for-next][PATCH 09/26] tracing: Delete repeated words in comments
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop repeated words in kernel/trace/.
{and, the, not}

Link: https://lkml.kernel.org/r/20200807033259.13778-1-rdunlap@infradead.org

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c             | 2 +-
 kernel/trace/trace.c              | 2 +-
 kernel/trace/trace_dynevent.c     | 2 +-
 kernel/trace/trace_events_synth.c | 2 +-
 kernel/trace/tracing_map.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 603255f5f085..84f32dbc7be8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2402,7 +2402,7 @@ struct ftrace_ops direct_ops = {
  *
  * If the record has the FTRACE_FL_REGS set, that means that it
  * wants to convert to a callback that saves all regs. If FTRACE_FL_REGS
- * is not not set, then it wants to convert to the normal callback.
+ * is not set, then it wants to convert to the normal callback.
  *
  * Returns the address of the trampoline to set to
  */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 29a9034b38d0..8fac7d6db222 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9287,7 +9287,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	}
 
 	/*
-	 * We need to stop all tracing on all CPUS to read the
+	 * We need to stop all tracing on all CPUS to read
 	 * the next buffer. This is a bit expensive, but is
 	 * not done often. We fill all what we can read,
 	 * and then release the locks again.
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 9442a9bb080e..5fa49cfd2bb6 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -402,7 +402,7 @@ void dynevent_arg_init(struct dynevent_arg *arg,
  * whitespace, all followed by a separator, if applicable.  After the
  * first arg string is successfully appended to the command string,
  * the optional @operator is appended, followed by the second arg and
- * and optional @separator.  If no separator was specified when
+ * optional @separator.  If no separator was specified when
  * initializing the arg, a space will be appended.
  */
 void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index f86a2aa0bccd..7c765e80e974 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1211,7 +1211,7 @@ __synth_event_trace_start(struct trace_event_file *file,
 	 * ENABLED bit is set (which attaches the probe thus allowing
 	 * this code to be called, etc).  Because this is called
 	 * directly by the user, we don't have that but we still need
-	 * to honor not logging when disabled.  For the the iterated
+	 * to honor not logging when disabled.  For the iterated
 	 * trace case, we save the enabed state upon start and just
 	 * ignore the following data calls.
 	 */
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 74738c9856f1..4b50fc0cb12c 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -260,7 +260,7 @@ int tracing_map_add_var(struct tracing_map *map)
  * to use cmp_fn.
  *
  * A key can be a subset of a compound key; for that purpose, the
- * offset param is used to describe where within the the compound key
+ * offset param is used to describe where within the compound key
  * the key referenced by this key field resides.
  *
  * Return: The index identifying the field in the map and associated
-- 
2.28.0


