Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231DF218B08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgGHPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:19:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:64868 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:19:10 -0400
IronPort-SDR: p3ImO6w58ENSzBMFnnAnXZH4a5mNXb4vNl4XDQD+fQMb8hB2Zm8eCpu7ZkbKO8DDaboDdUg7pT
 9hKjG6qKksNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="165929567"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="165929567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 08:16:50 -0700
IronPort-SDR: Vy40RHloS8edlXSM86Rp+AIdeOqWAJP89X+nfG35v0MbQSs1SV6Mjar8ACAx9b6OoUGnkxJ4Xc
 CRPI+uUu3STg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="283827370"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2020 08:16:47 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf: Allow closing siblings' file descriptors
Date:   Wed,  8 Jul 2020 18:16:33 +0300
Message-Id: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've been looking at reducing the number of open file descriptors per perf
session. If we retain one descriptor per event, in a large group they add
up. At the same time, we're not actually using them for anything after the
SET_OUTPUT and maybe SET_FILTER ioctls. So, this series is a stab at that.

So, I added a new flag to the perf_event_open() that tells perf to keep
the event around after its file descriptor gets closed, for as long as its
group leader is alive. Since this is a new behavior, the flag is an opt-in.

I also hacked this into the perf tool (mostly perf record, but I'll hack
stat as well if this general approach is agreeable).

Alexander Shishkin (2):
  perf: Add closing sibling events' file descriptors
  perf record: Support closing siblings' file descriptors

 include/linux/perf_event.h              |   7 ++
 include/uapi/linux/perf_event.h         |   1 +
 kernel/events/core.c                    | 149 +++++++++++++++++-------
 tools/include/uapi/linux/perf_event.h   |   1 +
 tools/lib/perf/evlist.c                 |  30 ++++-
 tools/lib/perf/evsel.c                  |  21 ++++
 tools/lib/perf/include/internal/evsel.h |   4 +
 tools/perf/builtin-record.c             |  48 ++++++--
 tools/perf/util/cpumap.c                |   4 +
 tools/perf/util/evlist.c                |   4 +-
 tools/perf/util/evsel.c                 |  17 ++-
 tools/perf/util/evsel.h                 |   3 +
 12 files changed, 234 insertions(+), 55 deletions(-)

-- 
2.27.0

