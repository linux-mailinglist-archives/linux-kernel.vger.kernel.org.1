Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1B2FFA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAVCLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:11:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:35190 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbhAVCLI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:11:08 -0500
IronPort-SDR: kMtmvq2QxSmTxor06jQgZX6NJsbRM9cWMNnhX/kMdEiHF8pyReqfmLk026pZiazXGllxF40ayh
 mCNbbJOFKl9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179463521"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="179463521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 18:09:22 -0800
IronPort-SDR: b+KRdue2WGpfeqMoz2/DzkI9mA36AnQkFjyfxBn63qP9OhJCkcTtMYT/6Z0FY0WONixdDrJ+Oy
 k2znAj2dLvUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="403428931"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2021 18:09:20 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3] perf stat: Append to default list if use -e event
Date:   Fri, 22 Jan 2021 10:08:10 +0800
Message-Id: <20210122020810.20521-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default event list includes the most common events which are widely
used by users. But with -e option, the current perf only counts the events
assigned by -e option. Users may want to collect some extra events with
the default list. For this case, users have to manually add all the events
from the default list. It's inconvenient. Also, users may don't know how to
get the default list.

Currently perf-stat has supported '-d' option which prints more detailed
statistics such as L1-dcache-loads, L1-dcache-load-misses. We just need
one line change to let '-d' support printing the default list.

Before:

root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1

 Performance counter stats for 'system wide':

              2.04 Joules power/energy-pkg/

       1.000863884 seconds time elapsed

After:

root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -d -- sleep 1

 Performance counter stats for 'system wide':

              2.24 Joules power/energy-pkg/         #    0.000 K/sec
          8,009.72 msec   cpu-clock                 #    7.995 CPUs utilized
               288        context-switches          #    0.036 K/sec
                10        cpu-migrations            #    0.001 K/sec
                 2        page-faults               #    0.000 K/sec
       125,889,836        cycles                    #    0.016 GHz                      (49.60%)
        23,216,112        instructions              #    0.18  insn per cycle           (62.40%)
         4,571,447        branches                  #    0.571 M/sec                    (62.80%)
           652,350        branch-misses             #   14.27% of all branches          (62.85%)
         6,564,491        L1-dcache-loads           #    0.820 M/sec                    (62.85%)
         1,030,251        L1-dcache-load-misses     #   15.69% of all L1-dcache accesses  (62.78%)
           567,451        LLC-loads                 #    0.071 M/sec                    (49.58%)
            52,983        LLC-load-misses           #    9.34% of all LL-cache accesses  (49.53%)

       1.001854149 seconds time elapsed

And it can append the metrics to the default event list easily.

root@kbl-ppc:~# ./perf stat -M Page_Walks_Utilization -a -d -- sleep 1

 Performance counter stats for 'system wide':

         1,332,948      itlb_misses.walk_pending  #    0.166 M/sec
                                                  #     0.05 Page_Walks_Utilization   (30.68%)
         1,144,389      dtlb_store_misses.walk_pending #    0.143 M/sec                    (31.09%)
       123,661,801      cycles                    #    0.015 GHz                      (31.49%)
         8,772,539      dtlb_load_misses.walk_pending #    1.096 M/sec                    (31.67%)
                 0      ept.walk_pending          #    0.000 K/sec                    (31.36%)
          8,007.56 msec cpu-clock                 #    7.992 CPUs utilized
               270      context-switches          #    0.034 K/sec
                 8      cpu-migrations            #    0.001 K/sec
                 3      page-faults               #    0.000 K/sec
       124,703,802      cycles                    #    0.016 GHz                      (30.95%)
        23,239,045      instructions              #    0.19  insn per cycle           (38.54%)
         4,500,430      branches                  #    0.562 M/sec                    (38.14%)
           658,460      branch-misses             #   14.63% of all branches          (37.96%)
         6,296,710      L1-dcache-loads           #    0.786 M/sec                    (37.96%)
         1,027,741      L1-dcache-load-misses     #   16.32% of all L1-dcache accesses  (37.96%)
           551,872      LLC-loads                 #    0.069 M/sec                    (30.37%)
            48,296      LLC-load-misses           #    8.75% of all LL-cache accesses  (30.37%)

       1.001971812 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v3:
   Improve '-d' to let it support printing default event list.
   
 v2:
   We just use a simple syntax: -e +event to append the -e event
   to default list.

 v1:
   Create a new option '--add-default' to append -e event to
   default list.

 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a380e38ca937..24f9ee90dbf0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1812,7 +1812,7 @@ static int add_default_attributes(void)
 		free(str);
 	}
 
-	if (!evsel_list->core.nr_entries) {
+	if (!evsel_list->core.nr_entries || detailed_run) {
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
-- 
2.17.1

