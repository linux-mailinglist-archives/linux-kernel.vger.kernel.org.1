Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FA269C75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgIODTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIODTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:19:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80DC06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:19:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1013303pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6+z5HIhq0XqJjeQRfSdm74ezgf/NaqZs4RaoBcCu3Q=;
        b=TrkBXa04YrI/agKtArcFDfirc68kmNbInKjvY5fwUEzdc1wzPW8MMTjeYJoG12uibH
         K9XxXwaN+Il+fEVau3aaxt724/msDuuo48oBnpDLBWZUh/hR/au1p5mAANH3cDhcvmkV
         qoC0NDm7rFJKx6TivScz8dPyO3Wd2yV/FxYc5hDdExgTRmWBOXtffKG7tZlhe5NDyixv
         3d5jL1V1krD2HWbu/bO0eMuBYCWO/R/6bSQmPvkpN5AloHFWJkkVvQb2ZlESpcDr6jvT
         6OWU65RQ9IYRRC0pXD1RVVNQMGxj8wVk/DwEUfmMd7sJ3Z8+fhFhwV9WU0H8KfKCEV91
         no+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q6+z5HIhq0XqJjeQRfSdm74ezgf/NaqZs4RaoBcCu3Q=;
        b=E++POTnynQBKIlNhFsi+1neC6bnsvEhzupGaq/I/6N6AEgpneZnOhyb16DHtgwM12I
         n9zH1lPPQSTzPhYQVx2heRsEXj/jzU4v47kEuzW/1YXXUGHGjwEIBP7pgPmn/viqmAVe
         2HvEr6IWAX7DhbXzuqNQhuK3VWul9yMWKtQFr24JibmXtGdjJeAbejjpDMK034HAanFu
         NR7foryiIOi5pa0Y8z51ohznJlbVj/xKbhS1449oUGrh0cW9GcUzGEaovOGNTXDso37Y
         ZXArVJie/75zYzLoTb2kOjbdB0RjDZ2rJTfOzB4q6Ns9XzFJqgjRHbvan+O6pgTkyHwm
         BPKg==
X-Gm-Message-State: AOAM533WTQLe4oBY6gJWB5kaVioPucvWV3uVUWJ0jFzgYg7tHGhdkVku
        JLdLwBG/GumAkFERfxM/dB8=
X-Google-Smtp-Source: ABdhPJxpe7NTxhM5rV4vCxqDASu/1bk55VquWKeErNjhUo4M4PJbY2YNJcw9PCcYzGg6fJ+tVAiYEw==
X-Received: by 2002:a17:90a:ba06:: with SMTP id s6mr2327549pjr.13.1600139946319;
        Mon, 14 Sep 2020 20:19:06 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:19:05 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 10/11] perf test: Free aliases for PMU event map aliases test
Date:   Tue, 15 Sep 2020 12:18:18 +0900
Message-Id: <20200915031819.386559-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aliases were never released causing the following leaks:

  Indirect leak of 1224 byte(s) in 9 object(s) allocated from:
    #0 0x7feefb830628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
    #1 0x56332c8f1b62 in __perf_pmu__new_alias util/pmu.c:322
    #2 0x56332c8f401f in pmu_add_cpu_aliases_map util/pmu.c:778
    #3 0x56332c792ce9 in __test__pmu_event_aliases tests/pmu-events.c:295
    #4 0x56332c792ce9 in test_aliases tests/pmu-events.c:367
    #5 0x56332c76a09b in run_test tests/builtin-test.c:410
    #6 0x56332c76a09b in test_and_print tests/builtin-test.c:440
    #7 0x56332c76ce69 in __cmd_test tests/builtin-test.c:695
    #8 0x56332c76ce69 in cmd_test tests/builtin-test.c:807
    #9 0x56332c7d2214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #10 0x56332c6701a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #11 0x56332c6701a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #12 0x56332c6701a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #13 0x7feefb359cc9 in __libc_start_main ../csu/libc-start.c:308

Cc: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 956a78356c24c ("perf test: Test pmu-events aliases")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pmu-events.c | 5 +++++
 tools/perf/util/pmu.c         | 2 +-
 tools/perf/util/pmu.h         | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index eb19f9a0bc15..d3517a74d95e 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -274,6 +274,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 	int res = 0;
 	bool use_uncore_table;
 	struct pmu_events_map *map = __test_pmu_get_events_map();
+	struct perf_pmu_alias *a, *tmp;
 
 	if (!map)
 		return -1;
@@ -347,6 +348,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 			  pmu_name, alias->name);
 	}
 
+	list_for_each_entry_safe(a, tmp, &aliases, list) {
+		list_del(&a->list);
+		perf_pmu_free_alias(a);
+	}
 	free(pmu);
 	return res;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f1688e1f6ed7..555cb3524c25 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -274,7 +274,7 @@ static void perf_pmu_update_alias(struct perf_pmu_alias *old,
 }
 
 /* Delete an alias entry. */
-static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
+void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 {
 	zfree(&newalias->name);
 	zfree(&newalias->desc);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 44ccbdbb1c37..b63c4c5e335e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -113,6 +113,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
+void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
-- 
2.28.0.618.gf4bc123cb7-goog

