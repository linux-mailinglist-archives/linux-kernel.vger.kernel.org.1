Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469C42E1C78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgLWNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:05:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:11794 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgLWNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:05:17 -0500
IronPort-SDR: WGxC366Y92a7bkN/EAluqDpF7Hp6b/sXT0qPjHFDr6Vzvf9b4o2TcoZs+3jH23CqICa7kjAIdU
 1RcmjHcd0QXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="240094456"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="240094456"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 05:03:23 -0800
IronPort-SDR: gVsxQ4FJpeNqNThzTKR/T6YmV7gVeElLJg/9iahrGCmN14eh8zDcggg+cHM9wMRzqAhLGBj6iK
 b57UmgTKJjVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="393087740"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2020 05:03:20 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v2 0/6] perf stat: Introduce iiostat mode to provide I/O performance metrics
Date:   Wed, 23 Dec 2020 16:03:14 +0300
Message-Id: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version can be found at:
v1: https://lkml.kernel.org/r/20201210090340.14358-1-alexander.antonov@linux.intel.com

Changes in this revision are:
v1 -> v2:
  1. Using 'perf iiostat' subcommand instead of 'perf stat --iiostat':
    - Added perf-iiostat.sh script to use short command
    - Updated manual pages to get help for 'perf iiostat'
    - Added 'perf-iiostat' to perf's gitignore file

Mode is intended to provide four I/O performance metrics in MB per each
IIO stack:
 - Inbound Read:   I/O devices below IIO stack read from the host memory
 - Inbound Write:  I/O devices below IIO stack write to the host memory
 - Outbound Read:  CPU reads from I/O devices below IIO stack
 - Outbound Write: CPU writes to I/O devices below IIO stack

Each metric requiries only one IIO event which increments at every 4B
transfer in corresponding direction. The formulas to compute metrics
are generic:
    #EventCount * 4B / (1024 * 1024)

Note: iiostat introduces new perf data aggregation mode - per I/O stack
hence -e and -M options are not supported.

Usage examples:

1. List all IIO stacks (example for 2-S platform):
   $ perf iiostat show
   S0-uncore_iio_0<0000:00>
   S1-uncore_iio_0<0000:80>
   S0-uncore_iio_1<0000:17>
   S1-uncore_iio_1<0000:85>
   S0-uncore_iio_2<0000:3a>
   S1-uncore_iio_2<0000:ae>
   S0-uncore_iio_3<0000:5d>
   S1-uncore_iio_3<0000:d7>

2. Collect metrics for all I/O stacks:
   $ perf iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
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
   $ perf iiostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
   357708+0 records in
   357707+0 records out
   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s

    Performance counter stats for 'system wide':

      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
   0000:17               358559                   44                    0                   22 
   0000:3a                    3                    2                    0                    0 

        197.081983474 seconds time elapsed


Alexander Antonov (6):
  perf stat: Add AGGR_IIO_STACK mode
  perf evsel: Introduce an observed performance device
  perf stat: Basic support for iiostat in perf
  perf stat: Helper functions for IIO stacks list in iiostat mode
  perf stat: Enable iiostat mode for x86 platforms
  perf: Update .gitignore file

 tools/perf/.gitignore                         |   1 +
 tools/perf/Documentation/perf-iiostat.txt     |  89 ++++
 tools/perf/Makefile.perf                      |   5 +-
 tools/perf/arch/x86/util/Build                |   1 +
 tools/perf/arch/x86/util/iiostat.c            | 462 ++++++++++++++++++
 tools/perf/builtin-stat.c                     |  40 +-
 tools/perf/command-list.txt                   |   1 +
 tools/perf/perf-iiostat.sh                    |  12 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/iiostat.h                     |  33 ++
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/stat-display.c                |  51 +-
 tools/perf/util/stat-shadow.c                 |  11 +-
 tools/perf/util/stat.c                        |   3 +-
 tools/perf/util/stat.h                        |   2 +
 15 files changed, 704 insertions(+), 10 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-iiostat.txt
 create mode 100644 tools/perf/arch/x86/util/iiostat.c
 create mode 100644 tools/perf/perf-iiostat.sh
 create mode 100644 tools/perf/util/iiostat.h


base-commit: 644bf4b0f7acde641d3db200b4db66977e96c3bd
-- 
2.19.1

