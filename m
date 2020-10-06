Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AB284E17
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgJFOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37E92065C;
        Tue,  6 Oct 2020 14:35:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3a-002zAH-Qf; Tue, 06 Oct 2020 10:35:10 -0400
Message-ID: <20201006143510.691850632@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-linus][PATCH 01/15] ftrace: Fix some typos in comment
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/coorditate/coordinate/
s/emty/empty/
s/preeptive/preemptive/
s/succes/success/
s/carefule/careful/

Link: https://lkml.kernel.org/r/20201002143126.2890-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 84f32dbc7be8..123d520b9261 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -230,7 +230,7 @@ static void update_ftrace_function(void)
 	/*
 	 * For static tracing, we need to be a bit more careful.
 	 * The function change takes affect immediately. Thus,
-	 * we need to coorditate the setting of the function_trace_ops
+	 * we need to coordinate the setting of the function_trace_ops
 	 * with the setting of the ftrace_trace_function.
 	 *
 	 * Set the function to the list ops, which will call the
@@ -1451,7 +1451,7 @@ static bool hash_contains_ip(unsigned long ip,
 {
 	/*
 	 * The function record is a match if it exists in the filter
-	 * hash and not in the notrace hash. Note, an emty hash is
+	 * hash and not in the notrace hash. Note, an empty hash is
 	 * considered a match for the filter hash, but an empty
 	 * notrace hash is considered not in the notrace hash.
 	 */
@@ -2976,7 +2976,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		synchronize_rcu_tasks_rude();
 
 		/*
-		 * When the kernel is preeptive, tasks can be preempted
+		 * When the kernel is preemptive, tasks can be preempted
 		 * while on a ftrace trampoline. Just scheduling a task on
 		 * a CPU is not good enough to flush them. Calling
 		 * synchornize_rcu_tasks() will wait for those tasks to
@@ -4368,7 +4368,7 @@ void **ftrace_func_mapper_find_ip(struct ftrace_func_mapper *mapper,
  * @ip: The instruction pointer address to map @data to
  * @data: The data to map to @ip
  *
- * Returns 0 on succes otherwise an error.
+ * Returns 0 on success otherwise an error.
  */
 int ftrace_func_mapper_add_ip(struct ftrace_func_mapper *mapper,
 			      unsigned long ip, void *data)
@@ -4536,7 +4536,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 
 	/*
 	 * Note, there's a small window here that the func_hash->filter_hash
-	 * may be NULL or empty. Need to be carefule when reading the loop.
+	 * may be NULL or empty. Need to be careful when reading the loop.
 	 */
 	mutex_lock(&probe->ops.func_hash->regex_lock);
 
-- 
2.28.0


