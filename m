Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154AE2AFC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgKLBiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbgKLAhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:37:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71267221E2;
        Thu, 12 Nov 2020 00:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YR-0002Di-E2; Wed, 11 Nov 2020 19:33:35 -0500
Message-ID: <20201112003335.321741954@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [for-next][PATCH 15/17] ftrace: Remove unused varible ret
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

'ret' in 2 functions are not used. and one of them is a void function.
So remove them to avoid gcc warning:
kernel/trace/ftrace.c:4166:6: warning: variable ‘ret’ set but not used
[-Wunused-but-set-variable]
kernel/trace/ftrace.c:5571:6: warning: variable ‘ret’ set but not used
[-Wunused-but-set-variable]

Link: https://lkml.kernel.org/r/1604674486-52350-1-git-send-email-alex.shi@linux.alibaba.com

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 03aad2b5cd5e..3db64fb0cce8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4162,7 +4162,6 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	struct ftrace_hash **orig_hash, *new_hash;
 	LIST_HEAD(process_mods);
 	char *func;
-	int ret;
 
 	mutex_lock(&ops->func_hash->regex_lock);
 
@@ -4215,7 +4214,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 
 	mutex_lock(&ftrace_lock);
 
-	ret = ftrace_hash_move_and_update_ops(ops, orig_hash,
+	ftrace_hash_move_and_update_ops(ops, orig_hash,
 					      new_hash, enable);
 	mutex_unlock(&ftrace_lock);
 
@@ -5567,7 +5566,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 	struct ftrace_hash **orig_hash;
 	struct trace_parser *parser;
 	int filter_hash;
-	int ret;
 
 	if (file->f_mode & FMODE_READ) {
 		iter = m->private;
@@ -5595,7 +5593,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
 		mutex_lock(&ftrace_lock);
-		ret = ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
+		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
 	} else {
-- 
2.28.0


