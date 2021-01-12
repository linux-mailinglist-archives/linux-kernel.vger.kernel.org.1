Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6A2F3FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395290AbhALXFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395279AbhALXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:05:19 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D942C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:04:39 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id g5so2635789qke.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Y0KAISnuXX2gFzoq/Qsl8sKWgicC7g3UhMx8vPDTkn8=;
        b=PYdqirPd7OL9UPyqVl0JlRQBnTI/hq6YNxK9vmGXEH04zrlGRGB4WIyjohJJaelkIz
         weiGIvEWA8T3gcm7iEYkdWQ1koRBJ8GWCHed3eC7kxwHx6xMYzfuxNeDYOc56Y0izqh6
         8z/pvis4AGiMsKXzaLGGKwJ8W89Sc3f50gkUo17A+t0B7vBsZy79L5Rse0rb3F7HIO6c
         KtMrD8XzaOMqwa1fpmIEt6YOFf5X2VIm4sqTjjxcKzUfQHYJ9Z7PeS5CZytqC2F1v3ME
         XV/YAlUuMC1taKq91eBvZLAAYh50asHvJa/XgKlECIbCYVfT8YQCdzWvB1YL6q4liB8H
         UcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Y0KAISnuXX2gFzoq/Qsl8sKWgicC7g3UhMx8vPDTkn8=;
        b=GbZhxRbHCLlH3c3lBP+r+mRqS8Gxz1vNM0W0NKjiu3XPqZgaEMyGnE+edKtm4oTsJH
         8bfgrx4k878TjK1sV5QevimGNDywPe/7FAtMdg2NZBvkeZk0cGbdw+xnFNI+Vg2Lj3wS
         W4JtkdD5z/XUyEjjVwn6feb/HGTH2lRL0tEc5LZ52az4us3njWkRxCi/lP6E1KuWMinm
         aGTdkPFhn8Ardfi48MmGD9nULJg/qsxOWiRelvB4cok0+pksJXeEtyUEWkl95wt1/uQe
         g4Eb2W5BOlzpJM/IChBqCfi8oNIH6SSdYOKd6xqnJfhjXYcjxoQltXpxKqB5kVjg4WtO
         FsBA==
X-Gm-Message-State: AOAM530oiV1baxPYMPsHWW3LWOhner5zcNPylBs3PcDxyrlRDSSE2l7z
        p+1Mm6NWE/TsojtrtsC1z0BXpmrVhS5E
X-Google-Smtp-Source: ABdhPJy9h9p7en4Uax+nPQlYCCR44s1BYsfahXglviCRXFu03lwly0uOlOrnYErYjVBIgWBoKqNoIs3HRXxn
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:90ee:: with SMTP id
 p101mr1980720qvp.29.1610492678281; Tue, 12 Jan 2021 15:04:38 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:04:29 -0800
Message-Id: <20210112230434.2631593-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v7 0/5] Don't compute events that won't be used in a metric.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    
For a metric like:
  EVENT1 if #smt_on else EVENT2
    
currently EVENT1 and EVENT2 will be measured and then when the metric
is reported EVENT1 or EVENT2 will be printed depending on the value
from smt_on() during the expr parsing. Computing both events is
unnecessary and can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies expression parsing so that constants are
considered when building the set of ids (events) and only events not
contributing to a constant value are measured.

v7. fixes the fix to be in the correct patch.

v6. rebases and fixes issues raised by Namhyung Kim <namhyung@kernel.org>,
a memory leak and a function comment.

v5. uses macros to reduce boiler plate in patch 5/5 as suggested by
Andi Kleen <ak@linux.intel.com>.

v4. reduces references to BOTTOM/NAN in patch 5/5 by using utility
functions. It improves comments and fixes an unnecessary union in a
peephole optimization.

v3. fixes an assignment in patch 2/5. In patch 5/5 additional comments
are added and useless frees are replaced by asserts. A new peephole
optimization is added for the case CONST IF expr ELSE CONST, where the
the constants are identical, as we don't need to evaluate the IF
condition.

v2. is a rebase.

Ian Rogers (5):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Don't compute unused events.

 tools/perf/tests/expr.c       | 159 +++++++++++-----
 tools/perf/tests/pmu-events.c |  42 +++--
 tools/perf/util/expr.c        | 137 ++++++++++++--
 tools/perf/util/expr.h        |  21 ++-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 343 ++++++++++++++++++++++++++--------
 tools/perf/util/metricgroup.c |  44 +++--
 tools/perf/util/stat-shadow.c |  54 ++++--
 8 files changed, 591 insertions(+), 218 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

