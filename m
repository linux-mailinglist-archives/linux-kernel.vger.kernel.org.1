Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C629505A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502448AbgJUQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:04:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:36326 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394870AbgJUQEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:04:10 -0400
IronPort-SDR: LB7Mzkr4xGKERdDmXTNhehmFhTQG1TtV4zyAG/AaZI7AI/I2haxO1W8Ha91fu4GVfzGuifoLtD
 2hxlT1aww2zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231583947"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="231583947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:03:52 -0700
IronPort-SDR: lfkg0aRbSF0CbAk1QGveoaw1cGL59JeJcg+7+JjbkiCak/WQ5TOQnmFxBJ890Z+AaxHQNI0KI+
 CALsqnBNL/CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="359543646"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2020 09:03:52 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id D09DD580107;
        Wed, 21 Oct 2020 09:03:49 -0700 (PDT)
Subject: [PATCH v2 09/15] perf record: introduce thread specific objects for
 trace streaming
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <bede5b00-8419-c03f-8595-7011679d363a@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:03:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce thread local data object and its array to be used for
threaded trace streaming.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba26d75c51d6..8e512096a060 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -85,11 +85,29 @@ struct switch_output {
 	int		 cur_file;
 };
 
+struct thread_data {
+	pid_t		   tid;
+	struct {
+		int	   msg[2];
+		int	   ack[2];
+	} comm;
+	struct fdarray	   pollfd;
+	int		   ctlfd_pos;
+	struct mmap	   *maps;
+	int		   nr_mmaps;
+	struct record	   *rec;
+	unsigned long long samples;
+	unsigned long	   waking;
+	u64		   bytes_written;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
 	u64			bytes_written;
 	struct perf_data	data;
+	struct thread_data	*thread_data;
+	int			nr_thread_data;
 	struct auxtrace_record	*itr;
 	struct evlist	*evlist;
 	struct perf_session	*session;
-- 
2.24.1

