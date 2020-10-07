Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2652C28679B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgJGSoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:44:13 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF986C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:44:13 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c67so1907817pfb.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=roCb7/YhJ1J9g1aL6y8hue0669Lq+IzoGlC5brUIAWQ=;
        b=u7KStS15kIm+Heu8DVgCSUWwiOwbb1arGa4w4IVRbQx1Znu6WEW3O9tUx7qGoTPKsy
         rQ0LX8s5CLEX2ZsLPnHGVIIQlU/sF5B19ZotJU7r2DTWDYqgactGeZZd/K6+Ed4qiLc2
         WGLOzuZqJDj1UISpOoIDsZS6HT1SmNgyaAhKX4VIPnISX00fTySNm2RMueJks7aIZXIq
         tTaavH1ABlJbDBnIEbbegVyasP+rogJ2YLaD9Y3AtnghZXgpUfpE2gHm5iTVDFB/VF0M
         WJJq9vlZ2kaIsSxvtqCvP1Tg30yKnauOo07kUvSG7yBg/vsKBJLWBjP0DKKM8X7C0OP9
         jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=roCb7/YhJ1J9g1aL6y8hue0669Lq+IzoGlC5brUIAWQ=;
        b=Jat/TxYsV6vM6sFv8hKuCZ6+3JouPJVy0KYr3ZoC3vdSw9KMmMBBUKYqLODa1Zulrw
         4rWD3YhCJ+EADIpkcwmh/th1D/MjY2rGOCA9BGf4nQrofoUJSKLas+AeYfom2Z35J7J1
         N5gqA+Up/7kBEepTqE9Vdzq1lKoxLVpexNpsm2xxwqNnTJU3SBybmVRjIeKIpZC/0Kb5
         O8jwpg2u6Defu62a/ZBAqf1g/FEZxJsosV+1CRllwUmWBKMti4bko+bqY7fZD2swJcwv
         JUhTfq05Lc3urkvbqPmeB2DNs3GUraHSIt03BXEFUrvWAMu/Gqbf5qhH/HnuYrnP28ja
         kcOQ==
X-Gm-Message-State: AOAM530YnDeb/Ampa2L/3ZQcnelx16Sd9kcRzkBNysW7fwCsRCevXoTa
        6ibhVUdWByQBlvW1QTQWeTEAkK+CORDOGJ4PK3t3
X-Google-Smtp-Source: ABdhPJx5aKBy8JW83gwhazdhKNAj7El6GejmjweU2s6gx5eGR1ZXqaBm2/WEVsZ0e4q78ESgpWbIDTzGPIpKAvVEh/iz
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a63:2547:: with SMTP id
 l68mr4078696pgl.241.1602096253163; Wed, 07 Oct 2020 11:44:13 -0700 (PDT)
Date:   Wed,  7 Oct 2020 11:44:03 -0700
In-Reply-To: <20201007184403.1902111-1-axelrasmussen@google.com>
Message-Id: <20201007184403.1902111-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20201007184403.1902111-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 2/2] mmap_lock: add tracepoints around lock acquisition
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of these tracepoints is to be able to debug lock contention
issues. This lock is acquired on most (all?) mmap / munmap / page fault
operations, so a multi-threaded process which does a lot of these can
experience significant contention.

We trace just before we start acquisition, when the acquisition returns
(whether it succeeded or not), and when the lock is released (or
downgraded). The events are broken out by lock type (read / write).

The events are also broken out by memcg path. For container-based
workloads, users often think of several processes in a memcg as a single
logical "task", so collecting statistics at this level is useful.

The end goal is to get latency information. This isn't directly included
in the trace events. Instead, users are expected to compute the time
between "start locking" and "acquire returned", using e.g. synthetic
events or BPF. The benefit we get from this is simpler code.

Because we use tracepoint_enabled() to decide whether or not to trace,
this patch has effectively no overhead unless tracepoints are enabled at
runtime. If tracepoints are enabled, there is a performance impact, but
how much depends on exactly what e.g. the BPF program does.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/mmap_lock.h        | 112 ++++++++++++++++++++++++++++---
 include/trace/events/mmap_lock.h |  70 +++++++++++++++++++
 mm/Makefile                      |   2 +-
 mm/mmap_lock.c                   |  87 ++++++++++++++++++++++++
 4 files changed, 261 insertions(+), 10 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index e1afb420fc94..aa3d64f99d17 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,11 +1,95 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#include <linux/lockdep.h>
+#include <linux/mm_types.h>
 #include <linux/mmdebug.h>
+#include <linux/rwsem.h>
+#include <linux/tracepoint-defs.h>
+#include <linux/types.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
 
