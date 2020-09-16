Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB526BBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 07:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgIPFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 01:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:31:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:31:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so3279477pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvGCW6G971AwKptXQR5rCpRVuZG2oI+J8zrp7uGZNS4=;
        b=kCuwLOXjHU58NKJZ7K/1nwiOlnI0U9NcVsZ/shCSi/yQVKhiWYfMioenlxeLzAgv8p
         brrZp8kDXhqb4MUK80BfXh7677J7qHsTH4H4Z0VW9N3mFx1X9SKn4H3XETpMvB4hLHos
         zbdo2Z0x4RqsaLUc4xoL0gpC0eAd5DmyyQEbpLHix60q/vN98Kv9xJ/diFCNPTWbvwHM
         3/WwuiMqcer1kz6mSSXap6gSnVP8Qv63M02AOw76E+esj4wT8vkfXqX+PHbb/YqlYhnn
         9rWmPRRNehWTud1EJvkcXJyrz9vXy96AMQwQ8DQx4WMHVAtocWAPrpla03JPA1C2MbP6
         cerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZvGCW6G971AwKptXQR5rCpRVuZG2oI+J8zrp7uGZNS4=;
        b=dJ31YzTd4rrHPqRZ8W+HXfytl9gcJL7kItzdOFAs7b8BOkPVtHP1je7ynsdpEzXQ4X
         1wQUzvgYzY0rCHwZ/sUdzOUoi8qRMTMBNz0e4OtrGJBAQlZqEQlMFlTVsBn/Q20Kdwvu
         xOy+FNQKUf7noXYCcol0xQB2P0tsiphr/VO5giahYsb2gM+r4b/snyv9KT4YJlJPTSUC
         sJOX34594+8Pek4/IUQe5yflxeFety/Fi2oCK6lNi8Q2c7IeyEipGoxkmFBaa+L/6UxJ
         Gx0X2m8q/Q7HgpoTMhDVKG13a8DKcrWuE4+rCP5MfZdqJFtZld1pBUNB73dB13CqciyK
         F5nQ==
X-Gm-Message-State: AOAM531xeTmS2m6beoWTjm4cBU/rhjm9HHl7bdQfjErv6MyR6Nz7MWGP
        Eyzh3umFGaenYYR7ocV3VTg=
X-Google-Smtp-Source: ABdhPJzXKRjYjkicEVFWDis3F2f5htudc0w3TnYCyCW2s9K+ugZ+oSy/eSBQP845qcvwXqsKnxPY6w==
X-Received: by 2002:aa7:9edb:0:b029:13e:d13d:a059 with SMTP id r27-20020aa79edb0000b029013ed13da059mr21505351pfq.31.1600234307651;
        Tue, 15 Sep 2020 22:31:47 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id s3sm15388513pfe.116.2020.09.15.22.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 22:31:47 -0700 (PDT)
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
Subject: [PATCH 2/2] perf parse-event: Fix cpu map leaks
Date:   Wed, 16 Sep 2020 14:31:31 +0900
Message-Id: <20200916053131.1001604-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200916053131.1001604-1-namhyung@kernel.org>
References: <20200916053131.1001604-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like evlist cpu map, evsel's cpu map should have a proper refcount.
As it's created with a refcount, we don't need to get an extra count.
Thanks to Arnaldo for the simpler suggestion.

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
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 176a51698a64..204395596381 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -366,7 +366,7 @@ __add_event(struct list_head *list, int *idx,
 	}
 
 	(*idx)++;
-	evsel->core.cpus   = perf_cpu_map__get(cpus);
+	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
-- 
2.28.0.618.gf4bc123cb7-goog

