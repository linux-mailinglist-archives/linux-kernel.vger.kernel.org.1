Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7062B297E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKNAII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNAII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:08:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:08:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v13so8488042ybe.18
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=eTdjv2rngDcsaDWT4WQKH1RsSRvVouhbrVuptq5s48Y=;
        b=Ohksk+KB272p6u87RNhfUuLZXl58HRUjNbyL87mj/sutTkuUas2CENsR71uVn7W52w
         06VcP4T/wkC2zkU0PistGGftNlmXYCQSzWhBc5D/pEzIhAgGedf0c8RGozf36DX7UP/J
         E0h8vGJBTZmuwTLT+Aynwc0zVdR1+sc83Fj1VpBPafOl6KzponPuVedAX8w2Wuer+8MJ
         o8ZrX1R6ifqIyPYF/v/9i2WvKNZ9vTd4ztG06SY8pJ1bwlDfzXt+EdbxQzlaOoPY7wr5
         ZWNVSRrAEs2pmROAyoi21a+KeoWKsYgBF5oneMZkdxj9ytDzwbfVi2ppFUFsZ5EEjKIN
         rHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=eTdjv2rngDcsaDWT4WQKH1RsSRvVouhbrVuptq5s48Y=;
        b=cCB4lUhbLaJjTD/cA18npy+LN8i2G9MkxBKnWIYUKvAnMe/qyY6HXnmrOp5MbKb/8e
         fH+hIKMHTQKod2hvqKR4lF+0D9NfTA+2YZ5T0lF6E9/Gc2Fmq0r56ZNN2To/DA4Pbkii
         tuCT5nHeoZ8Y2C8btn37F6MfqBUmCJoEv38h5tshkMroI95TJnOB7ppHpJcgFaMycaHt
         WUV3U48+ffVxVqvwhMorlnXf3lAdHkT2wkNhXOLS7jvjXkj4SZOyu9lOjtI1xQydYxYv
         IHFxCy98i1WWATOvVmQMD78ke7PDMGKf2r6YxK7oU+EjUoCKX1SzlaVWZkEXM8px45Im
         5JHw==
X-Gm-Message-State: AOAM533F2GFoLKACoShbPEqaE1Wgh+YY8MmhGmf61OD0ir/a0DMwU1x8
        eif6htmdmY0K1n/NqpEqrjF73h3YFtZT
X-Google-Smtp-Source: ABdhPJzibzamHePnxBf+A4piCsu4MGx6D9wlL0PVQxhkOPJeWVilpO1ArNnVKVOos72VtYAL67XHAH3mtito
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:fc1c:: with SMTP id
 v28mr4954437ybd.356.1605312487133; Fri, 13 Nov 2020 16:08:07 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:08:03 -0800
Message-Id: <20201114000803.909530-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] perf test: Fix dwarf unwind for optimized builds.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure the stack frames are on the stack tail calls optimizations
need to be inhibited. If your compiler supports an attribute use it,
otherwise use an asm volatile barrier.

The barrier fix was suggested here:
https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/

Fixes: 9ae1e990f1ab ("perf tools: Remove broken __no_tail_call
       attribute")
---
 tools/perf/tests/dwarf-unwind.c | 39 +++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 83638097c3bc..c8ce86bceea8 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -24,6 +24,23 @@
 /* For bsearch. We try to unwind functions in shared object. */
 #include <stdlib.h>
 
+/*
+ * The test will assert frames are on the stack but tail call optimizations lose
+ * the frame of the caller. Clang can disable this optimization on a called
+ * function but GCC currently (11/2020) lacks this attribute. The barrier is
+ * used to inhibit tail calls in these cases.
+ */
+#ifdef __has_attribute
+#if __has_attribute(disable_tail_calls)
+#define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
+#define NO_TAIL_CALL_BARRIER
+#endif
+#endif
+#ifndef NO_TAIL_CALL_ATTRIBUTE
+#define NO_TAIL_CALL_ATTRIBUTE
+#define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
+#endif
+
 static int mmap_handler(struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct perf_sample *sample,
@@ -95,7 +112,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	return strcmp((const char *) symbol, funcs[idx]);
 }
 
-noinline int test_dwarf_unwind__thread(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
 	struct perf_sample sample;
 	unsigned long cnt = 0;
@@ -126,7 +143,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
 
 static int global_unwind_retval = -INT_MAX;
 
-noinline int test_dwarf_unwind__compare(void *p1, void *p2)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 {
 	/* Any possible value should be 'thread' */
 	struct thread *thread = *(struct thread **)p1;
@@ -145,7 +162,7 @@ noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 	return p1 - p2;
 }
 
-noinline int test_dwarf_unwind__krava_3(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 {
 	struct thread *array[2] = {thread, thread};
 	void *fp = &bsearch;
@@ -164,14 +181,22 @@ noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 	return global_unwind_retval;
 }
 
-noinline int test_dwarf_unwind__krava_2(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
 {
-	return test_dwarf_unwind__krava_3(thread);
+	int ret;
+
+	ret =  test_dwarf_unwind__krava_3(thread);
+	NO_TAIL_CALL_BARRIER;
+	return ret;
 }
 
-noinline int test_dwarf_unwind__krava_1(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
 {
-	return test_dwarf_unwind__krava_2(thread);
+	int ret;
+
+	ret =  test_dwarf_unwind__krava_2(thread);
+	NO_TAIL_CALL_BARRIER;
+	return ret;
 }
 
 int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.29.2.299.gdc1121823c-goog

