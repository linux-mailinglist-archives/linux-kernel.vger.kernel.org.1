Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4229A30B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444467AbgJ0DMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:12:02 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:33221 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443814AbgJ0DMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:12:01 -0400
Received: by mail-pj1-f48.google.com with SMTP id k8so112152pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2S0mOj32dSJ0rHgj2cZGve+B+fdp3orG+yrp5sDE9x4=;
        b=esU8WF7tSbNZHIQRr3glm2pEvYrh8qll9RAeuoQtI8dd9P0H6ug7k0PSkq0enBi4wh
         Yea7UkEIEGD7DWsH7yNmeLUlatBc2OUi8im6FIi5Xj3tocrFAXgo0J1zwaejsx4u+I8D
         B4Iot2QhfO9hoBFe25fXc40fsttCWYpfxtpYVOJOk3loRa29s48EXtDz+xIG8TPhHNgt
         pYpozj2fjUZfQGN9iCaI1MYgVvtvs+2HRFsmQf0QxsGtDS+XXNwSpvQUgI7e19tOhnGh
         SnYvIZLI9lh8uGDEC8cQxHlwl/HdCfQ+Aedx0gctBq+9r11eCJjiaZWFOBktkd42WtRt
         FNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2S0mOj32dSJ0rHgj2cZGve+B+fdp3orG+yrp5sDE9x4=;
        b=fPOtV2YqoBB6+GxW1iKbrRg+l7yZ+7hfQlmFC9aaxWTOBGGVTRT9fMRj2pZSjX+LiC
         NoyKNa3Q+R1eRFS5yS2PcMnMFr9gbEbKDItAbg7P9r/hF4n5CgM2YaSKB7OwXropx1hb
         LxkymIzLEIb8H+R6RvUEpzuCOljbnrBBgS8FIwsjih4OpA6xUbC/mp9sJXQ17FNxMiTx
         b9VmGF3oNQcZ05KIQg/ydqedFEDKFlotbDUc2xXHaEvIThe9qxDHQL1CgWnEkUJS753+
         730tMLTjUv+0C2a03KY+ZUYsGxIujEJKy/+x8vXkq0yVaxu1zScHDEPc1dR1ZDI4j7Ms
         nc7w==
X-Gm-Message-State: AOAM532Vbj61T5/I2vVug08SePLWt908hfCC68wllPvy1W9WbWraj9pZ
        Z37Hb6P97SKjKNS7ZLixlvJa8A==
X-Google-Smtp-Source: ABdhPJzbb1rk0tcfPyS1TCLn1arXgKD92QMNZ5Sjy/6X4ao3OJ77WTyKkahm93EDJ+NkZQD61jqfWg==
X-Received: by 2002:a17:90a:4f0f:: with SMTP id p15mr107924pjh.10.1603768320151;
        Mon, 26 Oct 2020 20:12:00 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 17sm10750pgv.58.2020.10.26.20.11.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:59 -0700 (PDT)
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
Subject: [PATCH v4 21/21] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Tue, 27 Oct 2020 11:09:17 +0800
Message-Id: <20201027030917.15404-22-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 72 ++++++++++++++++++-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 +++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 5195ec3b1ec4..40b12d6893f9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -332,6 +332,21 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		if (ret < 0)
 			return ret;
 	}
+	if (payload & BIT(EV_ALIGNMENT)) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " ALIGNMENT");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & BIT(EV_PARTIAL_PREDICATE)) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " SVE-PARTIAL-PRED");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & BIT(EV_EMPTY_PREDICATE)) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " SVE-EMPTY-PRED");
+		if (ret < 0)
+			return ret;
+	}
 
 	return buf_len - blen;
 }
@@ -345,8 +360,42 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 	switch (class) {
 	case SPE_OP_PKT_HDR_CLASS_OTHER:
-		return arm_spe_pkt_snprintf(&buf, &blen,
-			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+		if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload)) {
+
+			ret = arm_spe_pkt_snprintf(&buf, &blen, "SVE-OTHER");
+			if (ret < 0)
+				return ret;
+
+			/* SVE effective vector length */
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
+						   SPE_OP_PKG_SVE_EVL(payload));
+			if (ret < 0)
+				return ret;
+
+			if (payload & SPE_OP_PKT_SVE_FP) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " FP");
+				if (ret < 0)
+					return ret;
+			}
+			if (payload & SPE_OP_PKT_SVE_PRED) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
+				if (ret < 0)
+					return ret;
+			}
+		} else {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, "OTHER");
+			if (ret < 0)
+				return ret;
+
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " %s",
+					payload & SPE_OP_PKT_COND ?
+					"COND-SELECT" : "INSN-OTHER");
+			if (ret < 0)
+				return ret;
+		}
+
+		return buf_len - blen;
+
 	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		ret = arm_spe_pkt_snprintf(&buf, &blen,
 					   payload & SPE_OP_PKT_ST ? "ST" : "LD");
@@ -400,6 +449,25 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 			break;
 		}
 
+		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
+			/* SVE effective vector length */
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
+						   SPE_OP_PKG_SVE_EVL(payload));
+			if (ret < 0)
+				return ret;
+
+			if (payload & SPE_OP_PKT_SVE_PRED) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
+				if (ret < 0)
+					return ret;
+			}
+			if (payload & SPE_OP_PKT_SVE_SG) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " SG");
+				if (ret < 0)
+					return ret;
+			}
+		}
+
 		return buf_len - blen;
 
 	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
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

