Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D832A8C39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbgKFBnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbgKFBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:00 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:00 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o129so2869169pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7VIsKd/U+74ddmtweKDOkwqEGtwIyY4KgrsGwOxsOzY=;
        b=X92uB4V0+cGYieih9eIt+2JZxT09gE6XemX9Tk1ui38Om4Y4ssPX7KzChWHhN75o78
         SdFNeUqTRT9Cqn9XvqTaUaHfAjyOzDwqVvAveDDWPvgQ9lN/31e+9vq+bTmTTEhlNB9h
         rwg4dcRh7O54PvIWggiJTG23GVCDyKo8f04vmtfbX7bSGiKzJBHgPnIlFRsZJxcVM94P
         n5XHsQntL1gW/TUjPYmjrBGNUP0R3OlKI5RlYRTWJ5vqahnE1RZf5ayHT4ifYeWbslvg
         tYNlhfy4dAcAsCGYlaheY91CB0SglcBuGQQelzyH6GRf0EB8tCIcF9b6ZILrWvXbosE0
         fexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7VIsKd/U+74ddmtweKDOkwqEGtwIyY4KgrsGwOxsOzY=;
        b=Y6mRc7LIaaegd8dcrm5OUoG1R2BY0nf6p4/QJlpIVSHTDtahviCBmaBD1QoxnNTiC2
         Lyqe6iCsyVx1cFG+cgECptUSHBe2DDgBxzT+A+fMQf7L2sBo9vWc0meeExB9dVhLu7jC
         iwDUN8JBSFgblGRvJuOac9EFVnFK2rMRN21S255Cicap5wMzMvPM2JAIIpi7JoAYwjSy
         tNjCSL/ojf64t7P8h89khOQiOii40birM/HYQqOitPsNLLLXgry+nygHTTqXR4KlHJbn
         Fq7V20hdZKlbdrGNOwJ41khvQFd1iKggJeMto+GoIe4yEzbJu+rvYN+hPRlPUZ4KECpo
         VKxg==
X-Gm-Message-State: AOAM5312Wjk/9crbw/pDJ8oKsaOD5t1u4pD1hnvaQVoXS/NxjNoAoMmE
        yM0FszABWYgjU8P+vYd6FPfn0Q==
X-Google-Smtp-Source: ABdhPJy8/dOHc89QQS/XFZsVYoDVHz8Hq1UBNgMmWgXnmIHgrRKqtmwLDXS9kyurzlTQ0INWYKL3vA==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr4808788pgb.165.1604626979938;
        Thu, 05 Nov 2020 17:42:59 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id c9sm4175811pfc.197.2020.11.05.17.42.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:59 -0800 (PST)
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
Subject: [PATCH v7 10/22] perf arm-spe: Refactor address packet handling
Date:   Fri,  6 Nov 2020 09:41:24 +0800
Message-Id: <20201106014136.14103-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to refactor address packet handling, it defines macros for
address packet's header and payload, these macros are used by decoder
and the dump flow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 29 ++++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 +++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 35 ++++++++++++-------
 3 files changed, 48 insertions(+), 42 deletions(-)

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
index 81f19966643d..ab02fc424938 100644
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
+		packet->index = SPE_HDR_EXTENDED_INDEX(buf[0], buf[1]);
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = SPE_HDR_SHORT_INDEX(buf[0]);
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -296,22 +294,22 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	int err = 0;
 
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
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
 				"%s 0x%llx el%d ns=%d",
 				(idx == 1) ? "TGT" : "PC", payload, el, ns);
 		break;
-	case 2:
+	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
 				     "VA 0x%llx", payload);
 		break;
-	case 3:
-		ns = !!(packet->payload & NS_FLAG);
-		payload &= ~(0xffULL << 56);
+	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
+		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
 				     "PA 0x%llx ns=%d", payload, ns);
 		break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 129f43405eb1..f97d6840be3a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -56,19 +56,28 @@ struct arm_spe_pkt {
 #define SPE_HEADER0_COUNTER			0x98
 #define SPE_HEADER1_ALIGNMENT			0x0
 
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
+#define SPE_HDR_SHORT_INDEX(h)			((h) & GENMASK_ULL(2, 0))
+#define SPE_HDR_EXTENDED_INDEX(h0, h1)		(((h0) & GENMASK_ULL(1, 0)) << 3 | \
+						 SPE_HDR_SHORT_INDEX(h1))
+
+/* Address packet header */
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
+#define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT_ULL(63)) >> 63)
+#define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
+
+#define SPE_ADDR_PKT_EL0			0
+#define SPE_ADDR_PKT_EL1			1
+#define SPE_ADDR_PKT_EL2			2
+#define SPE_ADDR_PKT_EL3			3
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
-- 
2.17.1

