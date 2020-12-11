Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477682D8134
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406118AbgLKVjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405977AbgLKVih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:38:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B450A23372;
        Fri, 11 Dec 2020 21:37:56 +0000 (UTC)
Date:   Fri, 11 Dec 2020 16:37:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jason Baron <jbaron@akamai.com>
Subject: [PATCH] jump_label: Do not profile branch annotations
Message-ID: <20201211163754.585174b9@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

While running my branch profiler that checks for incorrect "likely" and
"unlikely"s around the kernel, there's a large number of them that are
incorrect due to being "static_branches".

As static_branches are rather special, as they are likely or unlikely for
other reasons than normal annotations are used for, there's no reason to
have them be profiled.

Expose the "unlikely_notrace" and "likely_notrace" so that the
static_branch can use them, and have them be ignored by the branch
profilers.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index e512f5505dad..bbd141cf4b46 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -76,6 +76,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #else
 # define likely(x)	__builtin_expect(!!(x), 1)
 # define unlikely(x)	__builtin_expect(!!(x), 0)
+# define likely_notrace(x)	likely(x)
+# define unlikely_notrace(x)	unlikely(x)
 #endif
 
 /* Optimization barrier */
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 32809624d422..d92691262f51 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -261,14 +261,14 @@ static __always_inline void jump_label_init(void)
 
 static __always_inline bool static_key_false(struct static_key *key)
 {
-	if (unlikely(static_key_count(key) > 0))
+	if (unlikely_notrace(static_key_count(key) > 0))
 		return true;
 	return false;
 }
 
 static __always_inline bool static_key_true(struct static_key *key)
 {
-	if (likely(static_key_count(key) > 0))
+	if (likely_notrace(static_key_count(key) > 0))
 		return true;
 	return false;
 }
@@ -460,7 +460,7 @@ extern bool ____wrong_branch_error(void);
 		branch = !arch_static_branch_jump(&(x)->key, true);		\
 	else									\
 		branch = ____wrong_branch_error();				\
-	likely(branch);								\
+	likely_notrace(branch);								\
 })
 
 #define static_branch_unlikely(x)						\
@@ -472,13 +472,13 @@ extern bool ____wrong_branch_error(void);
 		branch = arch_static_branch(&(x)->key, false);			\
 	else									\
 		branch = ____wrong_branch_error();				\
-	unlikely(branch);							\
+	unlikely_notrace(branch);							\
 })
 
 #else /* !CONFIG_JUMP_LABEL */
 
-#define static_branch_likely(x)		likely(static_key_enabled(&(x)->key))
-#define static_branch_unlikely(x)	unlikely(static_key_enabled(&(x)->key))
+#define static_branch_likely(x)		likely_notrace(static_key_enabled(&(x)->key))
+#define static_branch_unlikely(x)	unlikely_notrace(static_key_enabled(&(x)->key))
 
 #endif /* CONFIG_JUMP_LABEL */
 
