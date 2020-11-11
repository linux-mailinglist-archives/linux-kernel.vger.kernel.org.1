Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C772AE9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKKHWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgKKHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074B8C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g19so224871pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g57WnyAXB6XG6sB8Q66AkBeHrlJQnF2VGdExqrGQCRE=;
        b=oFbsVRWHW+IlquO8RBs0cBIvaC05E+00wrvkkWPFuJSr8zWu8CTTBxEtg3RI5QcYwE
         X876G7HaxbaCYlySWqbpmwncB30DWm4bIvHKQPcchrTY6hoqoanpJXyiySK6xmGOv6sD
         xnL6LvA5h9Dz6rbnsvcZqKsmQy5HgHzxpvyxBlnhdBQT8b+ur5sIA+qRAoY9cb3k4mW3
         ZTcwF2th92VKIjkGRmBhXefNB+ogHag6xeGQBvkIApcS4z4EdP2q+Wm3AtwvJDs00Pnp
         FimkkWpt7H6aBmvpvgGJB8Fyv+UNAbofooFqpCS0JCZMhypDYhMtTmrPp64N3EGnisNS
         zPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g57WnyAXB6XG6sB8Q66AkBeHrlJQnF2VGdExqrGQCRE=;
        b=eNHD6k8+mQceFQV1gu04iejHFovnYl257pAtVQJHk0+be1fUTkqFOF7CQzs9U20azH
         vXp8p4peVnr0JXOj6G8j12byK3udcImUornZmsQpTKrFOarPyDU01UvaA02apgHLdiIZ
         Vk2wxnssCtnmPsa9n9r+inKTAoLQm4fRxX9sw//2nxTimOrqIYATgsI2hZv9D8cf+YyB
         MbubQXncaxqc7FHHjZEq5XbsC0nRnzI8K89brMDKVCoNSJoBAGBJcxJ4XuK/90eNfYvG
         FViC6MUMDeo+BT/Zam9oUVGZYhwqI466xA/eLFdBNSagh7mVYJOlCQQUGD+4awLre4KU
         4p9g==
X-Gm-Message-State: AOAM532pS6swzKUl+OdSVDrSH6bf9PBZINJLOwSFquzy6WFh9UGDkcyH
        diYu+yobGEKvjTtfurZKMfKAxA==
X-Google-Smtp-Source: ABdhPJzB/ZRVoAUF6AR49gLUNFis+x86CjiT4NmeOQiHA2nE5YCZ8bMO2/hLkK1O6WKRwobfIy5IJg==
X-Received: by 2002:a17:90b:d18:: with SMTP id n24mr2682265pjz.206.1605078766533;
        Tue, 10 Nov 2020 23:12:46 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id v196sm1364773pfc.34.2020.11.10.23.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:45 -0800 (PST)
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
Subject: [PATCH v8 07/22] perf arm-spe: Consolidate arm_spe_pkt_desc()'s return value
Date:   Wed, 11 Nov 2020 15:11:34 +0800
Message-Id: <20201111071149.815-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm_spe_pkt_desc() returns the length of consumed the buffer for
the success case; otherwise, it delivers the return value from
arm_spe_pkt_snprintf(), and returns the last return value if there have
multiple calling arm_spe_pkt_snprintf().

Since arm_spe_pkt_snprintf() has the same semantics with vsnprintf() for
the return value, and vsnprintf() might return value equals to or bigger
than the parameter 'size' to indicate the truncation.  Because the
return value is >= 0 when the string is truncated, this condition will
be returned up the stack as "success".

This patch simplifies the return value for arm_spe_pkt_desc(): '0' means
success and other values mean an error has occurred.  To realize this,
it relies on arm_spe_pkt_snprintf()'s parameter 'err', the 'err' is a
cumulative value, returns its final value if printing buffer is called
for one time or multiple times.

To unify the error value generation, this patch handles error in a
central place, rather than directly bailing out in switch-cases,
it returns error at the end of arm_spe_pkt_desc().

This patch changes the caller arm_spe_dump() to respect the updated
return value semantics of arm_spe_pkt_desc().

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 128 +++++++++---------
 tools/perf/util/arm-spe.c                     |   2 +-
 2 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 1970686f7020..424ff5862aa1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -301,9 +301,10 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ret, ns, el, idx = packet->index;
+	int ns, el, idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
+	char *buf_orig = buf;
 	size_t blen = buf_len;
 	int err = 0;
 
