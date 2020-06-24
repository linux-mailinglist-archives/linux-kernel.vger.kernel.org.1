Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338E206AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 05:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgFXDjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 23:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388187AbgFXDjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:39:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D602920874;
        Wed, 24 Jun 2020 03:39:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jnwG5-003u94-PN; Tue, 23 Jun 2020 23:39:33 -0400
Message-ID: <20200624033933.670764002@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 23:39:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 2/4] tracing/boot: Fix config dependency for synthedic event
References: <20200624033858.651927570@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since commit 726721a51838 ("tracing: Move synthetic events to
a separate file") decoupled synthetic event from histogram,
boot-time tracing also has to check CONFIG_SYNTH_EVENT instead
of CONFIG_HIST_TRIGGERS.

Link: http://lkml.kernel.org/r/159262475441.185015.5300725180746017555.stgit@devnote2

Fixes: 726721a51838 ("tracing: Move synthetic events to a separate file")
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 9de29bb45a27..8b5490cb02bb 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -120,7 +120,7 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 }
 #endif
 
-#ifdef CONFIG_HIST_TRIGGERS
+#ifdef CONFIG_SYNTH_EVENTS
 static int __init
 trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 {
-- 
2.26.2


