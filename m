Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07F2752D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIWIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:05:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so3248240pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ep+njMtXicDAzbVsLJ0J0pZ5EnnqkQlLSanrT0dJJTI=;
        b=ZndLFWiuAFaCf+9ASpT695avTapsRfGfNCxFFVslPC+yB/zrzu4SXglkVsXXounogm
         4+aD3MKFmaPcReNFx36TyMmoj8ecmCv5tQp/9bN/00rfKvkjkbQnsLSBUdKcnGyFaB+/
         7RDuolkpxRxLi/5Gn2jArNDQY2dXmQN7F6Jk+qRBmMwSocGIkSz4KLkpZwGz92C2svd6
         nw5GgGXGI49Hf+qfpzNZZN5xY+pitWqI3VtDOTk7LhrhXtKxGkUM/AN+4VUup1zh6x8r
         02TMdWXEiVNmpNlCIDDD3yhg2WhstxMinCRFAO1ffcBwIucSCQJs5zUsFUFLiknxB88G
         1t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Ep+njMtXicDAzbVsLJ0J0pZ5EnnqkQlLSanrT0dJJTI=;
        b=UwqpVKet12WNnOrO8DCZetL8GhgfsaWwBsX06u6qzKiON6x5j43fsdtWkV67SRiLWz
         Hqv5n4dXKTKx4vX6g++NZK6KZc6nMtfowW/5LxfuEjrcc25YKl4JIXdLSKGR05OcMBZK
         fZfPtLg/U3KG5hynhO0wnF8mFbsUkbKQr/TCPV18FudcE9ekqM5RGwIi+eh26WzBifZk
         QIYP6iK0HLUK+sabfyNLesLajZwnvIc1FXiEX0qXj3JDPEiXHdDHwYRLPHSNLDo4+tbd
         7+2PG0NkPdRcOwVIYj5NqHcmDEf3rkXyOTPfZtu3U5iBeq5e/ohY2T+LnEWXXccb+8A0
         6FXA==
X-Gm-Message-State: AOAM532THT16tP7De6PkiF6Nm4/PXa6D+FKO+IKjNQ2MeiDmZQLvwNrK
        35MHFQPCwYcSg+w/7BIWqOo=
X-Google-Smtp-Source: ABdhPJw48FwYBWeh2qqTqVbEG4stbNwFKru2fk5k2LNoKqIyz21XPMQt2bPbcOq5CUoPXLexBZVfUA==
X-Received: by 2002:a05:6a00:1343:b029:142:2501:35e6 with SMTP id k3-20020a056a001343b0290142250135e6mr2391944pfu.70.1600848343841;
        Wed, 23 Sep 2020 01:05:43 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:05:43 -0700 (PDT)
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
Subject: [PATCHSET v2 0/7] perf inject: Speed build-id injection
Date:   Wed, 23 Sep 2020 17:05:30 +0900
Message-Id: <20200923080537.155264-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is my second attempt to speed up build-id injection.  As this is
to improve performance, I've added a benchmark for it.  Please look at
the usage in the first commit.

By default, it measures average processing time of 100 MMAP2 events
and 10000 SAMPLE events.  Below is the current result on my laptop.

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 22.997 msec (+- 0.067 msec)
    Average time per event: 2.255 usec (+- 0.007 usec)

With this patchset applied, it got this:

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 18.441 msec (+- 0.106 msec)
    Average time per event: 1.808 usec (+- 0.010 usec)
    Average build-id-all injection took: 13.451 msec (+- 0.132 msec)
    Average time per event: 1.319 usec (+- 0.013 usec)

Real usecases might be different as it depends on the number of
mmap/sample events as well as how many DSOs are actually hit.

Also please take a look at the last patch which I removed the old
build-id inject logic which seems not used anymore.

This code is available at 'perf/inject-speedup-v2' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks
Namhyung


Namhyung Kim (7):
  perf bench: Add build-id injection benchmark
  perf inject: Add missing callbacks in perf_tool
  perf inject: Enter namespace when reading build-id
  perf inject: Do not load map/dso when injecting build-id
  perf inject: Add --buildid-all option
  perf bench: Run inject-build-id with --buildid-all option too
  perf inject: Remove stale build-id processing

 tools/perf/Documentation/perf-inject.txt |   6 +-
 tools/perf/bench/Build                   |   1 +
 tools/perf/bench/bench.h                 |   1 +
 tools/perf/bench/inject-buildid.c        | 432 +++++++++++++++++++++++
 tools/perf/builtin-bench.c               |   1 +
 tools/perf/builtin-inject.c              | 207 ++++++++---
 tools/perf/util/build-id.h               |   4 +
 tools/perf/util/map.c                    |  17 +-
 tools/perf/util/map.h                    |  14 +
 9 files changed, 617 insertions(+), 66 deletions(-)
 create mode 100644 tools/perf/bench/inject-buildid.c

-- 
2.28.0.681.g6f77f65b4e-goog

