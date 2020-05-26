Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926851BE6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD2TIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2TIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:08:25 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EDC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:08:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q57so3958184qte.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qmw+ZO37LozkL1ZoGSkd+2WKSA2ofgjbDJ5kFtNavk0=;
        b=ugM1MYbB0853pduw42upIUQk62A33TkyfHzWSXzzzJG10UaDBMvLZzgj7j3xG18kan
         qBSnQnv2847Ivppvvuvo42OcDosS1a2KG+iPTcYebi5k5z4gvyuTF2RNG87trzRN27k7
         Lif9LexcEhGYQT+bTA3HBo7OC1TycaI4gRCF7yF9xxRvTC9iCl+4fNuC7AYyG3IovK2f
         tPCN7iDRPrlpL89vu2A76CVAQAs9yKE8EZoj1MlIW0kl4gn2nMa0RtwRgpbAM/7oXKeC
         EbXyId/ke7LcIJUMbznJysMJmNCumVPpTYEMJI5VeWDi2yX5PDtymp2RW335tUUXb4ym
         +pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qmw+ZO37LozkL1ZoGSkd+2WKSA2ofgjbDJ5kFtNavk0=;
        b=iqVEwJwcWPleN7fwGNDp5EeriRnYz/R9Nzeamm6FhXyZp6iEwpD2Q2Q6pZCfJTRgUO
         HKt3FKIL/6q4WQ4YYhc8TvlBGFB48SS78Gi+Ew56bh1nDksYNNJ7fZiUxaL1zMAuJJQz
         ez+mDo4Nl03/lGscTd07McSzwOMjFcbC6CrecP812nyuK51cwCXamTFHAQfQGeYde6Br
         gD4+VWRxEEM6orxdWmVWhsemy52RIYrKBTVt0/dTJs1n+OW4XP6nsAq6h8YoZX4Ul703
         HNkEZoXNqnDHEsnUo6gtGGaPSYdR88NlHdSVd9/EbCz8/BCAGtxJmjyTBI0iEcWhp2qF
         PgpA==
X-Gm-Message-State: AGi0PuYm6dr9d18sIYmm/ljNNtSVMQUhHnD7i/uqM3i3pg5btvTZlQQf
        KG/zMLaHQcKerc0mY4So5O4HVnlaMs9Z
X-Google-Smtp-Source: APiQypKcm6pZyE0q8ShvlYHjN1JO19sijFRinX6Xb+1tGteK1LRdHjSgqnbGvVrLcjZVE5reHnYX5U+QCCqb
X-Received: by 2002:ad4:4a8b:: with SMTP id h11mr32536219qvx.210.1588187302842;
 Wed, 29 Apr 2020 12:08:22 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:08:19 -0700
Message-Id: <20200429190819.64235-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3] perf test x86: address multiplexing in rdpmc test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counters may be being used for pinned or other events which inhibit the
instruction counter in the test from being scheduled - time_enabled > 0
but time_running == 0. This causes the test to fail with division by 0.
Make time_running and enabled out parameters of mmap_read_self and add a
sleep loop to ensure that the counter is running before computing the
delta.

v3. Cleans up the code by adding a single scale_count boolean. It aligns
    the code with the comments in perf_event.h as suggested by Peter
    Zijlstra.
