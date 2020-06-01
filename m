Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1950B1EA764
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFAPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:55:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:44473 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgFAPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:55:56 -0400
IronPort-SDR: MboGF0yEzghC2d3jhHPVZbbWyeLpuiYC1PE+WUrlZR3giYHlkjtpwTO0LDjzALiaTIZXiGWrvO
 hZzXddSevM0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 08:55:55 -0700
IronPort-SDR: KBmtiMQJMdoKs9MQT6x68BRpGJ2cBFQeouJ5paLsWodLIS98ksc5pCitg3s3VfkDkmSDBz2gSF
 Bwqde9gbi8hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="257298516"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2020 08:55:55 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 34A83580646;
        Mon,  1 Jun 2020 08:55:53 -0700 (PDT)
Subject: [PATCH v5 06/13] perf stat: factor out body of event handling loop
 for launch case
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Organization: Intel Corp.
Message-ID: <57e17133-4fa7-821a-4637-4634d8686283@linux.intel.com>
Date:   Mon, 1 Jun 2020 18:55:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out body of event handling loop for launch use case
reusing process_timeout() and process_interval() functions.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4d03b18231d4..dc7506be8bbd 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -745,13 +745,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 
 		if (interval || timeout) {
-			while (!waitpid(child_pid, &status, WNOHANG)) {
+			while (!stop && !waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				process_interval();
-				if (interval_count && !(--times))
-					break;
+				stop = process_timeout(timeout, interval, &times);
 			}
 		}
 		if (child_pid != -1) {
-- 
2.24.1

