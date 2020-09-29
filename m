Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFE27CF85
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgI2NlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgI2Nk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC6CC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so4846860wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qg6E+ZY7mc7HMqewHbZr6nsNHW56+9bl7Lgvfl8vi1s=;
        b=Q1pJ4LCJd0DPCBu0wzyyPwbl0tNeZjZhUa67XJontPCgzxOaWR4fpFDtsxOHy5Roih
         ZZMUIWLwWOkUHqIFNoS3qzzKsVBcLVKTkT9IinpeCMvd7gkkJlucd76l2S93gPs9UHPg
         fKIedDQmSjs0SPd00zQSKcqJAVrShvf0xcnrRlAb6knDuZVmrV+PQyzsLmcLCm3qqZzC
         tgRHlfNT20mfRks717D0YAnx+l/suFZTeA5+DiGzpvkRnq6Ol14XJjYDiP5ee3fpKKKC
         /ToWZb2mCxdhbDZ7L1ojOsrb+UCw2386mAsn/JRzVTjLBcCM5N0dYP3mcTmEUqhhjuqi
         WEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qg6E+ZY7mc7HMqewHbZr6nsNHW56+9bl7Lgvfl8vi1s=;
        b=YUV6Xv8XRcj0RAof9B2FgZoQqIttJUuX3hJ/QKmQ0C90jf2O3c77XTK9f3/oBwOXbK
         GboDvdRziUtGmZluSHDvVhmYwU3M04J15G8zj8Plaw76Yh4LPUGIqJEHR5b4bawBWLRQ
         i2HUZ53yNcppV19z2suLCoS1XYK55qiVzphtt9KbDCJTGnzR46a+LKT+T7k/Pv/oq5wB
         MAsHzjUsdVaPR3nXvY0zvB8JLUOyNzWGytqZL0D/5UdF1Sl6t24H9VUeFZsZiM4sbQbz
         qSrHUjKu7QXuDXABsg/Apa6jrOQzfT4pxTaoPAIcr8x3HRj7KonKL1DrwUUYslmRJu1V
         cdTA==
X-Gm-Message-State: AOAM533vjoBiiiM+utv7g1j4hopq3oD9Eo9szRLsfy6rWXm+omERpohv
        l8edkpPOmKaZtt4LJWpqymDbIg==
X-Google-Smtp-Source: ABdhPJx4H18083Osw6ri8Q4ZAFZKR7XzUpiY+iMipD/pxIj33MUTSH4AIym1zyp7C7Nh5oPkp1WTuw==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr4590669wme.96.1601386855744;
        Tue, 29 Sep 2020 06:40:55 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:55 -0700 (PDT)
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
Subject: [PATCH v2 07/14] perf arm-spe: Refactor address packet handling
Date:   Tue, 29 Sep 2020 14:39:10 +0100
Message-Id: <20200929133917.9224-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to refactor address packet handling, it defines macros for
address packet's header and payload, these macros are used by decoder
and the dump flow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 33 ++++++++++---------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 25 +++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 27 ++++++++++-----
 3 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index cc18a1e8c212..9d3de163d47c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -24,36 +24,37 @@
 
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
-	u8 *addr = (u8 *)&payload;
-	int ns, el;
+	u64 ns, el;
 
 	/* Instruction virtual address or Branch target address */
 	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
 	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH) {
-		ns = addr[7] & SPE_ADDR_PKT_NS;
-		el = (addr[7] & SPE_ADDR_PKT_EL_MASK) >> SPE_ADDR_PKT_EL_OFFSET;
+		ns = payload & SPE_ADDR_PKT_INST_VA_NS;
+		el = (payload & SPE_ADDR_PKT_INST_VA_EL_MASK)
+			>> SPE_ADDR_PKT_INST_VA_EL_SHIFT;
+
+		/* Clean highest byte */
+		payload &= SPE_ADDR_PKT_ADDR_MASK;
 
 		/* Fill highest byte for EL1 or EL2 (VHE) mode */
-		if (ns && (el == SPE_ADDR_PKT_EL1 || el == SPE_ADDR_PKT_EL2))
-			addr[7] = 0xff;
-		/* Clean highest byte for other cases */
-		else
-			addr[7] = 0x0;
+		if (ns && (el == SPE_ADDR_PKT_INST_VA_EL1 ||
+			   el == SPE_ADDR_PKT_INST_VA_EL2))
+			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
 
 	/* Data access virtual address */
 	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT) {
 
+		/* Clean tags */
+		payload &= SPE_ADDR_PKT_ADDR_MASK;
+
 		/* Fill highest byte if bits [48..55] is 0xff */
-		if (addr[6] == 0xff)
-			addr[7] = 0xff;
-		/* Otherwise, cleanup tags */
-		else
-			addr[7] = 0x0;
+		if ((payload >> 48) == 0xffULL)
+			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
 
 	/* Data access physical address */
 	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS) {
-		/* Cleanup byte 7 */
-		addr[7] = 0x0;
+		/* Clean highest byte */
+		payload &= SPE_ADDR_PKT_ADDR_MASK;
 	} else {
 		pr_err("unsupported address packet index: 0x%x\n", index);
 	}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index e738bd04f209..b51a2207e4a0 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -13,9 +13,6 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-#define NS_FLAG		BIT(63)
