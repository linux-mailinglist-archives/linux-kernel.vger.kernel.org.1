Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2E29E3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgJ2HVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgJ2HUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F72C08EBB0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o129so1617919pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+sG0vIdCrrbuR5rtT0M6sRfsz5oija9sA5/ljYuvE8=;
        b=XlzTyc/AnaW3EZWJKRvF/Ig2S2xIjbLN8d8dnWsdYv123SFmFHoojcWz00Phup/69Q
         8ajnl/y8uaOfx6TBhJGdYYFuxGd5m+5rPII122EY/RtKSgA5W9/I2Y6T89hlRlkEVRNW
         Vg1XSiCKVX3eRZdhOeOHmDR5M5CHJzKpxnJYpUNIyGOEV7Tpx3a/WezMrkiFF4P6rHZ4
         g05JZcp9uVXnDJKiPYPOP1iiNLNK11hwNKTPf413lXLB/YrXf+wNH/qntnFNDTOcCgyq
         mpOliRIE6hLNe5o1D4iLpo5fHBnc3ZWFmyVBDjefVEJ8n/tqVxzIaJTf7gjDR8Revt81
         W/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6+sG0vIdCrrbuR5rtT0M6sRfsz5oija9sA5/ljYuvE8=;
        b=XwDw9qHFFRqyjCIryaLCEGsfAIMOdwOFAsHaJ2xpElV0vEHSjOMSAIylTTXJgb5Qv1
         W3tQREZfOoaxGeS0c7gzMmYNSIbg7e86K+Atc6OqsZlzOYzjvN9FtvUgBZK65tB5AZSP
         o4PVUbJVgNLKGsE9ibPfbyyB6f+rf2ZWEMLNmdv0IFGIllsMWROWBK5ZuY7Sz6AQ58YZ
         t5ZjipXmYg/vrwxRuc1juuoYswMuRaNsofW7eQoOTRBuu41cim2XhygTzo4S+OtPRfqt
         miA88h2FVypPN3NYO2908NgFt3Qwj82JYTrVgWQFHMlmitG5BYk/V5qeN7u7gvhwRHQd
         hBFg==
X-Gm-Message-State: AOAM532D9lGZTXsIpnxJ0KdHn2LZ1HElK3sTjhqWXJc1uO2hjZn3Cf9n
        VgeWKVrioSQyQZuplyTzckOkZg==
X-Google-Smtp-Source: ABdhPJxh9tCpzSfyclGmPfLNJp4lf2P3cWOo8rLDdqpa6h9y/obtehM/+cnry5Kak5GGSF4JzCUYVg==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr2950375pjb.75.1603956049174;
        Thu, 29 Oct 2020 00:20:49 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d26sm1752861pfo.82.2020.10.29.00.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:48 -0700 (PDT)
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
Subject: [PATCH v5 14/21] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Thu, 29 Oct 2020 15:19:20 +0800
Message-Id: <20201029071927.9308-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the event packet parsing from arm_spe_pkt_desc()
to the new function arm_spe_pkt_desc_event().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 66 +++++++++++--------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index bc4b5a5a528b..6e4896327e56 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -269,6 +269,43 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
+				  char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	size_t blen = buf_len;
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
+
+	if (payload & 0x1)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
+	if (payload & 0x2)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
+	if (payload & 0x4)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
+	if (payload & 0x8)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
+	if (payload & 0x10)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
+	if (payload & 0x20)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
+	if (payload & 0x40)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
+	if (payload & 0x80)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
+	if (packet->index > 1) {
+		if (payload & 0x100)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
+		if (payload & 0x200)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
+		if (payload & 0x400)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
+	}
+
+	return err ?: (int)(buf_len - blen);
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -341,34 +378,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_END:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
 	case ARM_SPE_EVENTS:
-		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
-
-		if (payload & 0x1)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
-		if (payload & 0x2)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
-		if (payload & 0x4)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
-		if (payload & 0x8)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
-		if (payload & 0x10)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
-		if (payload & 0x20)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
-		if (payload & 0x40)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
-		if (payload & 0x80)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
-		if (idx > 1) {
-			if (payload & 0x100)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
-			if (payload & 0x200)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
-			if (payload & 0x400)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
-		}
-		return err ?: (int)(buf_len - blen);
-
+		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
 		case 0:
-- 
2.17.1

