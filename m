Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B62693F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgINRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgINMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:05:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F594C061355
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so3921462pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOBJ9MjoirS+L5o0/6ixv/rHOD5sDCECP2wua5enYLg=;
        b=mFz+j23/DsHUjdmzVxlu9gnTp4M+x6SJ0Zt+v+cAtC5fobW/aJnu0UsSswHbY1B+1n
         uQzsa/PL/7EhePWKjquPfTPYyhVbxqKxTxnd0KhIPA0f+p+1uvMHQ1WgKjBBUoo5QPkq
         wjw9UvnrHMoySGqQ8T1WuVS85EPZCUuJJ8Ra3UZRRXEbL9rYZdTKzSGwr/HLlFlV3U61
         6snzU8WsY0UReB6koWGVldvJEG38Mm/rdlkKPMKjFaiz2UOSCzR/xMAQbL9JJQzoVV4H
         GYCD9gRBZDXzOKyqDu/bMtc6rMWpve3JBQmBGfr0A0m/5M0JLg9pRvh/TZ5zRproU74A
         qVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOBJ9MjoirS+L5o0/6ixv/rHOD5sDCECP2wua5enYLg=;
        b=NHiP0nw6CjG0p36Pv/C5u9W0cREAhegjLm/BbAR5gVQlXAllbSlZksGm+Wj6NnnhMT
         LwlFW7ZzA4ACBAc5qfjKnc5bb8IfkDyJoNq5gg7pKghU17l6c9T7ptVUeJdMEf7VHslL
         iDztV1Unp3fv4wbwlwi8rdjqbF45FIb0Zh5yn3ipc9VrbLg5FqW5HFdcbC5x/2eDVx5y
         D3mAsT/VUT5Q5D9M3q1BtTtkhHSO0FCKFdVZtn1WaEPfYG9lyoYbgK9QsSP7dffYdVMz
         N8WcA96ist6EllGGwTYeMy8VmgrB3fhNnLUqtCQY7MZip2btMktW97ByPZMK56pUYWo6
         oYcA==
X-Gm-Message-State: AOAM5324Uof9IFzn3+nq+OZhbY9MqHB7JTfVs8aOt16VhRR/zOWJsqhO
        PcWU4ksrZ4FU8AFlP5VM/eJwhA==
X-Google-Smtp-Source: ABdhPJzhnIQHCZNS8UAApJD38ZxCo2Rc99Md+3WX4LEEgKKEZwud4BYFnFfuxmmdE4J+gt4Uo6j9Bw==
X-Received: by 2002:a17:90a:d3cd:: with SMTP id d13mr14452003pjw.70.1600084534577;
        Mon, 14 Sep 2020 04:55:34 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i15sm3628675pfk.145.2020.09.14.04.55.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:55:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/6] perf tests tsc: Make tsc testing as a common testing
Date:   Mon, 14 Sep 2020 19:53:10 +0800
Message-Id: <20200914115311.2201-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 arch provides the testing for conversion between tsc and perf time,
the testing is located in x86 arch folder.  Move this testing out from
x86 arch folder and place it into the common testing folder, so allows
to execute tsc testing on other architectures (e.g. Arm64).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/x86/include/arch-tests.h           | 1 -
 tools/perf/arch/x86/tests/Build                    | 1 -
 tools/perf/arch/x86/tests/arch-tests.c             | 4 ----
 tools/perf/tests/Build                             | 1 +
 tools/perf/tests/builtin-test.c                    | 4 ++++
 tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c | 0
 tools/perf/tests/tests.h                           | 1 +
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (100%)

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
similarity index 100%
rename from tools/perf/arch/x86/tests/perf-time-to-tsc.c
rename to tools/perf/tests/perf-time-to-tsc.c
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

