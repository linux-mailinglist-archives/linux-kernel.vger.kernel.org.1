Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0401E2CB4FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbgLBG1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgLBG1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:27:33 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2657C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 22:26:52 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id o16so494881qvq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 22:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/U6JnhyXMOOWBOzVJwrT2AuMKkclyOwUZGq9GHvHseY=;
        b=mNhzbd6GBJWTUdVBMFch2wD+qhXO+5YpsK0XCGJZJgO27VwgL6/nmFuPFJIe/7Thk3
         3co4ewueMNDRyO0idFsc8eRM0L5pUgp9os3KoMn/3PvxYi/aNvf+aj8nTHsZli1+pTAt
         7YqCD7FOLveQ3yqI8I38TvMmGJZDOXoipEqHfuWuoN3uZhWI/b0kMqfLmWM7nmH8kL1T
         vh20CboPTgKFpQ/dUZIwd1B5mEJQov44gDQ1arRak9zSSION7H/OxhJ6jLxWuL3BLI1o
         3jKJhy6f8KH+UnaLQUGks7wfocQvimv+dx16t3RQvISg0XvUlplXHt1XGR/XvlYuqjnx
         5i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/U6JnhyXMOOWBOzVJwrT2AuMKkclyOwUZGq9GHvHseY=;
        b=gphErjC0VDibRiUnWcQN9k29MAFDFMVYEVEjnYVWxadqxaiUtveefdtnpkQlLWPmjs
         V2tUeOxJosxecce1Ng62L0yOlVe/2A5jZp/R5HBPdjac0PQ4YpkRPG8iOKKpOKFJbi0A
         FWFKGtZXJM1pqII4ePcR42Ait7iIWK9u3O3rCB7Ln98j4clnoHnsOWOvUwQKq8iESZz9
         tMs6BhVDX/OIS/EczwsXj9PRY3bAd9TPu8UjxdUkGePk+1OVOPKVKcOgzefHjyTe+rmx
         a3OP+6qI24nwsTF3+oV/Zkvu7e/Mzovb8e/Fh7B/nJTzgmzMkdMcKZm0u9mj5JjO8y8L
         1zjg==
X-Gm-Message-State: AOAM5323m4Kv7vs/M2xfHKCJ9Xv8hfQQaksAmyLPVp4cfPmwnC06PhRN
        EET0fqhMidBDz552mHkMfuwNUonM9vyU
X-Google-Smtp-Source: ABdhPJzSBvFH4QPm5tGQHjSDS6a3J36LvpniyysD6xCYmZpZqKLGS7zgvaevX4JcLDuO+44NSwdZX5cw18Cs
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:c30d:: with SMTP id
 f13mr1139116qvi.29.1606890411564; Tue, 01 Dec 2020 22:26:51 -0800 (PST)
Date:   Tue,  1 Dec 2020 22:26:41 -0800
Message-Id: <20201202062646.3780002-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v4 0/5] Don't compute events that won't be used in a metric.
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

 tools/perf/tests/expr.c       | 159 +++++++++----
 tools/perf/tests/pmu-events.c |  42 ++--
 tools/perf/util/expr.c        | 136 +++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 418 +++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.c |  44 ++--
 tools/perf/util/stat-shadow.c |  54 +++--
 8 files changed, 658 insertions(+), 221 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

