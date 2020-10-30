Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4629FBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgJ3C7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgJ3C7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303B9C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 13so4039236pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WruBdHWAwiqr4fqsYs8hO1VO3BlPsnc0pRnP+G+sLik=;
        b=pldBddqvSO/c/03YGAtnx+4DWaf+01Xsjc9dA3cpbvgPvk2+htF+eoadfbUpSd0gvM
         9vToD7PJRC+7mg9eM+V5xKo/vgorX3XYKs5/tuFe4DVUDaeEmKUGwVfekg2DPjhGHx3L
         jkQ3FhxaQG8jMLD8HS4foP44QqZe4V3wCspWPXR3rlMRFYpyLVAGE0Um9MhN3VfWmF3G
         1inKYEvDLxtvNAPvOErMCi4muG/c4OuWe5PnAmXcZUL2qseHQTsWHUsLcor2slukT9KM
         snjh4NKKiqJozBjMM1CIXgXObUtqXX4WY2zP7ENOSPBFPBQcPZU1mlNJbiuCM6aWp0vZ
         WBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WruBdHWAwiqr4fqsYs8hO1VO3BlPsnc0pRnP+G+sLik=;
        b=PRz3iedgUKlW6zBDS6hoBWjGA1VkjB18Q4l8O9k2cs3kuqpffrFHSmtWX5d/zi4cYp
         cDMyiXnZk4Hgupok9wJ440BFYYx1sDwAN+z9GGcmg3Hek1i+NZv+xJE0wNVEbl8E/0tR
         Kh4SNw+N2hZrJ9c9zgGjIURYxmPxfxtbbZ0EtmHf72uz2lxK7kvvrnEJyEU4FfZtQi5N
         zoon0ivD4B+5JMMm7h9M04boB7F1pCCE7KMflO4F/VwGJXtxhLwmvLrzfpe67+r/NNWr
         /xDKUtSUVbYodJ+ODBJOY9gLohBuJIO0b9NJkE5dbcUJmKp5u37wKC6QhB3WDCYJ3BXd
         2wpw==
X-Gm-Message-State: AOAM530E4dC0aeB2jnKTp6PJPdr5Xc6I5ZXHy3pvMA9X39sRKEYdYU+m
        j3orRq1O0RJUSKUUCxLckdjiJQ==
X-Google-Smtp-Source: ABdhPJzlj5RkOsWyWbTmR/lQy+FZDKZ3GU3kWix48Cnkprm67SIi6sva6giwvCBZk3Xebz0su0q9RA==
X-Received: by 2002:a62:1c92:0:b029:15c:aff1:b16f with SMTP id c140-20020a621c920000b029015caff1b16fmr7438662pfc.0.1604026776682;
        Thu, 29 Oct 2020 19:59:36 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id kr14sm1228822pjb.26.2020.10.29.19.59.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:59:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 21/21] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Fri, 30 Oct 2020 10:57:24 +0800
Message-Id: <20201030025724.19157-22-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 39 ++++++++++++++++++-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 ++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 9ec3057de86f..52c4990885ae 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -304,6 +304,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
 	if (payload & BIT(EV_REMOTE_ACCESS))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
+	if (payload & BIT(EV_ALIGNMENT))
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " ALIGNMENT");
+	if (payload & BIT(EV_PARTIAL_PREDICATE))
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " SVE-PARTIAL-PRED");
+	if (payload & BIT(EV_EMPTY_PREDICATE))
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " SVE-EMPTY-PRED");
 
 	return err ?: (int)(buf_len - blen);
 }
@@ -317,8 +323,26 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 	switch (packet->index) {
 	case SPE_OP_PKT_HDR_CLASS_OTHER:
-		return arm_spe_pkt_snprintf(&err, &buf, &blen,
-			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+		if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload)) {
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "SVE-OTHER");
+
+			/* SVE effective vector length */
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " EVLEN %d",
+					     SPE_OP_PKG_SVE_EVL(payload));
+
+			if (payload & SPE_OP_PKT_SVE_FP)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " FP");
+			if (payload & SPE_OP_PKT_SVE_PRED)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " PRED");
+		} else {
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "OTHER");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " %s",
+					     payload & SPE_OP_PKT_COND ?
+					     "COND-SELECT" : "INSN-OTHER");
+		}
+
+		return err ?: (int)(buf_len - blen);
+
 	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		arm_spe_pkt_snprintf(&err, &buf, &blen,
 				     payload & 0x1 ? "ST" : "LD");
@@ -349,6 +373,17 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 			break;
 		}
 
+		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
+			/* SVE effective vector length */
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " EVLEN %d",
+					     SPE_OP_PKG_SVE_EVL(payload));
+
+			if (payload & SPE_OP_PKT_SVE_PRED)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " PRED");
+			if (payload & SPE_OP_PKT_SVE_SG)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " SG");
+		}
+
 		return err ?: (int)(buf_len - blen);
 
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

