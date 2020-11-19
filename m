Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7C2B962E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgKSP0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgKSPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:59 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFFFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:58 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w14so4809752pfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+xcIkPaY2Uh+7Kl1sCcJhB1bqk9+hZ74A/aurRuPm88=;
        b=tSQ586OY0IIHNa5E2RluJVsYAZ2UbAZA3ERxFpV2kE1JVs9v/eKNHaoiNvKeboz1Jr
         LURClOVClokAmdYL3hNgqV1f1i9SdVqYGTLOio+I+HXZjHB1JOpHNZV6r0ntWumZajOb
         n9tI05e0PHTuxqqn7CeyfJYm+CQDLnG+dIMZw29xs7pBd+odTVT8XPXnOzjiSe8O1ALv
         pXt3XmCSO76F0lYxzaxPZhBSbofLUkatbVo/zA8zsVF9tSxu1LlDUHPRYMGxi8VoEtxU
         cgly28vejkNznc++ot/A2mDHcClMASEsM1jYoRPfFu2yMMmnZ1CjTF9YuK5n1NUxKwLe
         ubgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+xcIkPaY2Uh+7Kl1sCcJhB1bqk9+hZ74A/aurRuPm88=;
        b=OfC3A1Q+ku835Tpq248hxNDKzuYBk0nlsfDlvfzUkXwTn1AWkPJGW1Z5loh/arpLPL
         J3TkLs8eW5hC48wM8TfWkrzvEu1PkePLM6ucf22vHejJ7gqnIg8ukdM8ONXuDy0k6cOK
         OGrSEHR27qGcICMg5b0b/T/VC9ab7M6lfOyCge8ptScOrBEkHBljIdN8/uNHRf2sNwW0
         WxGWe3sjxr0ecbbHRT84F4Iod0xJOhgz58cfvMmqO3eBuHQYP9waLjd6zZWH46ezh5KK
         4BL+eRLLSP5WM+dFo9W3e1htuI2z6Uh4CWWo3Es07XOaC9SHhe/1/RRTCxt/mHtJY7Fu
         f6+g==
X-Gm-Message-State: AOAM532rzgfqPyckJNBWr0fa1tRPbQWxwpzfPfsCTc67284wldRQ9i81
        rgh4fEpgVP4Vrdu1+T2UrsT9kQ==
X-Google-Smtp-Source: ABdhPJxbLgJtHuTR08KXRzG3oLunFlYNB2WxxhXuH1HI45+kXErqbVQvGNMREOXI2NHvY3MJDhPbcg==
X-Received: by 2002:a63:6585:: with SMTP id z127mr13773044pgb.210.1605799558409;
        Thu, 19 Nov 2020 07:25:58 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id e10sm107640pfl.162.2020.11.19.07.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:57 -0800 (PST)
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
Subject: [PATCH v9 16/16] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Thu, 19 Nov 2020 23:24:41 +0800
Message-Id: <20201119152441.6972-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 57c01ce27915..f3ac9d40cebf 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -317,6 +317,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
 	if (payload & BIT(EV_REMOTE_ACCESS))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
+	if (payload & BIT(EV_ALIGNMENT))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " ALIGNMENT");
+	if (payload & BIT(EV_PARTIAL_PREDICATE))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
+	if (payload & BIT(EV_EMPTY_PREDICATE))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
 
 	return err;
 }
@@ -329,8 +335,23 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 	switch (packet->index) {
 	case SPE_OP_PKT_HDR_CLASS_OTHER:
-		arm_spe_pkt_out_string(&err, &buf, &buf_len,
-			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+		if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload)) {
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, "SVE-OTHER");
+
+			/* SVE effective vector length */
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " EVLEN %d",
+					       SPE_OP_PKG_SVE_EVL(payload));
+
+			if (payload & SPE_OP_PKT_SVE_FP)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
+			if (payload & SPE_OP_PKT_SVE_PRED)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
+		} else {
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, "OTHER");
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " %s",
+					       payload & SPE_OP_PKT_COND ?
+					       "COND-SELECT" : "INSN-OTHER");
+		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
@@ -361,6 +382,17 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 		default:
 			break;
 		}
+
+		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
+			/* SVE effective vector length */
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " EVLEN %d",
+					       SPE_OP_PKG_SVE_EVL(payload));
+
+			if (payload & SPE_OP_PKT_SVE_PRED)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
+			if (payload & SPE_OP_PKT_SVE_SG)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " SG");
+		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, "B");
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