-#define EL_FLAG		(BIT(62) | BIT(61))
-
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define le16_to_cpu bswap_16
 #define le32_to_cpu bswap_32
@@ -166,9 +163,10 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_ADDRESS;
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = (((buf[0] & SPE_ADDR_PKT_HDR_EXT_INDEX_MASK) << 3) |
+				  (buf[1] & SPE_ADDR_PKT_HDR_INDEX_MASK));
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = buf[0] & SPE_ADDR_PKT_HDR_INDEX_MASK;
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -403,18 +401,21 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
 		switch (idx) {
-		case 0:
-		case 1: ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
+		case SPE_ADDR_PKT_HDR_INDEX_INS:
+		case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
+			ns = !!(packet->payload & SPE_ADDR_PKT_INST_VA_NS);
+			el = (packet->payload & SPE_ADDR_PKT_INST_VA_EL_MASK)
+				>> SPE_ADDR_PKT_INST_VA_EL_SHIFT;
+			payload &= SPE_ADDR_PKT_ADDR_MASK;
 			return arm_spe_pkt_snprintf(&buf, &blen,
 					"%s 0x%llx el%d ns=%d",
 				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:
+		case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
 			return arm_spe_pkt_snprintf(&buf, &blen,
 						    "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
+		case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
+			ns = !!(packet->payload & SPE_ADDR_PKT_INST_VA_NS);
+			payload &= SPE_ADDR_PKT_ADDR_MASK;
 			return arm_spe_pkt_snprintf(&buf, &blen,
 						    "PA 0x%llx ns=%d", payload, ns);
 		default:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index a30fe3c5ab67..88d2231c76da 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -61,19 +61,30 @@ struct arm_spe_pkt {
 #define SPE_HEADER_SZ_SHIFT		(4)
 #define SPE_HEADER_SZ_MASK		GENMASK_ULL(5, 4)
 
+/* Address packet header */
+#define SPE_ADDR_PKT_HDR_INDEX_MASK		GENMASK_ULL(2, 0)
 #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	(0x3)
 
-#define SPE_ADDR_PKT_NS				BIT(7)
-#define SPE_ADDR_PKT_CH				BIT(6)
-#define SPE_ADDR_PKT_EL_OFFSET			(5)
-#define SPE_ADDR_PKT_EL_MASK			(0x3 << SPE_ADDR_PKT_EL_OFFSET)
-#define SPE_ADDR_PKT_EL0			(0)
-#define SPE_ADDR_PKT_EL1			(1)
-#define SPE_ADDR_PKT_EL2			(2)
-#define SPE_ADDR_PKT_EL3			(3)
+#define SPE_ADDR_PKT_HDR_EXT_INDEX_MASK		GENMASK_ULL(1, 0)
+
+/* Address packet payload for data access physical address */
+#define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		(56)
+#define SPE_ADDR_PKT_ADDR_MASK			GENMASK_ULL(55, 0)
+
+#define SPE_ADDR_PKT_DATA_PA_NS			BIT(63)
+#define SPE_ADDR_PKT_DATA_PA_CH			BIT(62)
+
+/* Address packet payload for instrcution virtual address */
+#define SPE_ADDR_PKT_INST_VA_NS			BIT(63)
+#define SPE_ADDR_PKT_INST_VA_EL_SHIFT		(61)
+#define SPE_ADDR_PKT_INST_VA_EL_MASK		GENMASK_ULL(62, 61)
+#define SPE_ADDR_PKT_INST_VA_EL0		(0)
+#define SPE_ADDR_PKT_INST_VA_EL1		(1)
+#define SPE_ADDR_PKT_INST_VA_EL2		(2)
+#define SPE_ADDR_PKT_INST_VA_EL3		(3)
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
-- 
2.20.1

