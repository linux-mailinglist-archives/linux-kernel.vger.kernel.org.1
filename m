Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF249292521
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgJSKDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgJSKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:03:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA74C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:03:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so5725411pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufof31RYiQXOa59W6k1vboLgDJlzH4aHFfSI/4F0ths=;
        b=GjGqdhPoiMGy/w6QYFCYeKzS7gGxue+Ud5zV6lNE5Ax3vDuY81YVFnoO9FIANc07N/
         109UJbXInDOouquduh+cAmusrpiaBVqPjh8O0OwFrURTgIrlYoVRiWdgTkM0v/yb0lWS
         TiP8DmtV+iQNB1HSSTH2FV6znQynhfhvP3QNcZOszAH/rqHYZSllzkG7BpaKJJ5x1iuA
         Cx73AOi+NPK67oBJT8DMysTsz63FSemFNJm8zrZKjSuqnOgNw6ME55eWZCGL+ojNW33a
         UOKaBKNQp0IEeDn07Jj6bjpV4iQKfD3SFaz+j7K566hkwMpEMdkB94F2/Id2BXO7UyGF
         Uwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ufof31RYiQXOa59W6k1vboLgDJlzH4aHFfSI/4F0ths=;
        b=mNPJEOSD+ksL/p3Y2D6plv3yvhmIgCRUo93S4NaGd+1E9VdpjaW1MAQDBQEqQYicxB
         IT2MHSQgjry6MZHz2YBKy+5uP8Jo80Zo5kMUFsnFa9V2ltonUh163dJCSBNw1ErdNvQ0
         MTrTnnIZhJL1rzR15W6qp1TXbSIz2XVhKqTnYW1owSMo9tFGoxPwf5HFJyMA+IedLTvJ
         gjIN8AFbVKJDFM9su6+SDYdxBYLwDu49viXLwQJFZacr168ZNy9m4pvu3QVnTTaWQCuk
         HWnIxsf7ljItrFzIvyqI5CIIoR4ag4B2fdpuJJPY/Ap6gJJixTCgQerYuurrrlgArpG2
         BdgA==
X-Gm-Message-State: AOAM533y7Y/Gs2X2E6PapQ4Ero+MkzgIP+tCviXieNYcJLd5cvVSS3Pm
        p/U5dPYGqCpdFV06hSsMTnjPAw==
X-Google-Smtp-Source: ABdhPJyk+Kb3YgmmHhRrn8Exmn3KGFLaauymigvH1FVCD1Wa7olABVpsYP5H9fW0/e78raslCl7E+Q==
X-Received: by 2002:a63:4083:: with SMTP id n125mr13825889pga.290.1603101780109;
        Mon, 19 Oct 2020 03:03:00 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x29sm11424483pfp.152.2020.10.19.03.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 03:02:59 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 1/2] perf tests tsc: Make tsc testing as a common testing
Date:   Mon, 19 Oct 2020 18:02:35 +0800
Message-Id: <20201019100236.23675-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019100236.23675-1-leo.yan@linaro.org>
References: <20201019100236.23675-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 arch provides the testing for conversion between tsc and perf time,
the testing is located in x86 arch folder.  Move this testing out from
x86 arch folder and place it into the common testing folder, so allows
to execute tsc testing on other architectures (e.g. Arm64).

This patch removes the inclusion of "arch-tests.h" from the testing
code, this can avoid building failure if any arch has no this header
file.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/x86/include/arch-tests.h           | 1 -
 tools/perf/arch/x86/tests/Build                    | 1 -
 tools/perf/arch/x86/tests/arch-tests.c             | 4 ----
 tools/perf/tests/Build                             | 1 +
 tools/perf/tests/builtin-test.c                    | 4 ++++
 tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c | 6 ++----
 tools/perf/tests/tests.h                           | 1 +
 7 files changed, 8 insertions(+), 10 deletions(-)
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (98%)

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index c41c5affe4be..6a54b94f1c25 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -7,7 +7,6 @@ struct test;
 
 /* Tests */
 int test__rdpmc(struct test *test __maybe_unused, int subtest);
-int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
 int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 2997c506550c..36d4f248b51d 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -3,6 +3,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
 perf-y += rdpmc.o
-perf-y += perf-time-to-tsc.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 6763135aec17..bc25d727b4e9 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -8,10 +8,6 @@ struct test arch_tests[] = {
 		.desc = "x86 rdpmc",
 		.func = test__rdpmc,
 	},
-	{
-		.desc = "Convert perf time to TSC",
-		.func = test__perf_time_to_tsc,
-	},
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	{
 		.desc = "DWARF unwind",
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 4d15bf6041fb..aa4dc4f5abde 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -62,6 +62,7 @@ perf-y += pfm.o
 perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
+perf-y += perf-time-to-tsc.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 132bdb3e6c31..02e7bbf70419 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -349,6 +349,10 @@ static struct test generic_tests[] = {
 		.desc = "Event expansion for cgroups",
 		.func = test__expand_cgroup_events,
 	},
+	{
+		.desc = "Convert perf time to TSC",
+		.func = test__perf_time_to_tsc,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
similarity index 98%
rename from tools/perf/arch/x86/tests/perf-time-to-tsc.c
rename to tools/perf/tests/perf-time-to-tsc.c
index 026d32ed078e..aee97c16c0d9 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -18,10 +18,8 @@
 #include "thread_map.h"
 #include "record.h"
 #include "tsc.h"
-#include "util/mmap.h"
-#include "tests/tests.h"
-
-#include "arch-tests.h"
+#include "mmap.h"
+#include "tests.h"
 
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index c85a2c08e407..c9b180e640e5 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -124,6 +124,7 @@ int test__pfm_subtest_get_nr(void);
 int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
 int test__expand_cgroup_events(struct test *test, int subtest);
+int test__perf_time_to_tsc(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
-- 
2.17.1

