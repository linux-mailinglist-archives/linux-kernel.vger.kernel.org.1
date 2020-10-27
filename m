Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A822A29A028
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442687AbgJ0A14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:27:56 -0400
Received: from one.firstfloor.org ([193.170.194.197]:59536 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394876AbgJ0A1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:27:50 -0400
Received: from firstfloor.org (c-71-237-255-61.hsd1.or.comcast.net [71.237.255.61])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by one.firstfloor.org (Postfix) with ESMTPSA id C4F5A86837;
        Tue, 27 Oct 2020 01:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1603758465;
        bh=9K+cenBFS949Ho1pS1ggc3fQZ0xkHgvhRaRIiyP+SII=;
        h=From:To:Cc:Subject:Date:From;
        b=nKYTUPRzYRcOWzj0ub69wuXgsmdlrqMPbs4FhUti+Embco1aKE+GfdwnFlAChFGCZ
         3XPRFEiCiJLhIWSVcrUqxSvXIpui0bHt1y4x58D0kqwhLzEAxOLld/bFXUPrBfr9Nf
         hDCpcL/2rpQ4pctqFjbmUtxXGjusCg37zmRMyJMA=
Received: by firstfloor.org (Postfix, from userid 1000)
        id EDAF9A0A57; Mon, 26 Oct 2020 17:27:42 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com, Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/2] perf tools: Add --quiet option to perf stat
Date:   Mon, 26 Oct 2020 17:27:36 -0700
Message-Id: <20201027002737.30942-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new --quiet option to perf stat. This is useful with perf stat
record to write the data only to the perf.data file, which can lower
measurement overhead because the data doesn't need to be formatted.

On my 4C desktop:

% time ./perf stat record  -e $(python -c 'print ",".join(["cycles"]*1000)')  -a -I 1000 sleep 5
...
real    0m5.377s
user    0m0.238s
sys     0m0.452s
% time ./perf stat record --quiet -e $(python -c 'print ",".join(["cycles"]*1000)')  -a -I 1000 sleep 5

real    0m5.452s
user    0m0.183s
sys     0m0.423s

In this example it cuts the user time by 20%. On systems with more cores
the savings are higher.

Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 tools/perf/Documentation/perf-stat.txt | 4 ++++
 tools/perf/builtin-stat.c              | 6 +++++-
 tools/perf/util/stat.h                 | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9f9f29025e49..b138dd192423 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -316,6 +316,10 @@ small group that need not have multiplexing is lowered. This option
 forbids the event merging logic from sharing events between groups and
 may be used to increase accuracy in this case.
 
+--quiet::
+Don't print output. This is useful with perf stat record below to only
+write data to the perf.data file.
+
 STAT RECORD
 -----------
 Stores stat data into perf data file.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b01af171d94f..743fe47e7a88 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -972,6 +972,8 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	/* Do not print anything if we record to the pipe. */
 	if (STAT_RECORD && perf_stat.data.is_pipe)
 		return;
+	if (stat_config.quiet)
+		return;
 
 	perf_evlist__print_counters(evsel_list, &stat_config, &target,
 				    ts, argc, argv);
@@ -1171,6 +1173,8 @@ static struct option stat_options[] = {
 		    "threads of same physical core"),
 	OPT_BOOLEAN(0, "summary", &stat_config.summary,
 		       "print summary for interval mode"),
+	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
+			"don't print output (useful with record)"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
@@ -2132,7 +2136,7 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (!output) {
+	if (!output && !stat_config.quiet) {
 		struct timespec tm;
 		mode = append_file ? "a" : "w";
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 487010c624be..05adf8165025 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -122,6 +122,7 @@ struct perf_stat_config {
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 stop_read_counter;
+	bool			 quiet;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.28.0

