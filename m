Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F272B21EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKMRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:19:24 -0500
Received: from foss.arm.com ([217.140.110.172]:41860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgKMRTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:19:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC2F1042;
        Fri, 13 Nov 2020 09:19:36 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D51163F718;
        Fri, 13 Nov 2020 09:19:34 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Cc:     james.clark@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 00/13 v3] perf tools: fix perf stat with large socket IDs
Date:   Fri, 13 Nov 2020 19:19:10 +0200
Message-Id: <20201113171923.29721-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break up the previous v2 patchset into smaller atomic commits.
The end result is the same as the previous patchset apart from
some minor refactoring, asserting on an empty header and
calling cpu__setup_cpunode_map() in the topology self test.

Testing done:

Tested --per-core, --per-thread, --per-die, --per-node 'perf
stat' outputs on Arm ThunderX2 and Intel KNL.

Also tested 'perf stat record' and 'perf stat report --input'
with recordings from a version of perf before this patchset
to confirm that the output was the same.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>

James Clark (13):
  perf tools: Improve topology test
  perf tools: Use allocator for perf_cpu_map
  perf tools: Add new struct for cpu aggregation
  perf tools: Replace aggregation ID with a struct
  perf tools: add new map type for aggregation
  perf tools: drop in cpu_aggr_map struct
  perf tools: restrict visibility of functions
  perf tools: Start using cpu_aggr_id in map
  perf tools: Add separate node member
  perf tools: Add separate socket member
  perf tools: Add separate die member
  perf tools: Add separate core member
  perf tools: add thread field

 tools/perf/builtin-stat.c      | 128 +++++++++++++------------
 tools/perf/tests/topology.c    |  58 +++++++++--
 tools/perf/util/cpumap.c       | 170 ++++++++++++++++++++++-----------
 tools/perf/util/cpumap.h       |  55 ++++++-----
 tools/perf/util/stat-display.c | 106 +++++++++++---------
 tools/perf/util/stat.c         |   2 +-
 tools/perf/util/stat.h         |   9 +-
 7 files changed, 332 insertions(+), 196 deletions(-)

-- 
2.28.0

