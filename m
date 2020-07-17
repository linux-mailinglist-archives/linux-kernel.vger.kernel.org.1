Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85022351A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGQHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 03:03:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:32324 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgGQHDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:03:22 -0400
IronPort-SDR: gnJAOqzq018Wven8M7x4vsowdHO3PpnoGjQxAAbQBpMpxcGQDSDOHKCkloO7aFS4lMo6JuO+S9
 7ICFkP1CVBvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150927248"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="150927248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:03:22 -0700
IronPort-SDR: xKl6nepEO351LRxr8y0AtZ903TiiFfrbX/TBHa7G37TcHntZf3IDgYk3Xc7O66VfFgOV60zcTk
 1el2k4D0LQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="326764750"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2020 00:03:22 -0700
Received: from [10.249.224.34] (abudanko-mobl.ccr.corp.intel.com [10.249.224.34])
        by linux.intel.com (Postfix) with ESMTP id A0D9758066D;
        Fri, 17 Jul 2020 00:03:20 -0700 (PDT)
Subject: [PATCH v12 08/15] perf stat: factor out body of event handling loop
 for fork case
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a8ae3f8d-a30e-fd40-998a-f5ca3e98cd45@linux.intel.com>
Date:   Fri, 17 Jul 2020 10:03:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out body of event handling loop for fork case reusing
handle_interval() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 87eebf3f55ae..91f31518948e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -792,10 +792,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				process_interval();
-				if (interval_count && !(--times))
+				if (timeout || handle_interval(interval, &times))
 					break;
 			}
 		}
-- 
2.24.1


