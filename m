Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35B429426F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437720AbgJTSr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437595AbgJTSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:47:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105FAC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:47:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d5so2649982qkg.16
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nOu5990EAVWcl0vENKdyJ6wWQ+WSv1D3fkNhY8O16/s=;
        b=bM0YAINO4DolnTNqcOiAoMMaNMmGNU2g4O9x3IkxwhodiYoLs+gJgf1AtuOE6ysf5c
         pPR6DdMtm2v9AWN4Ll+stnYkfd5T94MQLu5UqYV9WP47IuWyzVf1sdouYWizZWP0/8cp
         7HhFP0nNMBnlv6qO6lRcCj5Z7hLXLkjxfQm326PxmrgZ2GqTcjTx0LI9UX9qHRVdsx/7
         +jkyA8PQb6vj3TDhu5lUi3Pj49JPK+lWTC2/XNXbw/+2mFoBldketIxBECZT2Air9eQ3
         yiCs/X0dwnamRtAHHjWCY3p5avwpDuLwvKOy3ZYQxg6Bvq951YSMFj7G8o549fKBneZG
         rMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nOu5990EAVWcl0vENKdyJ6wWQ+WSv1D3fkNhY8O16/s=;
        b=da0wlL2MwyuTJLCAS3+6/+o8McGUX1idMzEV/6KoKFUyFRbqr4IG2OXjnv71xoTtlc
         BZ+Fvr4epNOAyghB72IRBUAUS/6P8P7xwCVup+0OxVW+Fm8HYJSGwhE+tODQETwTnCBy
         YjflZOgwrNsS4U/lbxcshfajnOVEuW6qEVarzPFb00dM1VnAtYyL94hvnsLcDY/Q7H0C
         +Bg4rwFmBc0VyL1eut9L1MqWqs3AjCynosiq+/sz8c1NlDzYoPcHSKJzZjOeO0iQvarS
         3sjcn9kUGb075JzFRqNjFJROhIZDeo1zNHfq5+SM8PR4tF9s+k1v9I8iX0E0yIc3sP/O
         Bfyw==
X-Gm-Message-State: AOAM530gr8E5bkR5Ll1ipEcXtWdRqbgjFrErgQo9/TUvKdEEs17PymSM
        vS+bKJWmsEcU6I+QXd9p3kiLRFdaynFlZz7r6RDq
X-Google-Smtp-Source: ABdhPJxMUUBvTB0kRbndXitw+F3FhGXvMgMiRTyJLGiaW4F6WD9OCc1Bh0vH94c7z/TpowGXgME7mRtcqlF8KHijn0Ji
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:e387:: with SMTP id
 a7mr4802058qvl.21.1603219675121; Tue, 20 Oct 2020 11:47:55 -0700 (PDT)
Date:   Tue, 20 Oct 2020 11:47:46 -0700
In-Reply-To: <20201020184746.300555-1-axelrasmussen@google.com>
Message-Id: <20201020184746.300555-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20201020184746.300555-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v4 1/1] mmap_lock: add tracepoints around lock acquisition
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Rientjes <rientjes@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
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

Reviewed-by: Michel Lespinasse <walken@google.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/mmap_lock.h        | 93 ++++++++++++++++++++++++++++--
 include/trace/events/mmap_lock.h | 98 ++++++++++++++++++++++++++++++++
 mm/Makefile                      |  2 +-
 mm/mmap_lock.c                   | 80 ++++++++++++++++++++++++++
 4 files changed, 267 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index e1afb420fc94..453d82879266 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,11 +1,63 @@
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
+static inline void __mmap_lock_trace_start_locking(struct mm_struct *mm,
+						   bool write)
+{
+	if (tracepoint_enabled(mmap_lock_start_locking))
+		__mmap_lock_do_trace_start_locking(mm, write);
+}
+
+static inline void __mmap_lock_trace_acquire_returned(struct mm_struct *mm,
+						      bool write, bool success)
+{
+	if (tracepoint_enabled(mmap_lock_acquire_returned))
+		__mmap_lock_do_trace_acquire_returned(mm, write, success);
+}
+
+static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
+{
+	if (tracepoint_enabled(mmap_lock_released))
+		__mmap_lock_do_trace_released(mm, write);
+}
+
+#else /* !CONFIG_TRACING */
+
+static inline void __mmap_lock_trace_start_locking(struct mm_struct *mm,
+						   bool write)
+{
+}
+static inline void __mmap_lock_trace_acquire_returned(struct mm_struct *mm,
+						      bool write, bool success)
+{
+}
+static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
+{
+}
+
+#endif /* CONFIG_TRACING */
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -13,58 +65,88 @@ static inline void mmap_init_lock(struct mm_struct *mm)
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
+	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
 static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
