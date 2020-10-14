Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0628E589
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbgJNRi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389518AbgJNRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D9B22246;
        Wed, 14 Oct 2020 17:37:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiO-002yGA-JZ; Wed, 14 Oct 2020 13:37:28 -0400
Message-ID: <20201014173728.487767298@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 03/12] tracing/boot: Add ftrace.instance.*.alloc_snapshot option
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add ftrace.instance.*.alloc_snapshot option.

This option has been described in Documentation/trace/boottime-trace.rst
but not implemented yet.

ftrace.[instance.INSTANCE.]alloc_snapshot
   Allocate snapshot buffer.

The difference from kernel.alloc_snapshot is that the kernel.alloc_snapshot
will allocate the buffer only for the main instance, but this can allocate
buffer for any new instances.

Link: https://lkml.kernel.org/r/160234368948.400560.15313384470765915015.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 754e3cf2df3a..c22a152ef0b4 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -284,6 +284,12 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 		if (tracing_set_tracer(tr, p) < 0)
 			pr_err("Failed to set given tracer: %s\n", p);
 	}
+
+	/* Since tracer can free snapshot buffer, allocate snapshot here.*/
+	if (xbc_node_find_value(node, "alloc_snapshot", NULL)) {
+		if (tracing_alloc_snapshot_instance(tr) < 0)
+			pr_err("Failed to allocate snapshot buffer\n");
+	}
 }
 
 static void __init
-- 
2.28.0


