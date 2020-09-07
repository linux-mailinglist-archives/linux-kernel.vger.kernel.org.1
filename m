Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D925F18A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 03:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIGBtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 21:49:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIGBtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 21:49:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D978CAB91;
        Mon,  7 Sep 2020 01:49:22 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rostedt@goodmis.org
Cc:     mingo@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] fgraph: Convert ret_stack tasklist scanning to rcu
Date:   Sun,  6 Sep 2020 18:33:26 -0700
Message-Id: <20200907013326.9870-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
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
2.26.2

