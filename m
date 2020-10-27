Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089EB29A2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440901AbgJ0DKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38243 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440635AbgJ0DKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id i26so6875038pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nR8tfefa4Y9xjF9y9XwwIkWaWPzRaYzf5FoTEH+uhdo=;
        b=MspCZozxAM8CSF0kfO9uLnHmFWmCM3tWcOaEHW5KAeOsbFUjvn13EExV9DzeswDFwW
         +4AD5N0OaW/t8oorQXgYDxXa4r/i1NORiTP27tyGr/Ir8deddmT87C0BPMtP54nrtZMt
         2x/rPRkp97hlJdcs5SC67cNV9eELCQXuvmN44hFTIMuxmpCiOD7fvubmI4T8vwGJSed8
         xkzR3adxIPLRwMsoq3wBx45BYimlPc6uR/C0+1hZ02Xo8Iw4kp3EyxG8AG46MSvxH+VU
         3Sng1x5sgTQSZdvP1qR4/GlwKJx50EaDJ16DAUhlTplXrBEe1izPeoKobFVP4lTcMrO3
         EpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nR8tfefa4Y9xjF9y9XwwIkWaWPzRaYzf5FoTEH+uhdo=;
        b=Pc9xxpIRanwFHnvXge4lOWSD5A4xkGX0C6I+GA0ai7szrz6PltbBdqCM9psBwHsJfH
         9+gbwWW6RtnwNgzX0w1FJ5pK/BzDiLTSCJwk+jp7FsqVn+Q+36pa6xAOnTyVLKgQ/xUt
         wXvR3mA7AK2NcFBJLEjROtT5kpH28b5DY3bVcIFOoYGN3SuAW3kajk3zdICefLOqWdhg
         A5JVA6K7KSOqa9c2S+lAOuccCVohK2RTppR/tzpQ+S8HC2E2KPqQZm1EGaYdGnknhnGP
         xrOjD65gL1d70BYBu5pWVTlAa5fZPQDSLHuoJm0U4UTwL5A9awoz7sYtk5S/wUOMhDeE
         fVUw==
X-Gm-Message-State: AOAM5303/1F+XbpgWelg00c0IxgIsRUUolderhYx4zjoVnd6UTkYZV3S
        uyByGuZeqqLNaajQl31p1USTWg==
X-Google-Smtp-Source: ABdhPJypGFKoXCM68S4K/CdtlIwmmkMfDhc/umZ9EX6IKMz52cNPtb5rviphei9NuPJ+GCWhZWItLw==
X-Received: by 2002:aa7:83c2:0:b029:156:5ece:98b6 with SMTP id j2-20020aa783c20000b02901565ece98b6mr376810pfn.4.1603768238809;
        Mon, 26 Oct 2020 20:10:38 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id t30sm164710pfg.126.2020.10.26.20.10.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 06/21] perf arm-spe: Refactor printing string to buffer
Date:   Tue, 27 Oct 2020 11:09:02 +0800
Message-Id: <20201027030917.15404-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 247 ++++++++++--------
 1 file changed, 135 insertions(+), 112 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 04fd7fd7c15f..b400636e6da2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -9,6 +9,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <linux/bitops.h>
+#include <stdarg.h>
 
 #include "arm-spe-pkt-decoder.h"
 
@@ -258,192 +259,214 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
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
+		return arm_spe_pkt_snprintf(&buf, &blen, "%s", name);
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
2.17.1

