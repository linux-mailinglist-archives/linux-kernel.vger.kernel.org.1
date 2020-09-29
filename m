Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2757327CF86
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgI2NlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgI2Nkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91D4C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so4664281wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4Lsq6UeTPVpcO1d7IrgHdysl3XCSamzRsBtaguygUE=;
        b=ufjr4+5K5uzmRCPRSM14g5IyJUHqFBRtIiZeVEFwif7pd+6e51xjzVkhaOonTy6zkR
         MiZGpzzV70e3uVfM8SNDHaNjo2Zq9VYmrmBUViLEH0IWbtJnKu++eppXS3AQZij3HSW9
         yZ1GFp0TdhWPhUlhG8p5Vm6TB7xPfeygG9tL1sBheAQ6GIhOxdwrxH+21mDHl4CD+JG/
         EuK4DeBq6MYagurs8mRAwArVSV6c7/hcogspjOc//fNWFw2ql8ukCf6643sYeUNEOwom
         xsVKXu7JykcsaTRBzhx9P3ihAx2Ba5Q9m/fOimcDzI1eTmBrusUnRtmjsM+4w2vA71Im
         KSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4Lsq6UeTPVpcO1d7IrgHdysl3XCSamzRsBtaguygUE=;
        b=tVX+PFxReLMU7fT6qsOOtfiFlWciI09Up+IgEVBck9VEIxng3czhiXmMMq+07xvd/R
         1nhgdFYWbWOfTR3SIVpMJkm4kqjtnChv0+bKcyb15mjsXgOKqLPIMhOBC+wiRihNyIXJ
         tcFhZBqLg0Zqpfh3Z7m2BYZPFcqxv9KGSnSQoqwaQx+5HIbT0DTy3PYmzD3uMnw/e7r8
         Dh6Y2/rzEx5248OVV5uHk68AQ57Gw49K/LCi0X7Ur9POoeKpu1tJ4hEI3L3DU+yuJiXm
         P2ibTTetQA63g1ZY9qnUioaUO1439PHdPrjBzRdxKGi5b5Ugb8uhHUscDuHEPE6DsAb0
         eUMw==
X-Gm-Message-State: AOAM53078gkTlVzfzkt2gef42NWAczb+rtjmGvpee09Ol/e9YmV78+B5
        5uJenniZVrwpvXPnSgjVCIlz4Q==
X-Google-Smtp-Source: ABdhPJzc9SuVAy5fww4fLoxmHfhR23Rvc65AJudPhzCoL1u0GHrPqXzaPuGws0yzy5X1OLBPfrFAuw==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr4563356wmc.76.1601386853448;
        Tue, 29 Sep 2020 06:40:53 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:52 -0700 (PDT)
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
Subject: [PATCH v2 05/14] perf arm-spe: Refactor printing string to buffer
Date:   Tue, 29 Sep 2020 14:39:08 +0100
Message-Id: <20200929133917.9224-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When outputs strings to the decoding buffer with function snprintf(),
SPE decoder needs to detects if any error returns from snprintf() and if
so needs to directly bail out.  If snprintf() returns success, it needs
to update buffer pointer and reduce the buffer length so can continue to
output the next string into the consequent memory space.

This complex logics are spreading in the function arm_spe_pkt_desc() so
there has many duplicate codes for handling error detecting, increment
buffer pointer and decrement buffer size.

To avoid the duplicate code, this patch introduces a new helper function
arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
the caller arm_spe_pkt_desc() will call it and simply check the returns
value.

This patch also moves the variable 'blen' as the function's local
variable, this allows to remove the unnecessary braces and improve the
readability.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 247 ++++++++++--------
 1 file changed, 135 insertions(+), 112 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4f0aeb62e97b..96b717a19163 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -9,6 +9,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <linux/bitops.h>
+#include <stdarg.h>
 
 #include "arm-spe-pkt-decoder.h"
 
@@ -256,192 +257,214 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
 	return ret;
 }
 
+static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
+				const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(*buf_p, *blen, fmt, ap);
+	va_end(ap);
+
+	if (ret < 0)
+		return ret;
+
+	*buf_p += ret;
+	*blen -= ret;
+	return ret;
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
 	int ret, ns, el, idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
