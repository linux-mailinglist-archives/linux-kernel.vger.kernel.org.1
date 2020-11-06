Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE72E2A97F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgKFOzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:55:05 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45987 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgKFOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:55:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UERBQOx_1604674489;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UERBQOx_1604674489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 22:54:49 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: remove unused varible 'ret'
Date:   Fri,  6 Nov 2020 22:54:46 +0800
Message-Id: <1604674486-52350-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' in 2 functions are not used. and one of them is a void function.
So remove them to avoid gcc warning:
kernel/trace/ftrace.c:4166:6: warning: variable ‘ret’ set but not used
[-Wunused-but-set-variable]
kernel/trace/ftrace.c:5571:6: warning: variable ‘ret’ set but not used
[-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/ftrace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8185f7240095..466b8359cbad 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4163,7 +4163,6 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	struct ftrace_hash **orig_hash, *new_hash;
 	LIST_HEAD(process_mods);
 	char *func;
-	int ret;
 
 	mutex_lock(&ops->func_hash->regex_lock);
 
@@ -4216,7 +4215,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 
 	mutex_lock(&ftrace_lock);
 
-	ret = ftrace_hash_move_and_update_ops(ops, orig_hash,
+	ftrace_hash_move_and_update_ops(ops, orig_hash,
 					      new_hash, enable);
 	mutex_unlock(&ftrace_lock);
 
@@ -5568,7 +5567,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 	struct ftrace_hash **orig_hash;
 	struct trace_parser *parser;
 	int filter_hash;
-	int ret;
 
 	if (file->f_mode & FMODE_READ) {
 		iter = m->private;
@@ -5596,7 +5594,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
 		mutex_lock(&ftrace_lock);
-		ret = ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
+		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
 	} else {
-- 
1.8.3.1

