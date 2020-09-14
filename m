Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE4269402
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgINRsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgINMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:03:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A4C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:54:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so12401927pfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q23N1TOucc/ZEqxZTf6rnZyxpHwEyiRp1vp3lvFnC78=;
        b=vITVmm8kJizd444PDe3E8+UH7q3lTG7Znw5SAbXHotbSLqVh4qAJvoAmZkXOzsvS65
         xkAK+aQ1L5/qZhNqfeYmlLYxGcTVvrpvr3XcQw4hEzTBU8fuytzaP5EzL1IbRTKKWmwO
         FmfBO1y0COxhKyTQ+fiXz+8kZMboE75xDquYmNqscuU81XwcVgxV4L6owAIfM9yZNc3x
         EBwNjILz70k541PUtPVEG4Y94EqwJ958fWASypuidNz9+ZRi5XWujASsVZAYASOula/M
         7/4Yq7M/RStZFClyDSBUeOApVxbeDFJoVr82RqtWnYVZeKJfW/8uKk5CtcNwWat2M16v
         fDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q23N1TOucc/ZEqxZTf6rnZyxpHwEyiRp1vp3lvFnC78=;
        b=nnGYJDzKz8UPhtIdiMxgV3pUHP8C//uLs5dzRdgLzCYFNQ3pt04MtJt/5dHNfEEH6F
         bi899TAiMrTmwfzeCjOMz5X7KaqTOdinWXQTVc87W8MTONzyujc5YxAjf7/1e7M9gw6I
         KvomVqa8KEZ+pTfFHue9A5i4XRHZAgmDb73857mEDaP3S26lGYvJ9MQ9EN9fRBC+kOcH
         i1EkXwBGZmQENSoDGB93jjOcZk26NA1779onHX9xM0yvy5ziXeQzqXH2aiKctnRP2Lbi
         RPSGSFx7YEVs4jr37HLTCks25doZdeLDf8DGiVHp0Dbnb9pj40y0uctcUqMboI/ChCQy
         NbMw==
X-Gm-Message-State: AOAM5316pWeO33x4/Y54nngI60MqmQBBK+drYTjegs1hz7mTWH0xxjfY
        8EPtmXypt9XE56l0Oo7crhcKxw==
X-Google-Smtp-Source: ABdhPJzInXcOR8cfrDUoA75xVqAPvLKogwE4HlVoVmEvnWPVnjb/9o00lIHq3RxZ+dKL36R28iXX+w==
X-Received: by 2002:a63:c80b:: with SMTP id z11mr10047599pgg.298.1600084497023;
        Mon, 14 Sep 2020 04:54:57 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id q4sm5910898pjl.28.2020.09.14.04.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:54:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/6] Perf tool: Support TSC for Arm64
Date:   Mon, 14 Sep 2020 19:53:05 +0800
Message-Id: <20200914115311.2201-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to refactor TSC implementation and move TSC code from
x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
alse move the TSC testing from x86 folder to tests so can work as a
common testing.

So far, for x86 it needs to support cap_user_time_zero and for Arm64
it needs to support cap_user_time_short.  For architecture specific
code, every arch only needs to implement its own rdtsc() to read out
timer's counter.

This patch set has been rebased on the perf/core branch with latest
commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
metric events") and tested on Arm64 DB410c.

  $ perf test list
    [...]
    68: Convert perf time to TSC
    [...]

  $ perf test 68 -v
    68: Convert perf time to TSC
    --- start ---
    test child forked, pid 10961
    mmap size 528384B
    1st event perf time 35715036563417 tsc 686221770989
    rdtsc          time 35715036649719 tsc 686221772647
    2nd event perf time 35715036660448 tsc 686221772852
    test child finished with 0
    ---- end ----
    Convert perf time to TSC: Ok

Changes from v3:
* Added comments for Arm64's rdtsc() for short counter (PeterZ);
* Rebased on latest acme/perf/core branch.

Changes from v2:
* Refactored patch set to move TSC common code to util/tsc.c (Wei/Al);
* Moved TSC testing to perf/tests (Wei);
* Dropped Arm SPE timestamp patch so can have clear purpose and easier
  reviewing; will send Arm SPE timestamp as separate patch.


Leo Yan (6):
  perf tsc: Move out common functions from x86
  perf tsc: Add rdtsc() for Arm64
  perf tsc: Calculate timestamp with cap_user_time_short
  perf tsc: Support cap_user_time_short for event TIME_CONV
  perf tests tsc: Make tsc testing as a common testing
  perf tests tsc: Add checking helper is_supported()

 tools/lib/perf/include/perf/event.h           |  4 +
 tools/perf/arch/arm64/util/Build              |  1 +
 tools/perf/arch/arm64/util/tsc.c              | 21 +++++
 tools/perf/arch/x86/include/arch-tests.h      |  1 -
 tools/perf/arch/x86/tests/Build               |  1 -
 tools/perf/arch/x86/tests/arch-tests.c        |  4 -
 tools/perf/arch/x86/util/tsc.c                | 73 +----------------
 tools/perf/tests/Build                        |  1 +
 tools/perf/tests/builtin-test.c               |  5 ++
 .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 13 +++
 tools/perf/tests/tests.h                      |  2 +
 tools/perf/util/jitdump.c                     | 14 ++--
 tools/perf/util/synthetic-events.c            |  8 --
 tools/perf/util/tsc.c                         | 81 +++++++++++++++++++
 tools/perf/util/tsc.h                         |  5 ++
 15 files changed, 143 insertions(+), 91 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/tsc.c
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (93%)

-- 
2.17.1

