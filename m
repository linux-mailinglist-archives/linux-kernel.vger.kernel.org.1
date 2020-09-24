Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E9277150
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIXMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgIXMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bd2so1611504plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82Hjxqjlp9ZV80LwxlPX6GmvhuS/yS1h7uDkIz8daCc=;
        b=jhK6zg5VSCjWhRDR0RQ6xa6XBw2MleAFsQk4ZmWxWL3pn59037PcBZVArhGlshKspE
         qG+loDUIU1/NBQRI2Bt9itwPuRPRqtRS0uJzGhtPNjLsTZyy1WQ+ZG2H3mS2LC3zZlWK
         9iyecaBhZ6xusJgls6Im1IVtk5HINv2ualtp0nriKhfudDuGCxQHij0uKKnSQBPGAxHK
         aB/0BP8tKfPpcmUx6Xla8c6oxV+DxWvTq+EMSXHVwc5YTiaRPRx5HHz6Xci6TsNvq2LE
         mtxHqIGGqwAC1qzB3w5JrfayyB3wNb/omoraZ3UMn8EqDpyYBKL89dm3HZfRyqMRGjz0
         ZDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=82Hjxqjlp9ZV80LwxlPX6GmvhuS/yS1h7uDkIz8daCc=;
        b=mW/bgId8UZrr29e/kxz7KDREbkCDbU906mxFgUU0keqxiWUOCI+1yBZIYT+m2MZGaN
         7jAnXFGLXX67CZnW/bvOS9BRuwQJhZJejk56lJ+At/FaO0aEQ6tdFRRuHmMeZuDaoar/
         UTqxX6JltWHM1JlJH5YTuHIUygK5vRKT2pigS2MVLVLY7UlLGi6R5+9dX0agCkcZzrb/
         eQjn31+o3UMppta8Z50RyBddQFTC69j3gbKytR7mYjj5I/tOXX0FAyjL/WlH4ZAeKuF+
         CaqPif2xjxBSuc6/zNRKCM13mv7ChEcydhwdchBdmpD4aXLR8j5+RS85XuLOrNn7R52z
         iFwA==
X-Gm-Message-State: AOAM533oHwAD6Z8P+vc2hXJ4L6rTyPPlwUAuITXQHUqqDeSNAB9/OR2J
        Dlk44Z/vyxkO2N3DR0uDoUE=
X-Google-Smtp-Source: ABdhPJzinzuAv6nLHcBQsmWWWnzNXZM/ssSRCPVJo3iIf9dKBuaGF0uMigjVwWaxeeprmxkjngJRrg==
X-Received: by 2002:a17:90a:9f8e:: with SMTP id o14mr3784544pjp.103.1600951503478;
        Thu, 24 Sep 2020 05:45:03 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 194sm2690310pfy.44.2020.09.24.05.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET v5 0/5] perf stat: Expand events for each cgroup
Date:   Thu, 24 Sep 2020 21:44:50 +0900
Message-Id: <20200924124455.336326-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When we profile cgroup events with perf stat, it's very annoying to
specify events and cgroups on the command line as it requires the
mapping between events and cgroups.  (Note that perf record can use
cgroup sampling but it's not usable for perf stat).

I guess most cases we just want to use a same set of events (N) for
all cgroups (M), but we need to specify NxM events and NxM cgroups.
This is not good especially when profiling large number of cgroups:
say M=200.

So I added --for-each-cgroup option to make it easy for that case.  It
will create NxM events from N events and M cgroups.  One more upside
is that it can handle metrics too.

For example, the following example measures IPC metric for 3 cgroups

  $ cat perf-expand-cgrp.sh
  #!/bin/sh
  
  METRIC=${1:-IPC}
  CGROUP_DIR=/sys/fs/cgroup/perf_event
  
  sudo mkdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C
  
  # add backgroupd workload for each cgroup
  echo $$ | sudo tee $CGROUP_DIR/A/cgroup.procs > /dev/null
  yes > /dev/null &
  echo $$ | sudo tee $CGROUP_DIR/B/cgroup.procs > /dev/null
  yes > /dev/null &
  echo $$ | sudo tee $CGROUP_DIR/C/cgroup.procs > /dev/null
  yes > /dev/null &

  # run 'perf stat' in the root cgroup
  echo $$ | sudo tee $CGROUP_DIR/cgroup.procs > /dev/null
  perf stat -a -M $METRIC --for-each-cgroup A,B,C sleep 1
  
  kill %1 %2 %3
  sudo rmdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C

  
  $ ./perf-expand-cgrp.sh IPC
  
   Performance counter stats for 'system wide':
  
      11,284,850,010      inst_retired.any          A #     2.71 IPC                    
       4,157,915,982      cpu_clk_unhalted.thread   A                                   
      11,342,188,640      inst_retired.any          B #     2.72 IPC                    
       4,173,014,732      cpu_clk_unhalted.thread   B                                   
      11,135,863,604      inst_retired.any          C #     2.67 IPC                    
       4,171,375,184      cpu_clk_unhalted.thread   C                                   
  
         1.011948803 seconds time elapsed


* Changes from v4:
 - fix python import error  (Kernel test robot)
 - make metric-related function calls conditional  (Jiri)

* Changes from v3:
 - rename to evlist__find_evsel  (Jiri)
 - add documentation  (Arnaldo)
 - check -G option together with --for-each-cgroup

* Changes from v2:
 - put relevant fields in evsel together  (Jiri)
 - add various error checks  (Jiri)
 - split cgroup open patch  (Jiri)

* Changes from v1:
 - rename the option to --for-each-cgroup  (Jiri)
 - copy evsel fields explicitly  (Jiri)
 - add libpfm4 test  (Ian)


The code is available at 'perf/cgroup-multiply-v5' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks
Namhyung


Namhyung Kim (5):
  perf evsel: Add evsel__clone() function
  perf stat: Add --for-each-cgroup option
  perf tools: Copy metric events properly when expand cgroups
  perf tools: Allow creation of cgroup without open
  perf test: Add expand cgroup event test

 tools/perf/Documentation/perf-stat.txt |   5 +
 tools/perf/builtin-stat.c              |  28 ++-
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   4 +
 tools/perf/tests/expand-cgroup.c       | 241 +++++++++++++++++++++++++
 tools/perf/tests/tests.h               |   1 +
 tools/perf/util/cgroup.c               | 115 +++++++++++-
 tools/perf/util/cgroup.h               |   3 +
 tools/perf/util/evlist.c               |  11 ++
 tools/perf/util/evlist.h               |   1 +
 tools/perf/util/evsel.c                | 104 +++++++++++
 tools/perf/util/evsel.h                |  93 ++++++----
 tools/perf/util/metricgroup.c          |  85 +++++++++
 tools/perf/util/metricgroup.h          |   6 +
 tools/perf/util/python.c               |  19 ++
 tools/perf/util/stat.h                 |   1 +
 16 files changed, 673 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/tests/expand-cgroup.c

-- 
2.28.0.681.g6f77f65b4e-goog

