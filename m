Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B582F57C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbhANCG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:06:56 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37851 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbhANCGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:48 -0500
Received: by mail-ot1-f45.google.com with SMTP id o11so3896576ote.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQsv2kugxUSbkXU1qFoAJvrH0gFzC7cZx7Q0Cn5ioMA=;
        b=BQJgiHjzFIx7nvNcV2RWf3ntkRWjNDFAVGIqhVGP/lnFz4pc+0e4uw08DNg9E3qPJ6
         Fb/PqMC/FqPpYF2xVkrL3qWS1wImsAts1WXBssZVmc8akaC/WqNjW2l1hWco9nDqh4eS
         xOOgCjQHANa/1AvFkSld8wF9S05Jpy1I2Gisa6ozmMbHzsrOIvzfHQpjF0nUymbxar8Y
         Y4yhLrB8BKXPAzW0m2dTB/aKlgakDkav+wqb27+x+Cq2QDmS6/Uz9ejKVzTFsOeGkqEI
         0VA20f+z6qtePjFrChEpeUq/cMKgDGENZmxysspz6WZl+tToZBz3jeDJf3P6OGudWOWe
         r5wA==
X-Gm-Message-State: AOAM530UtX4gwAtabPO/4rF5JslzD6kaDnh1qBC2M2In5j/zTLvI7Byr
        ej22v1nZ3JR1ZLutFwjcQg==
X-Google-Smtp-Source: ABdhPJxAx5/QxXVFrXMeW8WeFdLtl3+72AUiL4ywOTZ1Fyl6cWR2T2S8M/5tZS9jHezaLRtrtkj6/A==
X-Received: by 2002:a9d:3ee4:: with SMTP id b91mr3031579otc.86.1610589967775;
        Wed, 13 Jan 2021 18:06:07 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:06 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 0/9] libperf and arm64 userspace counter access support
Date:   Wed, 13 Jan 2021 20:05:56 -0600
Message-Id: <20210114020605.3943992-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Another version of libperf and arm64 userspace counter access support.
This originally resurrected Raphael's series[1] to enable userspace counter
access on arm64. My previous versions are here[2][3][4][5]. A git branch is
here[6].

Changes in v5:
 - Limit enabling/disabling access to CPUs associated with the PMU
   (supported_cpus) and with the mm_struct matching current->active_mm.
   The x86 method of using mm_cpumask doesn't work for arm64 as it is not
   updated.
 - Only set cap_user_rdpmc if event is on current cpu. See patch 2.
 - Create an mmap for every event in an evsel. This results in some changes
   to the libperf mmap API from the last version.
 - Rebase to v5.11-rc2

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

[1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
[4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
[5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
[6] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v5


Raphael Gault (3):
  arm64: pmu: Add function implementation to update event index in
    userpage
  arm64: perf: Enable PMU counter direct access for perf event
  Documentation: arm64: Document PMU counters access from userspace

Rob Herring (6):
  tools/include: Add an initial math64.h
  libperf: Add evsel mmap support
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
 arch/arm64/kernel/perf_event.c                |  68 +++++++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/include/linux/math64.h                  |  75 +++++++
 tools/lib/perf/Documentation/libperf.txt      |   2 +
 tools/lib/perf/evsel.c                        |  50 ++++-
 tools/lib/perf/include/internal/evsel.h       |   2 +
 tools/lib/perf/include/internal/mmap.h        |   3 +
 tools/lib/perf/include/internal/tests.h       |  32 +++
 tools/lib/perf/include/perf/evsel.h           |   2 +
 tools/lib/perf/libperf.map                    |   2 +
 tools/lib/perf/mmap.c                         | 186 ++++++++++++++++++
 tools/lib/perf/tests/Makefile                 |   6 +-
 tools/lib/perf/tests/test-evsel.c             |  65 ++++++
 tools/perf/arch/arm64/include/arch-tests.h    |   7 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 tools/perf/arch/arm64/tests/user-events.c     | 170 ++++++++++++++++
 22 files changed, 751 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst
 create mode 100644 tools/include/linux/math64.h
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

--
2.27.0
