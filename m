Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BD2C5F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 05:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392411AbgK0EOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgK0EOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 23:14:18 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF6C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 20:14:18 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id s63so3272685pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 20:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/j5tnaRXrIuRP8U5BaR0JnJNV/Mt1F7ct9YGlxTpuaI=;
        b=bLSPUzMD7qYvotm116F6Nh4R0W8JrmGysa4agsajOktv2uyyJ2TyuC+2z8ZaJRz9w+
         Tx32E8nFQczwmSFujjlGf2/62QpaMREB1TpiKxin+4U4emVz86NQWxIdj+/zLu39SP5C
         9Fw3OfKLJhQrsgifGvrI1KNJX3yBgaivODUw6nVCAYQVxlI0zk9vl/tJY9/Ggy1kIvjm
         pIf3nQarN+e6tkP4JqUkm7d/cHbLNpQEMkOucHoFtNWPtNH5DzUuv5gnu0vdNTy5vbDM
         o6H4KmIh8osFfLqySM2ocRL6hQQEduv1xH/DsI6iuQ5oPv5k+ezS/cgy4og5ylvxkmtY
         r/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/j5tnaRXrIuRP8U5BaR0JnJNV/Mt1F7ct9YGlxTpuaI=;
        b=mZs0rCjXU4Q53l+s2/2XT8i4lHGo0S2khrm8XAyn5vugtTpaK9zpVl1z6FQAWjGO+L
         m6cc8d/OU3ar0H+alVnNie4TG6M7O2fXkFFZJA9/xJ75RKq2tMrw5YnRzFzccLocq67U
         V5suZuGnDcbSm+cZde2c2vzCj3Q1ix9IjcPQEXocjedzsvjviTgs48D+7ZpoaGdqGsHK
         8a+lvUEKf1usmrF5xldHRnqkMy+QpAjIKu4j/WVrLHZemQyIFYWvhotGEbPqhqF2t/VZ
         xK9DQFkyEs6BiXpumUR3Rc6CkRQtOhlFS2Ev67CO83dxXLzgxrp5Aet13YA0dElAa45Y
         dcBA==
X-Gm-Message-State: AOAM532x2Q1UUQ7wwIx3tMJU+WKaWHxcl1IisOCJvpa4h0D8aBedC/q2
        j9yaH03GCpJZBM/ipwWNBqM=
X-Google-Smtp-Source: ABdhPJzTnuxRCi7Jl74wzMyFat1KiA3N7KZXz8CHltJMA2t9c831qxsNtajiZtEaC8VWItEpCuN9pQ==
X-Received: by 2002:a17:90a:de90:: with SMTP id n16mr7367118pjv.215.1606450457673;
        Thu, 26 Nov 2020 20:14:17 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id m18sm8096298pjl.41.2020.11.26.20.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 20:14:16 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Sam Xi <xyzsam@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/2] perf stat: Use proper cpu for shadow stats
Date:   Fri, 27 Nov 2020 13:14:03 +0900
Message-Id: <20201127041404.390276-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf stat shows some metrics (like IPC) for defined events.
But when no aggregation mode is used (-A option), it shows incorrect
values since it used a value from a different cpu.

Before:

  $ perf stat -aA -e cycles,instructions sleep 1

   Performance counter stats for 'system wide':

  CPU0      116,057,380      cycles
  CPU1       86,084,722      cycles
  CPU2       99,423,125      cycles
  CPU3       98,272,994      cycles
  CPU0       53,369,217      instructions      #    0.46  insn per cycle
  CPU1       33,378,058      instructions      #    0.29  insn per cycle
  CPU2       58,150,086      instructions      #    0.50  insn per cycle
  CPU3       40,029,703      instructions      #    0.34  insn per cycle

       1.001816971 seconds time elapsed

So the IPC for CPU1 should be 0.38 (= 33,378,058 / 86,084,722)
but it was 0.29 (= 33,378,058 / 116,057,380) and so on.

After:

  $ perf stat -aA -e cycles,instructions sleep 1

   Performance counter stats for 'system wide':

  CPU0      109,621,384      cycles
  CPU1      159,026,454      cycles
  CPU2       99,460,366      cycles
  CPU3      124,144,142      cycles
  CPU0       44,396,706      instructions      #    0.41  insn per cycle
  CPU1      120,195,425      instructions      #    0.76  insn per cycle
  CPU2       44,763,978      instructions      #    0.45  insn per cycle
  CPU3       69,049,079      instructions      #    0.56  insn per cycle

       1.001910444 seconds time elapsed

Reported-by: Sam Xi <xyzsam@google.com>
Fixes: 44d49a600259 ("perf stat: Support metrics in --per-core/socket mode")
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4b57c0c07632..a963b5b8eb72 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -324,13 +324,10 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	struct evlist *evlist = evsel->evlist;
 	int i;
 
-	if (!config->aggr_get_id)
-		return 0;
-
 	if (config->aggr_mode == AGGR_NONE)
 		return id;
 
-	if (config->aggr_mode == AGGR_GLOBAL)
+	if (!config->aggr_get_id)
 		return 0;
 
 	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
-- 
2.29.2.454.gaff20da3a2-goog

