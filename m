Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24328AEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgJLHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgJLHCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E73C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so3141325pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RN+hbUL0NYVT8QB5Vq3pnGcRVctGrSfTt0+NRJ+u8c=;
        b=tc7s7qqwskvgLr281jx0EFcu6sTMzFyuoJ6MEDR8hAFHlqYk56kDrtr3TPXL/vNSDM
         Nm4VQzCSU5azPfSvrTimtqoGy+85XFcxpUxZuFq9mC1RQ16F6CtCZnXzcWLUtLgR3hvS
         yfydx6bohyBbAINNkA/o1dUAje6UFn1RBu/sNPzsivUVKV/XkhCCuL0K/rN4K9WEwxs1
         f9TfbOL/bqP/i1kJH/T/mYkJ7YZrYbfs3yx9PY0bPh0eWF8S5QybDCREBc/jO26VJTPZ
         QV/7Ion4UqPdVWXySAR3vMUPLh5+4Kbq3Wgjv7TVZXlQKZM5XIL2z4ys9FGK7eOBeU68
         bO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4RN+hbUL0NYVT8QB5Vq3pnGcRVctGrSfTt0+NRJ+u8c=;
        b=AzVhmO7cW7lBImTzupi3dTLywhSGnfn5/O1deedzcgTsigWWJqaJUuzDWBfEosHt5L
         RafcVA4Bn8FLO0zGu4lLNSkCywXuQq0ccVMdonVV9rRQ0Jy8RJJVpysQaJsYChrPIJpr
         VgKdpsVe+o2E8fkVnxHMS7ubZWO0QRtOUR5j4Iu0EHUaxsA2DlHW9tWysePrO5BbA6Y8
         YuLeEa+aT7H7jDOvoPxh9RHrX9wIQo5eW7YJlszzodYAAqfX/5tHrkIY93fq6muj1SAv
         jdGTh2WxfM/R0p++VA4KyEgnAaPTUS0ECnX9D6E3XGKNfcHsXmK0HDaC5GhIGoj9gCTu
         i6WQ==
X-Gm-Message-State: AOAM53218X78aRxvOSJgcGU4svpFU9mgi4lbeeDVSOOSe0L2hAubENQc
        I3PfjawDr/+n8IiwrREY3jg=
X-Google-Smtp-Source: ABdhPJzE+7cobd9IEABBuqOIaoZPrWbR1ZvqlY9r1+cPXr+ZkzEO7IsjgrHPzzpl4HljZ4yeX8Fm1Q==
X-Received: by 2002:a63:d6:: with SMTP id 205mr12066548pga.309.1602486140183;
        Mon, 12 Oct 2020 00:02:20 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id n12sm18082556pgk.20.2020.10.12.00.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:02:19 -0700 (PDT)
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
Subject: [PATCHSET v4 0/6] perf inject: Speed build-id injection
Date:   Mon, 12 Oct 2020 16:02:08 +0900
Message-Id: <20201012070214.2074921-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
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
    Average build-id injection took: 25.789 msec (+- 0.202 msec)
    Average time per event: 2.528 usec (+- 0.020 usec)
    Average memory usage: 8411 KB (+- 7 KB)

With this patchset applied, it got this:

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 20.838 msec (+- 0.093 msec)
    Average time per event: 2.043 usec (+- 0.009 usec)
    Average memory usage: 8261 KB (+- 0 KB)
    Average build-id-all injection took: 19.361 msec (+- 0.118 msec)
    Average time per event: 1.898 usec (+- 0.012 usec)
    Average memory usage: 7440 KB (+- 0 KB)


Real usecases might be different as it depends on the number of
mmap/sample events as well as how many DSOs are actually hit.

The benchmark result now includes memory footprint in terms of maximum
RSS.  Also I've update the benchmark code to use timestamp so that it
can be queued to the ordered_events (and flushed at the end).  It's
also important how well it sorts the input events in the queue so I
randomly chose a timestamp at the beginning of each MMAP event
injection to resemble actual behavior.

As I said in other thread, perf inject currently doesn't flush the
input events and processes all at the end.  This gives a good speedup
but spends more memory (in proprotion to the input size).  While the
build-id-all injection bypasses the queue so it uses less memory as
well as faster processing.  The downside is that it'll mark all DSOs
as hit so later processing steps (like perf report) likely handle them
unnecessarily.


This code is available at 'perf/inject-speedup-v4' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Changes from v3:
 - add timestamp to the synthesized events in the benchmark
 - add a separate thread to read pipe in the benchmark

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


*** BLURB HERE ***

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
 tools/perf/bench/inject-buildid.c        | 476 +++++++++++++++++++++++
 tools/perf/builtin-bench.c               |   1 +
 tools/perf/builtin-inject.c              | 199 ++++++++--
 tools/perf/util/build-id.h               |   4 +
 tools/perf/util/map.c                    |  17 +-
 tools/perf/util/map.h                    |  14 +
 9 files changed, 664 insertions(+), 55 deletions(-)
 create mode 100644 tools/perf/bench/inject-buildid.c

-- 
2.28.0.1011.ga647a8990f-goog

