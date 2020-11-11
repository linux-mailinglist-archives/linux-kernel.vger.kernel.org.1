Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49A2AE9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKKHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKKHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:14:26 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76282C061A4B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:27 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x13so1057206pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkc6abxqhANiOnEXKEdBYwP6x6Xfev71i31URK+LSvc=;
        b=b96/7jqGZ71xI37TvtYG+ML6oGa0iyKBdlht48VIZapSm2RgcByBCMebNfEGhrJvpn
         jYRzrors6J71vG+EByybt7nbFAQy7SVQm3Cv7z5YkMlzf4I7X4vAUXDuKScDJz02lPLJ
         o3FKqQGOU5C+ggSHL+PQtyULfX5viFZ9fiJ28mczp++bCfxNdSIGcs3QNZNO8Y3tiCYG
         q9MV0HrvwQ5oBl0la833s+teU7M1bXxEBUj5QxKmeklN55S+AQCfhihkdgfdC4k4hzUe
         XJFA7j6DRv8k5IW9A77N4mhQTHNN9W+J/UCK+bDDtKCANL2kENTSmzGfwz3S8AYtE2ky
         hz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkc6abxqhANiOnEXKEdBYwP6x6Xfev71i31URK+LSvc=;
        b=ammqiUdmLUo0QDMBJ+/+i+698OgpTkpsDc89l+g0CVg4eS79Gtll2ymM8UzLVSx4+/
         prTV/s/zPOCqtoe3DMyK+Od8Qo5o/yf2CgMdTGtkTgU6eT3DFKItwmUg0UfWvkaRfjoZ
         uAxCiB0nxFeggbY1Ppuw+5QRL+ylTKL4o7iLd0fTQ7SaOifpQdUfhaCZkOCxLRypRn5R
         CWsMAU7dqoRGHFL2G2njfTGzjVLAizM8G6OeKIkdNYT2Q8OlIolyX10tBpSb7/FiGVYt
         EKugeZY7ml0RGvHsCod61Hz6hRcRMpUo6NHKVelv5AAdcs4IIi5g68gM106Muje8IuxZ
         K7hA==
X-Gm-Message-State: AOAM5332OIftHl93FZtdI6R1HMucXkeaQozKXV8aYzdBa+Z38SvSE5Zj
        9sjcIiBIQ2NbQDAI40fJodtQOQ==
X-Google-Smtp-Source: ABdhPJzk9Kk826vTx/43FNU5/zgznQRrTo0816CCyNWhA+TNbskB5z6UmZtTAZTlXIDWT8WK2jzdVQ==
X-Received: by 2002:a63:cb47:: with SMTP id m7mr8468065pgi.395.1605078806911;
        Tue, 10 Nov 2020 23:13:26 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id n6sm1330715pfj.209.2020.11.10.23.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:26 -0800 (PST)
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
Subject: [PATCH v8 18/22] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Wed, 11 Nov 2020 15:11:45 +0800
Message-Id: <20201111071149.815-19-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 79 +++++++++++--------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 64811021f36c..4f93b75c87e6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -321,6 +321,50 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return err;
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	int err = 0;
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+		break;
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				     payload & 0x1 ? "ST" : "LD");
+
+		if (payload & 0x2) {
+			if (payload & 0x4)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AT");
+			if (payload & 0x8)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EXCL");
+			if (payload & 0x10)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AR");
+		} else if (payload & 0x4) {
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SIMD-FP");
+		}
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "B");
+
+		if (payload & 0x1)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " COND");
+		if (payload & 0x2)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " IND");
+
+		break;
+	default:
+		/* Unknown index */
+		err = -1;
+		break;
+	}
+
+	return err;
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -404,40 +448,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		err = arm_spe_pkt_desc_event(packet, buf, buf_len);
 		break;
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-			break;
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
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
-
-			if (payload & 0x1)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
-			if (payload & 0x2)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
-
-			break;
-		default:
-			/* Unknown index */
-			err = -1;
-			break;
-		}
+		err = arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 		break;
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
-- 
2.17.1

