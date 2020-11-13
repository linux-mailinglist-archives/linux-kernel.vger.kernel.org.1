Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55F2B131E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMARB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgKMAQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:16:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AAFC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:16:56 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q25so5511249qkm.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=SF2/0cBD4SDXrx4kSO5jpkw3cm1P8On8XdzbrxLvYHc=;
        b=eSV+mjSXgJcCb1CVnnrLnnD0ABu+pRfHzud1Sn/xHVeRS4cxxt3tssKBrDRO+fvBNl
         0ZI6atxrCJKqLTib4fLCMfKcyXqzMMxqRmGwZB6kZV3d713uwHTsAWiAPQ3BP8h1qrKb
         TU/OoojdIdLIvGZ2Q9zoAbQNUsq5rpuuqHYWv0yEp01ATsqJ0+fOGFjYxlzCgCIpJtE1
         0dYhn80pwsJbwuLdnT6UhKvH87Q9JzkmnPKU1YYnmaiZ4hVkpGoABNePD8RMumgQqvJ0
         Mm01M3GvVx8X6GiaFUjEvzf+UinZIO31niJV0uM+tFxVRvcEMyUkRi8RADxJxfiEJzOO
         3QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=SF2/0cBD4SDXrx4kSO5jpkw3cm1P8On8XdzbrxLvYHc=;
        b=jPtKDHX08nNrFcvuF9bXrjfVKpI1XGJikPT/QQB/I+BWyv24xeoyK+SXhaxpFsreok
         AsJHsuJsVI7eYE2ZKFkq2aXOOIyoUtgy41MLEYIuSQTbKhoC0xwan8INwz5tr1d3AqXr
         4YgCFnqS2zllgDMBUvA12kyncNAryWnUh03E3WV+lgtk+hfACZU+xwWgB8c3qzq8IXv1
         oRJ90Mk1rAKB5JkBhux/ShWVM2IVGrxjJ3wFCuj5s3pLu8D/igIOY/UZnC9YN2deKpHQ
         v+PpbSpEUm6FMuGgrThHjikmNvODWPF1OZhpS/OmgUDsNibIgDYtGFTQzJJumgZYRgPN
         LazQ==
X-Gm-Message-State: AOAM530pH5geQ4A4i1gXjk0Gf6YDiz6TlvH3V76vpk81Tu3mtDhjBMa+
        ricznZEuMKht6tgxCa3LTZVBVNUzQG4E
X-Google-Smtp-Source: ABdhPJwyboO74LHKP98PlInQeAm3Rn2ncH8TrzT9NTK5yWDR5AbUSz+LT4KC0pVNzuUBfniZGLxyJE9p1S3T
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:c18a:: with SMTP id
 n10mr2475691qvh.54.1605226615225; Thu, 12 Nov 2020 16:16:55 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:16:46 -0800
Message-Id: <20201113001651.544348-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 0/5] Don't compute events that won't be used in a metric.
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
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
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

Ian Rogers (5):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Don't compute unused events.

 tools/perf/tests/expr.c       | 148 ++++++++++-----
 tools/perf/tests/pmu-events.c |  42 +++--
 tools/perf/util/expr.c        | 136 ++++++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 343 +++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.c |  44 +++--
 tools/perf/util/stat-shadow.c |  54 ++++--
 8 files changed, 586 insertions(+), 207 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

