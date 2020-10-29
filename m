Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951BD29E3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgJ2HVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJ2HVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38AC0613B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w21so1598987pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ChbZD/vXbR8gya2wEDNmWSWZ8h26L7YgaM3Rfw3CjLg=;
        b=MxEmTdeE9zEzSAvyn0wJV6mx7lhdYZDolEPuBgUj3rOqPZ2BrWOXtN1cWyzXWimRaI
         XyikEF9jpLPVlbkwfbdIpJmtKs9A42cUKPC8XCbsFXN3u8NdjbuHAC6jNT9CrLkKBb4q
         YrAKSzlIOad3VlPqSpUMvmSUCOJANDXNkRrFMfFifHqGFTn/przzJJCb0MahIqdAB/tO
         Dx5WpuudgMQwSBrMwMOEN9qWj/8ZDuqedCEace2JAIgQt33dbXm1lhT/ZBlOa8LoLFu2
         h7aPAx2Y7c4VWs7yzhCl5xJQNZnNgNcNmZiyyLbqTWsft7m+/R3S8h8k0xOLeV90hH5B
         HqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ChbZD/vXbR8gya2wEDNmWSWZ8h26L7YgaM3Rfw3CjLg=;
        b=TTaccs2uEd+xDvbGkVlgYpFRWwioEBiIWtkftJLbzrs65V2MALVgMTyRSq4Vn7ROpK
         wscvzmSiQIxtMFxic0xHwpcV81dqLkqUhxxrBKLiM6zkP5VYgqrzSpAUtq932sjR1bny
         agaMSnLR8uCNjtbjzGohTfFfFeIX/0WLPs8P8HkSGqW1WQKsVr+JfCNwIoz8DPLNtASP
         Imep4whoxqcwGadaWNR7l/dpWS1PQMCHwej/pQ57xKfDDqZ8sgm30m4g3R7nQLWERDoM
         FTlgaMAKTs9NQeBkw8QEmaSGknHAguyOiH8goeI/xv9ZxYwTDTOZkA4kXwDUvjjnvSCH
         cIYA==
X-Gm-Message-State: AOAM533LqyWZB4QnnlBDELccE6bY52uAI+iT3T4lKsZk97q0iEyDBpfz
        EbYMyva8G6ekRmIzC7QRojNjKg==
X-Google-Smtp-Source: ABdhPJwSM6c1eqGA6xTDdVENzErFKOyp7IYPqen3ZJt1C3QOPIKY6Tv4BbcsfPxghKeXPlMCzo63Cw==
X-Received: by 2002:a17:90a:a58d:: with SMTP id b13mr2946119pjq.196.1603956068375;
        Thu, 29 Oct 2020 00:21:08 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z16sm1851745pfq.33.2020.10.29.00.21.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:21:07 -0700 (PDT)
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
Subject: [PATCH v5 18/21] perf arm-spe: Refactor operation packet handling
Date:   Thu, 29 Oct 2020 15:19:24 +0800
Message-Id: <20201029071927.9308-19-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index e51b103d9973..575635c54e48 100644
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
 
@@ -312,32 +312,34 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 	int err = 0;
 
 	switch (packet->index) {
-	case 0:
+	case SPE_OP_PKT_HDR_CLASS_OTHER:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen,
-				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-	case 1:
+			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		arm_spe_pkt_snprintf(&err, &buf, &blen,
 				     payload & 0x1 ? "ST" : "LD");
 
-		if (payload & 0x2) {
-			if (payload & 0x4)
+		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
+			if (payload & SPE_OP_PKT_AT)
 				arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
-			if (payload & 0x8)
+			if (payload & SPE_OP_PKT_EXCL)
 				arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
-			if (payload & 0x10)
+			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
-		} else if (payload & 0x4) {
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
 		}
 
 		return err ?: (int)(buf_len - blen);
 
-	case 2:
+	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
 
-		if (payload & 0x1)
+		if (payload & SPE_OP_PKT_COND)
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
-		if (payload & 0x2)
+
+		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
 
 		return err ?: (int)(buf_len - blen);
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

