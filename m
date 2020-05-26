Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4361C7482
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgEFPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgEFPZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D768920A8B;
        Wed,  6 May 2020 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778723;
        bh=HEEk8PmAYoQEBFPU8KHu+Y/1Ujm+GfPN+zdAJQevnVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRvpW5RBa6swxJLJ632YIAG7okzjtb+N2kHvECubTsG136cjDc2GwZilvdzc+qAn+
         99ICfM1RJSMFf7ZDv56caXCbGU6Z80bE82XPHH5qjB06nRTf0i6rbsPNHqGxygIazG
         iausJCGODfqH1AJhU13AROYljaZsKALe81qhL3to=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 44/91] perf thread-stack: Add thread_stack__br_sample_late()
Date:   Wed,  6 May 2020 12:21:47 -0300
Message-Id: <20200506152234.21977-45-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a thread stack function to create a branch stack for hardware events
where the sample records get created some time after the event occurred.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 104 +++++++++++++++++++++++++++++++++
 tools/perf/util/thread-stack.h |   3 +
 2 files changed, 107 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 79698831b4b9..1b992bbba4e8 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -645,6 +645,110 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
 	}
 }
 
+/* Start of user space branch entries */
+static bool us_start(struct branch_entry *be, u64 kernel_start, bool *start)
+{
+	if (!*start)
+		*start = be->to && be->to < kernel_start;
+
+	return *start;
+}
+
+/*
+ * Start of branch entries after the ip fell in between 2 branches, or user
+ * space branch entries.
+ */
+static bool ks_start(struct branch_entry *be, u64 sample_ip, u64 kernel_start,
+		     bool *start, struct branch_entry *nb)
+{
+	if (!*start) {
+		*start = (nb && sample_ip >= be->to && sample_ip <= nb->from) ||
+			 be->from < kernel_start ||
+			 (be->to && be->to < kernel_start);
+	}
+
+	return *start;
+}
+
+/*
+ * Hardware sample records, created some time after the event occurred, need to
+ * have subsequent addresses removed from the branch stack.
+ */
+void thread_stack__br_sample_late(struct thread *thread, int cpu,
+				  struct branch_stack *dst, unsigned int sz,
+				  u64 ip, u64 kernel_start)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+	struct branch_entry *d, *s, *spos, *ssz;
+	struct branch_stack *src;
+	unsigned int nr = 0;
+	bool start = false;
+
+	dst->nr = 0;
+
+	if (!ts)
+		return;
+
+	src = ts->br_stack_rb;
+	if (!src->nr)
+		return;
+
+	spos = &src->entries[ts->br_stack_pos];
+	ssz  = &src->entries[ts->br_stack_sz];
+
+	d = &dst->entries[0];
+	s = spos;
+
+	if (ip < kernel_start) {
+		/*
+		 * User space sample: start copying branch entries when the
+		 * branch is in user space.
+		 */
+		for (s = spos; s < ssz && nr < sz; s++) {
+			if (us_start(s, kernel_start, &start)) {
+				*d++ = *s;
+				nr += 1;
+			}
+		}
+
+		if (src->nr >= ts->br_stack_sz) {
+			for (s = &src->entries[0]; s < spos && nr < sz; s++) {
+				if (us_start(s, kernel_start, &start)) {
+					*d++ = *s;
+					nr += 1;
+				}
+			}
+		}
+	} else {
+		struct branch_entry *nb = NULL;
+
+		/*
+		 * Kernel space sample: start copying branch entries when the ip
+		 * falls in between 2 branches (or the branch is in user space
+		 * because then the start must have been missed).
+		 */
+		for (s = spos; s < ssz && nr < sz; s++) {
+			if (ks_start(s, ip, kernel_start, &start, nb)) {
+				*d++ = *s;
+				nr += 1;
+			}
+			nb = s;
+		}
+
+		if (src->nr >= ts->br_stack_sz) {
+			for (s = &src->entries[0]; s < spos && nr < sz; s++) {
+				if (ks_start(s, ip, kernel_start, &start, nb)) {
+					*d++ = *s;
+					nr += 1;
+				}
+				nb = s;
+			}
+		}
+	}
+
+	dst->nr = nr;
+}
+
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index c279a0cbbdd0..3bc47a42af8e 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -91,6 +91,9 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
 			       u64 kernel_start);
 void thread_stack__br_sample(struct thread *thread, int cpu,
 			     struct branch_stack *dst, unsigned int sz);
+void thread_stack__br_sample_late(struct thread *thread, int cpu,
+				  struct branch_stack *dst, unsigned int sz,
+				  u64 sample_ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
-- 
2.21.1

