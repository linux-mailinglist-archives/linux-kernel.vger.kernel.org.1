Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E665D296157
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368474AbgJVO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368358AbgJVO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA98C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so2634078wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9Bv9lw9NiVbXoo9ljxEx0wpEY0C+7aQGjva8G/Yfs8=;
        b=JsT7Qs0EaT3iaSu8N1QjDiFh6jwfq8hhGSEuKkj4wBH/tZ/E5KNlYGmZ4c2Hwua3o9
         PNpUu7vN9iosMPnLkX/Ya5M3UGctrKFgUUyyDEjAe5eDKKD7gCAvhcf4NM3ONRNFKgYg
         FpcLtJm2m/rlbtlZQc3/Os1+AKxPN6brBAkQx/NJJdO2JwSPpcJTFEPzg5qvqmRpb6gw
         79msR9E5g+4dvdg1zJHNDBD8E1PTjLuMW3IZCo7pGzqH8OS9WuFiW2H49FFQ6FjTR3Pq
         Ls7r7k5bZAi1OXvMcYyUMygfEmmnKCfiChC8pA6TJSBKmJPzDK5q7vyAxA5qLDGDMkG2
         /8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9Bv9lw9NiVbXoo9ljxEx0wpEY0C+7aQGjva8G/Yfs8=;
        b=IfJpeTLwbxmJAe2WE32/ImQrZt291voFnLQEJvg+3usMC/MmLntxhxtQ8fVdz5LTYj
         tYj1Wf87ety43I0hxin/5pVyesvSOqVVrPSnN+Fy5jKcsojRR5yAb6m3T1dRUSpr8h6t
         LKRzrrLhsL3vnDsaBSKw9oenB0Xs3hFdr2ZL9Xjd1n1a2+AtNwWte4/1zyOCVsuABm5X
         hG3zNOC2Pp6VJcJHkRBAc9D45+lnf4f0bxMgOJylOXYXu9VqB/ht8pmV9J6zzDEDKQj3
         WHYYhURn+2bfmJh2umRTZCH9iLDpPehuO0tizCScpuNwVcYz6EleCDT+RhkjlZET9Sli
         jeVA==
X-Gm-Message-State: AOAM533TuSQ1U3c7EYrpl6axEqpSyRLnBKqDNRA9TA4bJOUE6DmDB8kl
        UIUZncnnBR1ojNjYHbtmN/ITlA==
X-Google-Smtp-Source: ABdhPJxt2NJmTiOh3mtur05kYwud/lRMFzYH2yQX9YdqgjJsaTuVZ3CPX4fRp26tGOPfNhAJW+gicA==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr2903098wmr.179.1603378720504;
        Thu, 22 Oct 2020 07:58:40 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:39 -0700 (PDT)
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
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 09/20] perf arm-spe: Refactor address packet handling
Date:   Thu, 22 Oct 2020 15:58:05 +0100
Message-Id: <20201022145816.14069-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to refactor address packet handling, it defines macros for
address packet's header and payload, these macros are used by decoder
and the dump flow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 29 ++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 +++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 34 ++++++++++++-------
 3 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index cc18a1e8c212..776b3e6628bb 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -24,36 +24,35 @@
 
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
+		ns = SPE_ADDR_PKT_GET_NS(payload);
+		el = SPE_ADDR_PKT_GET_EL(payload);
+
+		/* Clean highest byte */
+		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 
 		/* Fill highest byte for EL1 or EL2 (VHE) mode */
 		if (ns && (el == SPE_ADDR_PKT_EL1 || el == SPE_ADDR_PKT_EL2))
