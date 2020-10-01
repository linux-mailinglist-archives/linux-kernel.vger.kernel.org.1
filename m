Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A02800C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgJAOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36168 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732653AbgJAOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so5482404otw.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qb/1NmaW7H8akre/2JRgPHAnIybatgjdXNsVGVWM4nM=;
        b=AzM74GSdqBboffdO8jqNd6U6lsp+SxZFSQ8+I4N8wh/gpUGzoEi3g2oMFpKEqtUPnw
         SG00+gwF2rrovXKQEjQkhwm+4JdnvbdtRtiVEU08k+YOksatPt6JH4v2bw+aREWKJrfE
         WJWYqfcWYKHyspdxYEKq0Udbv+xBoQrGfy7L8NbKqthhLY8ab8rbvbBpnmuwwdJ+iPxU
         lDHr9jVTBg8lbH6L1vlF1RWHozvwZNlwQfmryHDLyLjGcd1iaWwz6YVqG1KXF9RUHRx8
         zBNk0i2irOJOlgj9xyG9i+2Kz+0RygEkN/cJe8fR0dxT89xqVwQ4iEewvTTYVwaIlHAu
         Xmtw==
X-Gm-Message-State: AOAM531LpiChbNlXhYRwmkC4NT4JaoVgHAOZ0vR7ASluYqBu4FS7LqyB
        p8hGe8xA3UdwnOKP2wk/Og==
X-Google-Smtp-Source: ABdhPJyfNTManYEyv/OqEOOHkTq7jtH+k99MjyRAFpxpF3sl4AoYBmmRA05p7ACB4eEZgu88KGjmkQ==
X-Received: by 2002:a05:6830:4f:: with SMTP id d15mr5214484otp.7.1601560888531;
        Thu, 01 Oct 2020 07:01:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v4 6/9] libperf: Add support for user space counter access
Date:   Thu,  1 Oct 2020 09:01:13 -0500
Message-Id: <20201001140116.651970-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001140116.651970-1-robh@kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 and arm64 can both support direct access of event counters in
userspace. The access sequence is less than trivial and currently exists
in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
projects such as PAPI and libpfm4.

In order to support usersapce access, an event must be mmapped first
with perf_evsel__mmap(). Then subsequent calls to perf_evsel__read()
will use the fast path (assuming the arch supports it).

Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Update perf_evsel__mmap size to pages
v3:
 - Split out perf_evsel__mmap() to separate patch
---
 tools/lib/perf/evsel.c                 |  3 +
 tools/lib/perf/include/internal/mmap.h |  3 +
 tools/lib/perf/mmap.c                  | 90 ++++++++++++++++++++++++++
 tools/lib/perf/tests/test-evsel.c      | 63 ++++++++++++++++++
 4 files changed, 159 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 42eaf3c18981..e1f18d65f604 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -222,6 +222,9 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
 
+	if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
+		return 0;
+
 	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
 		return -errno;
 
diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index be7556e0a2b2..5e3422f40ed5 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -11,6 +11,7 @@
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
 struct perf_mmap;
+struct perf_counts_values;
 
 typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
 
@@ -52,4 +53,6 @@ void perf_mmap__put(struct perf_mmap *map);
 
 u64 perf_mmap__read_head(struct perf_mmap *map);
 
+int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count);
+
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 79d5ed6c38cc..cb07969cfdbf 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -8,9 +8,11 @@
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
 #include <perf/event.h>
+#include <perf/evsel.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include "internal.h"
 
 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
@@ -273,3 +275,91 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 
 	return event;
 }
+
+#if defined(__i386__) || defined(__x86_64__)
+static u64 read_perf_counter(unsigned int counter)
+{
+	unsigned int low, high;
+
+	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
+
+	return low | ((u64)high) << 32;
+}
+
+static u64 read_timestamp(void)
+{
+	unsigned int low, high;
+
+	asm volatile("rdtsc" : "=a" (low), "=d" (high));
+
+	return low | ((u64)high) << 32;
+}
+#else
+static u64 read_perf_counter(unsigned int counter) { return 0; }
+static u64 read_timestamp(void) { return 0; }
+#endif
+
+int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
+{
+	struct perf_event_mmap_page *pc = map->base;
+	u32 seq, idx, time_mult = 0, time_shift = 0;
+	u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
+
+	BUG_ON(!pc);
+
+	if (!pc->cap_user_rdpmc)
+		return -1;
+
+	do {
+		seq = READ_ONCE(pc->lock);
+		barrier();
+
+		count->ena = READ_ONCE(pc->time_enabled);
+		count->run = READ_ONCE(pc->time_running);
+
+		if (pc->cap_user_time && count->ena != count->run) {
+			cyc = read_timestamp();
+			time_mult = READ_ONCE(pc->time_mult);
+			time_shift = READ_ONCE(pc->time_shift);
+			time_offset = READ_ONCE(pc->time_offset);
+
+			if (pc->cap_user_time_short) {
+				time_cycles = READ_ONCE(pc->time_cycles);
+				time_mask = READ_ONCE(pc->time_mask);
+			}
+		}
+
+		idx = READ_ONCE(pc->index);
+		cnt = READ_ONCE(pc->offset);
+		if (pc->cap_user_rdpmc && idx) {
+			u64 evcnt = read_perf_counter(idx - 1);
+			u16 width = READ_ONCE(pc->pmc_width);
+
+			evcnt <<= 64 - width;
+			evcnt >>= 64 - width;
+			cnt += evcnt;
+		} else
+			return -1;
+
+		barrier();
+	} while (READ_ONCE(pc->lock) != seq);
+
+	if (count->ena != count->run) {
+		u64 delta;
+
+		/* Adjust for cap_usr_time_short, a nop if not */
+		cyc = time_cycles + ((cyc - time_cycles) & time_mask);
+
+		delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
+
+		count->ena += delta;
+		if (idx)
+			count->run += delta;
+
+		cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
+	}
+
+	count->val = cnt;
+
+	return 0;
+}
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 135722ac965b..eeca8203d73d 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -120,6 +120,67 @@ static int test_stat_thread_enable(void)
 	return 0;
 }
 
+static int test_stat_user_read(int event)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_mmap_page *pc;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_HARDWARE,
+		.config	= event,
+	};
+	int err, i;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	pc = perf_evsel__mmap(evsel, 0);
+	__T("failed to mmap evsel", pc);
+
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+	__T("userspace counter access not supported", pc->cap_user_rdpmc);
+	__T("userspace counter access not enabled", pc->index);
+	__T("userspace counter width not set", pc->pmc_width >= 32);
+#endif
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	for (i = 0; i < 5; i++) {
+		volatile int count = 0x10000 << i;
+		__u64 start, end, last = 0;
+
+		__T_VERBOSE("\tloop = %u, ", count);
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		start = counts.val;
+
+		while (count--) ;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		end = counts.val;
+
+		__T("invalid counter data", (end - start) > last);
+		last = end - start;
+		__T_VERBOSE("count = %llu\n", end - start);
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	__T_START;
@@ -129,6 +190,8 @@ int main(int argc, char **argv)
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
+	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
+	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
 
 	__T_END;
 	return 0;
-- 
2.25.1

