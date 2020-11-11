Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32C2AE9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgKKHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgKKHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:14:09 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF12C061A47
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:13 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x13so1056848pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cwi+Q/uFcEJF2+kNznSruYlRv2WNCgUDUKyB3fZNRAA=;
        b=hLU0o4ed1PabH9Fg/g5G3+q7sbwj3i3wb5aroBHq2lpeZpw01jFYB5wOffbIxsMPMp
         1q7a15Kww3WUusmq9cfrL4z1iLVwyX9dzpLFeli1FG0dXD03xjvOa9yEI6iFWMqcEg9g
         cK85WMsZRCnwui0zy8gFuPwB8fmyKmVKkgVz5dcJ67wa0IHP1CVaf7/of1eOhlfcaAfZ
         kCG6bICbjqo6HHgE1H9i9x0TXqz8o9Bc0gbH0/f6VZKmYDp8stWIU3mjEIz4NWOzocnk
         Le4QVy8pFVnQvAp2f8302IQqR4xDTib8bKUOzDs/tEVoz/DKVjEzQFQnCmnwOLIMc46L
         GgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cwi+Q/uFcEJF2+kNznSruYlRv2WNCgUDUKyB3fZNRAA=;
        b=IsRqjXN/MtpDlF8UHgL1jxaZXahkRxUiSv896Lo24y72diuYVaQU4paeLTBhxUExpb
         ESqNMhKoNXhvBFtkoB2ncsBIlIT38oRkDsYPDjYj6sbK5s4Zpso6lyPbUxTW/7Bxys2H
         Sw/VZK3rAQOydkatI9idH6aJopbGVdRlTq9Y91oQwiVn/L7OzpnKgmcLBMjEVcFtP70K
         KxHfpVaYrs6n7pFxCYAYk59iBl9jxNOq3ihg3eB5ZoFjCgSEOdqe2RJU6+Qiz+pSwZON
         HFsy1NOyG3ccz3Qansah1Q58LXht5iqJZrsa/Fxjv36UiaWThREFk1eyBqK4Ja/zmE6R
         5OQw==
X-Gm-Message-State: AOAM531Ah+HHppvrI8D6nnlsKZdN8Zfj5BPPlbRjg2Zaxu07Ybuc6Cee
        0QCIe3ndeO+eedgtwJ9zdCq34A==
X-Google-Smtp-Source: ABdhPJzQfV/ONT5HymB5C4iSlDYGgIP/I1fY5jgPgwk0X9TIWlmnapxVMpuovkBMlehx1UJoolhk6w==
X-Received: by 2002:a63:5f17:: with SMTP id t23mr20936551pgb.190.1605078792639;
        Tue, 10 Nov 2020 23:13:12 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id v126sm1305060pfb.137.2020.11.10.23.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:12 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 14/22] perf arm-spe: Refactor counter packet handling
Date:   Wed, 11 Nov 2020 15:11:41 +0800
Message-Id: <20201111071149.815-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macros for counter packet header, and uses macros to
replace hard code values in functions arm_spe_get_counter() and
arm_spe_pkt_desc().

In the function arm_spe_get_counter(), adds a new line for more
readable.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 11 ++++++-----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index e8c9da1d4280..5178bbe64422 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -152,10 +152,11 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_COUNTER;
+
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = SPE_HDR_EXTENDED_INDEX(buf[0], buf[1]);
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = SPE_HDR_SHORT_INDEX(buf[0]);
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -333,13 +334,13 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 			     (unsigned short)payload);
 
 	switch (packet->index) {
-	case 0:
+	case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "TOT");
 		break;
-	case 1:
+	case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "ISSUE");
 		break;
-	case 2:
+	case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "XLAT");
 		break;
 	default:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 9bc876bffd35..7d8e34e35f05 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -82,6 +82,11 @@ struct arm_spe_pkt {
 /* Context packet header */
 #define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
 
+/* Counter packet header */
+#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		0x0
+#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
+#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

