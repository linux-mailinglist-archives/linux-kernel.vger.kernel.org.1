Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411C3279507
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgIYXrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgIYXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57F6C0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:42 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s66so3951268otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GKRgx1+J3D6WQ1h/+myxlWJJaGx1vz9Y6CYgKfy5Oc=;
        b=D0GJjSoFuiYKNBCKvGobJEjjtwgwcWUfjH8sr75923KX43QHs8Cvom5Q0fkDQEaq/s
         8fHG81WQR6/KmQhnvtRxwlu9GKXrEnY19iome1tfjg2I5F2ZBixrGykaoYc2pCS+Pzui
         Vcf8vmdU5l6A5KLy4wopKc4F7UVqwD3t1/8YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GKRgx1+J3D6WQ1h/+myxlWJJaGx1vz9Y6CYgKfy5Oc=;
        b=hT69YmaCi2PDKM6LLlcAQQYrznG4zqpVsFxSnLsAs5sPGM4781VyyW5WU7Sc7kMUZQ
         JzikAfx2wHNxGpDJM+xkuVDs/537iHiXPKNDJgi7ZKqphNV8WWQEXVVS8bJ3NQX0f6If
         ROttPJdYu9G4QR1pxPLSTvbUlJUbWdAem3IUSQ0ZSRZxzLNtR2hRaVI1O6XB5UoWK5hz
         Zs7egm0zohuC4g7+WS8aYN+pmUG/Q4bL+H9wp6q4sdoK3ibmeb3vuf8Gl8wZVyOnMtvh
         QVRUvCtTLwnEElHkZQAEyH0FydDuRFs9KaCg0vMWT9bLXFi55I/foOlcDETdb4sOu8a9
         AP9A==
X-Gm-Message-State: AOAM533p/0eFCcJ2pQ3aDwrQ7q0MzPsrGolp1eDR0TkqaDKSGmyCKUhP
        6RoeuYLiS2XJHlNbytUOwmDG3Q==
X-Google-Smtp-Source: ABdhPJzvn0MwX5rvkrAEKWKB3JQh1HqrhH2nhrKCWVvslvZ8vOurJDN3L8sgaAs8iFHVK9izO8sbGA==
X-Received: by 2002:a9d:4c0a:: with SMTP id l10mr1943745otf.166.1601077662022;
        Fri, 25 Sep 2020 16:47:42 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:41 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] drivers/android/binder: convert stats, transaction_log to counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:21 -0600
Message-Id: <ab2cb30977ac35cc172d30306da25178b742c328.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

stats tracks per-process binder statistics. Unsure if there is a chance
of this overflowing, other than stats getting reset to 0. Convert it to
use counter_atomic.

binder_transaction_log:cur is used to keep track of the current log entry
location. Overflow is handled in the code. Since it is used as a
counter, convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/android/binder.c          | 41 ++++++++++++++++---------------
 drivers/android/binder_internal.h |  3 ++-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f936530a19b0..52175cd6a62b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -66,6 +66,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/sizes.h>
+#include <linux/counters.h>
 
 #include <uapi/linux/android/binder.h>
 #include <uapi/linux/android/binderfs.h>
@@ -172,22 +173,22 @@ enum binder_stat_types {
 };
 
 struct binder_stats {
-	atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
-	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
-	atomic_t obj_created[BINDER_STAT_COUNT];
-	atomic_t obj_deleted[BINDER_STAT_COUNT];
+	struct counter_atomic32 br[_IOC_NR(BR_FAILED_REPLY) + 1];
+	struct counter_atomic32 bc[_IOC_NR(BC_REPLY_SG) + 1];
+	struct counter_atomic32 obj_created[BINDER_STAT_COUNT];
+	struct counter_atomic32 obj_deleted[BINDER_STAT_COUNT];
 };
 
 static struct binder_stats binder_stats;
 
 static inline void binder_stats_deleted(enum binder_stat_types type)
 {
-	atomic_inc(&binder_stats.obj_deleted[type]);
+	counter_atomic32_inc(&binder_stats.obj_deleted[type]);
 }
 
 static inline void binder_stats_created(enum binder_stat_types type)
 {
-	atomic_inc(&binder_stats.obj_created[type]);
+	counter_atomic32_inc(&binder_stats.obj_created[type]);
 }
 
 struct binder_transaction_log binder_transaction_log;
