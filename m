Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5C2AFC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgKLBhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgKLAdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:33:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E0521534;
        Thu, 12 Nov 2020 00:33:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YP-00028O-Rr; Wed, 11 Nov 2020 19:33:33 -0500
Message-ID: <20201112003333.746297897@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Kees Cook <keescook@chromium.org>
Subject: [for-next][PATCH 04/17] pstore/ftrace: Add recursion protection to the ftrace callback
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a ftrace callback does not supply its own recursion protection and
does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
make a helper trampoline to do so before calling the callback instead of
just calling the callback directly.

The default for ftrace_ops is going to change. It will expect that handlers
provide their own recursion protection, unless its ftrace_ops states
otherwise.

Link: https://lkml.kernel.org/r/20201028115612.990886844@goodmis.org
Link: https://lkml.kernel.org/r/20201106023546.720372267@goodmis.org

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh  Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Meyer <thomas@m3y3r.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/pstore/ftrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 5c0450701293..816210fc5d3a 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -28,6 +28,7 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 				       struct ftrace_ops *op,
 				       struct pt_regs *regs)
 {
+	int bit;
 	unsigned long flags;
 	struct pstore_ftrace_record rec = {};
 	struct pstore_record record = {
@@ -40,6 +41,10 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 	if (unlikely(oops_in_progress))
 		return;
 
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
 	local_irq_save(flags);
 
 	rec.ip = ip;
@@ -49,6 +54,7 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 	psinfo->write(&record);
 
 	local_irq_restore(flags);
+	ftrace_test_recursion_unlock(bit);
 }
 
 static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
-- 
2.28.0


