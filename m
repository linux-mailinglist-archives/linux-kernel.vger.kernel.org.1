Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8E1C0F71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEAIZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 04:25:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60928 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728325AbgEAIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:25:45 -0400
X-IronPort-AV: E=Sophos;i="5.73,339,1583164800"; 
   d="scan'208";a="90959959"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 May 2020 16:25:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3E99C4BCC88C;
        Fri,  1 May 2020 16:25:37 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 1 May 2020 16:25:38 +0800
Received: from TSO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 1 May 2020 16:25:38 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
Subject: [PATCH v2] perf: fix compilation failure on i386
Date:   Fri, 1 May 2020 16:25:37 +0800
Message-ID: <20200501082537.4740-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3E99C4BCC88C.AA9C5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation on i386 complains as following:

util/session.c: In function 'perf_session__process_compressed_event':
util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
  pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
           ^

util/zstd.c: In function 'zstd_decompress_stream':
util/zstd.c:102:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
    pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
           ^

Fix them by pairing "%zd" to size_t.

Also revert an unnecessary conversion: "(long)src_size" to plain "src_size"
with conversion specifier "%zd".

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 tools/perf/util/session.c | 2 +-
 tools/perf/util/zstd.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0b0bfe5bef17..50c2ffa388ad 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 		session->decomp_last = decomp;
 	}
 
-	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
+	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
 
 	return 0;
 }
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index d2202392ffdb..877bfb79e4af 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -74,8 +74,8 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t
 		ret = ZSTD_compressStream(data->cstream, &output, &input);
 		ZSTD_flushStream(data->cstream, &output);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to compress %ld bytes: %s\n",
-				(long)src_size, ZSTD_getErrorName(ret));
+			pr_err("failed to compress %zd bytes: %s\n",
+				src_size, ZSTD_getErrorName(ret));
 			memcpy(dst, src, src_size);
 			return src_size;
 		}
@@ -99,7 +99,7 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
+			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
 			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
 			break;
 		}
-- 
2.21.0



