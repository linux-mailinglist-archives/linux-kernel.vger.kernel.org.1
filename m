Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552F92AE972
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgKKHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKKHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:43 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273DDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:43 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id g19so224795pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJx2uekV90sNzAeiUc1stuBzx8fU8ORWCABlRU26gvQ=;
        b=Gxcj1alUonJ5G6t+WHrcoOfXJOTso6xrp2lHeIcwoghCEtdVXfuG4ZhrDp+JBGlbd4
         mfquMPv8C2+UO5B3reqPQ8VIjpHW7S7c2013BWQcqH1zEDlYKbOqghmogXZhpIc/WBgx
         MAKRm8TKYZqMtLuWCrxgjLtbner9gvUKs43cPrzYGAcJKem4x7qwBTBpBWP8cLQVrwU9
         Abyo6z9TkfrJW8ozfEvL9YziARWADQ/06gBZYJHZlcoEZfS0ref2UEknnmoN8i3wgef5
         gNwLe7/sbEyZzaMeQ8hAoc3++U8gYIzjaoRubQKou7TN+FrdTfjbRNN6L9j5AzdHfG4z
         5V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJx2uekV90sNzAeiUc1stuBzx8fU8ORWCABlRU26gvQ=;
        b=XQYriJGbY9cISuIHuOINBKBkYCnGzG6KRt6RnUtys7UZO2hk4WzDUkiBw6TaZGapQD
         2+cmdcLBm463pWhQs0xSSdDSLwG44Avcu0WCnO9TKdQsyknrJWCf9UDTagMQS4m9cvrJ
         McUA02PHuq/cdoXBYtjEmSX5htlVZo/qtnpIqSCyp9ck1iYXW2mkD9XnlhGPBt2EfPQ9
         BrKqCE3XyzAcaXAUq7mMhinnLP5m5GII6Xpj2PJxvsZx21rgCwJYA45SgFCW+8CpHSdA
         XhtZWtBcVxYBojOuDm+y2iwBB4Ir2cJB2sTzzrK1Dz25bc2a0O7j/FjubDuFhe3SQMA0
         jv1Q==
X-Gm-Message-State: AOAM5314kSnyBnNTjWUxlr8VWa83972ng5H+YWlnxagcEmUyJmAXbIeQ
        sYuFgHVj0iLWVQKZKl+3k9D30w==
X-Google-Smtp-Source: ABdhPJxIGggpUrssjl2QMG7QQtR/w1SuhMLbZavy+4R94Z0EhUo3jiksyrMJxXAz9pIQ/6i91qehIw==
X-Received: by 2002:a17:90a:c7c3:: with SMTP id gf3mr2536279pjb.140.1605078762704;
        Tue, 10 Nov 2020 23:12:42 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id i26sm1365949pfq.148.2020.11.10.23.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:42 -0800 (PST)
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
Subject: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Date:   Wed, 11 Nov 2020 15:11:33 +0800
Message-Id: <20201111071149.815-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
it's used by the caller arm_spe_pkt_desc().

This patch also moves the variable 'blen' as the function's local
variable, this allows to remove the unnecessary braces and improve the
readability.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 260 +++++++++---------
 1 file changed, 126 insertions(+), 134 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 04fd7fd7c15f..1970686f7020 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -9,6 +9,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <linux/bitops.h>
+#include <stdarg.h>
 
 #include "arm-spe-pkt-decoder.h"
 
@@ -258,192 +259,183 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
 	return ret;
 }
 
