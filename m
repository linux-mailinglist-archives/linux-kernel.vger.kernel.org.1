Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9787F1F4A26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgFIXnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 19:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFIXnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:43:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8406EC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:43:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u186so186703ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9+cOwCBqGMsIOgA41/ZDHwiFXLxCUnIp9HOeUSn4XnE=;
        b=s5ufXPbUTtFwwgxilrBjwkTaSJvTZwxFxYnOkewTS05P+hnZ9aAQj1vqZd6RCcgzTD
         XDchmG0A8yscS/lJuW0ZjDXQipVzCOUg/ZZJdMR9Q6GFgqdu1W83uqi44EqFX2u9dU0m
         O60sGjpp9Mk4TvggBWbL9h9qgXfFbRmSnXFFwr8b99tRb8t5NUYCjBsYnqz0CQZylaPT
         R16oM46uFyC7hwlWW5LMT50Qc2kTZQCGr5Vv58kC45+zov90SN6jupgN1mUDcXKOIqHf
         zUs8M//ltXB0sa3dSLmc8KKigh9Pu+v+I0at96U3rJf+TH3BACyHyc1huuPTIhufZXNR
         MBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9+cOwCBqGMsIOgA41/ZDHwiFXLxCUnIp9HOeUSn4XnE=;
        b=OnQEHOZV3VVmHpWwWAImGw1pbxkEw7DSdb8JTsxFGf/FURcASwH6VtiKCeZyi/34d+
         NtSsCZVjG/u1Qq8HmzBgy7DFAV/tJzJOtEXMPiK6uBFIJcihJZabRds4I+8saiORDd2Q
         Xsjqit9X8yo9uxtoQGVTd13Zfs7byd7mKtCvVy7lWdafkYGSTv41zpJ85AeiKQUOGeuG
         +lAXPfycXr+M4ShqnxJHLrijU9Tkt91+T5T6/xUzkDD2j6iAxu4JxYlzrEwAP0Q8fMsf
         HSoro61sHBvVOQnpeJ6ApI3F9H/HH4vD1G5o5gnoWPC5Pm56/DRQGVs0/1LJHM9xnREF
         BJOQ==
X-Gm-Message-State: AOAM530Ss0+Qz16Vl+rR6r2UVQDNSOX8jvbVUOiVKEyS1DMiCorVaJ9Y
        n8JRPY7U5d21kyi4VWiLi2X1xh+0bKWs
X-Google-Smtp-Source: ABdhPJwMCFYLlXWvQ80aQwrkqwxeVuYNAU88AZnF+hPfMSQxAcane1+wScjbXauI83b6V0Bu3IPhN4FVYmSv
X-Received: by 2002:a25:5786:: with SMTP id l128mr1013664ybb.186.1591746228239;
 Tue, 09 Jun 2020 16:43:48 -0700 (PDT)
Date:   Tue,  9 Jun 2020 16:43:43 -0700
Message-Id: <20200609234344.3795-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 1/2] perf pmu: remove unused declaration
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids multiple declarations if the flex header is included.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 85e0c7f2515c..f971d9aa4570 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -86,7 +86,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 				  struct list_head *head_terms);
-int perf_pmu_wrap(void);
 void perf_pmu_error(struct list_head *list, char *name, char const *msg);
 
 int perf_pmu__new_format(struct list_head *list, char *name,
-- 
2.27.0.278.ge193c7cf3a9-goog

