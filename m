Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD82F6F53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbhAOAOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:14:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbhAOAOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:14:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0993AC24;
        Fri, 15 Jan 2021 00:13:51 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jason.wessel@windriver.com
Cc:     daniel.thompson@linaro.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] kgdb: Schedule breakpoints via workqueue
Date:   Thu, 14 Jan 2021 16:13:44 -0800
Message-Id: <20210115001344.117108-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original functionality was added back in:

    1cee5e35f15 (kgdb: Add the ability to schedule a breakpoint via a tasklet)

However tasklets have long been deprecated as being too heavy on
the system by running in irq context - and this is not a performance
critical path. If a higher priority process wants to run, it must
wait for the tasklet to finish before doing so. Instead, generate
the breakpoint exception in process context.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
Compile-tested only.

 kernel/debug/debug_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index af6e8b4fb359..e1ff974c6b6f 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -119,7 +119,7 @@ static DEFINE_RAW_SPINLOCK(dbg_slave_lock);
  */
 static atomic_t			masters_in_kgdb;
 static atomic_t			slaves_in_kgdb;
-static atomic_t			kgdb_break_tasklet_var;
+static atomic_t			kgdb_break_work_var;
 atomic_t			kgdb_setting_breakpoint;
 
 struct task_struct		*kgdb_usethread;
@@ -1085,27 +1085,27 @@ static void kgdb_unregister_callbacks(void)
 }
 
 /*
- * There are times a tasklet needs to be used vs a compiled in
+ * There are times a workqueue needs to be used vs a compiled in
  * break point so as to cause an exception outside a kgdb I/O module,
  * such as is the case with kgdboe, where calling a breakpoint in the
  * I/O driver itself would be fatal.
  */
-static void kgdb_tasklet_bpt(unsigned long ing)
+static void kgdb_work_bpt(struct work_struct *unused)
 {
 	kgdb_breakpoint();
-	atomic_set(&kgdb_break_tasklet_var, 0);
+	atomic_set(&kgdb_break_work_var, 0);
 }
 
-static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
+static DECLARE_WORK(kgdb_async_breakpoint, kgdb_work_bpt);
 
 void kgdb_schedule_breakpoint(void)
 {
-	if (atomic_read(&kgdb_break_tasklet_var) ||
+	if (atomic_read(&kgdb_break_work_var) ||
 		atomic_read(&kgdb_active) != -1 ||
 		atomic_read(&kgdb_setting_breakpoint))
 		return;
-	atomic_inc(&kgdb_break_tasklet_var);
-	tasklet_schedule(&kgdb_tasklet_breakpoint);
+	atomic_inc(&kgdb_break_work_var);
+	schedule_work(&kgdb_async_breakpoint);
 }
 EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
 
-- 
2.26.2

