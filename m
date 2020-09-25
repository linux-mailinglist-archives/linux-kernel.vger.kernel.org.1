Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07E277CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 02:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIYAjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 20:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIYAjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 20:39:13 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8FC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:39:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x191so845324qkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Q1j1WY168LrRvlAv6fJ7IWcpUe0Uf5J8UDLD+lJyQzA=;
        b=A78Oa5TGjfEsyni7+yP2wXZCsx6as4Cdjk1wK8rw0dEypb2AC8wdPVrTVKsPkvFiRJ
         WS793B4+FVCD43Bj1gsQhCLhB25rX3X6581k2JSFdz8SppKUzhN4R8niBHK31bScrsMO
         UO3JF11qYHsx6UFC3yhJtG0d2ho8naklUxkiMROcPacGPTOim2vYzOuhoiwuIx1mkrYc
         OjTvSyD0RetsxzeC3xzlr321iznkOzam4BJRZAGrhdAlu6ZrBAMm0SxaBLMf/BIdrIbz
         0rcM8dxZkWXbSp6XKa7/EZwYT+8h86/C0L7b2+52aRVjXa3/q+FgI224IyvA2IwB6zoY
         favg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Q1j1WY168LrRvlAv6fJ7IWcpUe0Uf5J8UDLD+lJyQzA=;
        b=cX7PhfVimEPrpNFWfJ/OZWkYsnwD9bza6KHroawXskMOYS3Dd6uHh/ELglH8aQXOYW
         TvWv3q1poQRj7xMk5/S1TKDnzy31gHnbPWIbTdg5vdoPXneTNAQ8XLCUxqpltnmhK5St
         kqMp9ORM2pAjEy/ojK7RqtWPq2OeOWaIj4udaLRfhlI6B/FTWnFcckI03ZfZWLVhTKya
         Dt03fxf6wgTP3bSjmICjhqD5F6cOJmBSla+YhYNvGVUKIWH/TkyCsbYDWlrrqMDm9ICx
         j0bAvR6VeSiVP0MiT2CqCyKnE+FzCGt+aXKxtNLxDDeyLU77fiqvg7vX6ZBzyNKg6naI
         MMww==
X-Gm-Message-State: AOAM532VcFsWrd9YfVcY/8gSlgwSljaFHJvcWInVutyMQAGAF8/NqX97
        JARYWJXGu6p8SVwMC2Nu0COlETIKDZEM
X-Google-Smtp-Source: ABdhPJzX88zgzM5alZDp3MuDgEe/twM+unT/FMxzz0P723jDwZhnqb/JnZy2O9y9hbmo7GSVHSnxURQBy0Ve
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:ad4:47cc:: with SMTP id
 p12mr1991435qvw.25.1600994352155; Thu, 24 Sep 2020 17:39:12 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:39:03 -0700
Message-Id: <20200925003903.561568-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] perf parse-events: Reduce casts around bp_addr
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event_attr bp_addr is a u64. parse-events.y parses it as a u64, but
casts it to a void* and then parse-events.c casts it back to a u64.
Rather than all the casts, change the type of the address to be a u64.
This removes an issue noted in:
https://lore.kernel.org/lkml/20200903184359.GC3495158@kernel.org/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 ++--
 tools/perf/util/parse-events.h | 2 +-
 tools/perf/util/parse-events.y | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 667cbca1547a..f82ef1e840b2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -940,12 +940,12 @@ do {					\
 }
 
 int parse_events_add_breakpoint(struct list_head *list, int *idx,
-				void *ptr, char *type, u64 len)
+				u64 addr, char *type, u64 len)
 {
 	struct perf_event_attr attr;
 
 	memset(&attr, 0, sizeof(attr));
-	attr.bp_addr = (unsigned long) ptr;
+	attr.bp_addr = addr;
 
 	if (parse_breakpoint_type(type, &attr))
 		return -EINVAL;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 00cde7d2e30c..e80c9b74f2f2 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -190,7 +190,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 			   struct parse_events_error *error,
 			   struct list_head *head_config);
 int parse_events_add_breakpoint(struct list_head *list, int *idx,
-				void *ptr, char *type, u64 len);
+				u64 addr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 645bf4f1859f..d5b6aff82f21 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -511,7 +511,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					(void *)(uintptr_t) $2, $6, $4);
+					  $2, $6, $4);
 	free($6);
 	if (err) {
 		free(list);
@@ -528,7 +528,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	if (parse_events_add_breakpoint(list, &parse_state->idx,
-						(void *)(uintptr_t) $2, NULL, $4)) {
+					$2, NULL, $4)) {
 		free(list);
 		YYABORT;
 	}
@@ -544,7 +544,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					(void *)(uintptr_t) $2, $4, 0);
+					  $2, $4, 0);
 	free($4);
 	if (err) {
 		free(list);
@@ -561,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	if (parse_events_add_breakpoint(list, &parse_state->idx,
-						(void *)(uintptr_t) $2, NULL, 0)) {
+					$2, NULL, 0)) {
 		free(list);
 		YYABORT;
 	}
-- 
2.28.0.681.g6f77f65b4e-goog

