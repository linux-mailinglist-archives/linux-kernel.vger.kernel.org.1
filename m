Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D482929E3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJ2HUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJ2HUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDBC08EBB0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so1614255pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vpMWF1LcelbPSwCkWIapS1LgNwyt/oalvr9yuSvLLgY=;
        b=Mc2HieT/fVxcZR519vqi9wFlvITSfJiZIiHOYoaGcY/ZBvxGMXfwFLgbTDXg4wnnmu
         m52/FbgTuhMGaK0H/ubw+HymLU6WQ4J8cKTlsQOnhL/drOBlADxPhB7LGZ03MUP9h2Xx
         WrQTC6CR33o6rZXRYD0Cc9cQJ7EH9joYKOjOzvIsPALpodSUU4V+0Cv3cdZ/gDubaYxm
         X4N51etpxCbDDkvVeIHcJDyT3XICFfD/SCVLlOpiD+WNncE6bP6Cc99Jr8NNFmIBRqNo
         8ALNe/+Xvy6lTbdglWvxUlOABMuJ2FL0vQDBBp6xEQfgMDQnFjhme+ufifuhRgzgsjB+
         Lrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vpMWF1LcelbPSwCkWIapS1LgNwyt/oalvr9yuSvLLgY=;
        b=Zr4JwrhMsVFu/6hcU+N1O2MxKQzwJwZIp7lNkaQK/JmRyUPWaWmVWCviAfaxMlj65K
         yQnI5oNzV2RJkTza3PNPtQwwpvmUsaUYtmaYv3Ih5myNKI5mhNyzTZhDyEasbbDdSjhk
         HicOt49zZzyVqHv1N3oE5FOSuO8WlcuSGX9qiif+FgC88jAKhVrE39ZmVIB8fwqREl8W
         VcG2KaTelQfTRVDYmkBj1j+DJW8nhTlGUMw/eSeWJQbTKj1/7I7P701Eald4hzP8BgpK
         N8SNm5/iWLyL6vg35Qavsx9/SIqCxWYUDTierzJ1UfpJsXqvyTOaRY8USsb+tA/M+JtP
         tIEA==
X-Gm-Message-State: AOAM5338ApKa4Zaw1UrR/loiwUxwBfzxYPUtKirt5fObnanpEVwFSokt
        ae4BfQ/0a4iwT7kYHbZktkfWUA==
X-Google-Smtp-Source: ABdhPJynrUuaoVo873fViAx1/fyaFYIeHoAOK/Mw+ekqnh4vlkQkGfAq60RaeWj3GAcZ66DU6MPx/Q==
X-Received: by 2002:a62:aa0f:0:b029:162:ecc2:4d44 with SMTP id e15-20020a62aa0f0000b0290162ecc24d44mr2959009pff.52.1603956014198;
        Thu, 29 Oct 2020 00:20:14 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id bx24sm1722134pjb.20.2020.10.29.00.20.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 07/21] perf arm-spe: Refactor packet header parsing
Date:   Thu, 29 Oct 2020 15:19:13 +0800
Message-Id: <20201029071927.9308-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index 9147b88ae00c..34cc46385cf7 100644
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

