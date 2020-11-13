Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAF2B1533
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 06:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKMFCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 00:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMFCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 00:02:45 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76DDC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 21:02:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so6108954pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 21:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB3jkZmmr+zCLwgJZt2bFUeCFnmdXFyioIG+pOTQLc0=;
        b=EZ0pu0eY8Rax+6OXiyrw1fqfRImchInE3l1Owmr2Z6Xi77ltIcvtxIQbqEHJgus2Qy
         O8Zz95L4JaPuy5teLxM01Pz2Qd7e8K3qyhvly7vGkXPuFfeOWtOfNMV+qd7EFLm2MuJx
         OHoil1jU4US3YlFVqBBGnKJgdLlydHDf6VBbny/c1JrXhycNvuCAxVWPajCNNTmER/lM
         tI1MKHdlU0ZdjEeK1HrW8Po4T7Bh1WB/7W+8Wsg0aXl9Ytopi2N8Bl4XshOFUKsuPKg9
         wW7VAceWtLstRYKtv0k7bxnSrJ7pKXnZHU0QOmSlyUbyyJLLMJQeRUkHAEi20l+7m+nr
         543A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TB3jkZmmr+zCLwgJZt2bFUeCFnmdXFyioIG+pOTQLc0=;
        b=TMOUH3mPwYIXK+xmpxMoML8zTlj+UVA/NAZHIM4JeQLlZT4vvggfkUgHG6Y0baw/qo
         wVrHJSeAyjn81UTaMietSJyIrw3aXgI+5iauIC8acVVOuiNmQdGHKSdIRyV/lFgZdwui
         6q843IT98XLhyXbvi5+aBdkHOMH0Tlkb8QGuKP6FM16HQA5Lcs/s0tb+O4IM2bXon2RA
         FowkMLhUdCFytuJ79d/ysPoCKQMEawbaWNm3LcGo8NgcLWT93B5IIt3GSYxiOwQCS/wH
         Ci0egMjoVsE13gzFQBB9N4ZQ33sT1L/QE0+BVQCZh2tMtGCi+V7lPSG032M7BNll9U4O
         BAnw==
X-Gm-Message-State: AOAM530OiG1x3KhwZppoMbRfPu3+5aA6bBzIh5943+mgGN8RnGeoACPz
        bam9BmuzG1NMwDv0+Af6zLyqS0VehUw=
X-Google-Smtp-Source: ABdhPJxfPMghixR3PWItHeUHNQWS264Z5BX09FG1gctwrqkjM3lXyM7BNUOZFKS5Qi7DZ64zMLWWdw==
X-Received: by 2002:aa7:8154:0:b029:156:4b89:8072 with SMTP id d20-20020aa781540000b02901564b898072mr517100pfn.51.1605243764347;
        Thu, 12 Nov 2020 21:02:44 -0800 (PST)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id t74sm8150470pfc.47.2020.11.12.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 21:02:43 -0800 (PST)
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
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, Sam Xi <xyzsam@google.com>
Subject: [PATCH] perf stat: Use proper cpu for shadow stats
Date:   Fri, 13 Nov 2020 14:02:36 +0900
Message-Id: <20201113050236.175141-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
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
2.29.2.299.gdc1121823c-goog

