Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698E72D5612
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgLJJFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:05:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:6071 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLJJFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:05:33 -0500
IronPort-SDR: YBrn1K4rBLHh4/GvqXM3NKgzlUZueoT5HQf7+c5tKGUYTnyhluYa70/6zuOkrTcJOLvDJDD9Q+
 +fdPHzh/bK0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="170712731"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="170712731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 01:03:47 -0800
IronPort-SDR: Dj7UvgcF4zrBcK7+nlkOysADaagPsYet2XXFgkijKbtftcHdqMcgzhOYfAYdFYSp/PUd2zkWdQ
 ADjJ/Mq1d5lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="408450101"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2020 01:03:42 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        ak@linux.intel.com, alexander.antonov@linux.intel.com
Subject: [PATCH 0/5] perf stat: Introduce --iiostat mode to provide I/O performance metrics
Date:   Thu, 10 Dec 2020 12:03:35 +0300
Message-Id: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mode is intended to provide four I/O performance metrics in MB per each
IIO stack:
 - Inbound Read: I/O devices below IIO stack read from the host memory
 - Inbound Write: I/O devices below IIO stack write to the host memory
 - Outbound Read: CPU reads from I/O devices below IIO stack
 - Outbound Write: CPU writes to I/O devices below IIO stack

Each metric requiries only one IIO event which increments at every 4B
transfer in corresponding direction. The formulas to compute metrics
are generic:
    #EventCount * 4B / (1024 * 1024)

Note: --iiostat introduces new perf data aggregation mode - per I/O stack
hence -e and -M options are not supported.

Usage examples:

1. List all IIO stacks (example for 2-S platform):
   $ perf stat --iiostat=show
   S0-uncore_iio_0<0000:00>
   S1-uncore_iio_0<0000:80>
   S0-uncore_iio_1<0000:17>
   S1-uncore_iio_1<0000:85>
   S0-uncore_iio_2<0000:3a>
   S1-uncore_iio_2<0000:ae>
   S0-uncore_iio_3<0000:5d>
   S1-uncore_iio_3<0000:d7>

2. Collect metrics for all I/O stacks:
   $ perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
   357708+0 records in
   357707+0 records out
   375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s

    Performance counter stats for 'system wide':

      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
   0000:00                    1                    0                    2                    3 
   0000:80                    0                    0                    0                    0 
   0000:17               352552                   43                    0                   21 
   0000:85                    0                    0                    0                    0 
   0000:3a                    3                    0                    0                    0 
   0000:ae                    0                    0                    0                    0 
   0000:5d                    0                    0                    0                    0 
   0000:d7                    0                    0                    0                    0

3. Collect metrics for comma separated list of I/O stacks:
   $ perf stat --iiostat=0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
   357708+0 records in
   357707+0 records out
   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s

    Performance counter stats for 'system wide':

      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
   0000:17               358559                   44                    0                   22 
   0000:3a                    3                    2                    0                    0 

        197.081983474 seconds time elapsed

Alexander Antonov (5):
  perf stat: Add AGGR_IIO_STACK mode
  perf evsel: Introduce an observed performance device
  perf stat: Basic support for iiostat in perf stat
  perf stat: Helper functions for IIO stacks list in iiostat mode
  perf stat: Enable --iiostat mode for x86 platforms

 tools/perf/Documentation/perf-stat.txt        |  31 ++
 tools/perf/arch/x86/util/Build                |   1 +
 tools/perf/arch/x86/util/iiostat.c            | 460 ++++++++++++++++++
 tools/perf/builtin-stat.c                     |  38 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/iiostat.h                     |  33 ++
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/stat-display.c                |  51 +-
 tools/perf/util/stat-shadow.c                 |  11 +-
 tools/perf/util/stat.c                        |   3 +-
 tools/perf/util/stat.h                        |   2 +
 11 files changed, 625 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/iiostat.c
 create mode 100644 tools/perf/util/iiostat.h


base-commit: 644bf4b0f7acde641d3db200b4db66977e96c3bd
-- 
2.19.1

