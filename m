Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23982B961C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgKSPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgKSPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:02 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D624C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y7so4786286pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbbX/6tUQ7S2JLH6rTvxkENEi3ZHaW/j2TBI44XlAOM=;
        b=X2Sfb9RhGKDYbwhkb1GOpJUMwd+drri0jRVvxDcMqMDL5cRVy5cjaA2dNA1JIDnDUa
         rHD5ppMStAzOIqRR8gCgrS4hsntEaAQylWwKrPbi9pP3d5lXB77JhV1CRYyez2+2XEZ9
         eVWriPRe3gkcCQmPRNyOOrWJGiNCyNG+ropZ+Nd64J1iYWd2OpG+WCwl6u28xGm6NMCM
         XaEpUQBv34IAeDgGsbDHG213PGtu10ZlIUW65yk8V71/budtC+gSX/bf5DRabBOWAwqP
         LBhYlalSlVQhrcfgFN10S+YqIOLXPYj7JuNLytwsB08QrF2Mz1GjwrlurQswJNFv4SlS
         BJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbbX/6tUQ7S2JLH6rTvxkENEi3ZHaW/j2TBI44XlAOM=;
        b=lv1dOS3DrgaHslKyhNtN7dsqmsZUbRsJgMeNJeZPTpFRVFac7YlmaQM0eWyjJhVKUv
         /4HeO/uLbS6i2HuqN6+s0U7VPj2i72BOKrHg19f8PgLfGT0ejZdQhxqJRzLDdTLL9AKh
         w7A52cL9eWAsZoMU4OAJjhp6ZDoQ4gZZYdQCzcsjP5Q5ojIjXcVzv7n3uENbCXGn1ml8
         X3DPRiQDddXdYUAOI3osCbdsC3EL4JL0r0nvhd9zVUocfyKY6z8A3sjtAwiN6QzndA6N
         5GyiHvDy8hlXl/v0aYKSJyKk6NTr9PQC4wIl86UaO3Km9zbjCw1Q1+sPdw3Mo1c+vYKC
         6QQQ==
X-Gm-Message-State: AOAM5333iuSmkardPlTUOAua7YrNvHO1PUBI2+/yZx8AOO6i29+r94Fn
        TBfw6c7f4HRy08dM9PeSnVb5EQ==
X-Google-Smtp-Source: ABdhPJwH049xLbcMRkIEdmG6gfBDRk+pQ5m7frj1zrcYkavoKHVU3hANGY0zyzWHffZABN0vOCXivw==
X-Received: by 2002:a17:90a:67c5:: with SMTP id g5mr5208919pjm.13.1605799500773;
        Thu, 19 Nov 2020 07:25:00 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id o132sm107236pfg.100.2020.11.19.07.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:00 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 02/16] perf arm-spe: Refactor packet header parsing
Date:   Thu, 19 Nov 2020 23:24:27 +0800
Message-Id: <20201119152441.6972-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The packet header parsing uses the hard coded values and it uses nested
if-else statements.

To improve the readability, this patch refactors the macros for packet
header format so it removes the hard coded values.  Furthermore, based
on the new mask macros it reduces the nested if-else statements and
changes to use the flat conditions checking, this is directive and can
easily map to the descriptions in ARMv8-a architecture reference manual
(ARM DDI 0487E.a), chapter 'D10.1.5 Statistical Profiling Extension
protocol packet headers'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 92 +++++++++----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 20 ++++
 2 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index fbededc1bcd4..a769fe5a4496 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -16,28 +16,6 @@
 #define NS_FLAG		BIT_ULL(63)
 #define EL_FLAG		(BIT_ULL(62) | BIT_ULL(61))
 
-#define SPE_HEADER0_PAD			0x0
-#define SPE_HEADER0_END			0x1
-#define SPE_HEADER0_ADDRESS		0x30 /* address packet (short) */
-#define SPE_HEADER0_ADDRESS_MASK	0x38
-#define SPE_HEADER0_COUNTER		0x18 /* counter packet (short) */
-#define SPE_HEADER0_COUNTER_MASK	0x38
-#define SPE_HEADER0_TIMESTAMP		0x71
-#define SPE_HEADER0_TIMESTAMP		0x71
-#define SPE_HEADER0_EVENTS		0x2
-#define SPE_HEADER0_EVENTS_MASK		0xf
-#define SPE_HEADER0_SOURCE		0x3
-#define SPE_HEADER0_SOURCE_MASK		0xf
-#define SPE_HEADER0_CONTEXT		0x24
-#define SPE_HEADER0_CONTEXT_MASK	0x3c
-#define SPE_HEADER0_OP_TYPE		0x8
-#define SPE_HEADER0_OP_TYPE_MASK	0x3c
-#define SPE_HEADER1_ALIGNMENT		0x0
-#define SPE_HEADER1_ADDRESS		0xb0 /* address packet (extended) */
-#define SPE_HEADER1_ADDRESS_MASK	0xf8
-#define SPE_HEADER1_COUNTER		0x98 /* counter packet (extended) */
-#define SPE_HEADER1_COUNTER_MASK	0xf8
-
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define le16_to_cpu bswap_16
 #define le32_to_cpu bswap_32
