Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01218274E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgIWBo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgIWBoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6859C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i17so23256011oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxTjHJRlhpZBK3PdVGNqht+ElslUvop7qIcHfpqmSTQ=;
        b=TreJXNFFPkjB5Ms/Buivsao4LiEJc1uoLxB11Kq0pZJIPcQ6h4Dm4NMjNJzdBU5RRv
         MDG9kDUHpGvRxcs9amq7sfmjiOKnHi+9eZpJtuDHUZC1DDx5fIbQCuwBlXIuKGs/IzUm
         0FmxlEW1AXEOJyHvefm6VKnso0G2Rt6Xq9Wc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxTjHJRlhpZBK3PdVGNqht+ElslUvop7qIcHfpqmSTQ=;
        b=BjmT9phsphF38M5CS3L0h+Ao2k8UfeT3AggGlgh3vab247AzgjGBjjHDUc74UzYk0u
         wi3Qgt90K5jA9UxM3HPYe7S1K8XYIhye/TbHz3L3trRtI/TEGQxpIpJXFoSl+PNJgocP
         jHr6QGfbJSJubBOKJ/+fbswYcBx5uD2iadLn+uePT35ZfjaxHuBzKCc83l5/Uqvf9pNa
         Zp6ZfZc8UCM+04DFv7+fm7qJGGrTcP3FBVVNlRRIIQizUsHHFzT0MPaGmAtGowXvEIWY
         f8mlwb8P1jNLxVE1Ptjwo8Dc4Yirr0X/lT5PvfmFCkBxYq3TWJapz/o8gVtjx16YdIPx
         HSiA==
X-Gm-Message-State: AOAM531p3OUE8KeoS6MykHxYpKUJ9csBv8/TY26Lz7UTxsinTQ4R/Vsm
        vAGHsRVjI8qU/HKd/OfufZTvZA==
X-Google-Smtp-Source: ABdhPJzFwxgMwORVUlDDZc3IX4sn1185yzTf9h8W771Sv0oERD4Vd0ldrNbhLszRTAcSgCqSGW0Ytw==
X-Received: by 2002:aca:c758:: with SMTP id x85mr4420678oif.102.1600825459238;
        Tue, 22 Sep 2020 18:44:19 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:18 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/11] drivers/android/binder: convert stats, transaction_log to counter_atomic
Date:   Tue, 22 Sep 2020 19:43:36 -0600
Message-Id: <4fe28fc5f315657e4af276b8a3c71d80a5eaa379.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600816121.git.skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

counter_atomic is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

stats tracks per-process binder statistics. Unsure if there is a chance
of this overflowing, other than stats getting reset to 0. Convert it to
use counter_atomic.

binder_transaction_log:cur is used to keep track of the current log entry
location. Overflow is handled in the code. Since it is used as a
counter, convert it to use counter_atomic.

This conversion doesn't change the oveflow wrap around behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/android/binder.c          | 41 ++++++++++++++++---------------
 drivers/android/binder_internal.h |  3 ++-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f936530a19b0..11a0407c46df 100644
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
+	struct counter_atomic br[_IOC_NR(BR_FAILED_REPLY) + 1];
+	struct counter_atomic bc[_IOC_NR(BC_REPLY_SG) + 1];
+	struct counter_atomic obj_created[BINDER_STAT_COUNT];
+	struct counter_atomic obj_deleted[BINDER_STAT_COUNT];
 };
 
 static struct binder_stats binder_stats;
 
 static inline void binder_stats_deleted(enum binder_stat_types type)
 {
-	atomic_inc(&binder_stats.obj_deleted[type]);
+	counter_atomic_inc(&binder_stats.obj_deleted[type]);
 }
 
 static inline void binder_stats_created(enum binder_stat_types type)
 {
-	atomic_inc(&binder_stats.obj_created[type]);
+	counter_atomic_inc(&binder_stats.obj_created[type]);
 }
 
 struct binder_transaction_log binder_transaction_log;
