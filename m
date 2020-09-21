Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3C271F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgIUJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:46:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA6CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o25so3602748pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KA+3puRW5VzCtZ0MM3fDAmtMK/pJq5jv8szdVeIQg3c=;
        b=fWfs/Bu6Yo2E+ssLKQ7yocq4lDn+tUOhF3702F77zOzEaN3Fne987Qu9izfhW+lNv4
         lAfDNCvAQEhkGGhltylIr4FKXE1idXwTn6UoheHhCtbfzV1FLG/gPcEVLRe9RbVfsCPi
         dp/b5Qmu+YxhQ9xZ4tzsdZ1gEuTf24sI+C8Vj1U8cf5OoiyKR1y/b9k2khBwLlx4B4uT
         +Rgo2MzqTadOnywr6ofYtJyevziSVJHs4nQVz9Fo+nBLnHjT0UfhTFXmsJf1Dyl9cT+4
         kU5sKVJ2O74tHYRzh1cUwDji/+ioJnb98pRvDIvqjcrFSxEPuQLn3J4FNfCbpGCUQd8h
         F4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KA+3puRW5VzCtZ0MM3fDAmtMK/pJq5jv8szdVeIQg3c=;
        b=CA1lJL3Akl+Yqyurg7MqdRk/2BoppYkybim1wioqks6b+3uDn8E0wcEBPYGU/O9/31
         KslhTldRWRe9KOzkrtWjo4F8Z3rULMtyjoPi25CRgeC1EKLjwWR6NmiTH1MBnXAlVdoF
         c8tpKqW1lOKTyd0Vqwa8gD1y9L/VZjP7jDnMc0Y9tu3VbAUBr/rTga8uHZwuB91TsR2c
         yyYDJAiNbcEAEaF+0n0xkiU5KcGlR3xTaIhAQSsRPUfM9PEF6wqd4BSGB/vgYxvW18Dh
         H1sHjkNUjfIo2p0ex4Rlv1OzRbceOGhtBh4aBbvdF3FckFE9oyQoNrfanqfIprY9EC8Z
         UkSg==
X-Gm-Message-State: AOAM530hX4xsEGb5snw3vOM7WLaeFl9izcQLSkSAz92Umx3roCoKhddn
        1dUNGvL2WMxYoJRDa5/2kPM=
X-Google-Smtp-Source: ABdhPJwPIjWXFKAMa3vk13X+46jMuwjrzz+igEvTeSNbaXbiCnfoCXXBESGRdRP0q22lOFwNWer2zg==
X-Received: by 2002:a63:ba5e:: with SMTP id l30mr36444599pgu.425.1600681576071;
        Mon, 21 Sep 2020 02:46:16 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id x192sm11199984pfc.142.2020.09.21.02.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 02:46:15 -0700 (PDT)
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
Subject: [PATCHSET v3 0/5] perf stat: Expand events for each cgroup
Date:   Mon, 21 Sep 2020 18:46:05 +0900
Message-Id: <20200921094610.83736-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending with +LKML, sorry)

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


* Changes from v2:
 - put relevant fields in evsel together  (Jiri)
 - add various error checks  (Jiri)
 - split cgroup open patch  (Jiri)

* Changes from v1:
 - rename the option to --for-each-cgroup  (Jiri)
 - copy evsel fields explicitly  (Jiri)
 - add libpfm4 test  (Ian)


The code is available at 'perf/cgroup-multiply-v3' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks
Namhyung


Namhyung Kim (5):
  perf evsel: Add evsel__clone() function
  perf stat: Add --for-each-cgroup option
  perf tools: Copy metric events properly when expand cgroups
  perf tools: Allow creation of cgroup without open
  perf test: Add expand cgroup event test

 tools/perf/builtin-stat.c        |  21 ++-
 tools/perf/tests/Build           |   1 +
 tools/perf/tests/builtin-test.c  |   4 +
 tools/perf/tests/expand-cgroup.c | 241 +++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h         |   1 +
 tools/perf/util/cgroup.c         | 112 +++++++++++++-
 tools/perf/util/cgroup.h         |   3 +
 tools/perf/util/evlist.c         |  11 ++
 tools/perf/util/evlist.h         |   1 +
 tools/perf/util/evsel.c          | 104 +++++++++++++
 tools/perf/util/evsel.h          |  93 +++++++-----
 tools/perf/util/metricgroup.c    |  83 +++++++++++
 tools/perf/util/metricgroup.h    |   6 +
 tools/perf/util/stat.h           |   1 +
 14 files changed, 637 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/tests/expand-cgroup.c

-- 
2.28.0.681.g6f77f65b4e-goog

