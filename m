Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F229E4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgJ2Hks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgJ2HYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFEC08EADF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b3so1618742pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u3UF53vquJaw5yc8hotyKxe4w/WMIbGZ6vKYk9JL5x4=;
        b=YEbGX+jQ0jJrCF4mo0FpgIFc6xtxHwdlwbijjQuZjycA6IJ9LlR8BDJ6+m7lzdodC/
         rM0+YSnYa36jFUK4Ig7WDf8lQ+XY/eUBd3keszWE+qm8dJL9WiLvJuY5ZEOYIUNzYLzh
         7XJfOk7bxpicQV7A3SBW7gQ8nKsHhwlWhje7yfKCa118/bkkK2zmH9L7Zxj7WcM3yird
         2QwJbASOAy5ouFd2eYMsAiWVqF1t5cVfL73Ok37nbqkAtaXcg2BdaIeBaBqyHmX1i1PM
         v+eJ8X2evvugS7PpHXAfkfjvQpyRrXMyDMtU0TcnB79xN4wF0yzYMmTOmH+pvqMA8Sjw
         8F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3UF53vquJaw5yc8hotyKxe4w/WMIbGZ6vKYk9JL5x4=;
        b=bAJF0HareWRbUXk+D7638etK8G864ty8iby400sYxdw6LNxgNce7+ZdKnLD1XLxAWu
         SEJbw8oUrPqNd6XkuqNF6nG8VMr7c8kccikoxjPXT0WQOyrceywfc4g7Pdw20DpIEDoo
         MkhaPGpxWaVM/1zFG5lAt8bBv8tKyI4BgxmYCKL4hmH5DTOt2xKICBNf7rU6mVXBgHoM
         CW3UgOEV4fTaz4PzYjtNKXBQePl72LL3Kydq7Ztam2ZEdHJaF2hGZGhU75l4cxqjMrrS
         lOeTloUi7jkDQJS1nW7gh5cUCN0h50aRjbrqJap3QNHNJ/MP15mNPH3JrlseFwqET0H+
         D0+g==
X-Gm-Message-State: AOAM5304Z8L2fI5LSHdo72Fn9lDRiF2PlLpFBi6H3B8p24P6TqxdoefF
        uuxo57h1A/Yb/fQ14dICeFB9SQ==
X-Google-Smtp-Source: ABdhPJwpXlIcDiaThx9xofMCwQmRanuo6pdqQgQPoaXtPXtO52zGMUmch+4IaWlhVIlJWNlXrfrS4w==
X-Received: by 2002:a17:90a:f00f:: with SMTP id bt15mr3093243pjb.164.1603956009377;
        Thu, 29 Oct 2020 00:20:09 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a19sm1685857pjq.29.2020.10.29.00.20.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:08 -0700 (PDT)
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
Subject: [PATCH v5 06/21] perf arm-spe: Refactor printing string to buffer
Date:   Thu, 29 Oct 2020 15:19:12 +0800
Message-Id: <20201029071927.9308-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
it's used by the caller arm_spe_pkt_desc(); if printing buffer is called
for multiple times in a flow, the error is a cumulative value and simply
returns its final value.

This patch also moves the variable 'blen' as the function's local
variable, this allows to remove the unnecessary braces and improve the
readability.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 263 ++++++++----------
 1 file changed, 113 insertions(+), 150 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 04fd7fd7c15f..9147b88ae00c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -9,6 +9,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <linux/bitops.h>
+#include <stdarg.h>
 
 #include "arm-spe-pkt-decoder.h"
 
@@ -258,192 +259,154 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
 	return ret;
 }
 
+static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
+				const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(*buf_p, *blen, fmt, ap);
+	va_end(ap);
+
+	if (ret < 0) {
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
-	int ret, ns, el, idx = packet->index;
+	int ns, el, idx = packet->index;
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
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
+
+		if (payload & 0x1)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
+		if (payload & 0x2)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
+		if (payload & 0x4)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
+		if (payload & 0x8)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
+		if (payload & 0x10)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
+		if (payload & 0x20)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
+		if (payload & 0x40)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
+		if (payload & 0x80)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
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
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
+			if (payload & 0x200)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
+			if (payload & 0x400)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
 		}
-		if (ret < 0)
-			return ret;
-		blen -= ret;
-		return buf_len - blen;
-	}
+		return err ?: (int)(buf_len - blen);
+
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
+			arm_spe_pkt_snprintf(&err, &buf, &blen,
+					     payload & 0x1 ? "ST" : "LD");
 
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
+					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
+				if (payload & 0x8)
+					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
+				if (payload & 0x10)
+					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
 			} else if (payload & 0x4) {
-				ret = snprintf(buf, buf_len, " SIMD-FP");
-				buf += ret;
-				blen -= ret;
-			}
-			if (ret < 0)
-				return ret;
-			blen -= ret;
-			return buf_len - blen;
-		}
-		case 2:	{
-			size_t blen = buf_len;
-
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
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
 			}
-			if (ret < 0)
-				return ret;
-			blen -= ret;
-			return buf_len - blen;
-			}
-		default: return 0;
+
+			return err ?: (int)(buf_len - blen);
+
+		case 2:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
+
+			if (payload & 0x1)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
+			if (payload & 0x2)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
+
+			return err ?: (int)(buf_len - blen);
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
 		case 1: ns = !!(packet->payload & NS_FLAG);
 			el = (packet->payload & EL_FLAG) >> 61;
 			payload &= ~(0xffULL << 56);
-			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
+			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+					"%s 0x%llx el%d ns=%d",
 				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
+		case 2:
+			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+						    "VA 0x%llx", payload);
 		case 3:	ns = !!(packet->payload & NS_FLAG);
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
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
+				     (unsigned short)payload);
+
 		switch (idx) {
-		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
-		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
-		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
-		default: ret = 0;
+		case 0:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
+			break;
+		case 1:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
+			break;
+		case 2:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
+			break;
+		default:
+			break;
 		}
-		if (ret < 0)
-			return ret;
-		blen -= ret;
-		return buf_len - blen;
-	}
+
+		return err ?: (int)(buf_len - blen);
+
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

