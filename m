Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49CC29A2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441232AbgJ0DKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:46 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:43146 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440946AbgJ0DKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:46 -0400
Received: by mail-pl1-f175.google.com with SMTP id o9so10412plx.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOv4EKtxBbPwxWtS+WPJb8baDsdxMkVD4AGiTAO1fXc=;
        b=Mn85V3DtFXfvPJo3e2onIwpcnnBJXWDz6a8ua5bLMHUdqnb6bt5XEEv9+2A/341Sqw
         pDjOUQt3dozkATpEd272vtWiLh/NvpY5TNonMX7cWH9bgJQzeK3xfUha487EZVogEIIb
         b6hex0pmgLP+FSJnoUUJKPVKlTwtclIUIXKFj923kpcVTgPZ2H8lPs4Uuy5WcFudj0D4
         icr9kY4KlCP6CnnIBe7M+gLtUh7i0iWh1Q2ojnA6to4hLk496Y7Ghto8ukxwD2+HzVAm
         i4lHYp3/l2Y6aUlxTEiAASloBWh7Eb28FA20LkMTFzv6nBhrWmqLC9y/nUPlVcG3gFeP
         HWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KOv4EKtxBbPwxWtS+WPJb8baDsdxMkVD4AGiTAO1fXc=;
        b=TNXMZphB1q5fQ4U/t77ndl2khWzPKMwXNx6tzQ9u1ImavCukmNBX2vnZyrptRYUyAk
         vi2Gspw9bQC7A1FQhXxqEqG/XtkxkBPaiGmmRUkYXer+K92G1xGWdkj/TcIaFRMFTpwU
         b8sZw6ndfoLeLwuYHXjK4Hoop/u7GSGOIk19MqbcXgAPrGNZUYutBiCdtdMy6oBEnyCt
         ad/itMn6psHc//TJcptvahenBvPQLgnGwRW8Vjc5QGQ4QyTjab+O/q8VkZwNZ6/X4Vk3
         C22bHyJ6DUgZnuBwjfISz1HLRXvzSQvmQO7pFA2bqTdSmrPUv6V8jvf4pLi+hmqguaBk
         dCww==
X-Gm-Message-State: AOAM532MMTyj5BG12AS6vjdAckXnym2H2i+GpnAcXFmDm/GfFnqHSta6
        hXMDku1eWt9LuD88/wZNXHYPxw==
X-Google-Smtp-Source: ABdhPJz42Y5hwzRXkDc7Ycp4slwe5b9X2E+A6Y790/T6jy1SC82sY6mUoQYa321lbGtDG/uIw1Oc/A==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr64243pjq.119.1603768244443;
        Mon, 26 Oct 2020 20:10:44 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id u13sm163095pfl.162.2020.10.26.20.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 07/21] perf arm-spe: Refactor packet header parsing
Date:   Tue, 27 Oct 2020 11:09:03 +0800
Message-Id: <20201027030917.15404-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
index b400636e6da2..40007c3a28bc 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -16,28 +16,6 @@
 #define NS_FLAG		BIT(63)
 #define EL_FLAG		(BIT(62) | BIT(61))
 
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

