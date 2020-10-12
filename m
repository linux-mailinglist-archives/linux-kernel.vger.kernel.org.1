Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8828B100
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgJLI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:59:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:2608 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgJLI7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:59:55 -0400
IronPort-SDR: 0IyCp11gaMmaqStOTLip1CMvdzgSWDBKFxjh/eJ72YFW0qWx7gac74ddhL+65EETpU1agV+QFB
 ZnofzUoDEJtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="227355796"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="227355796"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:59:55 -0700
IronPort-SDR: oUe4XakV58n0uj0WbKD26dCGGM/iSGw9XnRz4rspEpfYFI879IiqaK9AMwIQQ3YzqccjWAEDEm
 f5L5dhG06m7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="329676643"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2020 01:59:55 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id B248A580814;
        Mon, 12 Oct 2020 01:59:52 -0700 (PDT)
Subject: [PATCH v1 07/15] perf record: introduce trace file, compressor and
 stats in mmap object
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
Message-ID: <781092bf-8b1d-9d01-367b-b83d88bccf7b@linux.intel.com>
Date:   Mon, 12 Oct 2020 11:59:51 +0300
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


Introduce trace file and compressor objects into mmap object so
they could be used to process and store data stream from the
corresponding kernel data buffer. Introduce bytes_transferred
and bytes_compressed stats so they would capture statistics for
the related data buffer transfers. Make use of the introduced
per mmap file, compressor and stats when they are initialized
and available.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 47 +++++++++++++++++++++++++++----------
 tools/perf/util/mmap.c      |  6 +++++
 tools/perf/util/mmap.h      |  5 ++++
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adf311d15d3d..619aaee11231 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -150,11 +150,17 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 {
 	struct perf_data_file *file = &rec->session->data->file;
 
+	if (map && map->file)
+		file = map->file;
+
 	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
 		return -1;
 	}
 
+	if (file != &rec->session->data->file)
+		return 0;
+
 	rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
@@ -172,8 +178,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 
 static int record__aio_enabled(struct record *rec);
 static int record__comp_enabled(struct record *rec);
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
-			    void *src, size_t src_size);
+static size_t zstd_compress(struct zstd_data *data,
+			    void *dst, size_t dst_size, void *src, size_t src_size);
 
 #ifdef HAVE_AIO_SUPPORT
 static int record__aio_write(struct aiocb *cblock, int trace_fd,
@@ -291,6 +297,7 @@ struct record_aio {
 static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size)
 {
 	struct record_aio *aio = to;
+	size_t compressed = size;
 
 	/*
 	 * map->core.base data pointed by buf is copied into free map->aio.data[] buffer
@@ -307,9 +314,14 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	 */
 
 	if (record__comp_enabled(aio->rec)) {
-		size = zstd_compress(aio->rec->session, aio->data + aio->size,
-				     mmap__mmap_len(map) - aio->size,
+		struct zstd_data *zstd_data = &(aio->rec->session->zstd_data);
+
+		compressed = zstd_compress(zstd_data,
+				     aio->data + aio->size, mmap__mmap_len(map) - aio->size,
 				     buf, size);
+
+		aio->rec->session->bytes_transferred += size;
+		aio->rec->session->bytes_compressed  += compressed;
 	} else {
 		memcpy(aio->data + aio->size, buf, size);
 	}
@@ -328,7 +340,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 		perf_mmap__get(&map->core);
 	}
 
-	aio->size += size;
+	aio->size += compressed;
 
 	return size;
 }
@@ -532,14 +544,28 @@ static int process_locked_synthesized_event(struct perf_tool *tool,
 static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
+	size_t compressed = size;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
+		struct zstd_data *zstd_data = &rec->session->zstd_data;
+
+		if (map->file)
+			zstd_data = &map->zstd_data;
+
+		compressed = zstd_compress(zstd_data, map->data, mmap__mmap_len(map), bf, size);
 		bf   = map->data;
+
+		if (map->file) {
+			map->bytes_transferred += size;
+			map->bytes_compressed  += compressed;
+		} else {
+			rec->session->bytes_transferred += size;
+			rec->session->bytes_compressed  += compressed;
+		}
 	}
 
 	rec->samples++;
-	return record__write(rec, map, bf, size);
+	return record__write(rec, map, bf, compressed);
 }
 
 static volatile int signr = -1;
@@ -1079,18 +1105,15 @@ static size_t process_comp_header(void *record, size_t increment)
 	return size;
 }
 
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
+static size_t zstd_compress(struct zstd_data *zstd_data, void *dst, size_t dst_size,
 			    void *src, size_t src_size)
 {
 	size_t compressed;
 	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
 
-	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
+	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
 						     max_record_size, process_comp_header);
 
-	session->bytes_transferred += src_size;
-	session->bytes_compressed  += compressed;
-
 	return compressed;
 }
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab7108d22428..a2c5e4237592 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
 
+	zstd_fini(&map->zstd_data);
+
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
@@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	map->core.flush = mp->flush;
 
 	map->comp_level = mp->comp_level;
+	if (zstd_init(&map->zstd_data, map->comp_level)) {
+		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
+		return -1;
+	}
 
 	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9d5f589f02ae..d98b0bdedeac 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -13,6 +13,7 @@
 #endif
 #include "auxtrace.h"
 #include "event.h"
+#include "util/compress.h"
 
 struct aiocb;
 
@@ -43,6 +44,10 @@ struct mmap {
 	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
+	struct perf_data_file *file;
+	struct zstd_data      zstd_data;
+	u64		      bytes_transferred;
+	u64		      bytes_compressed;
 };
 
 struct mmap_params {
-- 
2.24.1


