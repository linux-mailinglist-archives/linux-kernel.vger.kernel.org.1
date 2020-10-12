Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18528B0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgJLI5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:57:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:30277 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:57:06 -0400
IronPort-SDR: EQKaHuhpNKHV196kVb5jZaTd6S8GTyDQjW23fF6QWf9HqS5z41wCjMZJCGGvrQtmlne90iAH73
 006KOZxW0+BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="153540071"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="153540071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:57:04 -0700
IronPort-SDR: zwAvp9tbj9CscFsxBTroJaWpbR+6PyB3989f4TMURwbpWthze4UMrqzJniSTQzu33yjvVWkPsE
 OLxTttoQMp5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="420163741"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 01:57:03 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id 7BE575805EC;
        Mon, 12 Oct 2020 01:57:01 -0700 (PDT)
Subject: [PATCH v1 05/15] perf session: introduce decompressor into trace
 reader object
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
Message-ID: <a7fa42f9-a3a9-0ee0-4933-fe5d1d60176f@linux.intel.com>
Date:   Mon, 12 Oct 2020 11:57:00 +0300
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


Introduce decompressor to trace reader object so that decompression
could be executed on per trace file basis separately for every
trace file located at data directory.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/session.c | 4 +++-
 tools/perf/util/session.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 911b2dbcd0ac..6afc670fdf0c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -44,6 +44,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	u64 decomp_last_rem = 0;
 	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->decomp_last;
+	struct zstd_data *zstd_data = session->reader ?
+		&(session->reader->zstd_data) : &(session->zstd_data);
 
 	if (decomp_last) {
 		decomp_last_rem = decomp_last->size - decomp_last->head;
@@ -71,7 +73,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	src = (void *)event + sizeof(struct perf_record_compressed);
 	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 
-	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
+	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
 		munmap(decomp, mmap_len);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index abdb8518a81f..4fc9ccdf7970 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -42,6 +42,7 @@ struct reader {
 	u64		 data_size;
 	u64		 data_offset;
 	reader_cb_t	 process;
+	struct zstd_data zstd_data;
 };
 
 struct perf_session {
-- 
2.24.1


