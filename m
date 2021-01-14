Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A32F57D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbhANCIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:08:10 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42766 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbhANCG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:56 -0500
Received: by mail-ot1-f52.google.com with SMTP id x5so3876914otp.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMWBDEKf74JKkqccLeDtjQtyXiOgJF8ujNiX0uD1tgM=;
        b=n23tyCWSMT88pC5/5O7HqDPwvEKtKLu9oMNQiiVtYxlOTonORh1h+lHK+QAzhIIhNz
         RJ37xBt6J6N2MxMo0mgwKNxQXDOUmV6YRXAGv7ylAtRid5LuXLigqzfRCobaor+SEyDo
         tnuDmVc/t1Q/GTiygmn7tlhlE1T6ctxvhv84i3/rv8Rei1J9vld5D7HdZLR1c8FY4mGg
         s67QOMeJGGT8QRykaCy1Exp0JwPUgxSXqJaRiRF02NRkSl1x41UvNEcYix+LU5TAXO4G
         LkzmElG/oV+4p7DS7VlgQy4QNyJxnI9+TuS58PE8KD2l61fzbmnmGkIhNUk2oFXKtv+D
         ee/Q==
X-Gm-Message-State: AOAM5328e5zcrS2ho4kTcco/HuAvoiAJuUPOw5yTCtRETr993qEW8wNE
        oKLyW+yL5k34BSZ4PFswEA==
X-Google-Smtp-Source: ABdhPJwBKEYspqg1j2a3qdSUdWbvILQCL6YqhKzqHbLNsDOymO0a6N9WVyiO8JAlOJkU7ZXfTundEg==
X-Received: by 2002:a9d:a4e:: with SMTP id 72mr3213614otg.267.1610589975581;
        Wed, 13 Jan 2021 18:06:15 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:14 -0800 (PST)
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
Subject: [PATCH v5 5/9] libperf: tests: Add support for verbose printing
Date:   Wed, 13 Jan 2021 20:06:01 -0600
Message-Id: <20210114020605.3943992-6-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __T_VERBOSE() so tests can add verbose output. The verbose output is
enabled with the '-v' command line option.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v5:
 - Pass verbose flag to static tests
 - Fix getopt loop with unsigned char (arm64)
v3:
 - New patch
---
 tools/lib/perf/include/internal/tests.h | 32 +++++++++++++++++++++++++
 tools/lib/perf/tests/Makefile           |  6 +++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
index 2093e8868a67..29425c2dabe1 100644
--- a/tools/lib/perf/include/internal/tests.h
+++ b/tools/lib/perf/include/internal/tests.h
@@ -3,11 +3,32 @@
 #define __LIBPERF_INTERNAL_TESTS_H
 
 #include <stdio.h>
+#include <unistd.h>
 
 int tests_failed;
+int tests_verbose;
+
+static inline int get_verbose(char **argv, int argc)
+{
+	int c;
+	int verbose = 0;
+
+	while ((c = getopt(argc, argv, "v")) != -1) {
+		switch (c)
+		{
+		case 'v':
+			verbose = 1;
+			break;
+		default:
+			break;
+		}
+	}
+	return verbose;
+}
 
 #define __T_START					\
 do {							\
+	tests_verbose = get_verbose(argv, argc);	\
 	fprintf(stdout, "- running %s...", __FILE__);	\
 	fflush(NULL);					\
 	tests_failed = 0;				\
@@ -30,4 +51,15 @@ do {
 	}                                                                        \
 } while (0)
 
+#define __T_VERBOSE(...)						\
+do {									\
+	if (tests_verbose) {						\
+		if (tests_verbose == 1) {				\
+			fputc('\n', stderr);				\
+			tests_verbose++;				\
+		}							\
+		fprintf(stderr, ##__VA_ARGS__);				\
+	}								\
+} while (0)
+
 #endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/lib/perf/tests/Makefile b/tools/lib/perf/tests/Makefile
index 96841775feaf..b536cc9a26dd 100644
--- a/tools/lib/perf/tests/Makefile
+++ b/tools/lib/perf/tests/Makefile
@@ -5,6 +5,8 @@ TESTS = test-cpumap test-threadmap test-evlist test-evsel
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
 
+TEST_ARGS := $(if $(V),-v)
+
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
@@ -28,9 +30,9 @@ all: $(TESTS_A) $(TESTS_SO)
 
 run:
 	@echo "running static:"
-	@for i in $(TESTS_A); do ./$$i; done
+	@for i in $(TESTS_A); do ./$$i $(TEST_ARGS); done
 	@echo "running dynamic:"
-	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i $(TEST_ARGS); done
 
 clean:
 	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
-- 
2.27.0

