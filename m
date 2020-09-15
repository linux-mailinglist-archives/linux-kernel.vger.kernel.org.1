Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6C269C70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIODS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIODSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A012C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so600438plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNgzCmxroHrHpQiWcdb+vcIBBR9BGSqgA77Q+9QEsDk=;
        b=H6aS5JCRrdoONUwjzvl62X2DCiAJNggPFYgSQ2natXe0qSZEEHWNf96oPrh2em7g/a
         TYyCJdf5s7d0mv7Am9Fw6pnPF8U+XttscDZ85gX7bjDvZFm2Yrbuv+KIUOaWadmG8iut
         zXU4rahKxjoV9V9XxzfHEUkhxED+qyJCnVfmp4hfO5FWuo+Vt+qeTFV8o9cPHleR0S7+
         Ge3BvNelPJXdSVvCQFjvYhlON8NagHitjrqORnsLknbyGTvt91/bKV8fAh+Sx5n/Qctr
         StMwhpos3v2FpCscr9JTyK6UdZQfl6JEpmTQm3L6FXdnPbBwsJdBnuNgALNYg6UR9dGX
         FD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GNgzCmxroHrHpQiWcdb+vcIBBR9BGSqgA77Q+9QEsDk=;
        b=af8XW/LV4bQ4CZbdbsLSYWhggV9T1AQGG834LM+9kTbSSr797Ry8lq4sM/llPhv5Cu
         EveZIjR7RnzAIaDE4fMgHHATG6BvfiZUhiP5v3DRtAfO66XmnX3rPSJb6pj7XwfYgoHj
         QMNvVFb4HdUWvSFMTuc910pEVnA+zrCKEdqA+KDTsiSHbSl797HuJxg/oUBNJa4QojL4
         zHHtUv/5zZ2jHqaZJFi6fh9ynk4rTgCWVhyzL3z9M7zyJW+04ipPz6wkrlpMBR+TsGq/
         BzUKg10xshcVfsN8mbErTALX3w1WtK4kuE47iBqpDoTSNSTeiaW2fNBqDb/ZEYPwQ3bg
         2Zwg==
X-Gm-Message-State: AOAM532SpkrLoMj7ZTThAYXqkqgciLTApgPU4Dq5CPfCuHwWZfHnbkcy
        9UNY3FwB7kIs9mUxrm0Hw+8CPKbKa/NPWg==
X-Google-Smtp-Source: ABdhPJyeF7+M7jL8lcgFcmMna2s4GBeOsTwxHs7d77WtV5FWdmGXOt/wIHs0TukCWSEQfnt1U/w6aA==
X-Received: by 2002:a17:902:a70c:: with SMTP id w12mr17444763plq.80.1600139923974;
        Mon, 14 Sep 2020 20:18:43 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:43 -0700 (PDT)
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
Subject: [PATCH 04/11] perf parse-event: Fix cpu map leaks
Date:   Tue, 15 Sep 2020 12:18:12 +0900
Message-Id: <20200915031819.386559-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like evlist cpu map, evsel's cpu map should have proper refcount by
releasing the original count after creation.

This fixes the following ASAN report:

  Direct leak of 840 byte(s) in 70 object(s) allocated from:
    #0 0x7fe36703f628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
    #1 0x559fbbf611ca in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x559fbbf6229c in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:237
    #3 0x559fbbcc6c6d in __add_event util/parse-events.c:357
    #4 0x559fbbcc6c6d in add_event_tool util/parse-events.c:408
    #5 0x559fbbcc6c6d in parse_events_add_tool util/parse-events.c:1414
    #6 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
    #7 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
    #8 0x559fbbcc95da in __parse_events util/parse-events.c:2141
    #9 0x559fbbc2788b in check_parse_id tests/pmu-events.c:406
    #10 0x559fbbc2788b in check_parse_id tests/pmu-events.c:393
    #11 0x559fbbc2788b in check_parse_fake tests/pmu-events.c:436
    #12 0x559fbbc2788b in metric_parse_fake tests/pmu-events.c:553
    #13 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:599
    #14 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:574
    #15 0x559fbbc0109b in run_test tests/builtin-test.c:410
    #16 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
    #17 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
    #18 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
    #19 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #20 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #21 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #22 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #23 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308

And I've failed which commit introduced this bug as the code was
heavily changed since then. ;-/

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c4d2394e2b2d..b35e4bb1cecb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -360,8 +360,11 @@ __add_event(struct list_head *list, int *idx,
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
+	if (!evsel) {
+		if (!pmu)
+			perf_cpu_map__put(cpus);
 		return NULL;
+	}
 
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
@@ -369,6 +372,8 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
+	if (!pmu)
+		perf_cpu_map__put(cpus);
 	if (name)
 		evsel->name = strdup(name);
 
-- 
2.28.0.618.gf4bc123cb7-goog

