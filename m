Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68A269C73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIODTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIODSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so1004139pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p83EqnML7rpkabHtiYQUB940WsenEj86WL+ZStHm58g=;
        b=IMuc4IpNrHIGSuVVMyBqzgbtC6ui3VhOAHS/aXp7TXy23PIOBW6xxP76Izrum4aCU+
         sm1O6OAOc4wjztDDWJoi/fVA0Jwfvmpg00QqHh/Md8FSgaCGGJGyI6zBBhBpclz1MU2Z
         2MTFwyHG6YYLfviv4foeF8W1L0vY9IaP4IoH7Ev7NAv2eUll8ZIo97uFNMP/dDZZKv1s
         oS7qMCOa1ArgQCSxVYonvbbL9/lv5W4TIqhtIqQ0lk+GQ8cX8lJEpJpC6C/QIxnLz3W4
         NQDjWov2/DlqRYq3ntP6h2NsZGsARbyRv7X0aI8jlC6lsOcImu/vd4naZ3ICSRgkt+xu
         +k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=p83EqnML7rpkabHtiYQUB940WsenEj86WL+ZStHm58g=;
        b=RwqzozwDzk4knvmKJYd4+kNuDXy8LzcibCJ4JespZNUmyV6nGIX3lSTL/wcWUHhJ2F
         g4NP6XUWfJ8botpNoel6Ar7Y4GO7rd9GbcmeYxuqGCaHGHEmBXEd9MR9G+QflYYdnc1y
         8JQvACez92zgPN02WZL6CcA9YhNysqgt7R4BD9zfTD5QdlWfE4LE30xju7L3Ze51Knbr
         hdOqPkR9cbKKReb8zoSNBlMxREth3CHe28sHbiEE0QxOWFI8Fn5q/h+MtYqYdtFMgzXZ
         RAJ0HCHU0xDiYLHl+sRCGb42eBI8toVnCNr/sTY8nWJP5avW7cna6UiiXN71S6+eSdlC
         g2HQ==
X-Gm-Message-State: AOAM53255+werQjLpaNVVz0tYGwNHknqKcebJTPMrJKrys/1JbJQXJ5l
        INnF1RhZKvbrtuANq+uhk/I=
X-Google-Smtp-Source: ABdhPJyNT8uVBKwX58iXd+dQ9hSBcV6buKXPOf4ov90gAvdd9UXuCn7pOTqMxI/dm+ttutbnOT9EVA==
X-Received: by 2002:a17:90b:1111:: with SMTP id gi17mr2299323pjb.109.1600139927750;
        Mon, 14 Sep 2020 20:18:47 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:47 -0700 (PDT)
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
Subject: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
Date:   Tue, 15 Sep 2020 12:18:13 +0900
Message-Id: <20200915031819.386559-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel->unit borrows a pointer of pmu event or alias instead of
owns a string.  But tool event (duration_time) passes a result of
strdup() caused a leak.

It was found by ASAN during metric test:

  Direct leak of 210 byte(s) in 70 object(s) allocated from:
    #0 0x7fe366fca0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
    #1 0x559fbbcc6ea3 in add_event_tool util/parse-events.c:414
    #2 0x559fbbcc6ea3 in parse_events_add_tool util/parse-events.c:1414
    #3 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
    #4 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
    #5 0x559fbbcc95da in __parse_events util/parse-events.c:2141
    #6 0x559fbbc28555 in check_parse_id tests/pmu-events.c:406
    #7 0x559fbbc28555 in check_parse_id tests/pmu-events.c:393
    #8 0x559fbbc28555 in check_parse_cpu tests/pmu-events.c:415
    #9 0x559fbbc28555 in test_parsing tests/pmu-events.c:498
    #10 0x559fbbc0109b in run_test tests/builtin-test.c:410
    #11 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
    #12 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
    #13 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
    #14 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #15 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #16 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #17 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #18 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: f0fbb114e3025 ("perf stat: Implement duration_time as a proper event")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b35e4bb1cecb..ece321ccf599 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -416,7 +416,7 @@ static int add_event_tool(struct list_head *list, int *idx,
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
 	if (tool_event == PERF_TOOL_DURATION_TIME)
-		evsel->unit = strdup("ns");
+		evsel->unit = "ns";
 	return 0;
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

