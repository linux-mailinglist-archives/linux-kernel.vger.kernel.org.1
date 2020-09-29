Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B880D27CF89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgI2NlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgI2NlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B559C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so5432370wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S6koJJSggmSal63szAv1Wi+Rez3B6JEUgBs5HDL7mYM=;
        b=kYwsCooOXLXjUhxpfPavg1BYBaX0xF/mO2M3pDmE4dRBWDJI5q+47/eeKiUYhOWC/c
         ISztCpU66B6SnY3ZqwbFjBiwS3wh5cfbwrCeOJxvu0PvUirNeacUSQMWh3Bg1OB7FrDF
         5Gad541gfv/NXxgC0kTLzicfqp7odvTpygA29JJ22F/ther8KblsR2L+udqKDIca8V89
         6FbetCzVHTvw0pBHNZ2YxnuhTjRhDFbZ4LM6+aSW3Lg13JahZ9soGAzTk928QmwDVZHT
         oQCUkrE0Ctxk/cdNS/SiSEyyI9Zv4toCLI0ORUmOEVan7Vo7VTDmQyno9etkPeoS2g9p
         iHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S6koJJSggmSal63szAv1Wi+Rez3B6JEUgBs5HDL7mYM=;
        b=UefegLIcWD6RwIhbpPMUH9nhi9IHBUBbTvf8j39DlerYQIQtgXjDOD1ht9L4oLNuT7
         ap8gA/u3UKub6w5SlLOwH3iMDDhK65t6sGhhDRHhtOBUcq0lyMmqpedTJLXeC7Qbb1eX
         oov8e+Q5Q/7wZxF164LqrYKN6luwFaT+I12zDuVRbcmhYenKOiT85K9fEyXG0mS6f9AQ
         ZQNSN0DytWPhgccCvNRCqWAUHPavxSAj5TeBMk8NI37t1MANOrMtn9AEw8YN/Vu5dZWf
         8+4sUs8wF4i2RmJht42SWy+2uB/lpfTSJGfgrznLKHk49zNg3Keu3Qbsvn9QG3ykZoZT
         3ppw==
X-Gm-Message-State: AOAM533JNHaxjUMTkLFK2sfSz89laJMt/S1Yv4qMgZSmEh18dSB2ZBp3
        vd7TfJyeVIG9ga71JHEpkqTzWg==
X-Google-Smtp-Source: ABdhPJxyp8Oeq9HWvJ1/0pjWBLdyMKj3rrOq3micbuWzBxByyutnH0LAveN3J1hGAtDUVyS/FGiRvg==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr4391621wrs.218.1601386864764;
        Tue, 29 Sep 2020 06:41:04 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:41:04 -0700 (PDT)
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
Subject: [PATCH v2 14/14] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Tue, 29 Sep 2020 14:39:17 +0100
Message-Id: <20200929133917.9224-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 84 ++++++++++++++++++-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  6 ++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 05a4c74399d7..3ec381fddfcb 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -342,14 +342,73 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 					return ret;
 			}
 		}
+		if (idx > 2) {
+			if (payload & SPE_EVT_PKT_ALIGNMENT) {
+				ret = snprintf(buf, buf_len, " ALIGNMENT");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & SPE_EVT_PKT_SVE_PARTIAL_PREDICATE) {
+				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & SPE_EVT_PKT_SVE_EMPTY_PREDICATE) {
+				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			}
+		}
+
 		return buf_len - blen;
 
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
 		case SPE_OP_PKT_HDR_CLASS_OTHER:
-			return arm_spe_pkt_snprintf(&buf, &blen,
-					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
-					"COND-SELECT" : "INSN-OTHER");
+			if ((payload & SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK) ==
+					SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP) {
+
+				ret = arm_spe_pkt_snprintf(&buf, &blen, "SVE-OTHER");
+				if (ret < 0)
+					return ret;
+
+				/* Effective vector length: step is 32 bits */
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
+					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
+						SPE_OP_PKT_SVE_EVL_SHIFT));
+				if (ret < 0)
+					return ret;
+
+				if (payload & SPE_OP_PKT_SVE_FP) {
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " FP");
+					if (ret < 0)
+						return ret;
+				}
+				if (payload & SPE_OP_PKT_SVE_PRED) {
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
+					if (ret < 0)
+						return ret;
+				}
+			} else {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, "OTHER");
+				if (ret < 0)
+					return ret;
+
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " %s",
+					       payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
+					       "COND-SELECT" : "UNCOND");
+				if (ret < 0)
+					return ret;
+			}
+
+			return buf_len - blen;
+
 		case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 			ret = arm_spe_pkt_snprintf(&buf, &blen,
 						   payload & SPE_OP_PKT_LDST ?
@@ -394,6 +453,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " NV-SYSREG");
 				if (ret < 0)
 					return ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SVE) {
+				/* Effective vector length: step is 32 bits */
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
+					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
+						SPE_OP_PKT_SVE_EVL_SHIFT));
+				if (ret < 0)
+					return ret;
+
+				if (payload & SPE_OP_PKT_SVE_PRED) {
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " PRED");
+					if (ret < 0)
+						return ret;
+				}
+				if (payload & SPE_OP_PKT_SVE_SG) {
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " SG");
+					if (ret < 0)
+						return ret;
+				}
 			}
 
 			return buf_len - blen;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 1847cad517db..80266bfebec2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -147,6 +147,12 @@ struct arm_spe_pkt {
 #define SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK	(GENMASK_ULL(3, 3) | GENMASK_ULL(1, 1))
 #define SPE_OP_PKT_LDST_SUBCLASS_SVE		(0x8)
 
+#define SPE_OP_PKT_SVE_SG			BIT(7)
+#define SPE_OP_PKT_SVE_EVL_MASK			GENMASK_ULL(6, 4)
+#define SPE_OP_PKT_SVE_EVL_SHIFT		(4)
+#define SPE_OP_PKT_SVE_PRED			BIT(2)
+#define SPE_OP_PKT_SVE_FP			BIT(1)
+
 #define SPE_OP_PKT_AR				BIT(4)
 #define SPE_OP_PKT_EXCL				BIT(3)
 #define SPE_OP_PKT_AT				BIT(2)
-- 
2.20.1