-			addr[7] = 0xff;
-		/* Clean highest byte for other cases */
-		else
-			addr[7] = 0x0;
+			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
 
 	/* Data access virtual address */
 	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT) {
 
+		/* Clean tags */
+		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
+
 		/* Fill highest byte if bits [48..55] is 0xff */
-		if (addr[6] == 0xff)
-			addr[7] = 0xff;
-		/* Otherwise, cleanup tags */
-		else
-			addr[7] = 0x0;
+		if (SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload) == 0xffULL)
+			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
 
 	/* Data access physical address */
 	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS) {
-		/* Cleanup byte 7 */
-		addr[7] = 0x0;
+		/* Clean highest byte */
+		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 	} else {
 		pr_err("unsupported address packet index: 0x%x\n", index);
 	}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 550cd7648c73..156f98d6b8b2 100644
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
@@ -167,10 +164,11 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
 			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_ADDRESS;
+
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = SPE_ADDR_PKT_HDR_EXTENDED_INDEX(buf[0], buf[1]);
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = SPE_ADDR_PKT_HDR_SHORT_INDEX(buf[0]);
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -274,20 +272,20 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	u64 payload = packet->payload;
 
 	switch (idx) {
-	case 0:
-	case 1:
-		ns = !!(packet->payload & NS_FLAG);
-		el = (packet->payload & EL_FLAG) >> 61;
-		payload &= ~(0xffULL << 56);
+	case SPE_ADDR_PKT_HDR_INDEX_INS:
+	case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
+		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		el = SPE_ADDR_PKT_GET_EL(payload);
+		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		return arm_spe_pkt_snprintf(&buf, &buf_len,
 				"%s 0x%llx el%d ns=%d",
 				(idx == 1) ? "TGT" : "PC", payload, el, ns);
-	case 2:
+	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
 		return arm_spe_pkt_snprintf(&buf, &buf_len,
 					    "VA 0x%llx", payload);
-	case 3:
-		ns = !!(packet->payload & NS_FLAG);
-		payload &= ~(0xffULL << 56);
+	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
+		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		return arm_spe_pkt_snprintf(&buf, &buf_len,
 					    "PA 0x%llx ns=%d", payload, ns);
 	default:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 68552ff8a8f7..4111550d2bde 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -59,19 +59,27 @@ struct arm_spe_pkt {
 
 #define SPE_HEADER_SZ(val)			((val & GENMASK_ULL(5, 4)) >> 4)
 
-#define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
-#define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
-#define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
-#define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	(0x3)
-
-#define SPE_ADDR_PKT_NS				BIT(7)
-#define SPE_ADDR_PKT_CH				BIT(6)
-#define SPE_ADDR_PKT_EL_OFFSET			(5)
-#define SPE_ADDR_PKT_EL_MASK			(0x3 << SPE_ADDR_PKT_EL_OFFSET)
-#define SPE_ADDR_PKT_EL0			(0)
-#define SPE_ADDR_PKT_EL1			(1)
-#define SPE_ADDR_PKT_EL2			(2)
-#define SPE_ADDR_PKT_EL3			(3)
+/* Address packet header */
+#define SPE_ADDR_PKT_HDR_SHORT_INDEX(h)		((h) & GENMASK_ULL(2, 0))
+#define SPE_ADDR_PKT_HDR_EXTENDED_INDEX(h0, h1)	(((h0) & GENMASK_ULL(1, 0)) << 3 | \
+						 SPE_ADDR_PKT_HDR_SHORT_INDEX(h1))
+#define SPE_ADDR_PKT_HDR_INDEX_INS		0x0
+#define SPE_ADDR_PKT_HDR_INDEX_BRANCH		0x1
+#define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	0x2
+#define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	0x3
+
+/* Address packet payload */
+#define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		56
+#define SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(v)	((v) & GENMASK_ULL(55, 0))
+#define SPE_ADDR_PKT_ADDR_GET_BYTE_6(v)		(((v) & GENMASK_ULL(55, 48)) >> 48)
+
+#define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT(63)) >> 63)
+#define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
+
+#define SPE_ADDR_PKT_EL0			0
+#define SPE_ADDR_PKT_EL1			1
+#define SPE_ADDR_PKT_EL2			2
+#define SPE_ADDR_PKT_EL3			3
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
-- 
2.17.1