+DECLARE_TRACEPOINT(mmap_lock_start_locking);
+DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
+DECLARE_TRACEPOINT(mmap_lock_released);
+
+#ifdef CONFIG_TRACING
+
+void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write);
+void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
+					   bool success);
+void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write);
+
+#else /* !COFNIG_TRACING */
+
+static inline void __mmap_lock_do_trace_start_locking(struct mm_struct *mm,
+						      bool write)
+{
+}
+
+static inline void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm,
+							 bool write,
+							 bool success)
+{
+}
+
+static inline void __mmap_lock_do_trace_released(struct mm_struct *mm,
+						 bool write)
+{
+}
+
+#endif /* CONFIG_TRACING */
+
+static inline bool
+__mmap_lock_traced_trylock(struct mm_struct *mm,
+			   int (*trylock)(struct rw_semaphore *), bool write)
+{
+	bool ret;
+
+	if (tracepoint_enabled(mmap_lock_start_locking))
+		__mmap_lock_do_trace_start_locking(mm, write);
+	ret = trylock(&mm->mmap_lock) != 0;
+	if (tracepoint_enabled(mmap_lock_acquire_returned))
+		__mmap_lock_do_trace_acquire_returned(mm, write, ret);
+	return ret;
+}
+
+static inline void __mmap_lock_traced_lock(struct mm_struct *mm,
+					   void (*lock)(struct rw_semaphore *),
+					   bool write)
+{
+	if (tracepoint_enabled(mmap_lock_start_locking))
+		__mmap_lock_do_trace_start_locking(mm, write);
+	lock(&mm->mmap_lock);
+	if (tracepoint_enabled(mmap_lock_acquire_returned))
+		__mmap_lock_do_trace_acquire_returned(mm, write, true);
+}
+
+static inline int
+__mmap_lock_traced_lock_return(struct mm_struct *mm,
+			       int (*lock)(struct rw_semaphore *), bool write)
+{
+	int ret;
+
+	if (tracepoint_enabled(mmap_lock_start_locking))
+		__mmap_lock_do_trace_start_locking(mm, write);
+	ret = lock(&mm->mmap_lock);
+	if (tracepoint_enabled(mmap_lock_acquire_returned))
+		__mmap_lock_do_trace_acquire_returned(mm, write, ret == 0);
+	return ret;
+}
+
+static inline void
+__mmap_lock_traced_unlock(struct mm_struct *mm,
+			  void (*unlock)(struct rw_semaphore *), bool write)
+{
+	unlock(&mm->mmap_lock);
+	if (tracepoint_enabled(mmap_lock_released))
+		__mmap_lock_do_trace_released(mm, write);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -13,58 +97,66 @@ static inline void mmap_init_lock(struct mm_struct *mm)
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
-	down_write(&mm->mmap_lock);
+	__mmap_lock_traced_lock(mm, down_write, true);
 }
 
 static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