v2. Address review feedback from Peter Zijlstra.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h       | 34 +++++++-----
 tools/include/uapi/linux/perf_event.h | 34 +++++++-----
 tools/perf/arch/x86/tests/rdpmc.c     | 80 +++++++++++++++++++--------
 3 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..4936cce0a6d0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -488,19 +488,22 @@ struct perf_event_mmap_page {
 	/*
 	 * Bits needed to read the hw events in user-space.
 	 *
-	 *   u32 seq, time_mult, time_shift, index, width;
-	 *   u64 count, enabled, running;
-	 *   u64 cyc, time_offset;
-	 *   s64 pmc = 0;
+	 *   u32 seq, time_mult, time_shift, index;
+	 *   u64 cyc, time_offset, enabled, running = -1;
+	 *   s64 count = 0;
+	 *   bool scale_count = false;
 	 *
 	 *   do {
 	 *     seq = pc->lock;
-	 *     barrier()
+	 *     barrier();
 	 *
-	 *     enabled = pc->time_enabled;
-	 *     running = pc->time_running;
+	 *     if (pc->cap_user_time) {
+	 *       enabled = pc->time_enabled;
+	 *       running = pc->time_running;
+	 *       scale_count = enabled != running && running != 0;
+	 *     }
 	 *
-	 *     if (pc->cap_usr_time && enabled != running) {
+	 *     if (scale_count) {
 	 *       cyc = rdtsc();
 	 *       time_offset = pc->time_offset;
 	 *       time_mult   = pc->time_mult;
@@ -509,9 +512,13 @@ struct perf_event_mmap_page {
 	 *
 	 *     index = pc->index;
 	 *     count = pc->offset;
-	 *     if (pc->cap_user_rdpmc && index) {
-	 *       width = pc->pmc_width;
-	 *       pmc = rdpmc(index - 1);
+	 *     if (pc->cap_user_rdpmc && index && running != 0) {
+	 *       u16 width = pc->pmc_width;
+	 *       s64 pmc = rdpmc(index - 1);
+	 *
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;  // signed shift right
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -562,8 +569,9 @@ struct perf_event_mmap_page {
 	 *              ((rem * time_mult) >> time_shift);
 	 *
 	 * Where time_offset,time_mult,time_shift and cyc are read in the
-	 * seqcount loop described above. This delta can then be added to
-	 * enabled and possible running (if index), improving the scaling:
+	 * seqcount loop described above when scale_count is true. This delta
+	 * can then be added to enabled and possible running (if index),
+	 * improving the scaling:
 	 *
 	 *   enabled += delta;
 	 *   if (index)
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..4936cce0a6d0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -488,19 +488,22 @@ struct perf_event_mmap_page {
 	/*
 	 * Bits needed to read the hw events in user-space.
 	 *
-	 *   u32 seq, time_mult, time_shift, index, width;
-	 *   u64 count, enabled, running;
-	 *   u64 cyc, time_offset;
-	 *   s64 pmc = 0;
+	 *   u32 seq, time_mult, time_shift, index;
+	 *   u64 cyc, time_offset, enabled, running = -1;
+	 *   s64 count = 0;
+	 *   bool scale_count = false;
 	 *
 	 *   do {
 	 *     seq = pc->lock;
-	 *     barrier()
+	 *     barrier();
 	 *
-	 *     enabled = pc->time_enabled;
-	 *     running = pc->time_running;
+	 *     if (pc->cap_user_time) {
+	 *       enabled = pc->time_enabled;
+	 *       running = pc->time_running;
+	 *       scale_count = enabled != running && running != 0;
+	 *     }
 	 *
-	 *     if (pc->cap_usr_time && enabled != running) {
+	 *     if (scale_count) {
 	 *       cyc = rdtsc();
 	 *       time_offset = pc->time_offset;
 	 *       time_mult   = pc->time_mult;
@@ -509,9 +512,13 @@ struct perf_event_mmap_page {
 	 *
 	 *     index = pc->index;
 	 *     count = pc->offset;
-	 *     if (pc->cap_user_rdpmc && index) {
-	 *       width = pc->pmc_width;
-	 *       pmc = rdpmc(index - 1);
+	 *     if (pc->cap_user_rdpmc && index && running != 0) {
+	 *       u16 width = pc->pmc_width;
+	 *       s64 pmc = rdpmc(index - 1);
+	 *
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;  // signed shift right
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -562,8 +569,9 @@ struct perf_event_mmap_page {
 	 *              ((rem * time_mult) >> time_shift);
 	 *
 	 * Where time_offset,time_mult,time_shift and cyc are read in the
-	 * seqcount loop described above. This delta can then be added to
-	 * enabled and possible running (if index), improving the scaling:
+	 * seqcount loop described above when scale_count is true. This delta
+	 * can then be added to enabled and possible running (if index),
+	 * improving the scaling:
 	 *
 	 *   enabled += delta;
 	 *   if (index)
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 1ea916656a2d..93e1770d03d3 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -16,13 +16,13 @@
 #include <internal/lib.h> // page_size
 #include "arch-tests.h"
 
-static u64 rdpmc(unsigned int counter)
+static s64 rdpmc(unsigned int counter)
 {
 	unsigned int low, high;
 
 	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
 
-	return low | ((u64)high) << 32;
+	return low | ((s64)high) << 32;
 }
 
 static u64 rdtsc(void)
@@ -34,49 +34,67 @@ static u64 rdtsc(void)
 	return low | ((u64)high) << 32;
 }
 
-static u64 mmap_read_self(void *addr)
+/*
+ * Return a user rdpmc result as well as the time enabled and running. In the
+ * situation that the counter was ran and the kernel is multiplexing events, the
+ * counter is scaled.
+ */
+static s64 mmap_read_self(void *addr, u64 *enabled, u64 *running)
 {
 	struct perf_event_mmap_page *pc = addr;
-	u32 seq, idx, time_mult = 0, time_shift = 0;
-	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
+	u32 seq, time_mult = 0, time_shift = 0, index;
+	u64 cyc = 0, time_offset = 0;
+	s64 count = 0;
+	bool scale_count = false;
 
+	*enabled = -1;
+	*running = -1;
 	do {
 		seq = pc->lock;
 		barrier();
 
-		enabled = pc->time_enabled;
-		running = pc->time_running;
+		if (pc->cap_user_time) {
+			*enabled = pc->time_enabled;
+			*running = pc->time_running;
+			scale_count = *enabled != *running && *running != 0;
+		}
 
-		if (enabled != running) {
+		if (scale_count) {
 			cyc = rdtsc();
 			time_mult = pc->time_mult;
 			time_shift = pc->time_shift;
 			time_offset = pc->time_offset;
 		}
 
-		idx = pc->index;
+		index = pc->index;
 		count = pc->offset;
-		if (idx)
-			count += rdpmc(idx - 1);
+		if (pc->cap_user_rdpmc && index && *running != 0) {
+			u16 width = pc->pmc_width;
+			s64 pmc = rdpmc(index - 1);
+
+			pmc <<= 64 - width;
+			pmc >>= 64 - width;  // signed shift right
+			count += pmc;
+		}
 
 		barrier();
 	} while (pc->lock != seq);
 
-	if (enabled != running) {
-		u64 quot, rem;
+	if (scale_count) {
+		u64 quot, rem, delta;
 
 		quot = (cyc >> time_shift);
 		rem = cyc & (((u64)1 << time_shift) - 1);
 		delta = time_offset + quot * time_mult +
 			((rem * time_mult) >> time_shift);
 
-		enabled += delta;
-		if (idx)
-			running += delta;
+		*enabled += delta;
+		if (index)
+			*running += delta;
 
-		quot = count / running;
-		rem = count % running;
-		count = quot * enabled + (rem * enabled) / running;
+		quot = count / *running;
+		rem = count % *running;
+		count = quot * *enabled + (rem * *enabled) / *running;
 	}
 
 	return count;
@@ -104,7 +122,7 @@ static int __test__rdpmc(void)
 		.config = PERF_COUNT_HW_INSTRUCTIONS,
 		.exclude_kernel = 1,
 	};
-	u64 delta_sum = 0;
+	u64 delta_sum = 0, sleep_count = 0;
         struct sigaction sa;
 	char sbuf[STRERR_BUFSIZE];
 
@@ -130,14 +148,23 @@ static int __test__rdpmc(void)
 	}
 
 	for (n = 0; n < 6; n++) {
-		u64 stamp, now, delta;
-
-		stamp = mmap_read_self(addr);
+		u64 stamp, now, delta, enabled, running;
+
+		for (;;) {
+			stamp = mmap_read_self(addr, &enabled, &running);
+			if (enabled && running)
+				break;
+			/* Try to wait for event to be running. */
+			sleep_count++;
+			if (sleep_count > 20)
+				goto out_never_run;
+			sleep(1);
+		}
 
 		for (i = 0; i < loops; i++)
 			tmp++;
 
-		now = mmap_read_self(addr);
+		now = mmap_read_self(addr, &enabled, &running);
 		loops *= 10;
 
 		delta = now - stamp;
@@ -155,6 +182,11 @@ static int __test__rdpmc(void)
 		return -1;
 
 	return 0;
+
+out_never_run:
+	close(fd);
+	pr_err("Event counter failed to multiplexed in. Are higher priority counters being sampled by a different process?\n");
+	return -1;
 }
 
 int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.26.2.303.gf8c07b1a785-goog

