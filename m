Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0828B10E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgJLJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:02:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:1953 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgJLJCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:02:44 -0400
IronPort-SDR: faYTSfPYgJr4AFeCBwGD9QHm0XBhYr9O9Ag9iwKRikpiPF0vl5NZ91BlIV/mQzOxuLGbvHXqjW
 jUNv869aoy0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145574962"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="145574962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:02:43 -0700
IronPort-SDR: ygvizUtS/A6xdWDQtk2NJtEpvEbBC4fjcPAeYRG/MuyPCRytZFaruzWfwUYyj6Vi7/5NASzSEJ
 ftQ4CuCHxbjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="344804594"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 02:02:41 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id CA5F35805EC;
        Mon, 12 Oct 2020 02:02:38 -0700 (PDT)
Subject: [PATCH v1 09/15] perf record: introduce thread specific objects for
 trace streaming
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fe45bf0f-b9fd-e338-9fdb-2c947d7e7e07@linux.intel.com>
Date:   Mon, 12 Oct 2020 12:02:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
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


