Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2129FBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgJ3C7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgJ3C6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9947C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r3so2288646plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B5GzjEJjEgLQbnJDqua8ZaeQgReipIrlnz4wbGqIH1Y=;
        b=f809R6TUAEW24iKTIpElM0448xUjZdjJCIXwncQFcqMHyrxgCr40HS+hO2Ig8NHVSM
         oOd35LUbNkE91IMs5UUnNmtOjWSxHmg9GMjYCX70R6YV8nYRxtualrHY8HaAvHb6cy7r
         vMjva2dpjOqoxNwAc9lpMIE31MwEXbxzNcM3v72Qqh1oq53ww5AxgjS9vgpY7qQbNx6m
         tQSci26GobK7W0ZqTVt0WoycwBdgtwl2ngHCVU5ItBA4CxPOYKgnKi4RxaRl1hZg3aBq
         914IwvZaq1NHpbU07d2UsR0wsUs1TgTFpr7sblsX7PP1coGhU/F6phy+eHZw1YRFj5YE
         twYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B5GzjEJjEgLQbnJDqua8ZaeQgReipIrlnz4wbGqIH1Y=;
        b=onNmhQBUapy41ZknBfhNh1ytkotKms8Zqq3oYQ7KzmgDUpgEjGpEsip27CzcZz6e0D
         Es8RIFeUcyDfDHel4uy/fOfZ5ciSOLvysV3CslQks2OLMxHrPDUA+hQoXM6nwOOxBrms
         ojgXgtgEZQ0JbIJybr6kRVG1CHMmi8vpupsYaoFdPYXkDq4Dvyi8xoeyQI1efAYoAO4V
         sPcLrj0bzLNocUcWSZwkXvVzXAiIXAhvYE4pdq9Rw7b5uF3BULTpijvILw7gq47jjDsx
         hdcuh4J2hFcKT32/8w+kq0gCQx1/C2Fob08/YpIqYYwUEdyw/qBdWD60nBN3AE3/oQmM
         ovcg==
X-Gm-Message-State: AOAM533HiY056kpMfvXxtXD0ZRLvdfiqMKWeTxkVrsSyGSYCs1Rqo7Ls
        ozzCum5CjLI1Y8zjxigNrq9OZg==
X-Google-Smtp-Source: ABdhPJxxs15o4C/ZR5c3Bu3kBY54o7TUNGBSZkDn5w6O3S4gWTgRqBCHqySD2K3sLGGGGphF6msS9g==
X-Received: by 2002:a17:902:8bc4:b029:d6:88c3:ea41 with SMTP id r4-20020a1709028bc4b02900d688c3ea41mr6030100plo.53.1604026696222;
        Thu, 29 Oct 2020 19:58:16 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id k7sm4293969pfa.184.2020.10.29.19.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 06/21] perf arm-spe: Refactor printing string to buffer
Date:   Fri, 30 Oct 2020 10:57:09 +0800
Message-Id: <20201030025724.19157-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 267 ++++++++----------
 1 file changed, 117 insertions(+), 150 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 04fd7fd7c15f..1ecaf9805b79 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -9,6 +9,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <linux/bitops.h>
+#include <stdarg.h>
 
 #include "arm-spe-pkt-decoder.h"
 
@@ -258,192 +259,158 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
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

