Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6D290CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393610AbgJPUWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393586AbgJPUWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:22:46 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5271720878;
        Fri, 16 Oct 2020 20:22:44 +0000 (UTC)
Date:   Fri, 16 Oct 2020 16:22:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Fix of mismatch section
Message-ID: <20201016162242.16434e2b@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing: Fix mismatch section of adding early trace events

- Fixes the issue of a mismatch section that was missed due to gcc
  inlining the offending function, while clang did not (and reported
  the issue).


Please pull the latest trace-v5.10-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10-2

Tag SHA1: 39abab2b445c7e77fa0932a45e150c90ede54bd8
Head SHA1: ce66f6136460a51acfc32de4481fe8fd69dfd50b


Masami Hiramatsu (1):
      tracing: Remove __init from __trace_early_add_new_event()

----
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit ce66f6136460a51acfc32de4481fe8fd69dfd50b
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Fri Oct 16 13:20:02 2020 +0900

    tracing: Remove __init from __trace_early_add_new_event()
    
    The commit 720dee53ad8d ("tracing/boot: Initialize per-instance event
    list in early boot") removes __init from __trace_early_add_events()
    but __trace_early_add_new_event() still has __init and will cause a
    section mismatch.
    
    Remove __init from __trace_early_add_new_event() as same as
    __trace_early_add_events().
    
    Link: https://lore.kernel.org/lkml/CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com/
    
    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 851ab37058dd..e705f06c68c6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2498,7 +2498,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
  * for enabling events at boot. We want to enable events before
  * the filesystem is initialized.
  */
-static __init int
+static int
 __trace_early_add_new_event(struct trace_event_call *call,
 			    struct trace_array *tr)
 {
