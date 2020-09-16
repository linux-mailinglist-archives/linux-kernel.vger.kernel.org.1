Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33E326C956
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgIPTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgIPRoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:44:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B8C206B6;
        Wed, 16 Sep 2020 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600278281;
        bh=lbwzgG9C7Uk3b3oNUtZC0p6W/dyyyj45g8O5TmRre6k=;
        h=From:To:Cc:Subject:Date:From;
        b=Z8VUUEgELSXpR68cETHN0ckBCfeFDlRfc/Wkfb8P7tDJSaYLMrDOprGIxRs6CY4Sj
         5ekbt0TyF+iXXMAUKG8wrzIunE4SMiIA0Yyu+ZMzcv5RHx5b9ekA4MNJNhWdZjLyoP
         QV7b7irzcOx/xa0mJVVUa1/bqZbMjrVTjhUEh5u0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Sharp <dhsharp@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Ian Rogers <irogers@google.com>, Qi Liu <liuqi115@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.9: 3rd batch
Date:   Wed, 16 Sep 2020 14:44:33 -0300
Message-Id: <20200916174433.1328420-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-16

for you to fetch changes up to ce9c13f31b10560d4e4d801f9f94895f595756aa:

  perf stat: Fix the ratio comments of miss-events (2020-09-16 10:54:02 -0300)

Best regards,

- Arnaldo

P.S.: Test results in the signed tag.

----------------------------------------------------------------

perf tools fixes for v5.9: 3rd batch

- Set PERF_SAMPLE_PERIOD if attr->freq is set.

- Remove trailing commas from AMD JSON vendor event files.

- Don't clear event's period if set by a event definition term.

- Leader sampling shouldn't clear sample period in 'perf test'.

- Fix the "signal" test inline assembly when built with DEBUG=1.

- Fix memory leaks detected by ASAN, some in normal paths, some in error
  paths.

- Fix 2 memory sanitizer warnings in 'perf bench'.

- Fix the ratio comments of miss-events in 'perf stat'.

- Prevent override of attr->sample_period for libpfm4 events.

- Sync kvm.h and in.h headers with the kernel sources.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Arnaldo Carvalho de Melo (2):
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers UAPI: update linux/in.h copy

David Sharp (1):
      perf record: Set PERF_RECORD_PERIOD if attr->freq is set.

Henry Burns (1):
      perf vendor events amd: Remove trailing commas

Ian Rogers (3):
      perf bench: Fix 2 memory sanitizer warnings
      perf record: Don't clear event's period if set by a term
      perf test: Leader sampling shouldn't clear sample period

Jiri Olsa (1):
      perf test: Fix the "signal" test inline assembly

Namhyung Kim (10):
      perf test: Free aliases for PMU event map aliases test
      perf metric: Fix some memory leaks
      perf metric: Fix some memory leaks - part 2
      perf evlist: Fix cpu/thread map leak
      perf parse-event: Fix memory leak in evsel->unit
      perf test: Fix memory leaks in parse-metric test
      perf metric: Release expr_parse_ctx after testing
      perf metric: Free metric when it failed to resolve
      perf metric: Do not free metric when failed to resolve
      perf test: Free formats for perf pmu parse test

Qi Liu (1):
      perf stat: Fix the ratio comments of miss-events

Stephane Eranian (1):
      perf record: Prevent override of attr->sample_period for libpfm4 events

 tools/include/uapi/linux/in.h                    |  2 +-
 tools/include/uapi/linux/kvm.h                   |  6 ++--
 tools/perf/bench/sched-messaging.c               |  4 +--
 tools/perf/pmu-events/arch/x86/amdzen1/core.json |  2 +-
 tools/perf/pmu-events/arch/x86/amdzen2/core.json |  2 +-
 tools/perf/tests/attr/README                     |  1 +
 tools/perf/tests/attr/test-record-group2         | 29 ++++++++++++++++++++
 tools/perf/tests/bp_signal.c                     |  5 +++-
 tools/perf/tests/parse-metric.c                  | 14 ++++++----
 tools/perf/tests/pmu-events.c                    |  5 ++++
 tools/perf/tests/pmu.c                           |  1 +
 tools/perf/util/evlist.c                         | 11 ++++++--
 tools/perf/util/evsel.c                          | 10 +++++--
 tools/perf/util/metricgroup.c                    | 35 +++++++++++++++++-------
 tools/perf/util/parse-events.c                   |  2 +-
 tools/perf/util/pmu.c                            | 13 ++++++++-
 tools/perf/util/pmu.h                            |  2 ++
 tools/perf/util/record.c                         | 34 +++++++++++++++++------
 tools/perf/util/stat-shadow.c                    | 28 ++++++++++---------
 19 files changed, 154 insertions(+), 52 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group2
