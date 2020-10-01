Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E132800C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbgJAOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:02:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43262 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJAOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id n61so5451955ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhNdGeKB6aMIHB2cQa7PQRkWF7QSFmx3FEuDcb+C3Sk=;
        b=p+AqYuunl96GOHNamLKV8QgDox/Ax11clWLCZaaVTtIV1+A4VXuoj7hWqe/JzhCd2T
         KSpmNFCgwgaFmpnxggqHKWWrqC/zfVpUTnktvehm1+EqmAeKMieowy/bxpPZfTCFGX+3
         daMhSSzSWO4L0DAblPwduBFCE4TvnE0up6KgnI8NOVZaEfBFCwdTxHSqzox/lbG5AeZp
         M+KknY8Oatz0r74Xs5jfTmXIdo5px4RvPNHEnzCI5R13LjO9dqQIBmj48lkoaJrqOn7I
         3X4ZGuiswP+7P/rzY9cQm0PEGMxWWTN3Bdr4BJhI14fYq8qzBtDkFi3R/1QEjfjr58yA
         bDnQ==
X-Gm-Message-State: AOAM530smSt4GvzZLWkN8iSsjfS5Tgxts1SG/FLCPUBMJMftKDburrDJ
        K4C03ZMp1mCeu3O4ji7lkQ==
X-Google-Smtp-Source: ABdhPJwN2o+SFKQxpDKHd/CKMtJdtaefrQLrQfmZ9Tetge9Ui/bGp0biTvl3OiztDHjNX4iPEuz3sw==
X-Received: by 2002:a9d:ae7:: with SMTP id 94mr5201610otq.283.1601560878234;
        Thu, 01 Oct 2020 07:01:18 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v4 0/9] libperf and arm64 userspace counter access support
Date:   Thu,  1 Oct 2020 09:01:07 -0500
Message-Id: <20201001140116.651970-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is resurrecting Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4]. A git branch is
here[5].

Changes in v4:
 - Dropped 'arm64: pmu: Add hook to handle pmu-related undefined instructions'.
   The onus is on userspace to pin itself to a homogeneous subset of CPUs
   and avoid any aborts on heterogeneous systems, so the hook is not needed.
 - Make perf_evsel__mmap() take pages rather than bytes for size
 - Fix building arm64 heterogeneous test.

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
[4] https://lore.kernel.org/linux-arm-kernel/20200911215118.2887710-1-robh@kernel.org/
[5] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v4

Raphael Gault (3):
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
 arch/arm64/kernel/perf_event.c                |  62 ++++++
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
 22 files changed, 728 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst
 create mode 100644 tools/include/linux/math64.h
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

--
2.25.1
