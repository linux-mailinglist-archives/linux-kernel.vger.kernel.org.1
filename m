Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FFE269C79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgIODT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgIODS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1013144pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJvAZ9RyO+MV8dqRmcOcHC5VotRoWAMpBsJEIgC5sp8=;
        b=Zao0Zg2ZXYz4bUK+/9pqvCF2eykkN221yliCNKFtG3+SQtXfQKAZ0RKMa6cbfzw7MG
         r6w/qTx2JziLx/EBs2cWxe8wHlHWHBYIvGf+KY80fcUz8mdUyKuHH2HcDUT1Y5d6Mg5e
         2bzzGHVKzwRhqvE9BTDRZZx67UgMrqmaqewWk2cyF/fbYZzcEtG9sgnpdE1fgYEFiBLq
         T+OjlvBnrztw7i3bCkmVUfNgj8iubiYYfKiSgJx6tzugIUtEXTVey0564VQ+fp7tM8tV
         mDfwBmTvtNR4YIopE++dZTWNYedsKA6IxYTjr75+AxHmzidthE5VQrBrcqHKzBQHyrTB
         70dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KJvAZ9RyO+MV8dqRmcOcHC5VotRoWAMpBsJEIgC5sp8=;
        b=KXBALFVM6R+0Ha6VLgj2WqcXIwN/+nLz8iDjxlmjnBbcTMv9XxaC3q51KaFGbcnVd3
         FPAWsb4kzEG71N7+Yi/qXhBU6i+GGggQhBEeJznZ4RSbY/xfAUrXMhQiKwpWQB2C4DE2
         BPl9coimup6pxjSlc7uKRX/7BORz5qvUscl4jJwtXTAbzNeOW74vCvM1cHDCYL8/XtN2
         CxBruGv74KAkarW77bRo/T1WJqR1uH7H1s1MaFkArJ7J2vjuesQkpjfm/eqD+m1VZuqJ
         nf1qEZFvKXYUdf0iw/yO7u3M7ETvOo5QE9cYx6kqsKwZ0FA3xJRwvSB6mbSswDC9TR+/
         fD2w==
X-Gm-Message-State: AOAM530eBipN0RlDi6LjfuDiIPJTC52rAaqxNaGpm8CbsH6d1x1QnEUE
        HI4pVYXiDNuQBKOnsWTzFUE=
X-Google-Smtp-Source: ABdhPJy5I5o/Xz34gXyoWDuTzq1bqIzkEYASZQtoaHD6+bZVK29axa7ZUfqw35lB6jAmh0kWs6JBrA==
X-Received: by 2002:a17:90b:905:: with SMTP id bo5mr2138090pjb.73.1600139935059;
        Mon, 14 Sep 2020 20:18:55 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:54 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 07/11] perf metric: Release expr_parse_ctx after testing
Date:   Tue, 15 Sep 2020 12:18:15 +0900
Message-Id: <20200915031819.386559-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_generic_metric() missed to release entries in the pctx.
Asan reported following leak (and more):

  Direct leak of 128 byte(s) in 1 object(s) allocated from:
    #0 0x7f4c9396980e in calloc (/lib/x86_64-linux-gnu/libasan.so.5+0x10780e)
    #1 0x55f7e748cc14 in hashmap_grow (/home/namhyung/project/linux/tools/perf/perf+0x90cc14)
    #2 0x55f7e748d497 in hashmap__insert (/home/namhyung/project/linux/tools/perf/perf+0x90d497)
    #3 0x55f7e7341667 in hashmap__set /home/namhyung/project/linux/tools/perf/util/hashmap.h:111
    #4 0x55f7e7341667 in expr__add_ref util/expr.c:120
    #5 0x55f7e7292436 in prepare_metric util/stat-shadow.c:783
    #6 0x55f7e729556d in test_generic_metric util/stat-shadow.c:858
    #7 0x55f7e712390b in compute_single tests/parse-metric.c:128
    #8 0x55f7e712390b in __compute_metric tests/parse-metric.c:180
    #9 0x55f7e712446d in compute_metric tests/parse-metric.c:196
    #10 0x55f7e712446d in test_dcache_l2 tests/parse-metric.c:295
    #11 0x55f7e712446d in test__parse_metric tests/parse-metric.c:355
    #12 0x55f7e70be09b in run_test tests/builtin-test.c:410
    #13 0x55f7e70be09b in test_and_print tests/builtin-test.c:440
    #14 0x55f7e70c101a in __cmd_test tests/builtin-test.c:661
    #15 0x55f7e70c101a in cmd_test tests/builtin-test.c:807
    #16 0x55f7e7126214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #17 0x55f7e6fc41a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #18 0x55f7e6fc41a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #19 0x55f7e6fc41a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #20 0x7f4c93492cc9 in __libc_start_main ../csu/libc-start.c:308

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 6d432c4c8aa56 ("perf tools: Add test_generic_metric function")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-shadow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e1ba6c1b916a..a5f42c22c484 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -853,14 +853,16 @@ static void generic_metric(struct perf_stat_config *config,
 double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
 {
 	struct expr_parse_ctx pctx;
-	double ratio;
+	double ratio = 0.0;
 
 	if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
-		return 0.;
+		goto out;
 
 	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
-		return 0.;
+		ratio = 0.0;
 
+out:
+	expr__ctx_clear(&pctx);
 	return ratio;
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

