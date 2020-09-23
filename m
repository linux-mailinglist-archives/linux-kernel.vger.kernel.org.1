Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB4E274ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIWB7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:59:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06CAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:59:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so14071605pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HEI+Mbst1VHkiqcnM4/bVjiEYGJCFbwp/8i+/llCCzw=;
        b=nvQki2XhsOBzTSx6I1wV1xYp1n/WwBK4o7UonHat0yn0Z0Fgyff34JVoyGbCx6Thq7
         G8PSMt6V+nBEwrdP4soITSdYxXt7n7MDaJL5yKBgm6OVKBL91WEkXYRBjkNItWTVmTuL
         MBeF4GlBAcXjHky5Xeg0Icszyx+Ffx04YMZ0a483RZtBUJJ25g2g6SaYSc4SQHuFgikb
         o5O/GobpmatHVd8NfmNIxITAwlhAhG+VPMKWMptsw/s9pRyxaewjZl9Eea8V30slXOuN
         5etvlzvsiULNNAKEXCQr1GAJowUWO+jj7D8LE7LDgqkB2WliNJdMca/HRl00HWvaI8CQ
         TUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HEI+Mbst1VHkiqcnM4/bVjiEYGJCFbwp/8i+/llCCzw=;
        b=tGlDCE4DQxtk1mKBHPdeqSQqBxWG1J3zz/cIveb+Y1lCBaILVXwIGz0uPzAsveAZG+
         4LU8aTLg+sT1K6eUCXOrgfvTROVNiKtbc8bPROi4C7aAdBM8sN0qs/fy4F7uEr6DfRsV
         AU9ZQKq0/CAyjNOLWVBjB0/UoTmsGyDqEGXH5aipSuxJpzzpMQKmTVqOe/zJ1JPajid8
         z11I9+K4mPxCBRiOlgk3U149S6FG6re9fUV4aOfjIlUeQuNE2MetCV46vDKCViEKkLcn
         I4EWTdP3mrsHiNrFje2mcxWgUF91HwukeTLEFv8aXpEeQIm6HJ9KtlH51qfjRqiAT8Qo
         YWrg==
X-Gm-Message-State: AOAM533dTd8B/Lo5QaUjSzPU+GOeKHwgujCqp3aSz3U9LQp/uxhcIdTb
        RpSNbCHEj0wCpdnfqDb98Yk=
X-Google-Smtp-Source: ABdhPJyZpBAL04O7QvKGKEbwOA9warr6z52ijvA3NuwNJrIqCk7NQ6RcdeF5/1/egUruu8qBEKMHrA==
X-Received: by 2002:a62:3146:0:b029:13e:d13d:a13a with SMTP id x67-20020a6231460000b029013ed13da13amr6572263pfx.34.1600826392076;
        Tue, 22 Sep 2020 18:59:52 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v13sm3367741pjr.12.2020.09.22.18.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:59:51 -0700 (PDT)
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
Subject: [PATCHSET v4 0/5] perf stat: Expand events for each cgroup
Date:   Wed, 23 Sep 2020 10:59:40 +0900
Message-Id: <20200923015945.47535-1-namhyung@kernel.org>
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


The code is available at 'perf/cgroup-multiply-v4' branch on

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
 tools/perf/util/cgroup.c               | 107 ++++++++++-
 tools/perf/util/cgroup.h               |   3 +
 tools/perf/util/evlist.c               |  11 ++
 tools/perf/util/evlist.h               |   1 +
 tools/perf/util/evsel.c                | 104 +++++++++++
 tools/perf/util/evsel.h                |  93 ++++++----
 tools/perf/util/metricgroup.c          |  85 +++++++++
 tools/perf/util/metricgroup.h          |   6 +
 tools/perf/util/stat.h                 |   1 +
 15 files changed, 646 insertions(+), 45 deletions(-)
 create mode 100644 tools/perf/tests/expand-cgroup.c

-- 
2.28.0.681.g6f77f65b4e-goog