+	if (tracepoint_enabled(mmap_lock_start_locking))
+		__mmap_lock_do_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	if (tracepoint_enabled(mmap_lock_acquire_returned))
+		__mmap_lock_do_trace_acquire_returned(mm, true, true);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
-	return down_write_killable(&mm->mmap_lock);
+	return __mmap_lock_traced_lock_return(mm, down_write_killable, true);
 }
 
 static inline bool mmap_write_trylock(struct mm_struct *mm)
 {
-	return down_write_trylock(&mm->mmap_lock) != 0;
+	return __mmap_lock_traced_trylock(mm, down_write_trylock, true);
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_lock);
+	__mmap_lock_traced_unlock(mm, up_write, true);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	downgrade_write(&mm->mmap_lock);
+	if (tracepoint_enabled(mmap_lock_acquire_returned))
+		__mmap_lock_do_trace_acquire_returned(mm, false, true);
 }
 
 static inline void mmap_read_lock(struct mm_struct *mm)
 {
-	down_read(&mm->mmap_lock);
+	__mmap_lock_traced_lock(mm, down_read, false);
 }
 
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
-	return down_read_killable(&mm->mmap_lock);
+	return __mmap_lock_traced_lock_return(mm, down_read_killable, false);
 }
 
 static inline bool mmap_read_trylock(struct mm_struct *mm)
 {
-	return down_read_trylock(&mm->mmap_lock) != 0;
+	return __mmap_lock_traced_trylock(mm, down_read_trylock, false);
 }
 
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
-	up_read(&mm->mmap_lock);
+	__mmap_lock_traced_unlock(mm, up_read, false);
 }
 
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 {
-	if (down_read_trylock(&mm->mmap_lock)) {
+	if (mmap_read_trylock(mm)) {
 		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
+		if (tracepoint_enabled(mmap_lock_released))
+			__mmap_lock_do_trace_released(mm, false);
 		return true;
 	}
 	return false;
@@ -73,6 +165,8 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
 	up_read_non_owner(&mm->mmap_lock);
+	if (tracepoint_enabled(mmap_lock_released))
+		__mmap_lock_do_trace_released(mm, false);
 }
 
 static inline void mmap_assert_locked(struct mm_struct *mm)
diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
new file mode 100644
index 000000000000..ca652b52510e
--- /dev/null
+++ b/include/trace/events/mmap_lock.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mmap_lock
+
+#if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MMAP_LOCK_H
+
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+struct mm_struct;
+
+DECLARE_EVENT_CLASS(
+	mmap_lock_template,
+
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
+		bool success),
+
+	TP_ARGS(mm, memcg_path, write, success),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__string(memcg_path, memcg_path)
+		__field(bool, write)
+		__field(bool, success)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__assign_str(memcg_path, memcg_path);
+		__entry->write = write;
+		__entry->success = success;
+	),
+
+	TP_printk(
+		"mm=%p memcg_path=%s write=%s success=%s\n",
+		__entry->mm,
+		__get_str(memcg_path),
+		__entry->write ? "true" : "false",
+		__entry->success ? "true" : "false")
+	);
+
+DEFINE_EVENT(mmap_lock_template, mmap_lock_start_locking,
+
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
+		bool success),
+
+	TP_ARGS(mm, memcg_path, write, success)
+);
+
+DEFINE_EVENT(mmap_lock_template, mmap_lock_acquire_returned,
+
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
+		bool success),
+
+	TP_ARGS(mm, memcg_path, write, success)
+);
+
+DEFINE_EVENT(mmap_lock_template, mmap_lock_released,
+
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
+		bool success),
+
+	TP_ARGS(mm, memcg_path, write, success)
+);
+
+#endif /* _TRACE_MMAP_LOCK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/Makefile b/mm/Makefile
index 069f216e109e..b6cd2fffa492 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
new file mode 100644
index 000000000000..b849287bd12a
--- /dev/null
+++ b/mm/mmap_lock.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include <trace/events/mmap_lock.h>
+
+#include <linux/mm.h>
+#include <linux/cgroup.h>
+#include <linux/memcontrol.h>
+#include <linux/mmap_lock.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
+#include <linux/trace_events.h>
+
+/*
+ * We have to export these, as drivers use mmap_lock, and our inline functions
+ * in the header check if the tracepoint is enabled. They can't be GPL, as e.g.
+ * the nvidia driver is an existing caller of this code.
+ */
+EXPORT_SYMBOL(__tracepoint_mmap_lock_start_locking);
+EXPORT_SYMBOL(__tracepoint_mmap_lock_acquire_returned);
+EXPORT_SYMBOL(__tracepoint_mmap_lock_released);
+
+#ifdef CONFIG_MEMCG
+
+DEFINE_PER_CPU(char[MAX_FILTER_STR_VAL], trace_memcg_path);
+
+/*
+ * Write the given mm_struct's memcg path to a percpu buffer, and return a
+ * pointer to it. If the path cannot be determined, the buffer will contain the
+ * empty string.
+ *
+ * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
+ * disabled by the caller before calling us, and re-enabled only after the
+ * caller is done with the pointer.
+ */
+static const char *get_mm_memcg_path(struct mm_struct *mm)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
+
+	if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
+		char *buf = this_cpu_ptr(trace_memcg_path);
+
+		cgroup_path(memcg->css.cgroup, buf, MAX_FILTER_STR_VAL);
+		return buf;
+	}
+	return "";
+}
+
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
+	do {                                                                   \
+		if (trace_mmap_lock_##type##_enabled()) {                      \
+			get_cpu();                                             \
+			trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),      \
+					       ##__VA_ARGS__);                 \
+			put_cpu();                                             \
+		}                                                              \
+	} while (0)
+
+#else /* !CONFIG_MEMCG */
+
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
+	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
+
+#endif /* CONFIG_MEMCG */
+
+/*
+ * Trace calls must be in a separate file, as otherwise there's a circular
+ * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
+ */
+
+void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
+{
+	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write, true);
+}
+EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
+
+void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
+					   bool success)
+{
+	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
+}
+EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
+
+void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
+{
+	TRACE_MMAP_LOCK_EVENT(released, mm, write, true);
+}
+EXPORT_SYMBOL(__mmap_lock_do_trace_released);
-- 
2.28.0.806.g8561365e88-goog