@@ -200,46 +178,58 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
 static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
 				 struct arm_spe_pkt *packet)
 {
-	unsigned int byte;
+	unsigned int hdr;
+	unsigned char ext_hdr = 0;
 
 	memset(packet, 0, sizeof(struct arm_spe_pkt));
 
 	if (!len)
 		return ARM_SPE_NEED_MORE_BYTES;
 
-	byte = buf[0];
-	if (byte == SPE_HEADER0_PAD)
+	hdr = buf[0];
+
+	if (hdr == SPE_HEADER0_PAD)
 		return arm_spe_get_pad(packet);
-	else if (byte == SPE_HEADER0_END) /* no timestamp at end of record */
+
+	if (hdr == SPE_HEADER0_END) /* no timestamp at end of record */
 		return arm_spe_get_end(packet);
-	else if (byte & 0xc0 /* 0y11xxxxxx */) {
-		if (byte & 0x80) {
-			if ((byte & SPE_HEADER0_ADDRESS_MASK) == SPE_HEADER0_ADDRESS)
-				return arm_spe_get_addr(buf, len, 0, packet);
-			if ((byte & SPE_HEADER0_COUNTER_MASK) == SPE_HEADER0_COUNTER)
-				return arm_spe_get_counter(buf, len, 0, packet);
-		} else
-			if (byte == SPE_HEADER0_TIMESTAMP)
-				return arm_spe_get_timestamp(buf, len, packet);
-			else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS)
-				return arm_spe_get_events(buf, len, packet);
-			else if ((byte & SPE_HEADER0_SOURCE_MASK) == SPE_HEADER0_SOURCE)
-				return arm_spe_get_data_source(buf, len, packet);
-			else if ((byte & SPE_HEADER0_CONTEXT_MASK) == SPE_HEADER0_CONTEXT)
-				return arm_spe_get_context(buf, len, packet);
-			else if ((byte & SPE_HEADER0_OP_TYPE_MASK) == SPE_HEADER0_OP_TYPE)
-				return arm_spe_get_op_type(buf, len, packet);
-	} else if ((byte & 0xe0) == 0x20 /* 0y001xxxxx */) {
-		/* 16-bit header */
-		byte = buf[1];
-		if (byte == SPE_HEADER1_ALIGNMENT)
+
+	if (hdr == SPE_HEADER0_TIMESTAMP)
+		return arm_spe_get_timestamp(buf, len, packet);
+
+	if ((hdr & SPE_HEADER0_MASK1) == SPE_HEADER0_EVENTS)
+		return arm_spe_get_events(buf, len, packet);
+
+	if ((hdr & SPE_HEADER0_MASK1) == SPE_HEADER0_SOURCE)
+		return arm_spe_get_data_source(buf, len, packet);
+
+	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_CONTEXT)
+		return arm_spe_get_context(buf, len, packet);
+
+	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_OP_TYPE)
+		return arm_spe_get_op_type(buf, len, packet);
+
+	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_EXTENDED) {
+		/* 16-bit extended format header */
+		ext_hdr = 1;
+
+		hdr = buf[1];
+		if (hdr == SPE_HEADER1_ALIGNMENT)
 			return arm_spe_get_alignment(buf, len, packet);
-		else if ((byte & SPE_HEADER1_ADDRESS_MASK) == SPE_HEADER1_ADDRESS)
-			return arm_spe_get_addr(buf, len, 1, packet);
-		else if ((byte & SPE_HEADER1_COUNTER_MASK) == SPE_HEADER1_COUNTER)
-			return arm_spe_get_counter(buf, len, 1, packet);
 	}
 
+	/*
+	 * The short format header's byte 0 or the extended format header's
+	 * byte 1 has been assigned to 'hdr', which uses the same encoding for
+	 * address packet and counter packet, so don't need to distinguish if
+	 * it's short format or extended format and handle in once.
+	 */
+	if ((hdr & SPE_HEADER0_MASK3) == SPE_HEADER0_ADDRESS)
+		return arm_spe_get_addr(buf, len, ext_hdr, packet);
+
+	if ((hdr & SPE_HEADER0_MASK3) == SPE_HEADER0_COUNTER)
+		return arm_spe_get_counter(buf, len, ext_hdr, packet);
+
 	return ARM_SPE_BAD_PACKET;
 }
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 4c870521b8eb..129f43405eb1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -36,6 +36,26 @@ struct arm_spe_pkt {
 	uint64_t		payload;
 };
 
+/* Short header (HEADER0) and extended header (HEADER1) */
+#define SPE_HEADER0_PAD				0x0
+#define SPE_HEADER0_END				0x1
+#define SPE_HEADER0_TIMESTAMP			0x71
+/* Mask for event & data source */
+#define SPE_HEADER0_MASK1			(GENMASK_ULL(7, 6) | GENMASK_ULL(3, 0))
+#define SPE_HEADER0_EVENTS			0x42
+#define SPE_HEADER0_SOURCE			0x43
+/* Mask for context & operation */
+#define SPE_HEADER0_MASK2			GENMASK_ULL(7, 2)
+#define SPE_HEADER0_CONTEXT			0x64
+#define SPE_HEADER0_OP_TYPE			0x48
+/* Mask for extended format */
+#define SPE_HEADER0_EXTENDED			0x20
+/* Mask for address & counter */
+#define SPE_HEADER0_MASK3			GENMASK_ULL(7, 3)
+#define SPE_HEADER0_ADDRESS			0xb0
+#define SPE_HEADER0_COUNTER			0x98
+#define SPE_HEADER1_ALIGNMENT			0x0
+
 #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
-- 
2.17.1

