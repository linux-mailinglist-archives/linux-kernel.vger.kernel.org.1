Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC3295054
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444350AbgJUQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:02:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:46296 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444343AbgJUQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:02:04 -0400
IronPort-SDR: KvO2xhpgt7VnXV7Nx8VemAE/wffm1i2Yp3aqdsi+kOQLOrFY/koylUYFBLntSj9IF0CyJRV4wg
 y8SqDa8mkaOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167511479"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="167511479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:02:01 -0700
IronPort-SDR: VPwcWGKy+tSnhI6h56bZ3M7hmt0ueltw+l6TkyiYJhuk6vSXsmc2Xm6UySeB+/Nz5N2u9vW7V2
 jj/0Wy4hC7aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="523940993"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2020 09:01:58 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 1D578580720;
        Wed, 21 Oct 2020 09:01:55 -0700 (PDT)
Subject: [PATCH v2 07/15] perf record: introduce trace file, compressor and
 stats in mmap object
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
Message-ID: <8e07f6f3-61b8-3470-c46e-51303f96ab7b@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:01:54 +0300
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


