Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A2266A50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgIKVvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:51:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34448 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgIKVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:51:36 -0400
Received: by mail-io1-f66.google.com with SMTP id m17so12665356ioo.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/npTokW0/caRR52NC7zd+V6Q4Uga9BFc73EKnUd7cho=;
        b=TUJrkC8094sn6QUe/d9aeIzEes3KRxGyAzuW9ISurLZX1ZZ34vsh/AJscPJHZ3Gj2P
         qE/r8saR2MG3PLNM/aI58VoDeY3nS1to7sfX1LNsquu9FXkLDwfbOQzLJI/3pHNDwwxx
         deHxXhKzSy3MWH0jxSJsugiJZfKVEzPimY3L0kXS/FbbLKJ3IbdnwYjo/MvB6FcxBPsj
         cgIvFRPS0S3pDngOmHENlquXK1vnPyoDvYsYEPkENMjgZ3iEqOt+zlWjKL4uTw7aV4aj
         bGg5S2u8uHni4gWdUD/H4HQFlm9DMh8wj+RhlxclA7GWLw+MRYQAXnCRQQQazWMd4F0A
         u9Fw==
X-Gm-Message-State: AOAM532utzY/Eb9+s1mkUSqiSBrVG4HV8cw/KAvCeXobMajbmlfhFKP5
        N5pK/LW4/MJdiPYRAyCHtg==
X-Google-Smtp-Source: ABdhPJz0vpSPSRibmUpyZYBeQKi+Pzj5seDWNa5DO0RyUCladhPQE6RN8oB+cgU5JyUwo/397dM5jQ==
X-Received: by 2002:a05:6638:13c4:: with SMTP id i4mr3938717jaj.85.1599861089433;
        Fri, 11 Sep 2020 14:51:29 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a20sm1927966ilq.57.2020.09.11.14.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:51:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v3 06/10] libperf: tests: Add support for verbose printing
Date:   Fri, 11 Sep 2020 15:51:14 -0600
Message-Id: <20200911215118.2887710-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911215118.2887710-1-robh@kernel.org>
References: <20200911215118.2887710-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __T_VERBOSE() so tests can add verbose output. The verbose output is
enabled with the '-v' command line option.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - New patch
---
 tools/lib/perf/include/internal/tests.h | 32 +++++++++++++++++++++++++
 tools/lib/perf/tests/Makefile           |  4 +++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
index 2093e8868a67..27b6e64299e2 100644
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
+	char c;
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
index 96841775feaf..9438b385d489 100644
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
@@ -30,7 +32,7 @@ run:
 	@echo "running static:"
 	@for i in $(TESTS_A); do ./$$i; done
 	@echo "running dynamic:"
-	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i $(TEST_ARGS); done
 
 clean:
 	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
-- 
2.25.1

