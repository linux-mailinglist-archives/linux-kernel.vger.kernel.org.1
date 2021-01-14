Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0162F57D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbhANCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:07:55 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46481 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbhANCG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:58 -0500
Received: by mail-ot1-f48.google.com with SMTP id w3so3853858otp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWZ9sb+/pmxpB5AUaU8HBcSaDugYJXil5VRkIiBxzR8=;
        b=ec1WxOupEkZ8VW2l6/mkPlk7/+zDhFUve6hgJyInrdyrYsR50nIsolLsJmSCLQXjjy
         n9sJ/hgGtiaYFbiLvSvgNmbt2dBqJsHo0agnx3g6+3lVlJZlC6GYzwAVCs2XbSAP/0OL
         YjtuYSANalG/R2ICzJ8rbICxIChyV10jXJHIk3q3kE76Ch6HncEnCLBW9gspg0rEHmd3
         oIslJAExrxatoxXywrO2TbP9Z9Q7VrnOHWtSZktuUMFynlgDfPD06QoSzkdfqx2HuL5F
         S272ztc9aHJXHeDSC81xEz9YsW7bUMQ3/YNHbjKJH/F2fYn1EAT7MW/dfSbvutXTs4V8
         THqA==
X-Gm-Message-State: AOAM531onx7DriGw+/Z/47wtpulx7s7RlVmd9qWTAoirwN6sm9/agn+3
        V1I5Y9QPuTRtzZLrYerlEA==
X-Google-Smtp-Source: ABdhPJzE/DsywIZzx9D/7NoNY9uZqweBFwlQBKOeQgJw26X2MrFYS1zCwKZ1MKZeEfL+H2iCrOqzMQ==
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr3165381oto.90.1610589977026;
        Wed, 13 Jan 2021 18:06:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 6/9] libperf: Add support for user space counter access
Date:   Wed, 13 Jan 2021 20:06:02 -0600
Message-Id: <20210114020605.3943992-7-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
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
v5:
 - Make raw count s64 instead of u64 so that counter width shifting
   works
 - Adapt to mmap changes
v4:
 - Update perf_evsel__mmap size to pages
v3:
 - Split out perf_evsel__mmap() to separate patch

squash! libperf: Add support for user space counter access
---
 tools/lib/perf/evsel.c                 |  3 +
 tools/lib/perf/include/internal/mmap.h |  3 +
 tools/lib/perf/mmap.c                  | 88 ++++++++++++++++++++++++++
 tools/lib/perf/tests/test-evsel.c      | 65 +++++++++++++++++++
 4 files changed, 159 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 0b5bdf4badae..c0ecac77c85e 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -234,6 +234,9 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
 
+	if (!perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
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
index 79d5ed6c38cc..915469f00cf4 100644
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
@@ -273,3 +275,89 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 
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
+	if (!pc || !pc->cap_user_rdpmc)
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
+			s64 evcnt = read_perf_counter(idx - 1);
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
index 135722ac965b..95380ce7e76c 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -120,6 +120,69 @@ static int test_stat_thread_enable(void)
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
+	err = perf_evsel__mmap(evsel, 0);
+	__T("failed to mmap evsel", err == 0);
+
+	pc = perf_evsel__mmap_base(evsel, 0, 0);
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
@@ -129,6 +192,8 @@ int main(int argc, char **argv)
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
+	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
+	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
 
 	__T_END;
 	return 0;
-- 
2.27.0

