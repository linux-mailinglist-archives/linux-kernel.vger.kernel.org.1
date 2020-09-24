Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594AB27750F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgIXPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgIXPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:18:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:18:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m15so1834190pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DlHSo/msgaMSzxmTxKgqtpf8q6tea/erFORyL2OITnw=;
        b=s/D0DJJa4TGh6IrqRAQmvX7/dz0izT7BQkfh9KAi0NLypJJmuIHsO2laqONLAZTEL8
         wsntjsqsuS9jTix60G/KaqfGgcJgBEB0LpoKbEv2DKbjrXsbqTRMU9UikSryYKE9Pfd/
         I9m2vxppCOV5Ey47oqHPVqNOzbyW3T5OC4grZ227VDddSxlmwdRqWCaGDSERgfcbUmJH
         ulc5xBlfG6DQXsQsO5Vvlyw8WaaktXnKvE3rDxxpbnKOD2hpiw4aWJmbK5QwNeV/UFz+
         3mZfYFIKldjIze5fajbK75RPz2MO4dPtsfcRVdk1510LcFXTO+7rXRLeryqclSe8fa9v
         kckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DlHSo/msgaMSzxmTxKgqtpf8q6tea/erFORyL2OITnw=;
        b=KWrf8bpFzI0OPCfaWcPxBpygx5Nl8ASUV0pohPm7F5wRZckLkf8cgnrf6pld+8NlE7
         Ttt1OQwNOY8wkl81ZkfUuSZ9PgvmMHre9MBCnP9LsQsAungoiz2tKqkSmrdWcJrcOVcW
         ToKUbH0KkvyaAADYipCC6Btd6MOH62byH44sXxG1dGaRYdqmJhPCCV180f6RHQc3ykmK
         3L/uZsbS3keWfuLQjXSBM+3za/hRTRnE+5YXOPF/2dr5qiO/CHp+pjRtZ0R6gb2YYq9g
         5hwVbZENR7I+esLyjKtkIP0ldB/AeZu3LIs2hcHomPhRMTLRWokI12sKHokxWoqj7nEh
         aPDA==
X-Gm-Message-State: AOAM5310KfYnNPNusKkanhVHrsesEawyGHfm+Pv31Mb4nLhFg9QK1utg
        SWFHqlWPjGUs671Lr1g+qg2lRQ==
X-Google-Smtp-Source: ABdhPJxumsuGB4DhLnqTJCTMeTULo2oWYL/N7+BZmSe3uIsbIHcIRFnSOvm1Jc7z1aAk56xzgjuFqw==
X-Received: by 2002:a17:902:20b:b029:d2:5681:dcc4 with SMTP id 11-20020a170902020bb02900d25681dcc4mr4981875plc.65.1600960719109;
        Thu, 24 Sep 2020 08:18:39 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y13sm3295151pfr.141.2020.09.24.08.18.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 08:18:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephane Eranian <eranian@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 1/2] perf tests tsc: Make tsc testing as a common testing
Date:   Thu, 24 Sep 2020 23:18:14 +0800
Message-Id: <20200924151815.22930-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924151815.22930-1-leo.yan@linaro.org>
References: <20200924151815.22930-1-leo.yan@linaro.org>
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
index 69bea7996f18..8ddf81447344 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -61,6 +61,7 @@ perf-y += demangle-java-test.o
 perf-y += pfm.o
 perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
+perf-y += perf-time-to-tsc.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 651b8ea3354a..0abb5ce88962 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -345,6 +345,10 @@ static struct test generic_tests[] = {
 		.desc = "PE file support",
 		.func = test__pe_file_parsing,
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
index ef0f33c6ba23..60a1c317b8db 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -123,6 +123,7 @@ const char *test__pfm_subtest_get_desc(int subtest);
 int test__pfm_subtest_get_nr(void);
 int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
+int test__perf_time_to_tsc(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
-- 
2.17.1

