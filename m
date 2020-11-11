Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF72AE984
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKKHRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKKHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:15:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BFAC061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ei22so262084pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tLdPHb7wur2peZls2EEptjsAU4VSJb+8v+Xv8vCbleY=;
        b=rg9jVqxiNP9WLYstdMjM+YzDE3Z8f+mSBhEU312oBdbbJDE09/vaURNvJ+iUUqbQU9
         j/8kxWX1wPLfF4ELyinENvlD6H7ZSW1Dd4JvYK/eJ1N5erGTkQkmjp1XcLC+6OtNwwLr
         +8p0f0cIbXlRCDsVFgWBr+/tsVhrjc6So87NJK65UlEWCp6Wb0IqcJEtWAc/e8Q8szO+
         uSG3BOxBoEQl6p0kBsHTHMJQFjNLEovy0Febymiq29siThD7ZD0djJuPNJ6iZK6/am+u
         ZHQLYisMoC4Y5e7jQg1XWIy3Ofb8PdMEfE7QASHZ5Z7OdY2Xw9FJyM1W/tZKM8KWZ+7W
         PKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tLdPHb7wur2peZls2EEptjsAU4VSJb+8v+Xv8vCbleY=;
        b=oTyKXipjkXugsP58M9etRc9YngA/GrxxuL+NJHiIJURk0FRv2fzbdPx2gzJqzpxmuc
         O5jJSIXB3YDeNvYmhiwETDCR2Pt1c05SiY+SLyTGAtBYOLx76TvEnojiYNcUkwtk1pXQ
         ULRaZ2xy8d01AtmZDlFfjUmNPEXoQ9J19MHL5vNlxs7uAle8viIKiRjdaxfXm6fpRWQ4
         Ku+eGLazDpSBG5Ikhc7KBGQNQdWum8I6XQNbar/JWgykcNmFBLST2x10yrRspVhJmC0I
         vK7d6BpUHGKJj+Tr8/6UIRj1sFybT9ZOWxUejZEL9mNhsZww/YUuDRPHRdHSZHXyEsEF
         thjg==
X-Gm-Message-State: AOAM533cme21qnRDHw/fb4GZvmqqR4Z4Pp7g2h1fVMUlCLnvuhU2OlNH
        AwalSCs427/PTNl86WNldtufLw==
X-Google-Smtp-Source: ABdhPJw/AuHsJNSHQsndiqjBj0SJaEMqtY6z4ohpPphZTqb2jWeUJtUNm6ovr970KJJ4fu2whgDqBA==
X-Received: by 2002:a17:902:6b08:b029:d6:c471:8b5b with SMTP id o8-20020a1709026b08b02900d6c4718b5bmr20683231plk.78.1605078821981;
        Tue, 10 Nov 2020 23:13:41 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id b142sm1306784pfb.186.2020.11.10.23.13.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:41 -0800 (PST)
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
Subject: [PATCH v8 22/22] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Wed, 11 Nov 2020 15:11:49 +0800
Message-Id: <20201111071149.815-23-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index cbbbbefdc52b..afb6d9fe9eae 100644
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

