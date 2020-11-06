Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6EC2A9351
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKFJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgKFJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E854C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:21 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so517068pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBMDYR0EtJiH6gOkUzFJE+KFN5Qsrk4p6krIBtwIhQY=;
        b=uYmfu/e5OP600zOgAkXEJsmbIuOXJQvvjz2cTOe0se5Vwouzn28DlQkhR7vuntjUjC
         hFVCBL1FMFGM/08a+tsNzHDNHEhGC9wooNkgNjVQ5Vyb2cRh7LQgugCENzsXNFsICrEq
         or0EWO4gZPRnPtlmTac6unIGBtSXhUZcaFSgvNfosY/OWIZVCD+Cgx/cPfq6+4ZKbcN9
         ycxcUrpCcdRPUvyiKicpSSDBL8RILyzm4qtYZf+y1n7S7ChNAadx3pVLwl1hNA84Iq6e
         EJcnz0nQqhAwCkLjtwt54iv9FFxJYlzG0HP8fFm8b/ELOagL8jjrEN+p9gSzAGRxXnzN
         7xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBMDYR0EtJiH6gOkUzFJE+KFN5Qsrk4p6krIBtwIhQY=;
        b=mqwsEUmTktFZc8frppkgs+EBqVOexK9X98oY8OlxDAeCf33MVXXvZwbdCM/cuKkkWk
         DaQT/hmXZTPVm5AJXssRZhHrc6Sa+RrVOAX2yowMxKBtShYVJtSm6xntGcgjVaBbPePf
         GCjyu1v1dwodhQ+6NDAohX/HkXDRKBmM/dL3f+z1BmYTy10Cu+eyQLKGjnUs8ufqmBgn
         O3wLwE88R+NoURKvGpbH//F7Y/4THcXrG0gUl09q2XdSp/JRNewZyyKRZ5MnQ50XiEXm
         ZjW/pnZwRvVuDKuDrKmyMnQn8Bb26OH1RJxszM3CqDQDV+mIfZODuLonJdhEx2knzi85
         P5lg==
X-Gm-Message-State: AOAM530hIoemDyxmR8w9ToqTreZaswV0W0hzag72j1EdUB3WT+lnRZax
        I3i10o0W5420mwzeseQimPCAoA==
X-Google-Smtp-Source: ABdhPJz8jwfvIQYlaktjREIjkgDKkkAoPkmix0536oVpNSs9OrxIrnI8DtCp0bo3i3wRJPNE02fBog==
X-Received: by 2002:a63:1924:: with SMTP id z36mr1074217pgl.354.1604656161022;
        Fri, 06 Nov 2020 01:49:21 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id v12sm1109618pgr.4.2020.11.06.01.49.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:20 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/9] perf mem: Search event name with more flexible path
Date:   Fri,  6 Nov 2020 17:48:45 +0800
Message-Id: <20201106094853.21082-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf tool searches memory event name under the folder
'/sys/devices/cpu/events/', this leads to the limitation for selection
memory profiling event which must be under this folder.  Thus it's
impossible to use any other event as memory event which is not under
this specific folder, e.g. Arm SPE hardware event is not located in
'/sys/devices/cpu/events/' so it cannot be enabled for memory profiling.

This patch changes to search folder from '/sys/devices/cpu/events/' to
'/sys/devices', so it give flexibility to find events which can be used
for memory profiling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/util/mem-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ea0af0bc4314..35c8d175a9d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -18,8 +18,8 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
 struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"mem-stores"),
+	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
+	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
 };
 #undef E
 
@@ -93,7 +93,7 @@ int perf_mem_events__init(void)
 		struct perf_mem_event *e = &perf_mem_events[j];
 		struct stat st;
 
-		scnprintf(path, PATH_MAX, "%s/devices/cpu/events/%s",
+		scnprintf(path, PATH_MAX, "%s/devices/%s",
 			  mnt, e->sysfs_name);
 
 		if (!stat(path, &st))
-- 
2.17.1