+	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
-	return down_write_killable(&mm->mmap_lock);
+	int ret;
+
+	__mmap_lock_trace_start_locking(mm, true);
+	ret = down_write_killable(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
+	return ret;
 }
 
 static inline bool mmap_write_trylock(struct mm_struct *mm)
 {
-	return down_write_trylock(&mm->mmap_lock) != 0;
+	bool ret;
+
+	__mmap_lock_trace_start_locking(mm, true);
+	ret = down_write_trylock(&mm->mmap_lock) != 0;
+	__mmap_lock_trace_acquire_returned(mm, true, ret);
+	return ret;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	up_write(&mm->mmap_lock);
+	__mmap_lock_trace_released(mm, true);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	downgrade_write(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
 
 static inline void mmap_read_lock(struct mm_struct *mm)
 {
+	__mmap_lock_trace_start_locking(mm, false);
 	down_read(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
 
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
-	return down_read_killable(&mm->mmap_lock);
+	int ret;
+
+	__mmap_lock_trace_start_locking(mm, false);
+	ret = down_read_killable(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, ret == 0);
+	return ret;
 }
 
 static inline bool mmap_read_trylock(struct mm_struct *mm)
 {
-	return down_read_trylock(&mm->mmap_lock) != 0;
+	bool ret;
+
+	__mmap_lock_trace_start_locking(mm, false);
+	ret = down_read_trylock(&mm->mmap_lock) != 0;
+	__mmap_lock_trace_acquire_returned(mm, false, ret);
+	return ret;
 }
 
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
 	up_read(&mm->mmap_lock);
+	__mmap_lock_trace_released(mm, false);
 }
 
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 {
-	if (down_read_trylock(&mm->mmap_lock)) {
+	if (mmap_read_trylock(mm)) {
 		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
+		__mmap_lock_trace_released(mm, false);
 		return true;
 	}
 	return false;
@@ -73,6 +155,7 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
 	up_read_non_owner(&mm->mmap_lock);
+	__mmap_lock_trace_released(mm, false);
 }
 
 static inline void mmap_assert_locked(struct mm_struct *mm)
diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
new file mode 100644
index 000000000000..2268ff967072
--- /dev/null
+++ b/include/trace/events/mmap_lock.h
@@ -0,0 +1,98 @@
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
+TRACE_EVENT(mmap_lock_start_locking,
+
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
+
+	TP_ARGS(mm, memcg_path, write),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__string(memcg_path, memcg_path)
+		__field(bool, write)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__assign_str(memcg_path, memcg_path);
+		__entry->write = write;
+	),
+
+	TP_printk(
+		"mm=%p memcg_path=%s write=%s\n",
+		__entry->mm,
+		__get_str(memcg_path),
+		__entry->write ? "true" : "false"
+	)
+);
+
+TRACE_EVENT(mmap_lock_acquire_returned,
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
+		__entry->success ? "true" : "false"
+	)
+);
+
+TRACE_EVENT(mmap_lock_released,
+
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
+
+	TP_ARGS(mm, memcg_path, write),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__string(memcg_path, memcg_path)
+		__field(bool, write)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__assign_str(memcg_path, memcg_path);
+		__entry->write = write;
+	),
+
+	TP_printk(
+		"mm=%p memcg_path=%s write=%s\n",
+		__entry->mm,
+		__get_str(memcg_path),
+		__entry->write ? "true" : "false"
+	)
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
index 000000000000..52741eff7bea
--- /dev/null
+++ b/mm/mmap_lock.c
@@ -0,0 +1,80 @@
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
+EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
+EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
+EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
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
+		get_cpu();                                                     \
+		trace_mmap_lock_##type(mm, get_mm_memcg_path(mm),              \
+				       ##__VA_ARGS__);                         \
+		put_cpu();                                                     \
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
+	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
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
+	TRACE_MMAP_LOCK_EVENT(released, mm, write);
+}
+EXPORT_SYMBOL(__mmap_lock_do_trace_released);
-- 
2.29.0.rc1.297.gfa9743e501-goog

