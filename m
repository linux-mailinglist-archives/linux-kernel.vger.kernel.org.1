Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820BD2737F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgIVBZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgIVBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8052B23AF8;
        Tue, 22 Sep 2020 01:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX36-001sOc-Ib; Mon, 21 Sep 2020 21:24:52 -0400
Message-ID: <20200922012452.459753992@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 17/26] tracing/uprobes: Support perf-style return probe
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support perf-style return probe ("SYMBOL%return") for uprobe events
as same as kprobe events does.

Link: https://lkml.kernel.org/r/159972814601.428528.7641183316212425445.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace_uprobe.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca6da462326d..c35fcd2f2529 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5125,7 +5125,7 @@ static const char readme_msg[] =
   "place (kretprobe): [<module>:]<symbol>[+<offset>]%return|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
+  "   place (uprobe): <path>:<offset>[%return][(ref_ctr_offset)]\n"
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 56729c6b6614..3cf7128e1ad3 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -528,7 +528,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 /*
  * Argument syntax:
- *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS]
+ *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET[%return][(REF)] [FETCHARGS]
  */
 static int trace_uprobe_create(int argc, const char **argv)
 {
@@ -617,6 +617,19 @@ static int trace_uprobe_create(int argc, const char **argv)
 		}
 	}
 
+	/* Check if there is %return suffix */
+	tmp = strchr(arg, '%');
+	if (tmp) {
+		if (!strcmp(tmp, "%return")) {
+			*tmp = '\0';
+			is_return = true;
+		} else {
+			trace_probe_log_err(tmp - filename, BAD_ADDR_SUFFIX);
+			ret = -EINVAL;
+			goto fail_address_parse;
+		}
+	}
+
 	/* Parse uprobe offset. */
 	ret = kstrtoul(arg, 0, &offset);
 	if (ret) {
-- 
2.28.0


