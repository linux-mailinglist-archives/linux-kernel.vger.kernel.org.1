Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB65B277510
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgIXPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgIXPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:18:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D83C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:18:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so1829960plt.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=subQd7H0xCv+i94BqfvfOBk2O4HVh7NJGTRdMFF+r4M=;
        b=eDprx9t4AwfaSJ0p2GoPAbiiY7PnFKiaT1Mr1c40MKTrk7KTpMN6agr4Lgu9yQ46Rk
         lwpHj4i0QfgCMIz8HLfBMnxo7gDgNX1QUPOLeMOEo+oGl9U6bBdsvhIzItUAilQXNbiL
         ccwzda+o0VytJKWM2Xi/3moUEtFbGtO1McbKtaqYH/IcTwkcoN/+ErE5Gg2mKET+vB3c
         TqcNB6yTBRft39otwVkDucKtDcVjUhL1+zviwhsXZFJIdRnmuUPG/DZIC8dSQ0FLeyoY
         FkibibR797/lC+PeulixGUIisC2wk0pTJykOxtGuT9/9o9IJvPAjjk+wb2wUYTabtf9S
         bn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=subQd7H0xCv+i94BqfvfOBk2O4HVh7NJGTRdMFF+r4M=;
        b=cabQmzOvCAO5WMbeVbmmzr3m5wz5GWyw+NT2NZGoysTRrcE6pnkGYcgHQpJhQGZQO9
         ppzShxro8ObtO/19j3E9WOKmq7rDpsq+hYc8V3qP80boCqA30XS6r1zjzR8yHGIgk68c
         aPcC5HSWbGU/2/b/ScEuZ+CJVRqZVLVmaW8lVUGgoIEI9WfNrVPE37N9H8XLcx0s+qsR
         CNphlKEwPMPpZF39vCg8n9Pu+zBEbL/tyJR2hsttCfaOiRBuRX0XaVcLpSAbeyquIMhh
         ff7Tx0PDW3qS8/qbKpxVMWYq5E5ChvMF8pUd2ReGuIawsm4mtKfduiD0f1L19lCVk+1u
         AjBw==
X-Gm-Message-State: AOAM531BJmtNZADns821UNsW9XoAnri4o2zt3zyazlz9q9mK4re7cgUE
        6LhyOanlrwywF3WJUYgWZUEiGA==
X-Google-Smtp-Source: ABdhPJynAULd/UPE7k/GicRS/OItZBHOk+FnqipOxArhnQGI7mwt+uNnFsl/uKS5u/Xlz706ZQYjeA==
X-Received: by 2002:a17:902:7248:b029:d2:2a05:6eed with SMTP id c8-20020a1709027248b02900d22a056eedmr5072810pll.80.1600960723217;
        Thu, 24 Sep 2020 08:18:43 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y5sm3638073pge.62.2020.09.24.08.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 08:18:42 -0700 (PDT)
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
Subject: [PATCH v5 2/2] perf tests tsc: Add checking helper is_supported()
Date:   Thu, 24 Sep 2020 23:18:15 +0800
Message-Id: <20200924151815.22930-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924151815.22930-1-leo.yan@linaro.org>
References: <20200924151815.22930-1-leo.yan@linaro.org>
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
index aee97c16c0d9..a9560e0f6360 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -169,3 +169,16 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
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

