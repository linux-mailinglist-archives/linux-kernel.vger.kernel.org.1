Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54325F684
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgIGJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 05:33:01 -0400
Received: from sym2.noone.org ([178.63.92.236]:34848 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIGJcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:32:55 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BlNP16llxzvjc1; Mon,  7 Sep 2020 11:32:53 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] stackleak: let stack_erasing_sysctl take a kernel pointer buffer
Date:   Mon,  7 Sep 2020 11:32:53 +0200
Message-Id: <20200907093253.13656-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
signature of stack_erasing_sysctl to match ctl_table.proc_handler which
fixes the following sparse warning:

kernel/stackleak.c:31:50: warning: incorrect type in argument 3 (different address spaces)
kernel/stackleak.c:31:50:    expected void *
kernel/stackleak.c:31:50:    got void [noderef] __user *buffer

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/stackleak.h | 2 +-
 kernel/stackleak.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index 3d5c3271a9a8..a59db2f08e76 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -25,7 +25,7 @@ static inline void stackleak_task_init(struct task_struct *t)
 
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos);
+			void *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index a8fc9ae1d03d..ce161a8e8d97 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -20,7 +20,7 @@
 static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 
 int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
-- 
2.27.0

