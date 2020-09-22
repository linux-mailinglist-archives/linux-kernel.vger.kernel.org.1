Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED2273805
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgIVB0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbgIVBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A1C23A9D;
        Tue, 22 Sep 2020 01:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX36-001sNA-4k; Mon, 21 Sep 2020 21:24:52 -0400
Message-ID: <20200922012452.005374318@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 14/26] tracing/boot: Add per-instance tracing_on option support
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add per-instance tracing_on option, which will be useful with
traceon/traceoff event trigger actions. For example, if we
disable tracing_on by default and set traceon and traceoff on
a pair of events, we can trace functions between the pair of
events.

Link: https://lkml.kernel.org/r/159972811538.428528.2561315102284268611.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index fa0fc08c6ef8..d52d441a17e8 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -40,6 +40,16 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 			pr_err("Failed to set option: %s\n", buf);
 	}
 
+	p = xbc_node_find_value(node, "tracing_on", NULL);
+	if (p && *p != '\0') {
+		if (kstrtoul(p, 10, &v))
+			pr_err("Failed to set tracing on: %s\n", p);
+		if (v)
+			tracer_tracing_on(tr);
+		else
+			tracer_tracing_off(tr);
+	}
+
 	p = xbc_node_find_value(node, "trace_clock", NULL);
 	if (p && *p != '\0') {
 		if (tracing_set_clock(tr, p) < 0)
-- 
2.28.0


