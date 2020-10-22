Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C6296151
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368431AbgJVO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368377AbgJVO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308CFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so2844496wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rdtE/CTKuG22fgltDA/K3/fg/7WELrz8s5eFlNU3ExU=;
        b=EW1ldS7JdAsUl2FFSZeP38Zlr0dODHqayRa/WvgK82XrW7aMaNdhJJOq0YUgSuKKgC
         TXMsYylpp+pY3FSry1ZsvV5J2ud6syJL28fDD0fxrEJwy1zWdZgx7Yn+xvarTMmwmFRH
         GU/Qw7GPiKgwpDlfgQbSFKh6Q16nGW7vFTTvA/shXp0CUMsmkqfQ9mvPovziq/DVAPLP
         fAqlA5pWK9ApAUE+fYRikb4OQANI30yo+TUneE1CeiLw9+jiUGhKBYXO56t1biNtE8nc
         BsIAGxbhowNzsZaYuLzERblmf4MLB3W57BJENmOCSGheqHk1iN90NOzWh054pmGDc08k
         BHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rdtE/CTKuG22fgltDA/K3/fg/7WELrz8s5eFlNU3ExU=;
        b=gyVSwIouzxmiMIFkhK2DS5JR0r0f49j93I7BtO/GLmzZpitGPwv3FhhcIk4BQWUvL4
         LqMqFgcVDDOnpuiYL2XCCX/mPfIf/+aVZNuzHuaZGDg8+KSOzTY8r97wKXUvItbotLz3
         LUMU//aK0yueZhqU5LXLmpKMf0rTxLilKYdQx1jsbzOFHJSVGbds1aua3eGZExDclmAj
         SNVuPp9OxNTh9ANxehXxSjMKpPc9OYemfnmeYi7Vjumhkz6hC4CGdYKjZUa2c9HwSk+X
         Cw+Uq6ms/aXgCZUyCAnmJync6ewYVhVJYT44aH0u+WiHSXF04e0tP/Eo48yfWmGZNpl7
         s2Dg==
X-Gm-Message-State: AOAM532UiWwtpqF+qYJarkZPHtzcSg6EFMFGCrN+M//j0E5McQHIaJgT
        Ffc/m5av/SsFGC3bzixBErNUww==
X-Google-Smtp-Source: ABdhPJz5IHOIpvegF1ePbRIeTlNQL0jQjt4t/1vAg4vQAOx/j1apGiymOCAZDVVtCNCTTbcnnnTr/Q==
X-Received: by 2002:adf:f104:: with SMTP id r4mr3208315wro.202.1603378734868;
        Thu, 22 Oct 2020 07:58:54 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:54 -0700 (PDT)
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
Subject: [PATCH v3 20/20] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Thu, 22 Oct 2020 15:58:16 +0100
Message-Id: <20201022145816.14069-21-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 74 ++++++++++++++++++-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 74ac12cbec69..6da4cfbc9914 100644
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
@@ -345,8 +360,43 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 	switch (class) {
 	case SPE_OP_PKT_HDR_CLASS_OTHER:
-		return arm_spe_pkt_snprintf(&buf, &blen,
-			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+		if (SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP_GET(payload) ==
+				SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP) {
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
@@ -401,6 +451,26 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 			break;
 		}
 
+		if (SPE_OP_PKT_LDST_SUBCLASS_SVE_GET(payload) ==
+				SPE_OP_PKT_LDST_SUBCLASS_SVE) {
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
index d69af0d618ea..04bc09f3ea17 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -118,6 +118,9 @@ enum arm_spe_events {
 #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
 #define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
 
+#define SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP_GET(v)	((v) & (BIT(7) | BIT(3) | BIT(0)))
+#define SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP	0x8
+
 #define SPE_OP_PKT_COND				BIT(0)
 
 #define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
@@ -134,6 +137,21 @@ enum arm_spe_events {
 #define SPE_OP_PKT_AT				BIT(2)
 #define SPE_OP_PKT_ST				BIT(0)
 
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE_GET(v)	((v) & (GENMASK_ULL(3, 3) | GENMASK_ULL(1, 1)))
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE		0x8
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
 #define SPE_OP_PKT_BRANCH_SUBCLASS_GET(v)	((v) & GENMASK_ULL(7, 1))
 #define SPE_OP_PKT_BRANCH_SUBCLASS_DIRECT	0x0
 #define SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT	0x2
-- 
2.17.1

