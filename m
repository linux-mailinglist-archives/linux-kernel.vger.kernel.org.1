Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914EE29DEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403787AbgJ2A5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbgJ1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA04246DC;
        Wed, 28 Oct 2020 11:56:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXk3p-005ZI3-3t; Wed, 28 Oct 2020 07:56:13 -0400
Message-ID: <20201028115612.990886844@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 07:52:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4/9] pstore/ftrace: Add recursion protection to the ftrace callback
References: <20201028115244.995788961@goodmis.org>
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

The default for ftrace_ops is going to assume recursion protection unless
otherwise specified.

Cc: Thomas Meyer <thomas@m3y3r.de>
Cc: Kees Cook <keescook@chromium.org>
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


