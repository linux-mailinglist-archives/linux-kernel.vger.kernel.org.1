Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE19273833
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgIVBu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:50:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:43655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgIVBu2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:50:28 -0400
IronPort-SDR: 4EkRwBZr7X1vPWsGmgqvq6GsN1782se4Sc/6RnqW8dhsnyI3n4/S6RO1VhPJYnH9zpgGGVVVpy
 kw14e5tI9TpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="157892997"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="157892997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 18:50:28 -0700
IronPort-SDR: fJP63Xq2QTZXN+uoYzpd7A+Xkp6ORTK5RZu4JC2LvCR/kxi0LqIFxtJhTimxNQEUaEtbyUgOY8
 gucrHlPYdnmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="412496097"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2020 18:50:26 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Skip duration_time in setup_system_wide
Date:   Tue, 22 Sep 2020 09:50:04 +0800
Message-Id: <20200922015004.30114-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some metrics (such as DRAM_BW_Use) consists of uncore events and
duration_time. For uncore events, counter->core.system_wide is
true. But for duration_time, counter->core.system_wide is false
so target.system_wide is set to false.

Then 'enable_on_exec' is set in perf_event_attr of uncore event.
Kernel will return error when trying to open the uncore event.

This patch skips the duration_time in setup_system_wide then
target.system_wide will be set to true for the evlist of uncore
events + duration_time.

Before (tested on skylake desktop):

 # perf stat -M DRAM_BW_Use -- sleep 1
 Error:
 The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arb/event=0x84,umask=0x1/).
 /bin/dmesg | grep -i perf may provide additional information.

After:

 # perf stat -M DRAM_BW_Use -- sleep 1

  Performance counter stats for 'system wide':

                169      arb/event=0x84,umask=0x1/ #     0.00 DRAM_BW_Use
             40,427      arb/event=0x81,umask=0x1/
      1,000,902,197 ns   duration_time

        1.000902197 seconds time elapsed

Fixes: 648b5af3f3ae ("libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7f8d756d9408..9bcc93bc0973 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2047,8 +2047,10 @@ static void setup_system_wide(int forks)
 		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (!counter->core.system_wide)
+			if (!counter->core.system_wide &&
+			    strcmp(counter->name, "duration_time")) {
 				return;
+			}
 		}
 
 		if (evsel_list->core.nr_entries)
-- 
2.17.1

