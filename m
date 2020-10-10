Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66228A2DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgJJW7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbgJJVqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 17:46:23 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA612067C;
        Sat, 10 Oct 2020 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602366360;
        bh=eI6dJamnEibxOIMuboeWk71hOM+zYNzu2gxsoSAnrxM=;
        h=From:To:Cc:Subject:Date:From;
        b=oUgm07qHRaEsjbEV970EjLdE8fSFa58o+h+xwsxN0oLtXo3bQ3H1mkcx6e7LgY6kj
         sYHthZ1FEDBwOJbsp4XZHRFMQugojQiNv/l7QOf+VCFXiwrPaBIL9+U3/XqgrqeJmo
         kp4Q3vhSFTUrtMwG2n6nXGhjjE2RMb3PqPjSVBqU=
From:   Clark Williams <clrkwllms@kernel.org>
To:     rostedt@goodmis.org
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix compile failure on RT with PREEMPT_RT off
Date:   Sat, 10 Oct 2020 16:45:54 -0500
Message-Id: <20201010214554.389157-1-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against v5.9-rc8-rt14

Fix a compile issue when CONFIG_PREEMPT_RT is not defined. If
we're not on an RT kernel, just set the migration disabled
status to zero.

Signed-off-by: Clark Williams <clrkwllms@kernel.org>
---
 kernel/trace/trace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index aa7f3bef6d4f..896573d39baf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2437,6 +2437,16 @@ enum print_line_t trace_handle_return(struct trace_seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
 
+static inline unsigned short
+migration_disable_value(struct task_struct *tsk)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	return (tsk) ? tsk->migration_disabled : 0;
+#else
+	return 0;
+#endif
+}
+
 void
 tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
 			     unsigned long flags, int pc)
@@ -2460,7 +2470,7 @@ tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
 		(need_resched_lazy() ? TRACE_FLAG_NEED_RESCHED_LAZY : 0) |
 		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
 
-	entry->migrate_disable = (tsk) ? tsk->migration_disabled & 0xFF : 0;
+	entry->migrate_disable = migration_disable_value(tsk) & 0xFF : 0;
 }
 EXPORT_SYMBOL_GPL(tracing_generic_entry_update);
 
-- 
2.28.0