@@ -197,7 +198,7 @@ static struct binder_transaction_log_entry *binder_transaction_log_add(
 	struct binder_transaction_log *log)
 {
 	struct binder_transaction_log_entry *e;
-	unsigned int cur = atomic_inc_return(&log->cur);
+	unsigned int cur = counter_atomic_inc_return(&log->cur);
 
 	if (cur >= ARRAY_SIZE(log->entry))
 		log->full = true;
@@ -3615,9 +3616,9 @@ static int binder_thread_write(struct binder_proc *proc,
 		ptr += sizeof(uint32_t);
 		trace_binder_command(cmd);
 		if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.bc)) {
-			atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
-			atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
-			atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
+			counter_atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
+			counter_atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
+			counter_atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
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
+		counter_atomic_inc(&binder_stats.br[_IOC_NR(cmd)]);
+		counter_atomic_inc(&proc->stats.br[_IOC_NR(cmd)]);
+		counter_atomic_inc(&thread->stats.br[_IOC_NR(cmd)]);
 	}
 }
 
@@ -5841,7 +5842,7 @@ static void print_binder_stats(struct seq_file *m, const char *prefix,
 	BUILD_BUG_ON(ARRAY_SIZE(stats->bc) !=
 		     ARRAY_SIZE(binder_command_strings));
 	for (i = 0; i < ARRAY_SIZE(stats->bc); i++) {
-		int temp = atomic_read(&stats->bc[i]);
+		int temp = counter_atomic_read(&stats->bc[i]);
 
 		if (temp)
 			seq_printf(m, "%s%s: %d\n", prefix,
@@ -5851,7 +5852,7 @@ static void print_binder_stats(struct seq_file *m, const char *prefix,
 	BUILD_BUG_ON(ARRAY_SIZE(stats->br) !=
 		     ARRAY_SIZE(binder_return_strings));
 	for (i = 0; i < ARRAY_SIZE(stats->br); i++) {
-		int temp = atomic_read(&stats->br[i]);
+		int temp = counter_atomic_read(&stats->br[i]);
 
 		if (temp)
 			seq_printf(m, "%s%s: %d\n", prefix,
@@ -5863,8 +5864,8 @@ static void print_binder_stats(struct seq_file *m, const char *prefix,
 	BUILD_BUG_ON(ARRAY_SIZE(stats->obj_created) !=
 		     ARRAY_SIZE(stats->obj_deleted));
 	for (i = 0; i < ARRAY_SIZE(stats->obj_created); i++) {
-		int created = atomic_read(&stats->obj_created[i]);
-		int deleted = atomic_read(&stats->obj_deleted[i]);
+		int created = counter_atomic_read(&stats->obj_created[i]);
+		int deleted = counter_atomic_read(&stats->obj_deleted[i]);
 
 		if (created || deleted)
 			seq_printf(m, "%s%s: active %d total %d\n",
@@ -6054,7 +6055,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
 int binder_transaction_log_show(struct seq_file *m, void *unused)
 {
 	struct binder_transaction_log *log = m->private;
-	unsigned int log_cur = atomic_read(&log->cur);
+	unsigned int log_cur = counter_atomic_read(&log->cur);
 	unsigned int count;
 	unsigned int cur;
 	int i;
@@ -6124,8 +6125,8 @@ static int __init binder_init(void)
 	if (ret)
 		return ret;
 
-	atomic_set(&binder_transaction_log.cur, ~0U);
-	atomic_set(&binder_transaction_log_failed.cur, ~0U);
+	counter_atomic_set(&binder_transaction_log.cur, ~0U);
+	counter_atomic_set(&binder_transaction_log_failed.cur, ~0U);
 
 	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
 	if (binder_debugfs_dir_entry_root)
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 283d3cb9c16e..9f5ef382e761 100644
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
+	struct counter_atomic cur;
 	bool full;
 	struct binder_transaction_log_entry entry[32];
 };
-- 
2.25.1

