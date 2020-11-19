Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC42B962B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgKSPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgKSPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1389CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 131so4801421pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2AEhGRHQ2uiOfXxIoJGw/coTAZ4hFTUpYYpyzpitvwY=;
        b=zXManRHahK4/1hOgKc1t0UbdykNz87k477j3cqveGyc7pEDQitnymLV5VbIFp7mReu
         WXLrYbIahsmhhdPIvxG+kjrsQGEmup3ga71o3quOgThdbAPDSgSUO08IrHlknGnXTYsX
         IwUvGqxNupFwzLnjZsczNJSmU75Mpx9J30My2892X8U2XVJJbmMrn8651uyotyCuMq1w
         57FK44DkU4QpAGK8IP8jdiY6gtL8PLIppEy44GpLZ6Z3ZDAnnkBvA38ufdUARG/dbiQ4
         Ag3hBrCH+qupcSDzwm3sHlkJD/Jv4Jcu/kqS/MamtOnN4gk0FohfSBVCEcN/PJVElxhc
         0jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2AEhGRHQ2uiOfXxIoJGw/coTAZ4hFTUpYYpyzpitvwY=;
        b=ZKZfs0YV86RxbhxmchsLawNMCJvnZWZ3R6YTlKLipGLM0Id/o4Dv9xm9WjY/qTxyKW
         OiLf7+wwxspBKVmUJmTBRDfVyaCQRE4qrFBQtX9kGHUHrF8pEjNhwBt6QfVlfXNKxddw
         VUrcH3g/esfBGrtX9EusXe4fXhnvCn+q1cuf0foIbWgvmW2vHxAYK07bM/Ov7h45i3x2
         +paO5IslKgaYhxMpPdh55l2IvK1paMxVjjWvwccoUHRDdEZmm9LdyJYg5r4iIhqYTa5S
         +9DBYVuJXeyr5wi/Nn7aRbMfD8ytNTv/4LEiTsonNSbSNiF0NpcvNNNtWE6JnCt2fGq5
         tmYA==
X-Gm-Message-State: AOAM533RnmS2LFfeWr/TO9p381m04TWCq8hfwUOWshDpyP6aHLzOSdSO
        JVkwYbhv/wzx1eFwTI5mXZJBHg==
X-Google-Smtp-Source: ABdhPJwKkZpLK5L5LIaz82SQId6XtaCfbg5rNnJQewz3oZNZpcVEHVkYISwIaCOP1BJJM6v+QzKjDA==
X-Received: by 2002:a17:90a:458e:: with SMTP id v14mr5050480pjg.40.1605799546629;
        Thu, 19 Nov 2020 07:25:46 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id gx24sm7262807pjb.38.2020.11.19.07.25.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:46 -0800 (PST)
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
Subject: [PATCH v9 13/16] perf arm-spe: Refactor operation packet handling
Date:   Thu, 19 Nov 2020 23:24:38 +0800
Message-Id: <20201119152441.6972-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index d6c060f119b4..1d1354a0eef4 100644
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
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
-				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
 		break;
-	case 1:
+	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
 				       payload & 0x1 ? "ST" : "LD");
 
-		if (payload & 0x2) {
-			if (payload & 0x4)
+		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
+			if (payload & SPE_OP_PKT_AT)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AT");
-			if (payload & 0x8)
+			if (payload & SPE_OP_PKT_EXCL)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCL");
-			if (payload & 0x10)
+			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AR");
-		} else if (payload & 0x4) {
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SIMD-FP");
 		}
 		break;
-	case 2:
+	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, "B");
 
-		if (payload & 0x1)
+		if (payload & SPE_OP_PKT_COND)
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " COND");
-		if (payload & 0x2)
+
+		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " IND");
 
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

