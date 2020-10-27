Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3529A308
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443552AbgJ0DLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:47 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:44263 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443523AbgJ0DLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:46 -0400
Received: by mail-pl1-f171.google.com with SMTP id h2so9441pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SXOjaw+2AHW0LVReBaxxcNZltTA0C1+hbv7Vc25+MWs=;
        b=d01b8585GifNfFu/eYJDfrzigXA1fXoOqBignru7jmpNZHybC1+vOiqjw+r3fBQtug
         0A9opIKNk8MfYOdZafkVIv7+X6z2/JyUXakF3RG4kpkTKwIVwd2Vkao5tl47pZtdGDtL
         pyt98R2ZTdz6vQ/AC76iK46IdQJmRnjO78bFex2sgVe8RD386kHv2yZGk8gB+pFVw2AT
         pK1k3jVIyk92mp/uyFDePHY4D7UeW9exQRm2/An2GQMksO4bU8N2fmmCkb3X0JIckOvf
         ZEzdu1MhU1pGCcI7OgPn2U8OX+ImO3AsxfuOZNpXsLlPzo5Kyl+XvNGXw7H5Fitl9Ivt
         qVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SXOjaw+2AHW0LVReBaxxcNZltTA0C1+hbv7Vc25+MWs=;
        b=Tp/lhJeeHt1w/CCdYyYaZJfkQsgLTERAwCUBL5hyFVJGwQ7JMF1cCtecPgCPYzeSlV
         svOgQkvV0Z+u7mTHHBmjaxLIdEd4QK2cTzlUE9zFtQZs8bCtTPFPDB4lg4fBuB9oxgg7
         Q9Dqpznk7NERQ0GtT47UkTNQAtcynKm6sY3ZIqtT6VENXT8NYlMq/j/5tFX2+fCsAbP2
         iXqKZ3LpDfVg0VO++neb6DGjU8iD+o131ylJuQpu1N9pAqHt+iECxbX4px+UtgiUmDPe
         c2gOskJzjoyj7UhWD4R4KZ0HvCmVNh/SWW3RnCjAnLQKpzACm8bYlESVk1BQEFf3yExx
         JtKA==
X-Gm-Message-State: AOAM531lZt77IpsKFutvdaDZunpiN3wLi11FINuNw4LVwz+cK5Wx6zRR
        7qoL76Ac+7IfzT9KDHfx/MoB+A==
X-Google-Smtp-Source: ABdhPJyxVH6FruHtbJYWif9k1CUp7Tl6wHM8wyUulZ4g/C7tlsKMHtSSQX62SCiAWgE6vAkQZXa4ww==
X-Received: by 2002:a17:90a:8406:: with SMTP id j6mr77484pjn.37.1603768304114;
        Mon, 26 Oct 2020 20:11:44 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y137sm173166pfc.77.2020.10.26.20.11.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:43 -0700 (PDT)
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
Subject: [PATCH v4 18/21] perf arm-spe: Refactor operation packet handling
Date:   Tue, 27 Oct 2020 11:09:14 +0800
Message-Id: <20201027030917.15404-19-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macros for operation packet header and formats (support sub
classes for 'other', 'branch', 'load and store', etc).  Uses these
macros for operation packet decoding and dumping.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 32 ++++++++++---------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 23 +++++++++++++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 7c6a0caed976..e3b0d22743e8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -144,7 +144,7 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_OP_TYPE;
-	packet->index = buf[0] & 0x3;
+	packet->index = SPE_OP_PKT_HDR_CLASS(buf[0]);
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
@@ -339,37 +339,38 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				    char *buf, size_t buf_len)
 {
-	int ret, idx = packet->index;
+	int ret, class = packet->index;
 	unsigned long long payload = packet->payload;
 	size_t blen = buf_len;
 
-	switch (idx) {
-	case 0:
+	switch (class) {
+	case SPE_OP_PKT_HDR_CLASS_OTHER:
 		return arm_spe_pkt_snprintf(&buf, &blen,
-				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-	case 1:
+			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		ret = arm_spe_pkt_snprintf(&buf, &blen,
-					   payload & 0x1 ? "ST" : "LD");
+					   payload & SPE_OP_PKT_ST ? "ST" : "LD");
 		if (ret < 0)
 			return ret;
 
-		if (payload & 0x2) {
-			if (payload & 0x4) {
+		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
+			if (payload & SPE_OP_PKT_AT) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x8) {
+			if (payload & SPE_OP_PKT_EXCL) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x10) {
+			if (payload & SPE_OP_PKT_AR) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
 				if (ret < 0)
 					return ret;
 			}
-		} else if (payload & 0x4) {
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
 			if (ret < 0)
 				return ret;
@@ -377,17 +378,18 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 		return buf_len - blen;
 
-	case 2:
+	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
 		if (ret < 0)
 			return ret;
 
-		if (payload & 0x1) {
+		if (payload & SPE_OP_PKT_COND) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x2) {
+
+		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload)) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
 			if (ret < 0)
 				return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 42ed4e61ede2..7032fc141ad4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -105,6 +105,29 @@ enum arm_spe_events {
 	EV_EMPTY_PREDICATE	= 18,
 };
 
+/* Operation packet header */
+#define SPE_OP_PKT_HDR_CLASS(h)			((h) & GENMASK_ULL(1, 0))
+#define SPE_OP_PKT_HDR_CLASS_OTHER		0x0
+#define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
+#define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
+
+#define SPE_OP_PKT_COND				BIT(0)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
+#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
+#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
+#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	0x10
+#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	0x30
+
+#define SPE_OP_PKT_IS_LDST_ATOMIC(v)		(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
+
+#define SPE_OP_PKT_AR				BIT(4)
+#define SPE_OP_PKT_EXCL				BIT(3)
+#define SPE_OP_PKT_AT				BIT(2)
+#define SPE_OP_PKT_ST				BIT(0)
+
+#define SPE_OP_PKT_IS_INDIRECT_BRANCH(v)	(((v) & GENMASK_ULL(7, 1)) == 0x2)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