+	size_t blen = buf_len;
 
 	switch (packet->type) {
 	case ARM_SPE_BAD:
 	case ARM_SPE_PAD:
 	case ARM_SPE_END:
-		return snprintf(buf, buf_len, "%s", name);
-	case ARM_SPE_EVENTS: {
-		size_t blen = buf_len;
-
-		ret = 0;
-		ret = snprintf(buf, buf_len, "EV");
-		buf += ret;
-		blen -= ret;
+		return arm_spe_pkt_snprintf(&buf, &blen, name);
+	case ARM_SPE_EVENTS:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
+		if (ret < 0)
+			return ret;
+
 		if (payload & 0x1) {
-			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x2) {
-			ret = snprintf(buf, buf_len, " RETIRED");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x4) {
-			ret = snprintf(buf, buf_len, " L1D-ACCESS");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x8) {
-			ret = snprintf(buf, buf_len, " L1D-REFILL");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x10) {
-			ret = snprintf(buf, buf_len, " TLB-ACCESS");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x20) {
-			ret = snprintf(buf, buf_len, " TLB-REFILL");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x40) {
-			ret = snprintf(buf, buf_len, " NOT-TAKEN");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
+			if (ret < 0)
+				return ret;
 		}
 		if (payload & 0x80) {
-			ret = snprintf(buf, buf_len, " MISPRED");
-			buf += ret;
-			blen -= ret;
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
+			if (ret < 0)
+				return ret;
 		}
 		if (idx > 1) {
 			if (payload & 0x100) {
-				ret = snprintf(buf, buf_len, " LLC-ACCESS");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
+				if (ret < 0)
+					return ret;
 			}
 			if (payload & 0x200) {
-				ret = snprintf(buf, buf_len, " LLC-REFILL");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
+				if (ret < 0)
+					return ret;
 			}
 			if (payload & 0x400) {
-				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
+				if (ret < 0)
+					return ret;
 			}
 		}
-		if (ret < 0)
-			return ret;
-		blen -= ret;
 		return buf_len - blen;
-	}
+
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
-					"COND-SELECT" : "INSN-OTHER");
-		case 1:	{
-			size_t blen = buf_len;
-
-			if (payload & 0x1)
-				ret = snprintf(buf, buf_len, "ST");
-			else
-				ret = snprintf(buf, buf_len, "LD");
-			buf += ret;
-			blen -= ret;
+		case 0:
+			return arm_spe_pkt_snprintf(&buf, &blen,
+					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+		case 1:
+			ret = arm_spe_pkt_snprintf(&buf, &blen,
+						   payload & 0x1 ? "ST" : "LD");
+			if (ret < 0)
+				return ret;
+
 			if (payload & 0x2) {
 				if (payload & 0x4) {
-					ret = snprintf(buf, buf_len, " AT");
-					buf += ret;
-					blen -= ret;
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
+					if (ret < 0)
+						return ret;
 				}
 				if (payload & 0x8) {
-					ret = snprintf(buf, buf_len, " EXCL");
-					buf += ret;
-					blen -= ret;
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
+					if (ret < 0)
+						return ret;
 				}
 				if (payload & 0x10) {
-					ret = snprintf(buf, buf_len, " AR");
-					buf += ret;
-					blen -= ret;
+					ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
+					if (ret < 0)
+						return ret;
 				}
 			} else if (payload & 0x4) {
-				ret = snprintf(buf, buf_len, " SIMD-FP");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
+				if (ret < 0)
+					return ret;
 			}
+
+			return buf_len - blen;
+
+		case 2:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
 			if (ret < 0)
 				return ret;
-			blen -= ret;
-			return buf_len - blen;
-		}
-		case 2:	{
-			size_t blen = buf_len;
 
-			ret = snprintf(buf, buf_len, "B");
-			buf += ret;
-			blen -= ret;
 			if (payload & 0x1) {
-				ret = snprintf(buf, buf_len, " COND");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
+				if (ret < 0)
+					return ret;
 			}
 			if (payload & 0x2) {
-				ret = snprintf(buf, buf_len, " IND");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
+				if (ret < 0)
+					return ret;
 			}
-			if (ret < 0)
-				return ret;
-			blen -= ret;
+
 			return buf_len - blen;
-			}
-		default: return 0;
+
+		default:
+			return 0;
 		}
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
-		return snprintf(buf, buf_len, "%s %lld", name, payload);
+		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
 		switch (idx) {
 		case 0:
 		case 1: ns = !!(packet->payload & NS_FLAG);
 			el = (packet->payload & EL_FLAG) >> 61;
 			payload &= ~(0xffULL << 56);
-			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
+			return arm_spe_pkt_snprintf(&buf, &blen,
+					"%s 0x%llx el%d ns=%d",
 				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
+		case 2:
+			return arm_spe_pkt_snprintf(&buf, &blen,
+						    "VA 0x%llx", payload);
 		case 3:	ns = !!(packet->payload & NS_FLAG);
 			payload &= ~(0xffULL << 56);
-			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
-					payload, ns);
-		default: return 0;
+			return arm_spe_pkt_snprintf(&buf, &blen,
+						    "PA 0x%llx ns=%d", payload, ns);
+		default:
+			return 0;
 		}
 	case ARM_SPE_CONTEXT:
-		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
-				(unsigned long)payload, idx + 1);
-	case ARM_SPE_COUNTER: {
-		size_t blen = buf_len;
-
-		ret = snprintf(buf, buf_len, "%s %d ", name,
-			       (unsigned short)payload);
-		buf += ret;
-		blen -= ret;
-		switch (idx) {
-		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
-		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
-		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
-		default: ret = 0;
-		}
+		return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%lx el%d",
+					    name, (unsigned long)payload, idx + 1);
+	case ARM_SPE_COUNTER:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "%s %d ", name,
+					   (unsigned short)payload);
 		if (ret < 0)
 			return ret;
-		blen -= ret;
+
+		switch (idx) {
+		case 0:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
+			if (ret < 0)
+				return ret;
+			break;
+		case 1:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
+			if (ret < 0)
+				return ret;
+			break;
+		case 2:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			break;
+		}
+
 		return buf_len - blen;
-	}
+
 	default:
 		break;
 	}
 
-	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
-			name, payload, packet->index);
+	return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%llx (%d)",
+				    name, payload, packet->index);
 }
-- 
2.20.1

