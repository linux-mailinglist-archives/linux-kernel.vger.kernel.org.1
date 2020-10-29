Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7EC29E3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJ2HWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgJ2HVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3EBC0604C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so1591776pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=79MY1JSusPKl0vTlmTQFq3tCRLcr9Um1mANzV0pthDw=;
        b=bjbF343P/mhWg7WavdO/YpWozOqLSZ+HnsnrDs/xUSvgQD0woFqbE/0iu9R8f+hJGm
         zT2ZgXR5HFSU9i0IiaxrqUOjtYoke1Y0jgGc6VEW2ayem0sH9/nrpY+No53+q4+u6xpu
         BGtJxaOL3MwsINLJCE/Y6frsWELHPyUh1DhFlmESQbUc4HznwGlDefiLmd6BEs0jDbvb
         /yrkFOn3JcjYguGLNIX0JTJm6Xj35IUVy6XT5Een7m2u/ruD1KrP857pQjYZPKhHFwTZ
         aCz7SXRCDJAP3aheC+yq4OdnLgsi7Gko66nhbnj+Qnw6wzoVqNpKq/riilia3T7zJL65
         t8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=79MY1JSusPKl0vTlmTQFq3tCRLcr9Um1mANzV0pthDw=;
        b=IM0UbOI/wfotRxlLr1VMGy3WKrEStfjcR//38Li6faGPMZ+8xfuXkArxk+//fBLpdX
         iZbkICuaFhRz4Hm0b+F9+o4K+ZqwsTRwTXJoGxLp6j6vyTme8UN++UsicGsg51fPn72j
         fEF+BlMAVkGpBEzp7QguDB6PYAgrDSJa1XPCWOfbttR/cJJv7Q5wihytLOc+STW+Vjr1
         BxfpqyRIL9UKC0iaI0Da6bVwlZchWgoC2WRKq4UBu5OcxlwdbTE9Yvx9gErDyYICHm6z
         +JtoZDyWxD1xBsuwiyBzj5j6Rx68AtF+UMtyWx+E+hTtsfZBh6lDLy6ABcwmvgkg7cAy
         jIIA==
X-Gm-Message-State: AOAM530OFRqVL/c0L17htPhgkdJbR4S7mfe8JQRS50O7jRqAj19x0Cv0
        AjU6aeZnwg4UZwUnkro8xBGTQw==
X-Google-Smtp-Source: ABdhPJwUdf7/x0+kPVQiRXj+lOjfE5giyie0ExkMVsADA5vnfoPx6J9fUHmaCfEYeLkkrFFrcLs+Ww==
X-Received: by 2002:a65:684d:: with SMTP id q13mr2928931pgt.372.1603956082936;
        Thu, 29 Oct 2020 00:21:22 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id o22sm1475243pgb.83.2020.10.29.00.21.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:21:22 -0700 (PDT)
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
Subject: [PATCH v5 21/21] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Thu, 29 Oct 2020 15:19:27 +0800
Message-Id: <20201029071927.9308-22-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index 97a47ac3aa28..6c1d872caa81 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -300,6 +300,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
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
@@ -313,8 +319,26 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
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
@@ -345,6 +369,17 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
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

