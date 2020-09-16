Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5026BD24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIPGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:31:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0362FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:31:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so840806pfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bpr/5O3kJtSf42pIHIW3TEuUixHKQt811YkKuwWpK1U=;
        b=m5oBAROg9vrSDCvKOT59Wh1Tyaj64ONor8olfyfpJMjvSwoC1Qbn+JE3uZbY1pZnka
         1GUIL130pgccuusUZhWKbup8FejJq9GfXIHTz3CFkneYwbS7B/SE+S1HxUZ0rwxsTOZB
         U67B4QiilJuQZFlaqES61qlmRyK3ZwtJtPI/eAYZCCOIClfRhnnD83NVpYspVlNUFJ+z
         SdU6TwB1/5Jf1JEjFgr2srXJBBWEc/gzR3ptTzzaX7kNn+qcCWnZXvzj7NG3zAjHzAaa
         1RQdYCo2b5EpF7NxAa+HijkbOsh1yT4eiPp4btsn98npnJy3RWvf+TINkxBO6kI4MTu0
         XPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Bpr/5O3kJtSf42pIHIW3TEuUixHKQt811YkKuwWpK1U=;
        b=Mlq1fqd3c2TnGah/QBxnAsMgLygy7WMPlk/83ZcwWXqawlfZMvKZ7Nf0YrBYhq3waT
         WYEhg5ghhRm+NB2fbbEGvvNYvudJ+RVtnwJ05GHx5awsQQn0d5AAc72r/FXc/O3dB3b5
         QRt91pic9TGMXG4VeJj8NKcY8l2lZYZqM49GmyuELsLGolHXK+xB1+KO0cSAZEjVRYJF
         k0YZ+GGV1rkBCwiZp5viek0ENIOacn7rXNUECI5TKlTmkQAeRHS4NrvyQnzO+D3UeGlW
         e3qHvHE9LYHeecUDDKVz9gQqtNXtmjd+UPhAy/7TgWdSlPHOtfZjQXPQsn7yjc/rOCiy
         Borw==
X-Gm-Message-State: AOAM530Kozx2tAjmwzPvqqc3g4HMXVJg9BWkzTdIh37QmoFzZgXYCZWo
        ZuLOb88pAil9wnzxOmBGNTjGfrF7Ccw=
X-Google-Smtp-Source: ABdhPJz5YewJz4ChhwxeQYbcOn7zla+Y6CQvvGHLuJJQMNsq+UqzMuecmzCkHTDVjgFrlg3thCJOVw==
X-Received: by 2002:a63:d506:: with SMTP id c6mr17120358pgg.396.1600237895430;
        Tue, 15 Sep 2020 23:31:35 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 203sm15401388pfz.131.2020.09.15.23.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 23:31:34 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET v2 0/4] perf stat: Expand events for each cgroup
Date:   Wed, 16 Sep 2020 15:31:25 +0900
Message-Id: <20200916063129.1061487-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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


* Changes from v1:
 - rename the option to --for-each-cgroup  (Jiri)
 - copy evsel fields explicitly  (Jiri)
 - add libpfm4 test  (Ian)


The code is available at 'perf/cgroup-multiply-v2' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks
Namhyung


Namhyung Kim (4):
  perf evsel: Add evsel__clone() function
  perf stat: Add --for-each-cgroup option
  perf tools: Copy metric events properly when expand cgroups
  perf test: Add expand cgroup event test

 tools/perf/builtin-stat.c        |  21 ++-
 tools/perf/tests/Build           |   1 +
 tools/perf/tests/builtin-test.c  |   4 +
 tools/perf/tests/expand-cgroup.c | 241 +++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h         |   1 +
 tools/perf/util/cgroup.c         | 107 +++++++++++++-
 tools/perf/util/cgroup.h         |   3 +
 tools/perf/util/evlist.c         |  11 ++
 tools/perf/util/evlist.h         |   1 +
 tools/perf/util/evsel.c          |  85 +++++++++++
 tools/perf/util/evsel.h          |   1 +
 tools/perf/util/metricgroup.c    |  77 ++++++++++
 tools/perf/util/metricgroup.h    |   6 +
 tools/perf/util/stat.h           |   1 +
 14 files changed, 554 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/tests/expand-cgroup.c

-- 
2.28.0.618.gf4bc123cb7-goog