@@ -311,82 +312,76 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_BAD:
 	case ARM_SPE_PAD:
 	case ARM_SPE_END:
-		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
+		break;
 	case ARM_SPE_EVENTS:
-		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
 
 		if (payload & 0x1)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
 		if (payload & 0x2)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
 		if (payload & 0x4)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
 		if (payload & 0x8)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
 		if (payload & 0x10)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
 		if (payload & 0x20)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
 		if (payload & 0x40)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
 		if (payload & 0x80)
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
 		if (idx > 1) {
 			if (payload & 0x100)
-				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
 			if (payload & 0x200)
-				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
 			if (payload & 0x400)
-				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
 		}
-		if (ret < 0)
-			return ret;
-		blen -= ret;
-		return buf_len - blen;
+		break;
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
 		case 0:
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+			arm_spe_pkt_snprintf(&err, &buf, &blen,
 					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+			break;
 		case 1:
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen,
-						   payload & 0x1 ? "ST" : "LD");
+			arm_spe_pkt_snprintf(&err, &buf, &blen,
+					     payload & 0x1 ? "ST" : "LD");
 
 			if (payload & 0x2) {
 				if (payload & 0x4)
-					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
+					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
 				if (payload & 0x8)
-					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
+					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
 				if (payload & 0x10)
-					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
+					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
 			} else if (payload & 0x4) {
-				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
 			}
-
-			if (ret < 0)
-				return ret;
-			blen -= ret;
-			return buf_len - blen;
-
+			break;
 		case 2:
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
 
 			if (payload & 0x1)
-				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
 			if (payload & 0x2)
-				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
-
-			if (ret < 0)
-				return ret;
-			blen -= ret;
-			return buf_len - blen;
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
 
+			break;
 		default:
-			return 0;
+			/* Unknown index */
+			err = -1;
+			break;
 		}
+		break;
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
-		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
+		break;
 	case ARM_SPE_ADDRESS:
 		switch (idx) {
 		case 0:
@@ -394,48 +389,59 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 			ns = !!(packet->payload & NS_FLAG);
 			el = (packet->payload & EL_FLAG) >> 61;
 			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
+			arm_spe_pkt_snprintf(&err, &buf, &blen,
 					"%s 0x%llx el%d ns=%d",
 				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
+			break;
 		case 2:
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-						    "VA 0x%llx", payload);
+			arm_spe_pkt_snprintf(&err, &buf, &blen,
+					     "VA 0x%llx", payload);
+			break;
 		case 3:
 			ns = !!(packet->payload & NS_FLAG);
 			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-						    "PA 0x%llx ns=%d", payload, ns);
+			arm_spe_pkt_snprintf(&err, &buf, &blen,
+					     "PA 0x%llx ns=%d", payload, ns);
+			break;
 		default:
-			return 0;
+			/* Unknown index */
+			err = -1;
+			break;
 		}
+		break;
 	case ARM_SPE_CONTEXT:
-		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
-					    name, (unsigned long)payload, idx + 1);
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
+				     name, (unsigned long)payload, idx + 1);
+		break;
 	case ARM_SPE_COUNTER:
-		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
-					   (unsigned short)payload);
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
+				     (unsigned short)payload);
 		switch (idx) {
 		case 0:
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
 			break;
 		case 1:
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
 			break;
 		case 2:
-			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
+			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
 			break;
 		default:
-			ret = 0;
 			break;
 		}
-		if (ret < 0)
-			return ret;
-		blen -= ret;
-		return buf_len - blen;
+		break;
 	default:
+		/* Unknown index */
+		err = -1;
 		break;
 	}
 
-	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
-				    name, payload, packet->index);
+	/* Output raw data if detect any error */
+	if (err) {
+		err = 0;
+		arm_spe_pkt_snprintf(&err, &buf_orig, &buf_len, "%s 0x%llx (%d)",
+				     name, payload, packet->index);
+	}
+
+	return err;
 }
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3882a5360ada..8901a1656a41 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -113,7 +113,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 		if (ret > 0) {
 			ret = arm_spe_pkt_desc(&packet, desc,
 					       ARM_SPE_PKT_DESC_MAX);
-			if (ret > 0)
+			if (!ret)
 				color_fprintf(stdout, color, " %s\n", desc);
 		} else {
 			color_fprintf(stdout, color, " Bad packet!\n");
-- 
2.17.1

