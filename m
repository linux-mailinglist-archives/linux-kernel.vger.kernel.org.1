Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179AE266A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgIKVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:51:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34433 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgIKVvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:51:21 -0400
Received: by mail-io1-f68.google.com with SMTP id m17so12665072ioo.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b7LSNxFBMXfkQ9+O4qJULGEgaNjsKsj1DUpH/bPVcU=;
        b=Jond/rvk2c5K/B03iHw2iwpiuwwLTC5ou85xncu5bQTFzjCRU2u7KJY5cyr4f9iHkG
         y9aUkgK/bKQb9gYzxWmVMV3Ah6TK8F3EMnzzBiTbdDQb4iWdxxQTvU/6+lJQ1tePwYUp
         2OwV50mlDitG+k500D4DULtpSzYyxe7ckUffyGU95si2zc3T9r+dI9ogVr2BhrpJz4WQ
         SnhY1h/4677U2nDucRmSRn6UhEJ+BthoZBuYtR1MN6uGoFMnHKjvQihPv3Dn9QP0ZOXW
         emCFG+nEhrw4qW/x+sG9kLzvkp+D9FJLLN3y6kgj67U6259R1BkzekLIIOjDT/zan2NW
         mxjQ==
X-Gm-Message-State: AOAM532SWCqQaqTlotNyuygNX0pT5pujpKhOgaFSyzZKnJTl+RiE5CfI
        G22perLhH5gj5Uh/TSKU7A==
X-Google-Smtp-Source: ABdhPJxtYa/RYHb4QM1EhvMdFyuoZ9Z7q5I1sxA7/dbcyos4ABSYRuvOY+v3/djDXJqtzgQE+OussQ==
X-Received: by 2002:a05:6638:611:: with SMTP id g17mr3846451jar.40.1599861080426;
        Fri, 11 Sep 2020 14:51:20 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a20sm1927966ilq.57.2020.09.11.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:51:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v3 0/10] libperf and arm64 userspace counter access support
Date:   Fri, 11 Sep 2020 15:51:08 -0600
Message-Id: <20200911215118.2887710-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is resurrecting Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3].

Changes in v3:
 - Dropped removing x86 rdpmc test until libperf tests can run via 'perf test'
 - Added verbose prints for tests
 - Split adding perf_evsel__mmap() to separate patch


The following changes to the arm64 support have been made compared to
Raphael's last version:

The major change is support for heterogeneous systems with some
restrictions. Specifically, userspace must pin itself to like CPUs, open
a specific PMU by type, and use h/w specific events. The tests have been
reworked to demonstrate this.

Chained events are not supported. The problem with supporting chained
events was there's no way to distinguish between a chained event and a
native 64-bit counter. We could add some flag, but do self monitoring
processes really need that? Native 64-bit counters are supported if the
PMU h/w has support. As there's already an explicit ABI to request 64-bit
counters, userspace can request 64-bit counters and if user
access is not enabled, then it must retry with 32-bit counters.

Prior versions broke the build on arm32 (surprisingly never caught by
0-day). As a result, event_mapped and event_unmapped implementations have
been moved into the arm64 code.

There was a bug in that pmc_width was not set in the user page. The tests
now check for this.

The documentation has been converted to rST. I've added sections on
chained events and heterogeneous.

The tests have been expanded to test the cycle counter access.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/linux-arm-kernel/20200828205614.3391252-1-robh@kernel.org/

Raphael Gault (4):
  arm64: pmu: Add hook to handle pmu-related undefined instructions
  arm64: pmu: Add function implementation to update event index in
    userpage
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (6):
  tools/include: Add an initial math64.h
  libperf: Add libperf_evsel__mmap()
  libperf: tests: Add support for verbose printing
  libperf: Add support for user space counter access
  libperf: Add arm64 support to perf_mmap__read_self()
  perf: arm64: Add test for userspace counter access on heterogeneous
    systems

 Documentation/arm64/index.rst                 |   1 +
 .../arm64/perf_counter_user_access.rst        |  56 ++++++
 arch/arm64/include/asm/mmu.h                  |   5 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 ++
 arch/arm64/kernel/cpufeature.c                |   4 +-
 arch/arm64/kernel/perf_event.c                | 116 +++++++++++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/include/linux/math64.h                  |  75 +++++++
 tools/lib/perf/Documentation/libperf.txt      |   1 +
 tools/lib/perf/evsel.c                        |  34 ++++
 tools/lib/perf/include/internal/evsel.h       |   2 +
 tools/lib/perf/include/internal/mmap.h        |   3 +
 tools/lib/perf/include/internal/tests.h       |  32 +++
 tools/lib/perf/include/perf/evsel.h           |   2 +
 tools/lib/perf/libperf.map                    |   1 +
 tools/lib/perf/mmap.c                         | 188 ++++++++++++++++++
 tools/lib/perf/tests/Makefile                 |   4 +-
 tools/lib/perf/tests/test-evsel.c             |  63 ++++++
 tools/perf/arch/arm64/include/arch-tests.h    |   7 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 tools/perf/arch/arm64/tests/user-events.c     | 170 ++++++++++++++++
 23 files changed, 784 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst
 create mode 100644 tools/include/linux/math64.h
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

--
2.25.1
