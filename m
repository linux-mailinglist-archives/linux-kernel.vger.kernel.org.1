Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45F2C08CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgKWNAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbgKWM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:58:48 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B5AC0613CF;
        Mon, 23 Nov 2020 04:58:46 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id r14so9030008vsa.13;
        Mon, 23 Nov 2020 04:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1Bdu1f8R9bBNbgeIXBGwkTBiP2EkZW/1Ka6vd1hK2g=;
        b=ZbRVnfUAwS4Elf8wQZqKbSZX+5D8Btlpq/oxzkrXKUSHf3LXr9yxbicJodM2oc59PW
         FzvZ1PvK+5ax3wNfJFXHLAFuWyppaSGjzA7Nog2vgYVscPWLSA3waiIEvRfEc70rObIB
         MjHtPmcbVa71q5bUExpYsbaqQAoGJEHRlHod8bnXsuR4MJoidixNanzyfkGKIisecz6V
         42purhjVYkJm4vxMffAarXnrkp0T4edfLQZRXeC3t8ug4/52BNhvWD20xpfYmuP8zZKx
         QMPBqJw7w4MqmK2B4zgWCvN+DEFI0/DFydb4Huyb11D7TrrzI9JxZ9L6bZglk7nAEobJ
         3rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1Bdu1f8R9bBNbgeIXBGwkTBiP2EkZW/1Ka6vd1hK2g=;
        b=NiTLoaYoU+c992Mn+LiVk+Jrjt592O0K7n+PhA5O3JVomLyvhOpazgPSUz7alQrHb3
         5KC3ucEBvvkwJTNsVJC10FzHsEpWWqYuBdGsm9Qhr2aUck69FjXm2J1Rb60mbRTYKPob
         niWWlIo+MKjKuFx+eduiEAjmD2g4rw6/D2/Z3OII0+GpvE59C2mLmBQj6yUrR0rLZw2x
         uIpI0ANCzrICkefevOb1JDBrYnF+yTfNW0znGuSBQHuI0G+sWn6p4QB1qbmpIG+7JGkh
         xoIh/aTXPUHeU5azpYpUye99kEWuNLlnhZRiZscfl+QxE5CB4DJTv60g4nN8wVZjdRGr
         MbuQ==
X-Gm-Message-State: AOAM532gYXzN2PZ4xfEdbW3TnOXBVPLaovKlEq5gxKOKmFaxcd2MFHbG
        MsZcDJeKRBg2dKIkZIhuX/c=
X-Google-Smtp-Source: ABdhPJzY4tCRQPW2PwqUqym6cBqNT+iGG9NxQKtRz5dJbI0yZQso8iYkf7MMqpFQ5OZF8MGb/YC+ZQ==
X-Received: by 2002:a67:f2c3:: with SMTP id a3mr17160775vsn.57.1606136325653;
        Mon, 23 Nov 2020 04:58:45 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id h16sm1579091uaw.7.2020.11.23.04.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:58:44 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 1/5] sched: don't include stats.h in sched.h
Date:   Mon, 23 Nov 2020 20:58:04 +0800
Message-Id: <20201123125808.50896-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201123125808.50896-1-laoar.shao@gmail.com>
References: <20201123125808.50896-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a preparation of the followup patches. In the followup
patches some common helpers will be defined in stats.h, and these common
helpers require some definitions in sched.h, so let's move stats.h out
of sched.h.

The source files which require stats.h include it specifically.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c      | 1 +
 kernel/sched/deadline.c  | 1 +
 kernel/sched/debug.c     | 1 +
 kernel/sched/fair.c      | 1 +
 kernel/sched/idle.c      | 1 +
 kernel/sched/rt.c        | 2 +-
 kernel/sched/sched.h     | 6 +++++-
 kernel/sched/stats.c     | 1 +
 kernel/sched/stats.h     | 2 ++
 kernel/sched/stop_task.c | 1 +
 10 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..fd76628778f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11,6 +11,7 @@
 #undef CREATE_TRACE_POINTS
 
 #include "sched.h"
+#include "stats.h"
 
 #include <linux/nospec.h>
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f232305dcefe..7a0124f81a4f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,7 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 #include "sched.h"
+#include "stats.h"
 #include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2357921580f9..9758aa1bba1e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -7,6 +7,7 @@
  * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
  */
 #include "sched.h"
+#include "stats.h"
 
 static DEFINE_SPINLOCK(sched_debug_lock);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8917d2d715ef..8ff1daa3d9bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include "stats.h"
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 24d0ee26377d..95c02cbca04a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -7,6 +7,7 @@
  *        tasks which are handled in sched/fair.c )
  */
 #include "sched.h"
+#include "stats.h"
 
 #include <trace/events/power.h>
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..af772ac0f32d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -4,7 +4,7 @@
  * policies)
  */
 #include "sched.h"
-
+#include "stats.h"
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..871544bb9a38 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2,6 +2,9 @@
 /*
  * Scheduler internal types and methods:
  */
+#ifndef _KERNEL_SCHED_SCHED_H
+#define _KERNEL_SCHED_SCHED_H
+
 #include <linux/sched.h>
 
 #include <linux/sched/autogroup.h>
@@ -1538,7 +1541,6 @@ extern void flush_smp_call_function_from_idle(void);
 static inline void flush_smp_call_function_from_idle(void) { }
 #endif
 
-#include "stats.h"
 #include "autogroup.h"
 
 #ifdef CONFIG_CGROUP_SCHED
@@ -2633,3 +2635,5 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#endif	/* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..844bd9dbfbf0 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -3,6 +3,7 @@
  * /proc/schedstat implementation
  */
 #include "sched.h"
+#include "stats.h"
 
 /*
  * Current schedstat API version.
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33d0daf83842..c23b653ffc53 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,6 +2,8 @@
 
 #ifdef CONFIG_SCHEDSTATS
 
+#include "sched.h"
+
 /*
  * Expects runqueue lock to be held for atomicity of update
  */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index ceb5b6b12561..a5d289049388 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -8,6 +8,7 @@
  * See kernel/stop_machine.c
  */
 #include "sched.h"
+#include "stats.h"
 
 #ifdef CONFIG_SMP
 static int
-- 
2.18.4

