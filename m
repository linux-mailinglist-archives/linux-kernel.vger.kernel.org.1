Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475892737FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgIVBZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgIVBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB9923A8B;
        Tue, 22 Sep 2020 01:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX36-001sO8-E7; Mon, 21 Sep 2020 21:24:52 -0400
Message-ID: <20200922012452.322184057@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 16/26] tracing/kprobes: Support perf-style return probe
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support perf-style return probe ("SYMBOL%return") for kprobe events.
This will allow boot-time tracing user to define a return probe event.

Link: https://lkml.kernel.org/r/159972813535.428528.4437029657208468954.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace_kprobe.c | 18 +++++++++++++++++-
 kernel/trace/trace_probe.h  |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 55b829863127..ca6da462326d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5122,7 +5122,7 @@ static const char readme_msg[] =
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
-  "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
+  "place (kretprobe): [<module>:]<symbol>[+<offset>]%return|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
   "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f8e46929ceba..9d46415296eb 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -718,6 +718,9 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	 *      p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
 	 *  - Add kretprobe:
 	 *      r[MAXACTIVE][:[GRP/]EVENT] [MOD:]KSYM[+0] [FETCHARGS]
+	 *    Or
+	 *      p:[GRP/]EVENT] [MOD:]KSYM[+0]%return [FETCHARGS]
+	 *
 	 * Fetch args:
 	 *  $retval	: fetch return value
 	 *  $stack	: fetch stack address
@@ -747,7 +750,6 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	switch (argv[0][0]) {
 	case 'r':
 		is_return = true;
-		flags |= TPARG_FL_RETURN;
 		break;
 	case 'p':
 		break;
@@ -805,12 +807,26 @@ static int trace_kprobe_create(int argc, const char *argv[])
 		symbol = kstrdup(argv[1], GFP_KERNEL);
 		if (!symbol)
 			return -ENOMEM;
+
+		tmp = strchr(symbol, '%');
+		if (tmp) {
+			if (!strcmp(tmp, "%return")) {
+				*tmp = '\0';
+				is_return = true;
+			} else {
+				trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
+				goto parse_error;
+			}
+		}
+
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 			goto parse_error;
 		}
+		if (is_return)
+			flags |= TPARG_FL_RETURN;
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
 		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index a22b62813f8c..04d00987da69 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -404,6 +404,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
+	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\
 	C(BAD_GROUP_NAME,	"Group name must follow the same rules as C identifiers"), \
-- 
2.28.0


