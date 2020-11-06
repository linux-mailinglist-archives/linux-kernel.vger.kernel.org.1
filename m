Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42EC2A9350
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKFJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:14 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF4C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:14 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g12so524888pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7GGm+15NsiqV9cmWAtiFnC9DpN0irpfGqorANfORa8w=;
        b=cCtpPd9eTAkBXS66LMXjj1vCK6k9z2saUc6OR81LyOBukpfj4SC1ndwl38jB1S0ocq
         Lsm5WhNCicIXvfi59JT8dG5NpZw8fJyByPfQgyGWQv1Ow3vS8NX6w69YB9GNbU3hjg3w
         9CE6f803psnTuWwv3vPuZ64ArVJtTit/qjNAexm8nBj8DjBRpd9IHm2PPF9b2swT7mwp
         gM3sqt/s94TwncILtebGy0e0pTCLRJGs290XFBmP5XLHuHW2W9Pm8HwbptLv+eaNwXE5
         gVEeTuZZSL+x6px+MyaZaKczK4kOnOGJ8Y0amvpq70YNviNugOUTASjYHm4DN5VWfoVI
         D1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7GGm+15NsiqV9cmWAtiFnC9DpN0irpfGqorANfORa8w=;
        b=DSygMMUwGinkCPOmTPlBiawSPj2Kgd+tCThI4zjFlxGHQOYrInJ/i7Z2SBOwyC+q2i
         XxqFVOVU9TgzXVM3SCNA4LcTWVC39Q0t4257Dj1ZyW38M6ORlVmKu7Z+5Q0myVTF9UmU
         6uxV1F5+2rrqd8691LQ42teJi5ubPoz8CEKAk627KjIW3MyFKpXMyshVB8i9WVNzpFcH
         eQkaufwWi3ezq4slWVocENZe1D+PfGRDkT/IuBPWnJ6uTkWwyLvm7OM3mYrKVuuNh09F
         8VA2L9u4XVQKpS2f5BV8BU1JnVzbOe9+6kyrRb1tnxUBLIldNQ4+vGGaWX//nFDB7Ztd
         kG1w==
X-Gm-Message-State: AOAM532H8wQPNWujTwq9EhzbiSh5elnBysIws+IHxi7+ddrYwCfza3q2
        Um9zFZLUM/JER2WaTN4xuOre1JCVkdGyrh4JDXk=
X-Google-Smtp-Source: ABdhPJwMdvOOo2rzShbMP9JBXuA7TSBYMQkkfsSDx152a/Ptxms0KgTY1vugZdWx07ThAM32BHRJ9g==
X-Received: by 2002:a17:90a:c381:: with SMTP id h1mr1699710pjt.2.1604656153991;
        Fri, 06 Nov 2020 01:49:13 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id kb12sm1784173pjb.2.2020.11.06.01.49.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:12 -0800 (PST)
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
Subject: [PATCH v4 0/9] perf mem/c2c: Support AUX trace
Date:   Fri,  6 Nov 2020 17:48:44 +0800
Message-Id: <20201106094853.21082-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is v4 for support perf mem/c2c AUX trace.

Comparing to patch set v3, this patch set adds back the patch 06/09 for
introducing the itrace option '-M', this allows to synthenize memory
event from the AUX trace data.

Since perf mem/c2c tools are focus on memory profiling, this patch set
makes itrace memory event as default for perf mem/c2c, the tool will
tell AUX trace decoder that it is _ONLY_ interested in memory event
rather than other itrace events.  So patches 07, 08 have updated
'itrace_synth_opts' for this.

This patch has dropped the memory type 'ldst' and keeps to use the old
types 'load' and 'store', if user passes the type 'load,store', the tool
can automatically use PERF_MEM_EVENTS__LOAD_STORE event if arch supports
it, otherwise, rolls back to enable both LOAD and STORE events.  So we
don't need to do any change for tool's usage.

This patch set has been applied clearly on the perf/core branch with the
latest commit 7b3bcedf5ee5 ("perf scripting python: Avoid declaring
function pointers with a visibility attribute").

This patch set has been verified on both x86 and Arm64.

On x86, below commands have been tested:

  # perf c2c record -- ~/false_sharing.exe 2
  # perf c2c record -e ldlat-loads  -- ~/false_sharing.exe 2
  # perf c2c record -e ldlat-stores  -- ~/false_sharing.exe 2
  # perf mem record -- ~/false_sharing.exe 2
  # perf mem record -t load -- ~/false_sharing.exe 2
  # perf mem record -t store -- ~/false_sharing.exe 2
  # perf mem record -t load,store -- ~/false_sharing.exe 2
  # perf mem record -e ldlat-loads  -- ~/false_sharing.exe 2
  # perf mem record -e ldlat-stores  -- ~/false_sharing.exe 2

On Arm64, below commands have been tested:

  # perf c2c record -- ~/false_sharing.exe 2
  # perf c2c record -e spe-load  -- ~/false_sharing.exe 2
  # perf c2c record -e spe-store  -- ~/false_sharing.exe 2
  # perf c2c record -e spe-ldst  -- ~/false_sharing.exe 2
  # perf mem record -- ~/false_sharing.exe 2
  # perf mem record -t load -- ~/false_sharing.exe 2
  # perf mem record -t store -- ~/false_sharing.exe 2
  # perf mem record -t load,store -- ~/false_sharing.exe 2
  # perf mem record -e spe-load  -- ~/false_sharing.exe 2
  # perf mem record -e spe-store  -- ~/false_sharing.exe 2
  # perf mem record -e spe-ldst  -- ~/false_sharing.exe 2

Changes from v3:
* Added back the patch 06/09 for introducing the itrace option '-M'
  (Jiri);
* Added 'itrace_synth_opts' for memory event (Jiri);
* Dropped type 'ldst' so don't change any usages for tools (Ian);
* Dropped the patch "perf mem: Return NULL for event 'ldst' on
  PowerPC" due type 'ldst' is not added anymore (Ian);
* Added patch 04/09 "perf c2c: Support memory event
  PERF_MEM_EVENTS__LOAD_STORE", so can convert the load/store requests
  to event PERF_MEM_EVENTS__LOAD_STORE (James Clark).


Leo Yan (9):
  perf mem: Search event name with more flexible path
  perf mem: Introduce weak function perf_mem_events__ptr()
  perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
  perf c2c: Support memory event PERF_MEM_EVENTS__LOAD_STORE
  perf mem: Only initialize memory event for recording
  perf auxtrace: Add itrace option '-M' for memory events
  perf mem: Support AUX trace
  perf c2c: Support AUX trace
  perf mem: Support Arm SPE events

 tools/perf/Documentation/itrace.txt     |  1 +
 tools/perf/arch/arm64/util/Build        |  2 +-
 tools/perf/arch/arm64/util/mem-events.c | 37 ++++++++++++++++
 tools/perf/builtin-c2c.c                | 39 ++++++++++++++---
 tools/perf/builtin-mem.c                | 56 +++++++++++++++++++------
 tools/perf/util/auxtrace.c              |  4 ++
 tools/perf/util/auxtrace.h              |  2 +
 tools/perf/util/mem-events.c            | 45 +++++++++++++++-----
 tools/perf/util/mem-events.h            |  3 +-
 9 files changed, 158 insertions(+), 31 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c

-- 
2.17.1

