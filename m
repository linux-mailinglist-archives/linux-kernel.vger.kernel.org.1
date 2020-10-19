Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09E292522
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgJSKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgJSKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:03:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE04C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:03:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so5739865pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDFdXMe8XDk1EcL38X1C0KG0UZX1eJrknoepkr71B0w=;
        b=SCT3zHmSFBbP+zANnM+et31sFxU/qHFK+4eDcV1PCcZWR1BQI3/TYw/JFbXQJFnOin
         SQMVJCnV5XveH1mLmhiONzE1vDSG6uTgeVnu7l/gnd5LdM5TO1bbNLbRywYEHdyXbFel
         k7k2DMIONL3ioOVtzuqMskUTG0kQtNsYDwXtj4NwmjvZs0lfPknwKDV1TTNopVmLg8iR
         MC6jTkc5w/n0nrxzaNpTw1VPKjkoAiyB/dH4L5y1Uabi03CxmBXbSO4MuJgkvP/4IiNw
         wV6bcNMxV3bd+X/3T6rTwHp/GsOB3k2cDwK0Ydnkct9xE7XvjfgtfK1TC6vWePWkxmyg
         3KRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDFdXMe8XDk1EcL38X1C0KG0UZX1eJrknoepkr71B0w=;
        b=rFMPZBd+yyUih9gEFhTmEFX6c/iq5UFsEbIzxT6ucG/pf2Psh66AYz8msHtKOsijJE
         YgmeB+xyK3BuNtoer4Uv3iLUEp0KjkpcfYJNZQWycgcqG4FUGvvMmLqwUCI/kq6MPmcW
         rpYelVSZXcF+HcSSXMA5sJ7Av1XR5ubHfu/VUEtBmDaC/ln7KuJccEuFdZTm+AiMKilD
         vFgtinVUU7XZGxgZo/7bvd2T8TBJCq93EGYByB18p4I/sSAUv3xb/YfWa4xDqRaPpr6Y
         X2KqTPvwiK0kdQJ20mHF9qtV8RcY2QX2+7ftg5fwIRBxB94NpDB5A/x6UW1WBRaQ66+0
         hpIA==
X-Gm-Message-State: AOAM533FQGT9BZXPcpoO2P1lwwWKvqXCaW5sGZqL/cUbYHE2TXbh/IB6
        5EASvmMv0T6oy4TorfJu+u4JMQ==
X-Google-Smtp-Source: ABdhPJxt4obBRn2DvF0qtZMmmTIh2wS/V27YAZRiJDJvPPMA4CF02elqgMvxAgj+P7AXNBR6+tRn2w==
X-Received: by 2002:aa7:8f37:0:b029:155:30d4:f8db with SMTP id y23-20020aa78f370000b029015530d4f8dbmr16608085pfr.42.1603101784440;
        Mon, 19 Oct 2020 03:03:04 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id mn11sm5932417pjb.19.2020.10.19.03.03.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 03:03:03 -0700 (PDT)
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
Subject: [PATCH v6 2/2] perf tests tsc: Add checking helper is_supported()
Date:   Mon, 19 Oct 2020 18:02:36 +0800
Message-Id: <20201019100236.23675-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019100236.23675-1-leo.yan@linaro.org>
References: <20201019100236.23675-1-leo.yan@linaro.org>
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
index 02e7bbf70419..a185904c47f3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -352,6 +352,7 @@ static struct test generic_tests[] = {
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
index c9b180e640e5..b1f2aac93b33 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -129,6 +129,7 @@ int test__perf_time_to_tsc(struct test *test, int subtest);
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
+bool test__tsc_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-- 
2.17.1

