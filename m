Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0045A2693ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgINMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:05:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1426C061356
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so5420529pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USSoWqTLQC6v1WLfARfFq+pVWAIHjEU5sK5PvidLdGc=;
        b=jCgsYkQlvyk7xLwBgGmTjchRWziS1lk31OKpWV+nkfj8rz/fsxfGpEluTFjXE2TqnV
         IelfNmdpPlV9uZvIRhhxTDl7I4jqs3GDslfjbrNZhmvSBEFl1uGLijm8P359ozTVWYMB
         pgB95szyeJAR5EQGmFaOEDcHiRJVvpMAjzfVXcNHFk1CXv9sl/9HzU68lQB6r4AltMXm
         xBTaYql1fiHKcbpjPL5HGCzzcLvkJb2f2CiH4q4LA0rzpiM6UCL4lt19qGQjYtnUmCIj
         A/b4GxoaHBuWfzEu1ssTktlVDVtAU967S1D+avCXAcGEzEsysw9wqW+6MHkoMx3119JH
         Ttlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=USSoWqTLQC6v1WLfARfFq+pVWAIHjEU5sK5PvidLdGc=;
        b=VIDwbLIDchLCqI6F3WtLp+ywKPUANBGsyQdMs0SD8bQdPrk7FQ2WgnGEcjCA1F04on
         r9EOCbvC6bU+uGnjQItDl16rZm9Z2DduewN5kFak/Miaxt6fQ6ChuCXDEsNzYCedP/qK
         3wClKTWI9i3TlgtegUWmo9R5ufDjuBSpKrTT/2Ho8Cw94g4/7mVPBFtQngMwz7Xx/It7
         SAgKNFB+zpp0xCWtuFSQ1q4KkVQmtqnSNV6h5cv+Z38t/LqdGSeBSAMSgFKhZlmGCTBp
         rMqUmF5ICnQHHDYb7OmSuY3GzOZ5h1H3I2RvdJMAe4y6i9Acvn2JRB54RTsIz69j2lSa
         hiEg==
X-Gm-Message-State: AOAM531zqfA8IKncrzrW7kCQPFb9ejNtsiaICOnarsAXBtgXDK7rvHjC
        Qlon5UJW6fHhb0bGzRk5cQtxbA==
X-Google-Smtp-Source: ABdhPJwDDJyYR/9kOYREWO7yiSBLaOJtOd4EQfMPYei15KHGHfhINzf6uZxyrpwLG1vsxF/wiIoGAQ==
X-Received: by 2002:a17:90a:db05:: with SMTP id g5mr14210632pjv.22.1600084540825;
        Mon, 14 Sep 2020 04:55:40 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id c9sm3506128pfn.78.2020.09.14.04.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:55:40 -0700 (PDT)
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
Subject: [PATCH v4 6/6] perf tests tsc: Add checking helper is_supported()
Date:   Mon, 14 Sep 2020 19:53:11 +0800
Message-Id: <20200914115311.2201-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far tsc is enabled on x86_64, i386 and Arm64 architectures, add
checking helper to skip this testing for other architectures.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/builtin-test.c     |  1 +
 tools/perf/tests/perf-time-to-tsc.c | 13 +++++++++++++
 tools/perf/tests/tests.h            |  1 +
 3 files changed, 15 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0abb5ce88962..60682e945f9b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -348,6 +348,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Convert perf time to TSC",
 		.func = test__perf_time_to_tsc,
+		.is_supported = test__tsc_is_supported,
 	},
 	{
 		.func = NULL,
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 026d32ed078e..41dadd4cd097 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -171,3 +171,16 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evlist__delete(evlist);
 	return err;
 }
+
+bool test__tsc_is_supported(void)
+{
+	/*
+	 * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.
+	 * Just enable the test for x86_64/i386 and Arm64 archs.
+	 */
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
+	return true;
+#else
+	return false;
+#endif
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 60a1c317b8db..9f1eedb21eee 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -128,6 +128,7 @@ int test__perf_time_to_tsc(struct test *test, int subtest);
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
+bool test__tsc_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-- 
2.17.1

