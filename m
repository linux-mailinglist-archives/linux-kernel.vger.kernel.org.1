Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5394626D35F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIQGCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQGCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:02:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:02:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so545809pfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jhvNlISQTRzyDORPkxoCeHD+9I3JMCdtcL/5KBr1n4=;
        b=Ke2B+sh4PKy0Mvmp3JoJDocR0tzQvltI7WLPP99a50WXGPswfbCoKX8kk2kuUtmxc7
         NQG4pkoeVhKa/EWtyUwM/sGzu8zKWH9fX+6eZX3vDhI8z7L64M7uyiwlZUjSOq46ALNG
         CqtczgT0z8gwN2ItG7jwxWR9LjvsHndB7rSCSgKucn3OcdMx3XdsW8B34AZWJK0j39x0
         x/DjFq+uDtVabJcSpbsD5sDhCHdhJjXA7+Zsr1bG9zugIGUZeWPI1JSEWxMkm95PaZ70
         1dxSZ5UXrokBZfCnUL//5W3S1h1De4cS27a0Qn5R863RPnf9p0dcelVfE94BEnZf6erh
         LGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9jhvNlISQTRzyDORPkxoCeHD+9I3JMCdtcL/5KBr1n4=;
        b=aWYrktfBRRywKY5BXGEBYl7eHt/fdJDvp462Ge+e+x3edHagLU0esNonH3MKYIZq20
         5DEkY4J55uDNW6i/L+IbLEv+HCt34vaW9YaPwlOaJm/2tMGct8WsTj6pesTBdzJK25Y4
         hlgBmpOHTwdoDWEJWOo3+TqKvG6gPlS/synJ9FYW61MOlnSErub5+bETorqW5iSAPV78
         orAuLMhore1mSBa6rOOvehBkazlH0/mD/u2Yf/jTGFRmKsIC+6hKw09NNT8matBW3Lfo
         t8kBx63vscox7W5wJbQVJTlGSFpzRz/QJx4pWxuXaabPFpiTgHc2xBOBOZJ2pg1FbXRv
         xItw==
X-Gm-Message-State: AOAM532Xf2lQH1dPlWowgag7moV1Ox9zTnDGZ4UyEZqz3fy7sbZnzT41
        nj87QyJPnt3YhJygoZGt64E=
X-Google-Smtp-Source: ABdhPJxieP18KYJlyhV4EWWoVy7yrjL0uSVJPcKyTga3TmW2mPQIyvbUMTgwmvg0U9bosTI52cPyVw==
X-Received: by 2002:a62:3001:0:b029:142:2501:39e3 with SMTP id w1-20020a6230010000b0290142250139e3mr9243705pfw.50.1600322551282;
        Wed, 16 Sep 2020 23:02:31 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id o19sm14602960pfp.64.2020.09.16.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:02:30 -0700 (PDT)
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
Subject: [PATCH v2 2/2] perf parse-event: Fix cpu map leaks
Date:   Thu, 17 Sep 2020 15:02:19 +0900
Message-Id: <20200917060219.1287863-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200917060219.1287863-1-namhyung@kernel.org>
References: <20200917060219.1287863-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/util/parse-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 176a51698a64..fbe0d3143353 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -353,7 +353,7 @@ __add_event(struct list_head *list, int *idx,
 	    const char *cpu_list)
 {
 	struct evsel *evsel;
-	struct perf_cpu_map *cpus = pmu ? pmu->cpus :
+	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
 
 	if (init_attr)
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

