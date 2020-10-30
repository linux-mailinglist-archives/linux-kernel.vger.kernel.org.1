Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928CF29FBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJ3C7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgJ3C7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24033C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j5so2275363plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcb0Ae6y/hKnMEhcOkT2hBOvLU9DZU0XejKxPIgMjHI=;
        b=w1lHNyCxtXaViTAhl8ZjQev2a5RbweOFW52xxSG/tcmKi4BJX3taTx06JEbq/5lwg+
         fxZ5aoGaVBA70p7oRKi82OqCjK43yvzKT4l+ZFFWKN724pEqyDBvQ5IKatF70d+lJAQ5
         mCskY4shQJpV5q95n8js/PlTpc2NqA0KVbBwXlEB9swpP5kbmrYgePcxMIg7FQKWCfyX
         GKMMjUSyOzc+ihuLFtdmsC3GFRzXYFvTslVrk+9hfQtLLE7YccaJZjyHeW5ipv9BX2Vt
         G8PsWE3AeibWH1RKrZ1DQMATVUjbmPj/e+fwg4/Be4lz+wkJ19C09oFhyyYC8ymmY7g+
         LWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcb0Ae6y/hKnMEhcOkT2hBOvLU9DZU0XejKxPIgMjHI=;
        b=bs6cdQ3e+BP3tIZ/elQ7jIdwkEawvyNjGzOo1a9WnootB74QP8xqxVf+ZO8k329EJ2
         nzc3cOb/+vscC6mEUznK7Ea1vByk6kIsikjl51Rpn+SjRL08XIjdu3r8plu+67eba5sU
         o1QzwMWvbSpI1H9rUtauv/H20+JYLhZPuGy2+7YvtgP58GPkpScKt1gEuBZvfAwIKaWE
         HqVGi4xtlBLSwkynGGMA/Y6X3Q5OU4zLqI0cK0zEnHqijdb/YpC4zFyIjzTuFAXOMRZH
         Bmm01K5kevj6TmjKF+BW1JBXAPjB0G9qGz45K8WXhlKnBwJ9qVLuZytRi0xMtQIXAY1g
         IWnA==
X-Gm-Message-State: AOAM530r/AUPkZTyda+nQpMKMi8C5BkzpP8L/Haxjho9swBM4i2GjclD
        MLA1Fr8s+TxDKPSZmZDTyckPLg==
X-Google-Smtp-Source: ABdhPJxOSU7xrMjaJ6bu/GlRCI0NlwkdKLleKfRZY4EsfN3GTW6Q3BhG0a4hQYLfwDIh39G1TyQstQ==
X-Received: by 2002:a17:902:143:b029:d2:564a:5de8 with SMTP id 61-20020a1709020143b02900d2564a5de8mr6876309plb.74.1604026754678;
        Thu, 29 Oct 2020 19:59:14 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a2sm4225886pfo.11.2020.10.29.19.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:59:14 -0700 (PDT)
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
Subject: [PATCH v6 17/21] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Fri, 30 Oct 2020 10:57:20 +0800
Message-Id: <20201030025724.19157-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation type packet is complex and contains subclass; the parsing
flow causes deep indentation; for more readable, this patch introduces
a new function arm_spe_pkt_desc_op_type() which is used for operation
type parsing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 78 +++++++++++--------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 07934e1eedca..1616a88db9ba 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -308,6 +308,49 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return err ?: (int)(buf_len - blen);
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	size_t blen = buf_len;
+	int err = 0;
+
+	switch (packet->index) {
+	case 0:
+		return arm_spe_pkt_snprintf(&err, &buf, &blen,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &blen,
+				     payload & 0x1 ? "ST" : "LD");
+
+		if (payload & 0x2) {
+			if (payload & 0x4)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
+			if (payload & 0x8)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
+			if (payload & 0x10)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
+		} else if (payload & 0x4) {
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
+		}
+
+		return err ?: (int)(buf_len - blen);
+
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
+
+		if (payload & 0x1)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
+		if (payload & 0x2)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
+
+		return err ?: (int)(buf_len - blen);
+
+	default:
+		return 0;
+	}
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -382,40 +425,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_EVENTS:
 		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-		case 1:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     payload & 0x1 ? "ST" : "LD");
-
-			if (payload & 0x2) {
-				if (payload & 0x4)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
-				if (payload & 0x8)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
-				if (payload & 0x10)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
-			} else if (payload & 0x4) {
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
-			}
-
-			return err ?: (int)(buf_len - blen);
-
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
-
-			if (payload & 0x1)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
-			if (payload & 0x2)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
-
-			return err ?: (int)(buf_len - blen);
-
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
-- 
2.17.1

