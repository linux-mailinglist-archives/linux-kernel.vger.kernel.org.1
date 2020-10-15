Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175E28F511
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbgJOOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388305AbgJOOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE23C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e23so3461260wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1sKt0qAbpSX+oBrhrT+egnfhYrLJVpycm37nkl3I/0k=;
        b=Y/kIwOkkyXsI27pbuxbgvQMYt4S+5jdK5aWJ0o6f4AOzz3Qs4zygLJUHNIatdf3S8m
         Klct29ul1a4dr2wlmTmV0nCje18POeRAQWUQiadka0Io5UjTEw0bEBrjWolMc8Gicr6H
         ImjixASfGdl1fo+z7qRxq6AUQnK7edkgZlJ4wRh6um93EYqi/Y5KbQ7gnp9LxyQ2RzLp
         ovJC/riVYR3VwUGjKQO29MaevATiFZkSPpT83WKgj0vBldqruCA+7VP5ycsPFbDcAKqS
         rj3+ANnAOLsP+jfEjp419BfUoylnKVm5/Vl4yGwhstt1h6H/toHZ5LuxhhY91GKCVz2L
         xN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1sKt0qAbpSX+oBrhrT+egnfhYrLJVpycm37nkl3I/0k=;
        b=UIv/oWhFwXzmEn32OaYX4wHu3O05Jg1/XEMACaE8IojyXYfKoBSycLv9S9I1sDJ69B
         qfQqD4oji/33BTHPuqwYp5RToiIGveKWCCEPaeh8/qEf+bLkSjl04LLg76q7TD3k8OPH
         ivigJf35zelJ/8zd9X5GiXno7bbvo+11uPq2JzHppo3u+C/tEhaz28KC9rGK+FSyr41x
         Kk2zHaq4+bTXAHK253l20QAbnM9VWoTsLOtbBtDX6FGwM0Zorp7KBQ5pftyZ9khD6CHS
         b2QowzYDSvNPR2zyVqqv8CbP1aWlfHPPHwo0wl60M3quwYu9LBdY08yun/vQz6yLZDhe
         sX2w==
X-Gm-Message-State: AOAM530GoS4/ol5QEjhf83dQlwFb8DphmBvDh2aotCgjX+Txaw29P5R6
        Ru7lJq2DuO1ooblhHYWAJU3U0w==
X-Google-Smtp-Source: ABdhPJzEIC6L7XdN5sFDpP2iR+uyiia6bGWJSrUpRIBQWMJplu9ryN4vryHu5jm5AxFDMZ8uKpH5Ag==
X-Received: by 2002:a05:600c:2905:: with SMTP id i5mr4409473wmd.9.1602773167625;
        Thu, 15 Oct 2020 07:46:07 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q5sm5413421wrs.54.2020.10.15.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:46:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/9] perf c2c: Refine the organization of metrics
Date:   Thu, 15 Oct 2020 15:45:39 +0100
Message-Id: <20201015144548.18482-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to refine metrics output organization.

If we reivew the current memory metrics in Perf c2c tool, it doesn't
organize the metrics with directive approach; thus user needs to take
time to dig into every statistics item.  On the other hand, if use the
"summary and breakdown" approach, the output result will be easier for
reviewing by users, e.g. the output result can firstly give out the
summary values, and then the later items will breakdown into more
detailed statistics.

For this reason, this patch is to reorganize the metrics and it only
changes for the "Shared Data Cache Line Table": it firstly displays the
summary values for total records, total loads, total stores; then it
breaks these summary values into small values, with the order from the
most near memory node ("CPU Load Hit") to more far nodes
("LLC Load Hit", "RMT Load Hit", "Load Dram").

  "LLC Load Hit" = "LclHit" + "LclHitm"

  "RMT Load Hit" = "RmtHit" + "RmtHitm" \
                                         ->  LLC Load Miss
  "Load Dram"    = "Lcl" + "Rmt"        /

Another main reason for this patch set is wanting to extend "perf c2c"
to support Arm SPE memory event, but Arm SPE doesn't contain 'HTIM' tag
in its default trace data, for this case if want to analyze cache false
sharing issue, we need to rely on LLC metrics + multi-threading info.
So this patch set can be friendly to show LLC related metrics in the
"Shared Data Cache Line Table"; for sorting cache lines with LLC metrics
which will be sent out with another separate patch set.

Before:

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----  ---- Store Reference ----  --- Load Dram ----      LLC    Total  ----- Core Load Hit -----  -- LLC Load Hit --
# Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt    Total    L1Hit   L1Miss       Lcl       Rmt  Ld Miss    Loads       FB       L1       L2       Llc       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  .......  ........  ........
#
      0      0x55acdcc92100     0    8197    40716   52.18%     3170     3170        0    24466    24437       29         0         0        0    16250     3349     5909        0      3822         0
      1      0x55acdcc920c0     0       1     4621   31.01%     1884     1884        0        0        0        0         0         0        0     4621      739        0        0      1998         0
      2      0x55acdcc92080     0       1     4475   16.69%     1014     1014        0        0        0        0         0         0        0     4475     2405        0        0      1056         0


After:

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
#
      0      0x55acdcc92100     0    8197   52.18%     3170     3170        0    40716    16250    24466    24437       29     3349     5909        0      3822     3170         0        0         0         0
      1      0x55acdcc920c0     0       1   31.01%     1884     1884        0     4621     4621        0        0        0      739        0        0      1998     1884         0        0         0         0
      2      0x55acdcc92080     0       1   16.69%     1014     1014        0     4475     4475        0        0        0     2405        0        0      1056     1014         0        0         0         0

Changes from v1:
* Added Joe's test tag for patches 01-08;
* Added a new patch for updating documentation.


Leo Yan (9):
  perf c2c: Display the total numbers continuously
  perf c2c: Display "Total Stores" as a standalone metrics
  perf c2c: Organize metrics based on memory hierarchy
  perf c2c: Change header from "LLC Load Hitm" to "Load Hitm"
  perf c2c: Use more explicit headers for HITM
  perf c2c: Change header for LLC local hit
  perf c2c: Correct LLC load hit metrics
  perf c2c: Add metrics "RMT Load Hit"
  perf c2c: Update documentation for metrics reorganization

 tools/perf/Documentation/perf-c2c.txt | 34 +++++------
 tools/perf/builtin-c2c.c              | 83 ++++++---------------------
 2 files changed, 36 insertions(+), 81 deletions(-)

-- 
2.17.1

