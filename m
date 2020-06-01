Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2E1EAFF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgFAUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 16:08:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:58214 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgFAUII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:08:08 -0400
IronPort-SDR: HJ7UwdaG+FNpHYFjFf4pl5JnJ9RtqY6FYYQzDUrh9yy1oYASMuVMeXZ98FwzVzUEIkIYpSezq8
 DygslOi9V8NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 13:08:07 -0700
IronPort-SDR: efbdzejADLTmhF//dV8jm1kG+dZdqIX/7Tq02nGus7KNtaGvfWHSNgR6cK88s3lW2cD/GTTxAH
 317n8Miw3NWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="303750467"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2020 13:08:07 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id D11D858010E;
        Mon,  1 Jun 2020 13:08:04 -0700 (PDT)
Subject: [PATCH v6 04/13] perf stat: factor out body of event handling loop
 for system wide
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
Organization: Intel Corp.
Message-ID: <19c16087-3d8e-2d50-bdc0-19bfc52d8ab0@linux.intel.com>
Date:   Mon, 1 Jun 2020 23:08:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce process_timeout() and process_interval() functions that
factor out body of event handling loop for attach and system wide
monitoring use cases.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2b79aa161dd..6dd28c714f4a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -422,6 +422,23 @@ static void process_interval(void)
 	print_counters(&rs, 0, NULL);
 }
 
+static bool print_interval(unsigned int interval, int *times)
+{
+	if (interval) {
+		process_interval();
+		if (interval_count && !(--(*times)))
+			return true;
+	}
+	return false;
+}
+
+static bool process_timeout(int timeout, unsigned int interval, int *times)
+{
+	if (timeout)
+		return true;
+	return print_interval(interval, times);
+}
+
 static void enable_counters(void)
 {
 	if (stat_config.initial_delay)
@@ -558,6 +575,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity affinity;
 	int i, cpu;
 	bool second_pass = false;
+	bool stop = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -752,17 +770,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done) {
+		while (!done && !stop) {
 			nanosleep(&ts, NULL);
 			if (!is_target_alive(&target, evsel_list->core.threads))
 				break;
-			if (timeout)
-				break;
-			if (interval) {
-				process_interval();
-				if (interval_count && !(--times))
-					break;
-			}
+			stop = process_timeout(timeout, interval, &times);
 		}
 	}
 
-- 
2.24.1