+static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
+				const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	/* Bail out if any error occurred */
+	if (err && *err)
+		return *err;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(*buf_p, *blen, fmt, ap);
+	va_end(ap);
+
+	if (ret < 0) {
+		if (err && !*err)
+			*err = ret;
+
+	/*
+	 * A return value of (*blen - 1) or more means that the
+	 * output was truncated and the buffer is overrun.
+	 */
+	} else if (ret >= ((int)*blen - 1)) {
+		(*buf_p)[*blen - 1] = '\0';
+
+		/*
+		 * Set *err to 'ret' to avoid overflow if tries to
+		 * fill this buffer sequentially.
+		 */
+		if (err && !*err)
+			*err = ret;
+	} else {
+		*buf_p += ret;
+		*blen -= ret;
+	}
+
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
+	int err = 0;
 
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
-		if (payload & 0x1) {
-			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x2) {
-			ret = snprintf(buf, buf_len, " RETIRED");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x4) {
-			ret = snprintf(buf, buf_len, " L1D-ACCESS");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x8) {
-			ret = snprintf(buf, buf_len, " L1D-REFILL");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x10) {
-			ret = snprintf(buf, buf_len, " TLB-ACCESS");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x20) {
-			ret = snprintf(buf, buf_len, " TLB-REFILL");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x40) {
-			ret = snprintf(buf, buf_len, " NOT-TAKEN");
-			buf += ret;
-			blen -= ret;
-		}
-		if (payload & 0x80) {
-			ret = snprintf(buf, buf_len, " MISPRED");
-			buf += ret;
-			blen -= ret;
-		}
+		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
+	case ARM_SPE_EVENTS:
+		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
+
+		if (payload & 0x1)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
+		if (payload & 0x2)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
+		if (payload & 0x4)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
+		if (payload & 0x8)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
+		if (payload & 0x10)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
+		if (payload & 0x20)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
+		if (payload & 0x40)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
+		if (payload & 0x80)
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
 		if (idx > 1) {
-			if (payload & 0x100) {
-				ret = snprintf(buf, buf_len, " LLC-ACCESS");
-				buf += ret;
-				blen -= ret;
-			}
-			if (payload & 0x200) {
-				ret = snprintf(buf, buf_len, " LLC-REFILL");
-				buf += ret;
-				blen -= ret;
-			}
-			if (payload & 0x400) {
-				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
-				buf += ret;
-				blen -= ret;
-			}
+			if (payload & 0x100)
+				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
+			if (payload & 0x200)
+				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
+			if (payload & 0x400)
+				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
 		}
 		if (ret < 0)
 			return ret;
 		blen -= ret;
 		return buf_len - blen;
-	}
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
-					"COND-SELECT" : "INSN-OTHER");
-		case 1:	{
-			size_t blen = buf_len;
+		case 0:
+			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+		case 1:
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen,
+						   payload & 0x1 ? "ST" : "LD");
 
-			if (payload & 0x1)
-				ret = snprintf(buf, buf_len, "ST");
-			else
-				ret = snprintf(buf, buf_len, "LD");
-			buf += ret;
-			blen -= ret;
 			if (payload & 0x2) {
-				if (payload & 0x4) {
-					ret = snprintf(buf, buf_len, " AT");
-					buf += ret;
-					blen -= ret;
-				}
-				if (payload & 0x8) {
-					ret = snprintf(buf, buf_len, " EXCL");
-					buf += ret;
-					blen -= ret;
-				}
-				if (payload & 0x10) {
-					ret = snprintf(buf, buf_len, " AR");
-					buf += ret;
-					blen -= ret;
-				}
+				if (payload & 0x4)
+					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
+				if (payload & 0x8)
+					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
+				if (payload & 0x10)
+					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
 			} else if (payload & 0x4) {
-				ret = snprintf(buf, buf_len, " SIMD-FP");
-				buf += ret;
-				blen -= ret;
+				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
 			}
+
 			if (ret < 0)
 				return ret;
 			blen -= ret;
 			return buf_len - blen;
-		}
-		case 2:	{
-			size_t blen = buf_len;
 
-			ret = snprintf(buf, buf_len, "B");
-			buf += ret;
-			blen -= ret;
-			if (payload & 0x1) {
-				ret = snprintf(buf, buf_len, " COND");
-				buf += ret;
-				blen -= ret;
-			}
-			if (payload & 0x2) {
-				ret = snprintf(buf, buf_len, " IND");
-				buf += ret;
-				blen -= ret;
-			}
+		case 2:
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
+
+			if (payload & 0x1)
+				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
+			if (payload & 0x2)
+				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
+
 			if (ret < 0)
 				return ret;
 			blen -= ret;
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
+		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
 		switch (idx) {
 		case 0:
-		case 1: ns = !!(packet->payload & NS_FLAG);
+		case 1:
+			ns = !!(packet->payload & NS_FLAG);
 			el = (packet->payload & EL_FLAG) >> 61;
 			payload &= ~(0xffULL << 56);
-			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
+			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+					"%s 0x%llx el%d ns=%d",
 				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
+		case 2:
+			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+						    "VA 0x%llx", payload);
+		case 3:
+			ns = !!(packet->payload & NS_FLAG);
 			payload &= ~(0xffULL << 56);
-			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
-					payload, ns);
-		default: return 0;
+			return arm_spe_pkt_snprintf(&err, &buf, &blen,
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
+		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
+					    name, (unsigned long)payload, idx + 1);
+	case ARM_SPE_COUNTER:
+		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
+					   (unsigned short)payload);
 		switch (idx) {
-		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
-		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
-		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
-		default: ret = 0;
+		case 0:
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
+			break;
+		case 1:
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
+			break;
+		case 2:
+			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
+			break;
+		default:
+			ret = 0;
+			break;
 		}
 		if (ret < 0)
 			return ret;
 		blen -= ret;
 		return buf_len - blen;
-	}
 	default:
 		break;
 	}
 
-	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
-			name, payload, packet->index);
+	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
+				    name, payload, packet->index);
 }
-- 
2.17.1

