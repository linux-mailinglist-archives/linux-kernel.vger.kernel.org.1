Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B92296153
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368445AbgJVO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368391AbgJVO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE4C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so2626131wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QvQ47HzCCJo3p61BZ7V9gOyETm7R4zyuNVw2t+GK0V8=;
        b=tV9+LNBg5aSwLGfuTvW0mXfIsWk1LS3QeyEhB9K+2EsOpa/qhKl45e6xX/t4a2OdfQ
         ugm3810HY08FHH5fTg2AGvGggImFt0BNS+3Eov5d86tPiOXswIPZ7kZ0Z09muUwNEFKK
         5w+HNWPf6hzqcpO1gyWEdGN14rLhDjTykXyGHVDWrOLPUBAlzYG81uDePKRgk0tlt477
         sQLa2xX09eenIQUFZzFRW1vqtVuc6D/Bvv9dyaoUk0bxFpqMEkGGcWec8XhEFOXRFzNN
         u26Za6i4upWc/lbLw9Fd5Y5lY1z5FO48EqG5eu5FUQDfK7BWlhtGVlt6dbFhVrOpZdHP
         smpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QvQ47HzCCJo3p61BZ7V9gOyETm7R4zyuNVw2t+GK0V8=;
        b=QepdBJ749GEEgPz0MFGawYtxl77ERSJqdf7ewkGpF/RlNaZd1Gp0AN/NGHh5IAM8Yt
         PmlkQFPPZEnlaDRGotmFvqn5R4t0y/25DmUUqD7Gkr901lIk65iIH5s8iLI8Hk2ZHVz0
         oSfjnrkFw7sWExJEaB6FqG83/RMnLGpygKeYIG5xx3TW/7Iqx5khrE+hqG02OUf/dZSJ
         0q8bWHCPSOleGr9+lyM4OKJIZn1S5JGFip3A010HZuyGsJd2rarWmweGclIREi2YriSY
         H3FKZnTwy/8IYL8QZxrES5kXTVVxYvNvkgeR6glYjS5IL7WPERUGPPiRtULVzJ9Owfat
         OvuA==
X-Gm-Message-State: AOAM530UrixRLE1xj1FUWj7LSVmi8aXm0AOzNbDTKlyn5gCW7eJlzdE9
        RFeJqSNi9CiVsZUQjfbKu07ITg==
X-Google-Smtp-Source: ABdhPJwHt79TtLNiLlAZ6eWinUCVK+WXre8ezmxWTd0qlYBq+0wMo6Jt1JVJn5wZsZjkZgh90o37CQ==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr2925550wma.178.1603378729555;
        Thu, 22 Oct 2020 07:58:49 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:48 -0700 (PDT)
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
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 16/20] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Thu, 22 Oct 2020 15:58:12 +0100
Message-Id: <20201022145816.14069-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation type packet is complex and contains subclass; the parsing
flow causes deep indentation; for more readable, this patch introduces
a new function arm_spe_pkt_desc_op_type() which is used for operation
type parsing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 122 ++++++++++--------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 2cb019999016..19d05d9734ab 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -336,6 +336,70 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return buf_len - blen;
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	int ret, idx = packet->index;
+	unsigned long long payload = packet->payload;
+	size_t blen = buf_len;
+
+	switch (idx) {
+	case 0:
+		return arm_spe_pkt_snprintf(&buf, &blen,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+	case 1:
+		ret = arm_spe_pkt_snprintf(&buf, &blen,
+					   payload & 0x1 ? "ST" : "LD");
+		if (ret < 0)
+			return ret;
+
+		if (payload & 0x2) {
+			if (payload & 0x4) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
+				if (ret < 0)
+					return ret;
+			}
+			if (payload & 0x8) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
+				if (ret < 0)
+					return ret;
+			}
+			if (payload & 0x10) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
+				if (ret < 0)
+					return ret;
+			}
+		} else if (payload & 0x4) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
+			if (ret < 0)
+				return ret;
+		}
+
+		return buf_len - blen;
+
+	case 2:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
+		if (ret < 0)
+			return ret;
+
+		if (payload & 0x1) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
+			if (ret < 0)
+				return ret;
+		}
+		if (payload & 0x2) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
+			if (ret < 0)
+				return ret;
+		}
+
+		return buf_len - blen;
+
+	default:
+		return 0;
+	}
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -403,7 +467,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ret, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	size_t blen = buf_len;
@@ -416,61 +480,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_EVENTS:
 		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			return arm_spe_pkt_snprintf(&buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-		case 1:
-			ret = arm_spe_pkt_snprintf(&buf, &blen,
-						   payload & 0x1 ? "ST" : "LD");
-			if (ret < 0)
-				return ret;
-
-			if (payload & 0x2) {
-				if (payload & 0x4) {
-					ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
-					if (ret < 0)
-						return ret;
-				}
-				if (payload & 0x8) {
-					ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
-					if (ret < 0)
-						return ret;
-				}
-				if (payload & 0x10) {
-					ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
-					if (ret < 0)
-						return ret;
-				}
-			} else if (payload & 0x4) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
-				if (ret < 0)
-					return ret;
-			}
-
-			return buf_len - blen;
-
-		case 2:
-			ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
-			if (ret < 0)
-				return ret;
-
-			if (payload & 0x1) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
-				if (ret < 0)
-					return ret;
-			}
-			if (payload & 0x2) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
-				if (ret < 0)
-					return ret;
-			}
-
-			return buf_len - blen;
-
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
-- 
2.17.1

