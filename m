Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF52762D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIWVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgIWVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:07:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4921C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:07:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e28so759034pgm.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EI8D8euVnqE4tbRisfgZZb6mweGrIp0U9jbq/rpkV0Q=;
        b=wWPPSVV2yi1NQfgj3Wro/rL4gL141lRfl3g+1J/NL+X2zJS0X9qnb2oJ5aW5G+3S3T
         YhUwIEBFU+7jTlFp5UTU4iBLvNlPsYpdj5fo5YLN0dW3+N7JZ3dXxE79RbRxpF8W1ass
         BBcyfMaRgL/TjFDhYxwWk/vM+wKyCAweENaz0UNGgxgJte2ITClkfpk45uv+yCOM1VR3
         Ra3jy/00oDnS6WRMxqhVvmnAKzP7V+X0uH77UbA9oTiRnow5/B56uYT2ekF68t4bi3uJ
         7vUnJkZcPbkbqHEgzazhk3HrioJlwhVfYliXf6+XGdGqrWmhBJAI//c0BJxEyE/iheov
         WMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EI8D8euVnqE4tbRisfgZZb6mweGrIp0U9jbq/rpkV0Q=;
        b=MeKcngV/4jw6jk1NW5VrFqsRLqHZW2LQklFJU8dOGyM3H6RTxLW37e1XH64jDZ64es
         B5hEio12BlghsA1eE7xlCAFNSiBQ18GGk4c+488NlNhVTAY7Ixr3ZszoMPdFrbN4ObGV
         FWNXX0pYhKf6iwxkVg+ihpzjToZaUWBA+V/J4C1dp1VZ2hHphXIy+Tnxzq0ZN4nb6Q1P
         EJLkazJ8R2JcqhAVh9Zm/2i09tb1IcM1q6+4qmp0hZ8wPpNDNd7shkhrfAFhQxYX5WNC
         RLyfJ9q4z9+jgLCiHgCk/T4m35OHpgmOQdAXhyanz6m+V3zu/Si+gIrY2Ct093Vh9Kgv
         1I8g==
X-Gm-Message-State: AOAM531IhZxblPsq4RhiPe4Zjif/0Co/4AL2rcX0EDY3U0iGDyFiua9V
        mJlmI2WArA1R1B8y2yyk3mxZPpt+Wu5s
X-Google-Smtp-Source: ABdhPJy0WNyqqzcjfGBJ4eMIJLhWH0XOi4Yzx2qld7+13kbcPk7tQCSkG0jAcy87zrPWcCNkovEEv8JTsHvB
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a62:1542:0:b029:150:e3f5:d8fc with SMTP id
 63-20020a6215420000b0290150e3f5d8fcmr1478852pfv.66.1600895223924; Wed, 23 Sep
 2020 14:07:03 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:06:55 -0700
Message-Id: <20200923210655.4143682-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] perf test: Fix msan uninitialized use.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure 'st' is initialized before an error branch is taken.
Fixes test "67: Parse and process metrics" with LLVM msan:
==6757==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x5570edae947d in rblist__exit tools/perf/util/rblist.c:114:2
    #1 0x5570edb1c6e8 in runtime_stat__exit tools/perf/util/stat-shadow.c:141:2
    #2 0x5570ed92cfae in __compute_metric tools/perf/tests/parse-metric.c:187:2
    #3 0x5570ed92cb74 in compute_metric tools/perf/tests/parse-metric.c:196:9
    #4 0x5570ed92c6d8 in test_recursion_fail tools/perf/tests/parse-metric.c:318:2
    #5 0x5570ed92b8c8 in test__parse_metric tools/perf/tests/parse-metric.c:356:2
    #6 0x5570ed8de8c1 in run_test tools/perf/tests/builtin-test.c:410:9
    #7 0x5570ed8ddadf in test_and_print tools/perf/tests/builtin-test.c:440:9
    #8 0x5570ed8dca04 in __cmd_test tools/perf/tests/builtin-test.c:661:4
    #9 0x5570ed8dbc07 in cmd_test tools/perf/tests/builtin-test.c:807:9
    #10 0x5570ed7326cc in run_builtin tools/perf/perf.c:313:11
    #11 0x5570ed731639 in handle_internal_command tools/perf/perf.c:365:8
    #12 0x5570ed7323cd in run_argv tools/perf/perf.c:409:2
    #13 0x5570ed731076 in main tools/perf/perf.c:539:3

Fixes: commit f5a56570a3f2 ("perf test: Fix memory leaks in parse-metric test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-metric.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index aea4f970fccc..7c1bde01cb50 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -157,6 +157,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
+	runtime_stat__init(&st);
 
 	/* Parse the metric into metric_events list. */
 	err = metricgroup__parse_groups_test(evlist, &map, name,
@@ -170,7 +171,6 @@ static int __compute_metric(const char *name, struct value *vals,
 		goto out;
 
 	/* Load the runtime stats with given numbers for events. */
-	runtime_stat__init(&st);
 	load_runtime_stat(&st, evlist, vals);
 
 	/* And execute the metric */
-- 
2.28.0.681.g6f77f65b4e-goog

