Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0144273800
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgIVBZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgIVBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E499723AC6;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sMg-Vi; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012451.863339519@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [for-next][PATCH 13/26] fgraph: Convert ret_stack tasklist scanning to rcu
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

It seems that alloc_retstack_tasklist() can also take a lockless
approach for scanning the tasklist, instead of using the big global
tasklist_lock. For this we also kill another deprecated and rcu-unsafe
tsk->thread_group user replacing it with for_each_process_thread(),
maintaining semantics.

Here tasklist_lock does not protect anything other than the list
against concurrent fork/exit. And considering that the whole thing
is capped by FTRACE_RETSTACK_ALLOC_SIZE (32), it should not be a
problem to have a pontentially stale, yet stable, list. The task cannot
go away either, so we don't risk racing with ftrace_graph_exit_task()
which clears the retstack.

The tsk->ret_stack management is not protected by tasklist_lock, being
serialized with the corresponding publish/subscribe barriers against
concurrent ftrace_push_return_trace(). In addition this plays nicer
with cachelines by avoiding two atomic ops in the uncontended case.

Link: https://lkml.kernel.org/r/20200907013326.9870-1-dave@stgolabs.net

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1af321dec0f1..5658f13037b3 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -387,8 +387,8 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 		}
 	}
 
-	read_lock(&tasklist_lock);
-	do_each_thread(g, t) {
+	rcu_read_lock();
+	for_each_process_thread(g, t) {
 		if (start == end) {
 			ret = -EAGAIN;
 			goto unlock;
@@ -403,10 +403,10 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 			smp_wmb();
 			t->ret_stack = ret_stack_list[start++];
 		}
-	} while_each_thread(g, t);
+	}
 
 unlock:
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
 		kfree(ret_stack_list[i]);
-- 
2.28.0


