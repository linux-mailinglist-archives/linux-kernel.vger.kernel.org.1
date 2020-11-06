Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74ED2A8C44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgKFBn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgKFBn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86062C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:56 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f38so2711245pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WJjE2UBzv1cPnx48XD6/Bs/FSlDkJjZbJmagVZX39Ic=;
        b=PsHFl9uhnkaobeoo6Hrd2jBGa5m0gdX5ezjjQSiVQCE0YBQGyldvULiBDieH7rycI6
         DhWRYBqn9wawW2zsDLw8olh62PJrauaNvUGCnrOn6HLnE2sTW/EGZ/ozFgjzFVf5ihvV
         fDorGPqwiQ5ML1Lnyz1ZUn6n2VTKWglPWznyr69J+zZStJl4JbP7YIKPI9Z9MKNTk4i0
         1X6zQaeIC7JUNdple0XAuMWw996Z+v9yeXZFETBG8DGj7r9qW9EoHQAH7jZk63sN8/6x
         rtLma+4cMrAMvedVaU7ETSLibC+HARAFw5hCkj1oVFuCwQZYjbV+szQ8uwlzMpHMjkCA
         b1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WJjE2UBzv1cPnx48XD6/Bs/FSlDkJjZbJmagVZX39Ic=;
        b=N6ZB/JYgU8H0RYHg2SM6eREDLkPLppqasjYKAl7hGQIpgl4r2ItbiERBgYdvbRNOGX
         vGYRjzYjSUhJNQOSuC9Ugk3OjgzvQpiQUkIJ7QVkrIVp7snVDoRheuYqO5bsOHQ19mex
         KsUZyg9Z5KPfB5yLN4iZVC5eOuTdfEjBlNlFuJ4Lpi9LbEG7UhxTIoaJq3XRK73VvnV9
         9Fl/XpoI3N5lwrr9CXQJYBbUsl11LV4LcFierQx9l6HKKAe9TQOoouHh/+iqTKkC8K8a
         qMjtsRNNonvMpHBk1c6aWKRiIIAkdRuZvYu9LqCiFDuezwb94TIx3Vdhz4MaIpZmQGCa
         ESlw==
X-Gm-Message-State: AOAM532NoIg124y3s6IvIupZnctQmFgmhPh05X+8VwqRx7G/UU4AcheJ
        aSVLsEq9t10dVOWRwNM4Kz8Dgw==
X-Google-Smtp-Source: ABdhPJzMeX+OswgD1jqXge8wcRUy4ttAVetLnJSudsZia/j0Oq4p6BM3RhXETxxL2ETZG9MM2b3/dQ==
X-Received: by 2002:a63:540d:: with SMTP id i13mr5054883pgb.37.1604627036054;
        Thu, 05 Nov 2020 17:43:56 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id b6sm3764088pjq.42.2020.11.05.17.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:55 -0800 (PST)
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
Subject: [PATCH v7 19/22] perf arm-spe: Refactor operation packet handling
Date:   Fri,  6 Nov 2020 09:41:33 +0800
Message-Id: <20201106014136.14103-20-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macros for operation packet header and formats (support sub
classes for 'other', 'branch', 'load and store', etc).  Uses these
macros for operation packet decoding and dumping.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 ++++++++++---------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 23 ++++++++++++++++
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a8027819018a..ea0bbf7c5aa1 100644
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
 
@@ -328,31 +328,33 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 	int err = 0;
 
 	switch (packet->index) {
-	case 0:
+	case SPE_OP_PKT_HDR_CLASS_OTHER:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
-				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
 		break;
-	case 1:
+	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
 				     payload & 0x1 ? "ST" : "LD");
 
-		if (payload & 0x2) {
-			if (payload & 0x4)
+		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
+			if (payload & SPE_OP_PKT_AT)
 				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AT");
-			if (payload & 0x8)
+			if (payload & SPE_OP_PKT_EXCL)
 				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EXCL");
-			if (payload & 0x10)
+			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AR");
-		} else if (payload & 0x4) {
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SIMD-FP");
 		}
 		break;
-	case 2:
+	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "B");
 
-		if (payload & 0x1)
+		if (payload & SPE_OP_PKT_COND)
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " COND");
-		if (payload & 0x2)
+
+		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " IND");
 
 		break;
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

