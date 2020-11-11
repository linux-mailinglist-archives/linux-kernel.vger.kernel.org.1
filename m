Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108742AE985
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKKHRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgKKHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:15:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DECEC061A4C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gi3so261278pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/px56nC3xW0eCOWvJbFEZe/Qi65aZMohNDWcFSiNRk=;
        b=PzPD1UtKxzBbPgvTjZrbQ7Zz8AfWsflMdUSA4UwGC3GIRYQqjMsIc73VSfP1IC/iwz
         JNqNsGEaMKROC6kMRjf/naXg30btY3LaB1ZeH4zAyN5nRnW8OLPVkc8eKlrbY5YOwxt4
         wtjW2BHiFQbucfDrCtIvfZ7KBZwW7qGmP7I0m0DAZ7Kv9TqXIssGTW+x/gnKEs0/k7S5
         wHWwDSN65hUQWeOcm3qR+TKYeLBpK4sZXGYRTKbhAR6bJju1q9c+7OLrs1FqFHo/ygr4
         T53xkyJ+QjOT4i0K1jyQMqZDVoEuxjE4jWXrVpF4X0LMJPLofcUcxpvqpg94TA+BvhWm
         WoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/px56nC3xW0eCOWvJbFEZe/Qi65aZMohNDWcFSiNRk=;
        b=uEZfxSZDZrBTdwB5DXy4pbjfK4v2ZdW6uC8xNjDEDDgb3A0lG9HO6lOr/ZUTnHFVA4
         +DEhMSWT+6wEtGHVJGEg7QbtUwCL9JyjGjuAvifS5AdGvUWI1r93W1c95Zp5WRce6TFN
         23HLZhmSqYhiqgsIOOzSLZZtAc0gerYNUTAMZUAeNFkNcbxPeVDOumxZzyoXRoGUn3ZM
         uNRFyRb/vEPA75GY6pyv33xcQKJk+7s12Rt/AZNIjkAskVD1xsaZdhpiRomFoiMPG2GW
         Qszy4eBdKVubI3E1QAuehHpIkLiUV6Fgr7feA1s7oqq+cSx+zRygNksjOrafGqnDrIkj
         qvVA==
X-Gm-Message-State: AOAM532dPEID5hhkLjzLNjUTvRAWj0n16F7lx30YTgE6q2vOvaL/sb59
        XpRknguaydf7LJ4yReUygdJAwg==
X-Google-Smtp-Source: ABdhPJyXd1hnHCADKrZYEkCFoio4/8npHGC5ku1HKYDB63SgJJ33f5z7VgK+IYRQ02gOztosDTIsLQ==
X-Received: by 2002:a17:90a:454d:: with SMTP id r13mr2660940pjm.122.1605078811050;
        Tue, 10 Nov 2020 23:13:31 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id j12sm1315637pga.78.2020.11.10.23.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:30 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 19/22] perf arm-spe: Refactor operation packet handling
Date:   Wed, 11 Nov 2020 15:11:46 +0800
Message-Id: <20201111071149.815-20-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index 4f93b75c87e6..5fe1c5e8094d 100644
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

