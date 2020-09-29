Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD927CF88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgI2NlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgI2Nkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54716C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so5487686wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9OO/7nJQwP+T52lJPD6CHY2lBMHXMuf1V294LNXmryk=;
        b=RgrX204msh3QP8jnKg6MWX5gFzpYUlKa1hkd5g12RimQPeQo7mEVk87PFSRWjnFyUB
         bavnNQ1KYbfJxY6DV5ZFhcVOL05rSHIsbcvLKgv4so5SOHNGHn7IZduhN6mWO6n4Vc8P
         /pPbhsl5A5NwmVIu1xM7JlV5jjWWaCjJgl3wEA7ZOlV23MAFb3KvxtZ1S/Z+FY6K/jJX
         P3qLgOtBtYfkskZnH1MOliTmcx7nZPkMD2APi/HmIjMzQAvI1M3tIZx44U0Qp9loYhvg
         yJ5CAH4M81LLUNy6IEoOy+RXdkLLZiJ7NoQiSOgRgG5jhJeQ+Hz8UQF6e4JuKraXeXXi
         tOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9OO/7nJQwP+T52lJPD6CHY2lBMHXMuf1V294LNXmryk=;
        b=KHVX++nbrWrjS33dOen2GcVFWSTsV8IsYNd2N+XBfwR/NUJem1RHdAGqYu/luQMZ7Y
         PU9hPg1k8ehU8HfzhiFDEvpAvYsGQw0GMkXI6LMIn09mQ2rfkC2VHoqJ/MmVWJMCZhez
         HtnJPwYUK8//WNPFkB+uMG88XCCMhSPC+KrAGPjnRN5Lk+MxGJhW8WJWK9rRUU2pDgOY
         iP97wcXcNU7FP9qWV4CAl9S6S9RwCQuHA0wdlGWfSoezrr9qjHsac6T81Xal4PUIV+S6
         ccNuhe5tDYJ5vGuCxe3oOZpJZvSsvMz7N7ADiLTK507p9AsCJvJEzkCA3swrLsYdwvla
         zAFQ==
X-Gm-Message-State: AOAM532dB/mc646Ui9LpjUBC+/arhfWzGxyX1c2LXCS5Gqx9L57BxB0N
        Fp9yRE3Z8JBezMT30yOUvF4dDQ==
X-Google-Smtp-Source: ABdhPJx2l0K16tq6BF6AjXbjbvVcF2kAkYL66DfTnsPSKxxrnfphi6BVuI0bK16jApkVdYk6KAuEIg==
X-Received: by 2002:a5d:574a:: with SMTP id q10mr4367251wrw.127.1601386850891;
        Tue, 29 Sep 2020 06:40:50 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 03/14] perf arm-spe: Refactor payload length calculation
Date:   Tue, 29 Sep 2020 14:39:06 +0100
Message-Id: <20200929133917.9224-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macro for payload length calculation instead of static function.

Currently the event packet's 'index' is assigned as payload length, but
the flow is not directive: it firstly gets the packet length (includes
header length and payload length) and then reduces header length from
packet length, so finally get the payload length; to simplify the code,
this patch directly assigns payload length to event packet's index.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 ++++++++-----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  4 +++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 7c7b5eb09fba..5a8696031e16 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -69,22 +69,20 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
 	return arm_spe_packet_name[type];
 }
 
-/* return ARM SPE payload size from its encoding,
- * which is in bits 5:4 of the byte.
- * 00 : byte
- * 01 : halfword (2)
- * 10 : word (4)
- * 11 : doubleword (8)
+/*
+ * Return ARM SPE payload size from header bits 5:4
+ *   00 : byte
+ *   01 : halfword (2)
+ *   10 : word (4)
+ *   11 : doubleword (8)
  */
-static int payloadlen(unsigned char byte)
-{
-	return 1 << ((byte & 0x30) >> 4);
-}
+#define PAYLOAD_LEN(val)	\
+	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = payloadlen(buf[0]);
+	size_t payload_len = PAYLOAD_LEN(buf[0]);
 
 	if (len < 1 + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
@@ -136,8 +134,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
 			      struct arm_spe_pkt *packet)
 {
-	int ret = arm_spe_get_payload(buf, len, packet);
-
 	packet->type = ARM_SPE_EVENTS;
 
 	/* we use index to identify Events with a less number of
@@ -145,9 +141,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
-	packet->index = ret - 1;
+	packet->index = PAYLOAD_LEN(buf[0]);
 
-	return ret;
+	return arm_spe_get_payload(buf, len, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 4c870521b8eb..f2d0af39a58c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -9,6 +9,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
+#include <linux/bits.h>
 
 #define ARM_SPE_PKT_DESC_MAX		256
 
@@ -36,6 +37,9 @@ struct arm_spe_pkt {
 	uint64_t		payload;
 };
 
+#define SPE_HEADER_SZ_SHIFT		(4)
+#define SPE_HEADER_SZ_MASK		GENMASK_ULL(5, 4)
+
 #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
-- 
2.20.1

