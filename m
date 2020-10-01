Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56D2800C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbgJAOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33584 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732665AbgJAOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id m12so5512137otr.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBGg1IajRkPa9rDnwSTGXUDiEPHo1fymKsDmTQwxJrQ=;
        b=HzABd/Q2ndKQwRSeGnx/5Orpjg8+4g6v5ZEDFfE6vByzMi+AKmrX76V7tnXb4R+oJ1
         IYhZ6dOqviGuO3K9taklN2PoIzJY/5E/eWrA8G/gLcVc9u2lLeNrGor2iYgmiViBQQaO
         aSaomQHiCuTAR2iSmcqdNoPDaGj0dZlqKSu84hu+hHw1utYgUhjFvIh2+DKAnpKeaK6R
         hD/NgZ17l3IzoQzgtHfzqkNeemW2/WuTQJihBWc5DlcOp0/sFLoLz5nOPTi8CNhdwC+a
         HuYkg02vksn3BgHOZBt1nHzgcjF29zO/hBkeA3txNjciD+ws4t8tojLWdKEzJKKRJwv8
         NoTw==
X-Gm-Message-State: AOAM5331lxdq6zrZbvwG3bo34MVeh2xyhbWpIymd9nKK9mfKYrOSGOkY
        0wGKzkhxIrvdjAPVD9IJ4Q==
X-Google-Smtp-Source: ABdhPJynzOoN22e5DlnCvxDjJF5gwnoE8XjAFdIzm+Og5Uw09aZhdDebj/7ahpZj0VCzGQ/ZgjiVJQ==
X-Received: by 2002:a9d:bd1:: with SMTP id 75mr5099436oth.176.1601560891352;
        Thu, 01 Oct 2020 07:01:31 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:30 -0700 (PDT)
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
Subject: [PATCH v4 8/9] perf: arm64: Add test for userspace counter access on heterogeneous systems
Date:   Thu,  1 Oct 2020 09:01:15 -0500
Message-Id: <20201001140116.651970-9-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001140116.651970-1-robh@kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace counter access only works on heterogeneous systems with some
restrictions. The userspace process must be pinned to a homogeneous
subset of CPUs and must open the corresponding PMU for those CPUs. This
commit adds a test implementing these requirements.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
- Update perf_evsel__mmap params
v2:
- Drop all but heterogeneous test as others covered by libperf tests
- Rework to use libperf
---
 tools/perf/arch/arm64/include/arch-tests.h |   7 +
 tools/perf/arch/arm64/tests/Build          |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
 tools/perf/arch/arm64/tests/user-events.c  | 170 +++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 90ec4c8cb880..380ad34a3f09 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,11 +2,18 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
+#include <linux/compiler.h>
+
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
+int test__arch_unwind_sample(struct perf_sample *sample,
+			     struct thread *thread);
 #endif
 
 extern struct test arch_tests[];
+int test__rd_pinned(struct test __maybe_unused *test,
+		       int __maybe_unused subtest);
+
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index a61c06bdb757..3f9a20c17fc6 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,5 @@
 perf-y += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
+perf-y += user-events.o
 perf-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 5b1543c98022..80ce7bd3c16d 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Pinned CPU user counter access",
+		.func = test__rd_pinned,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arch/arm64/tests/user-events.c
new file mode 100644
index 000000000000..46a6b05fe3fd
--- /dev/null
+++ b/tools/perf/arch/arm64/tests/user-events.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <sched.h>
+#include <cpumap.h>
+
+#include <perf/core.h>
+#include <perf/threadmap.h>
+#include <perf/evsel.h>
+
+#include "pmu.h"
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+static int run_test(struct perf_evsel *evsel)
+{
+	int n;
+	volatile int tmp = 0;
+	u64 delta, i, loops = 1000;
+	struct perf_counts_values counts = { .val = 0 };
+
+	for (n = 0; n < 6; n++) {
+		u64 stamp, now;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		stamp = counts.val;
+
+		for (i = 0; i < loops; i++)
+			tmp++;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		now = counts.val;
+		loops *= 10;
+
+		delta = now - stamp;
+		pr_debug("%14d: %14llu\n", n, (long long)delta);
+
+		if (!delta)
+			break;
+	}
+	return delta ? 0 : -1;
+}
+
+static struct perf_pmu *pmu_for_cpu(int cpu)
+{
+	int acpu, idx;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->is_uncore)
+			continue;
+		perf_cpu_map__for_each_cpu(acpu, idx, pmu->cpus)
+			if (acpu == cpu)
+				return pmu;
+	}
+	return NULL;
+}
+
+static bool pmu_is_homogeneous(void)
+{
+	int core_cnt = 0;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_uncore && !perf_cpu_map__empty(pmu->cpus))
+			core_cnt++;
+	}
+	return core_cnt == 1;
+}
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	(void)level;
+	return vfprintf(stderr, fmt, ap);
+}
+
+static struct perf_evsel *perf_init(struct perf_event_attr *attr)
+{
+	int err;
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+
+	libperf_init(libperf_print);
+
+	threads = perf_thread_map__new_dummy();
+	if (!threads) {
+		pr_err("failed to create threads\n");
+		return NULL;
+	}
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(attr);
+	if (!evsel) {
+		pr_err("failed to create evsel\n");
+		goto out_thread;
+	}
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	if (err) {
+		pr_err("failed to open evsel\n");
+		goto out_open;
+	}
+
+	if (!perf_evsel__mmap(evsel, 0)) {
+		pr_err("failed to mmap evsel\n");
+		goto out_mmap;
+	}
+
+	return evsel;
+
+out_mmap:
+	perf_evsel__close(evsel);
+out_open:
+	perf_evsel__delete(evsel);
+out_thread:
+	perf_thread_map__put(threads);
+	return NULL;
+}
+
+int test__rd_pinned(struct test __maybe_unused *test,
+		    int __maybe_unused subtest)
+{
+	int cpu, cputmp, ret = -1;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.config = 0x8, /* Instruction count */
+		.config1 = 0, /* 32-bit counter */
+		.exclude_kernel = 1,
+	};
+	cpu_set_t cpu_set;
+	struct perf_pmu *pmu;
+
+	if (pmu_is_homogeneous())
+		return TEST_SKIP;
+
+	cpu = sched_getcpu();
+	pmu = pmu_for_cpu(cpu);
+	if (!pmu)
+		return -1;
+	attr.type = pmu->type;
+
+	CPU_ZERO(&cpu_set);
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus)
+		CPU_SET(cpu, &cpu_set);
+	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+		pr_err("Could not set affinity\n");
+
+	evsel = perf_init(&attr);
+	if (!evsel)
+		return -1;
+
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus) {
+		CPU_ZERO(&cpu_set);
+		CPU_SET(cpu, &cpu_set);
+		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+			pr_err("Could not set affinity\n");
+
+		pr_debug("Running on CPU %d\n", cpu);
+
+		ret = run_test(evsel);
+		if (ret)
+			break;
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+	return ret;
+}
-- 
2.25.1

