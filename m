Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1C2A8C37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgKFBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732788AbgKFBms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:42:48 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:42:47 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w65so2865953pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VOcm8/EpmzASlT7a2hQLnC9GbAU8VHkQXBuc8CwXxrc=;
        b=s5AFqvpsgFagsavZf8hhlDc7+eVYH7NncGde/TgoDyEiUnZup97x4rUeFzzG7uhDLQ
         mL0/qoVGz9H/pWaAn8JNlMEpUhMP2Zwvm0ALFXSATXwpljRv5VR59PT7QMs0u2MHogFv
         VxWggHoIKxPBUvOv+pIZuNsU8/RRBb9+pvGTWpQo/TBzUufDpF/LwAsbTsZevUOyRouE
         XMI8hDiKlqutAZWfoBk03AFKIRSOvuysYICt31bZ5Is7yqpfLTmJ6okeOGiaWp7QRcIT
         yFjrG0ISi0qBcRMfII/IbLg9g6+SpjwpOMPPBd7YsEBApVmmQ1D+SaAU9L8ENCIpz5US
         khsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VOcm8/EpmzASlT7a2hQLnC9GbAU8VHkQXBuc8CwXxrc=;
        b=sPlbJmkLNc4TjFa1lR83EcGuSDiGEWSQ2+Fg6BNQD/Hl/MqKJht/zzVlWGhobmidVB
         1JV01l8jTnnmlXf5c577CQHib25vpR9AOGHs4wvnxUZqBaSHNiAThmbLLW7KaqFZip7a
         e2geEQB8FaHNqRdEnUeYuq5QDvkfEunXN9pY7WeWWydCUaiUWsPihQaflruxjSO8DJj0
         LgRduQai4JuBZ9++BP8lXFs78EnXOSDFyCzuDrqFBAgt7rC0fAHjuOIp07ncSDst4w5Z
         ur22rq0/5mctmzg63ootkjoz9NO+Zsl5LG6/z8u7/uZngvwWD6zTZ5Sy+Q9jv7wYBmvN
         UNLA==
X-Gm-Message-State: AOAM533YIsVvmvz5WzfOfT+3YtaLu/5FlSRrUEg3pW8srpaQhJgu0kvG
        95nBmBrDgMTDet9bP5dsdrIzWw==
X-Google-Smtp-Source: ABdhPJwlHAMrRqbSDURVPVztxvO2hp45Md/phkJxiK3WdasqIBh/q9CgIbHlWhQBSGHSBYkGga5wxw==
X-Received: by 2002:a17:90a:ab16:: with SMTP id m22mr5129927pjq.219.1604626967359;
        Thu, 05 Nov 2020 17:42:47 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id q84sm4207112pfq.144.2020.11.05.17.42.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:46 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 08/22] perf arm-spe: Refactor packet header parsing
Date:   Fri,  6 Nov 2020 09:41:22 +0800
Message-Id: <20201106014136.14103-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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
index 33baef0c2c0b..6608a73a7cbe 100644
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

