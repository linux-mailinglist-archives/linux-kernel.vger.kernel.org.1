Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549DB2A8C47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgKFBoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKFBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:44:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A233AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:44:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i26so2700062pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pYa/npzkxFmRSZ5LTLij8d+0Umk6ois4pnm4vkUzXU=;
        b=BIYvOHxSTN/OKJq5xzyKk6Uyfh0N5tEULAszHIo9LOeueYCk4WhXHFHgay9P4ow83Z
         hnP7FG2Z4Wn/Eq5f/upJNkB8SIpdwwlHVK5ynfpHgZoio2bJHoe7OZDAScMdADeHJJ/z
         IQ5jtWSCu2DWaHalnYdNSgYklVOTMPtrReZRI3hs89IKo/sV3j7iflkdgHpFZJ+tlLfd
         iSQHQ8hPDL+4z2uOjbPxfZzpsPJ4ypjsd3iIW+0kh3nmefY6Xp5p25kV9RyX1K18et6n
         0outVedpqo4BicCav7aME7ZBQ4efCfzrh2HePvaynRNv8cVR5xfx0iFE04WXVD6mGTo9
         95Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pYa/npzkxFmRSZ5LTLij8d+0Umk6ois4pnm4vkUzXU=;
        b=nMH1Di1jioyWPlDJR2rq+lrOwVDPZW9VZrOvsgv2kMcOjPPjUCCl8EqEBwHUyWGqUg
         XKDyMIBbmM/3GOEXdhppeJ1feiBmj7DpFQ7xKM8C2voJ4kOPOQnJPMBmcG5Dpur2QnUl
         lJt4eSCGlrm2Kan2SSkuNG5lD5Km5/Dyb2xAgphquUKnaaxjKX4H4zRA15hNMh6A63qs
         txAenASEbNge43CstfGuNmVKEpnh5H0r9RU1VW45SqoF50Ul3bC43vvjFO6D5h5H1wFY
         TDEx1sHq5koaQ0GT8cBO9WxjJ6LX+KFbsuKQ7xiWf6w/MSwyR/saKpU8ch8As/oXgjxA
         5QvQ==
X-Gm-Message-State: AOAM53207oL/rVnZVAEg83sHpYiq6tFP3HnSsqOom//YMdvb/i8OxLPe
        s8Yx2iZlv5xvGSe46XW+Xg0EJw==
X-Google-Smtp-Source: ABdhPJweQ3/8FobLAaphv5PhpABj2Q2lrbNIUqWjOOARki2xjCsKgHPqYXdtctob9uXWjahZpqlNMg==
X-Received: by 2002:a63:b5f:: with SMTP id a31mr4844101pgl.197.1604627056221;
        Thu, 05 Nov 2020 17:44:16 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id b16sm3891110pju.16.2020.11.05.17.44.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:44:15 -0800 (PST)
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
Subject: [PATCH v7 22/22] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Fri,  6 Nov 2020 09:41:36 +0800
Message-Id: <20201106014136.14103-23-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

This patch is to support Armv8.3 extension for SPE, it adds alignment
field in the Events packet and it supports the Scalable Vector Extension
(SVE) for Operation packet and Events packet with two additions:

  - The vector length for SVE operations in the Operation Type packet;
  - The incomplete predicate and empty predicate fields in the Events
    packet.

Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 36 +++++++++++++++++--
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 +++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4744048478ca..7b77b9bc1f08 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -317,6 +317,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-REFILL");
 	if (payload & BIT(EV_REMOTE_ACCESS))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " REMOTE-ACCESS");
+	if (payload & BIT(EV_ALIGNMENT))
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " ALIGNMENT");
+	if (payload & BIT(EV_PARTIAL_PREDICATE))
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
+	if (payload & BIT(EV_EMPTY_PREDICATE))
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
 
 	return err;
 }
@@ -329,8 +335,23 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 	switch (packet->index) {
 	case SPE_OP_PKT_HDR_CLASS_OTHER:
-		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
-			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+		if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload)) {
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, "SVE-OTHER");
+
+			/* SVE effective vector length */
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EVLEN %d",
+					     SPE_OP_PKG_SVE_EVL(payload));
+
+			if (payload & SPE_OP_PKT_SVE_FP)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " FP");
+			if (payload & SPE_OP_PKT_SVE_PRED)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " PRED");
+		} else {
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, "OTHER");
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " %s",
+					     payload & SPE_OP_PKT_COND ?
+					     "COND-SELECT" : "INSN-OTHER");
+		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
@@ -361,6 +382,17 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 		default:
 			break;
 		}
+
+		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
+			/* SVE effective vector length */
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EVLEN %d",
+					     SPE_OP_PKG_SVE_EVL(payload));
+
+			if (payload & SPE_OP_PKT_SVE_PRED)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " PRED");
+			if (payload & SPE_OP_PKT_SVE_SG)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SG");
+		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "B");
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 1ad14885c2a1..9b970e7bf1e2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -113,6 +113,8 @@ enum arm_spe_events {
 #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
 #define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
 
+#define SPE_OP_PKT_IS_OTHER_SVE_OP(v)		(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
+
 #define SPE_OP_PKT_COND				BIT(0)
 
 #define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
@@ -128,6 +130,20 @@ enum arm_spe_events {
 #define SPE_OP_PKT_AT				BIT(2)
 #define SPE_OP_PKT_ST				BIT(0)
 
+#define SPE_OP_PKT_IS_LDST_SVE(v)		(((v) & (BIT(3) | BIT(1))) == 0x8)
+
+#define SPE_OP_PKT_SVE_SG			BIT(7)
+/*
+ * SVE effective vector length (EVL) is stored in byte 0 bits [6:4];
+ * the length is rounded up to a power of two and use 32 as one step,
+ * so EVL calculation is:
+ *
+ *   32 * (2 ^ bits [6:4]) = 32 << (bits [6:4])
+ */
+#define SPE_OP_PKG_SVE_EVL(v)			(32 << (((v) & GENMASK_ULL(6, 4)) >> 4))
+#define SPE_OP_PKT_SVE_PRED			BIT(2)
+#define SPE_OP_PKT_SVE_FP			BIT(1)
+
 #define SPE_OP_PKT_IS_INDIRECT_BRANCH(v)	(((v) & GENMASK_ULL(7, 1)) == 0x2)
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
-- 
2.17.1