@@ -197,7 +198,7 @@ static struct binder_transaction_log_entry *binder_transaction_log_add(
 	struct binder_transaction_log *log)
 {
 	struct binder_transaction_log_entry *e;
-	unsigned int cur = atomic_inc_return(&log->cur);
+	unsigned int cur = counter_atomic32_inc_return(&log->cur);
 
 	if (cur >= ARRAY_SIZE(log->entry))
 		log->full = true;
@@ -3615,9 +3616,9 @@ static int binder_thread_write(struct binder_proc *proc,
 		ptr += sizeof(uint32_t);
 		trace_binder_command(cmd);
 		if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.bc)) {
-			atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
-			atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
-			atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
+			counter_atomic32_inc(&binder_stats.bc[_IOC_NR(cmd)]);
+			counter_atomic32_inc(&proc->stats.bc[_IOC_NR(cmd)]);
+			counter_atomic32_inc(&thread->stats.bc[_IOC_NR(cmd)]);
 		}
 		switch (cmd) {
 		case BC_INCREFS:
@@ -4047,9 +4048,9 @@ static void binder_stat_br(struct binder_proc *proc,
 {
 	trace_binder_return(cmd);
 	if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.br)) {
-		atomic_inc(&binder_stats.br[_IOC_NR(cmd)]);
-		atomic_inc(&proc->stats.br[_IOC_NR(cmd)]);
-		atomic_inc(&thread->stats.br[_IOC_NR(cmd)]);
+		counter_atomic32_inc(&binder_stats.br[_IOC_NR(cmd)]);
+		counter_atomic32_inc(&proc->stats.br[_IOC_NR(cmd)]);
+		counter_atomic32_inc(&thread->stats.br[_IOC_NR(cmd)]);
 	}
 }
 
@@ -5841,7 +5842,7 @@ static void print_binder_stats(struct seq_file *m, const char *prefix,
 	BUILD_BUG_ON(ARRAY_SIZE(stats->bc) !=
 		     ARRAY_SIZE(binder_command_strings));
 	for (i = 0; i < ARRAY_SIZE(stats->bc); i++) {
-		int temp = atomic_read(&stats->bc[i]);
+		int temp = counter_atomic32_read(&stats->bc[i]);
 
 		if (temp)
 			seq_printf(m, "%s%s: %d\n", prefix,
@@ -5851,7 +5852,7 @@ static void print_binder_stats(struct seq_file *m, const char *prefix,
 	BUILD_BUG_ON(ARRAY_SIZE(stats->br) !=
 		     ARRAY_SIZE(binder_return_strings));
 	for (i = 0; i < ARRAY_SIZE(stats->br); i++) {
-		int temp = atomic_read(&stats->br[i]);
+		int temp = counter_atomic32_read(&stats->br[i]);
 
 		if (temp)
 			seq_printf(m, "%s%s: %d\n", prefix,
@@ -5863,8 +5864,8 @@ static void print_binder_stats(struct seq_file *m, const char *prefix,
 	BUILD_BUG_ON(ARRAY_SIZE(stats->obj_created) !=
 		     ARRAY_SIZE(stats->obj_deleted));
 	for (i = 0; i < ARRAY_SIZE(stats->obj_created); i++) {
-		int created = atomic_read(&stats->obj_created[i]);
-		int deleted = atomic_read(&stats->obj_deleted[i]);
+		int created = counter_atomic32_read(&stats->obj_created[i]);
+		int deleted = counter_atomic32_read(&stats->obj_deleted[i]);
 
 		if (created || deleted)
 			seq_printf(m, "%s%s: active %d total %d\n",
@@ -6054,7 +6055,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
 int binder_transaction_log_show(struct seq_file *m, void *unused)
 {
 	struct binder_transaction_log *log = m->private;
-	unsigned int log_cur = atomic_read(&log->cur);
+	unsigned int log_cur = counter_atomic32_read(&log->cur);
 	unsigned int count;
 	unsigned int cur;
 	int i;
@@ -6124,8 +6125,8 @@ static int __init binder_init(void)
 	if (ret)
 		return ret;
 
-	atomic_set(&binder_transaction_log.cur, ~0U);
-	atomic_set(&binder_transaction_log_failed.cur, ~0U);
+	counter_atomic32_set(&binder_transaction_log.cur, ~0U);
+	counter_atomic32_set(&binder_transaction_log_failed.cur, ~0U);
 
 	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
 	if (binder_debugfs_dir_entry_root)
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 283d3cb9c16e..c77960c01430 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/uidgid.h>
+#include <linux/counters.h>
 
 struct binder_context {
 	struct binder_node *binder_context_mgr_node;
@@ -136,7 +137,7 @@ struct binder_transaction_log_entry {
 };
 
 struct binder_transaction_log {
-	atomic_t cur;
+	struct counter_atomic32 cur;
 	bool full;
 	struct binder_transaction_log_entry entry[32];
 };
-- 
2.25.1

