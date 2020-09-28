Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1505927A911
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgI1Hw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1Hw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:52:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB4C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:52:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so134329pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bhvop87tpErmKCFZkEfey/IjtNH1/EsMEVJCK/onP0Q=;
        b=OHxm4wsRve0+7rrN826L/NLj4C879u3xOMXlMN7BrN3f4+I0bd65i3XNZ5PbPOTNn8
         08v/FGT4B04tgXnFLW1ZvteuB/hxuY8l7igX2lioR5o10+2M+HMtJ7HYsRyZUixwusIW
         c80Jj+IeDqHe55tWYyeMZ5jh6YteRtnxOHZFuJv16tlhqSVBNdBTGW5vbg5Yl/6yoEHN
         ITKofB5ET0rZe9ALzyGSdIXasv1LcHR/KOvLnrNsNmH7JTwvkmkqY3M9gi5lbJ8/8EQI
         KE4bJo7GKkVUSlJoKZpypFgRGe8ofYdZFCI7LcKA2GFklX9vQU855EPMCR8hiHIuUwL4
         RbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Bhvop87tpErmKCFZkEfey/IjtNH1/EsMEVJCK/onP0Q=;
        b=p9hVAxE/JbzDSC46i4VPcCDiOL3iYw+LsTwb7h9c8G8086+PFWN0RqVlYPKWn9CEpr
         TTYFL0HftdYdmn2+57sL/kQBVCoSJ2+Lu/RVkgnu5WMAvNZTkC0e7W0JBBjHuaJuOKmE
         d2zrgvqEA5IHxXVv01NGlahwcHKh3nx9tDSw6iA75U2/a8Leo2lIZiFNqABZT3nDv2nJ
         zMgnTj7Y5+72MvVnni+1FRLPgBScpdJwQTsg7CidoGRbB4SLyaQwEu0SZVecHfdDKQ/H
         EbJz+KHfylaSKAnE4XfFdfFM4TbwJ8LM0vbJ0FkE49oVG0O+WxPLMhCglHI2/DdgwR6N
         QCdw==
X-Gm-Message-State: AOAM533euRJ23EX51QcycvtpgBdkfSRoIZ1WGrxu9JHhz7WwbzdrTaoN
        Otn7K8k2atG2F1mCdzOg68k=
X-Google-Smtp-Source: ABdhPJyyvLXJjp4fMRBhM6laBbEAbcPCpm0uxMXuN0ujqUslXO47apn5zaD62bfUTJBmoCU1HeY1kw==
X-Received: by 2002:a17:902:b587:b029:d2:80bd:2f0c with SMTP id a7-20020a170902b587b02900d280bd2f0cmr470289pls.60.1601279579020;
        Mon, 28 Sep 2020 00:52:59 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 141sm520241pfb.50.2020.09.28.00.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:52:58 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET v3 0/6] perf inject: Speed build-id injection
Date:   Mon, 28 Sep 2020 16:52:40 +0900
Message-Id: <20200928075246.853729-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the new version of speed up build-id injection.  As this is
to improve performance, I've added a benchmark for it.  Please look at
the usage in the first commit.

By default, it measures average processing time of 100 MMAP2 events
and 10000 SAMPLE events.  Below is the current result on my laptop.

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 23.885 msec (+- 0.114 msec)
    Average time per event: 2.342 usec (+- 0.011 usec)
    Average memory usage: 7864 KB (+- 10 KB)

With this patchset applied, it got this:

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 18.182 msec (+- 0.126 msec)
    Average time per event: 1.783 usec (+- 0.012 usec)
    Average memory usage: 7334 KB (+- 6 KB)
    Average build-id-all injection took: 17.520 msec (+- 0.046 msec)
    Average time per event: 1.718 usec (+- 0.005 usec)
    Average memory usage: 7418 KB (+- 2 KB)

Real usecases might be different as it depends on the number of
mmap/sample events as well as how many DSOs are actually hit.

The benchmark result now includes memory footprint in terms of maximum
RSS.  Also I've fixed a bug in the benchmark code not to read all the
required bytes and return early.  With that, sadly, some speedup in
the build-id-all injection was gone, but it's still slightly faster
while uses more memory.

In addition, I dropped the last patch for now which changes build-id
handling when -b option is not used.  As this can impact build-id-all
performance, I'll think about it more and come up with something later.


This code is available at 'perf/inject-speedup-v3' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Changes from v2:
 - fix benchmark to read required data
 - add Acked-by from Jiri and Ian
 - pass map flag to check huge pages  (Jiri)
 - add comments on some functions  (Ian)
 - show memory (max-RSS) usage in the benchmark  (Ian)
 - drop build-id marking patch at the last  (Adrian)


Namhyung Kim (6):
  perf bench: Add build-id injection benchmark
  perf inject: Add missing callbacks in perf_tool
  perf inject: Enter namespace when reading build-id
  perf inject: Do not load map/dso when injecting build-id
  perf inject: Add --buildid-all option
  perf bench: Run inject-build-id with --buildid-all option too

 tools/perf/Documentation/perf-inject.txt |   6 +-
 tools/perf/bench/Build                   |   1 +
 tools/perf/bench/bench.h                 |   1 +
 tools/perf/bench/inject-buildid.c        | 457 +++++++++++++++++++++++
 tools/perf/builtin-bench.c               |   1 +
 tools/perf/builtin-inject.c              | 199 ++++++++--
 tools/perf/util/build-id.h               |   4 +
 tools/perf/util/map.c                    |  17 +-
 tools/perf/util/map.h                    |  14 +
 9 files changed, 645 insertions(+), 55 deletions(-)
 create mode 100644 tools/perf/bench/inject-buildid.c

-- 
2.28.0.681.g6f77f65b4e-goog

