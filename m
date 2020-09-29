Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2760527CF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgI2Nl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbgI2NlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17854C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t10so5477593wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b9R++Imxq1fTj+RG6DGGN7zRIK1ICdF+RXO6CmyryJw=;
        b=Wzrfwd1G8ieO5UT5TgZKQ/e3MVFT2bTFqmeb4K1ZgUc/7lDRXzUqutM5jJsPHEgCGp
         Ziaj8+wFQqJGOvifh1eIT1V1Sh0ZXpoOXqXHWkqB4z/wY6I3jZYWN1xJxXDm++Vxuaxb
         YyoPaLa5b/oYOGCSQRQ4djEfbYJ0mOBAIk0wSWXfV3lIY+z3wD6Qcbp9U4pOLZwAmTJA
         8m936t98Thjh/Xmw/iXHfwbzbg9ZrveD7UzE0nE7WUM8bq7ylrKjp8YDmqxvR5Mmg1ng
         JGeYQMHLkAhxpp+1V9VSX4gjcEkwWb2RVmuOyCGEHz/GlnCVgznVCZNHmrxN3m7383ho
         dPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b9R++Imxq1fTj+RG6DGGN7zRIK1ICdF+RXO6CmyryJw=;
        b=UK3uk5B81T6ejJCafUUruQY1aKTYeWjrcZzYVr+LLcoR1beYGSF7pcc9CaWkMrnKR2
         09FIZ3NaVIBqiXmjFmEZL3mUd1XeQPQCPsm97lFa/ZwB06jj93Wt6RZKUXl5mKTBtrF9
         KYQDBtS/vi1spIc9cFijw/sRKBw4GzVFT9rRjJYPQpwA3bkYDZ0eWtPUyv5WdjCv+CXp
         aKpfAvMqoV0xkOGr2lpLa2eVR/wj5vBooD7keIBiFumgH2Lj4hW5IXjT/J27zJRzaGC+
         Q5xqT407Ddxi7i9xtE5vfV1ARz2zYEWwU8IUp+YYVdUGeK/KEANcO103k4OsS/ZgyDSr
         1rKQ==
X-Gm-Message-State: AOAM533wcwwPxkAjHM2F1qsvSeZxBDGTqBiT57zr/s++FT9Uto3NsFRc
        bSdUSqvQr+JvwC/V+CEsZO6CoQ==
X-Google-Smtp-Source: ABdhPJxYbc9OXiHBfbMXLQw6WUDBE5Vwv1g5VA/ts7VOhaePqeqlSke8v1iqOritaY6PEbnhQqBiUg==
X-Received: by 2002:adf:b306:: with SMTP id j6mr4227881wrd.279.1601386860620;
        Tue, 29 Sep 2020 06:41:00 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:59 -0700 (PDT)
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
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 11/14] perf arm-spe: Refactor operation packet handling
Date:   Tue, 29 Sep 2020 14:39:14 +0100
Message-Id: <20200929133917.9224-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macros for operation packet header and formats (support sub
classes for 'other', 'branch', 'load and store', etc).  Uses these
macros for operation packet decoding and dumping.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 31 +++++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 36 +++++++++++++++++++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b8f343320abf..a848c784f4cf 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -142,7 +142,7 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_OP_TYPE;
-	packet->index = buf[0] & 0x3;
+	packet->index = buf[0] & SPE_OP_PKT_HDR_CLASS_MASK;
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
@@ -345,32 +345,36 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-		case 0:
+		case SPE_OP_PKT_HDR_CLASS_OTHER:
 			return arm_spe_pkt_snprintf(&buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-		case 1:
+					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
+					"COND-SELECT" : "INSN-OTHER");
+		case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 			ret = arm_spe_pkt_snprintf(&buf, &blen,
-						   payload & 0x1 ? "ST" : "LD");
+						   payload & SPE_OP_PKT_LDST ?
+						   "ST" : "LD");
 			if (ret < 0)
 				return ret;
 
-			if (payload & 0x2) {
-				if (payload & 0x4) {
+			if ((payload & SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_ATOMIC) {
+				if (payload & SPE_OP_PKT_AT) {
 					ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
 					if (ret < 0)
 						return ret;
 				}
-				if (payload & 0x8) {
+				if (payload & SPE_OP_PKT_EXCL) {
 					ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
 					if (ret < 0)
 						return ret;
 				}
-				if (payload & 0x10) {
+				if (payload & SPE_OP_PKT_AR) {
 					ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
 					if (ret < 0)
 						return ret;
 				}
-			} else if (payload & 0x4) {
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
 				if (ret < 0)
 					return ret;
@@ -378,17 +382,18 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 
 			return buf_len - blen;
 
-		case 2:
+		case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 			ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
 			if (ret < 0)
 				return ret;
 
-			if (payload & 0x1) {
+			if (payload & SPE_OP_PKT_BRANCH_SUBCLASS_COND) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x2) {
+			if ((payload & SPE_OP_PKT_BRANCH_SUBCLASS_MASK) ==
+					SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
 				if (ret < 0)
 					return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index e9a88cf685bb..2c4086bf3149 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -114,6 +114,42 @@ struct arm_spe_pkt {
 #define SPE_EVT_PKT_ARCH_RETIRED		BIT(1)
 #define SPE_EVT_PKT_GEN_EXCEPTION		BIT(0)
 
+/* Operation packet header */
+#define SPE_OP_PKT_HDR_CLASS_MASK		GENMASK_ULL(2, 0)
+#define SPE_OP_PKT_HDR_CLASS_OTHER		(0x0)
+#define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	(0x1)
+#define SPE_OP_PKT_HDR_CLASS_BR_ERET		(0x2)
+
+#define SPE_OP_PKT_OTHER_SUBCLASS_MASK		GENMASK_ULL(7, 1)
+#define SPE_OP_PKT_OTHER_SUBCLASS_OTHER_OP	(0x0)
+#define SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK	(BIT(7) | BIT(3) | BIT(0))
+#define SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP	(0x8)
+
+#define SPE_OP_PKT_OTHER_SUBCLASS_COND		BIT(0)
+
+#define SPE_OP_PKT_BRANCH_SUBCLASS_MASK		GENMASK_ULL(7, 1)
+#define SPE_OP_PKT_BRANCH_SUBCLASS_DIRECT	(0x0)
+#define SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT	(0x2)
+
+#define SPE_OP_PKT_BRANCH_SUBCLASS_COND		BIT(0)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_MASK		GENMASK_ULL(7, 1)
+#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		(0x0)
+#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	(0x4)
+#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	(0x10)
+#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	(0x30)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_MASK	(GENMASK_ULL(7, 5) | GENMASK_ULL(1, 1))
+#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC		(0x2)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK	(GENMASK_ULL(3, 3) | GENMASK_ULL(1, 1))
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE		(0x8)
+
+#define SPE_OP_PKT_AR				BIT(4)
+#define SPE_OP_PKT_EXCL				BIT(3)
+#define SPE_OP_PKT_AT				BIT(2)
+#define SPE_OP_PKT_LDST				BIT(0)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.20.1

