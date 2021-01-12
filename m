Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1004D2F3FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394968AbhALW6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394889AbhALW6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:58:48 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD527C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:07 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s66so2645539qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=e8qMN7Kh7MTaJy58MKUxD++RLKAy2XbYQvARp4SosYg=;
        b=FEG69UzGsE0eGafYEvYU0yvhAU5hoMTxSN5KbOFBokJqP5jrOe9WoeRt5dk5mvhVSC
         HTc/+577yFgGrYkw3z4vRK9YjixmEO25AVklgrfuQV8h1kVlNvuXW2cZha/3xhnxkrCX
         WuMQ+gJyvpElwAUx0YHBPP7/ZFZs4w35pBG7Z7Jmv3m27SKEYfcVOYCczzC8oqfrNRTN
         9ZezU5O3PfUuQ0BFuKCz4TRrsQfkUzhiqWaUfnQvqhGcZvNeyidnnDn+oxrY+492w8/N
         N9tCbnz0WY4BXuMa75uvL3DONth0orDqjVUKeSGfFnmLtY0XV0lVW6a0m1K+15tKk5Y+
         77uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=e8qMN7Kh7MTaJy58MKUxD++RLKAy2XbYQvARp4SosYg=;
        b=hFgBNIZkiWYdl+eh/Kd+w24rE3sCFmGQRWXm9+BCMOFtTY+GtAL+QX1I6S2KMUZtig
         B3/i2EY6CrKApAtZ/ckm9ETpCvY6dMzxONq8EZsUy6gKW6naOx/RLVS2nUzvNljULdlt
         8Ukdz2itXviU9WskOzvYHuI3JHg4xaLDN66M/p5f2TWqOjBUq8NjXjVJ6+2Xxn0wq+Xo
         vWXtGPPwLtB+O4zzG84q94GwwZw5RrR6IELXoSWnGDS12KVZrAFCgNqsLxRmnWPWTHqz
         8pKj4IcF96WxXex74+aDoQQ087ozXnZ+ghgBTUlV8MSq9M1sOPaxRc6pSO6/JCjoxd3Y
         0P/g==
X-Gm-Message-State: AOAM532KBsm/EDFyXNJ7kUU6uaiIKaEicY6IdM9uKo529vnxfzQ5zTK0
        uhNO7bSv0b73WuRqhiiT3qSQx9WnEiiv
X-Google-Smtp-Source: ABdhPJzgYNyjwCcZ0nsnO5H10jl3+ceBCgeoDD7YwDFiEgNEyOtloxA/n/RgjUQUMTtQFVNwyHAOZQQLIOQD
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a05:6214:302:: with SMTP id
 i2mr1563771qvu.14.1610492286788; Tue, 12 Jan 2021 14:58:06 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:57:57 -0800
Message-Id: <20210112225802.2613039-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v6 0/5] Don't compute events that won't be used in a metric.
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

