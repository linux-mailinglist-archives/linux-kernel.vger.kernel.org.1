Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F629FBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJ3C6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgJ3C61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB78C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c20so4023460pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FncvX4hf1R3bJQc0rquZ7Scowd75RYDbwAbQhhIPCbs=;
        b=FvX5OweLhighMPW5T7CUQa36ue4KeR/SM4pf8lTOyyd5FGXmZzIWSsJ+fZJoY4d712
         Ux8TYoRI4QlxDi6qokE2CXHdanuLYh5xHgzcdjWOPN1dOHqbyUrJ5BwjQr7JVRy+x63C
         yw97dIGXyZt7CgEBcpZofTWEbwt/yWC/+XtoXy5nRCtcuItXP2ZB2EUjC9xadm06TIbR
         pq0AQJ4RP9i0UnmsnNJjFy6BiW19g9mVknHklX33XDfpHutlljkQb3USRgB0YyTvIkDF
         gFGOk7RzTSdR+xmuCu3YzbI9A5mqnvSyQxdEaKgYmCaKhcW92CIDxgK1meBNXBuPRfE9
         OBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FncvX4hf1R3bJQc0rquZ7Scowd75RYDbwAbQhhIPCbs=;
        b=HbLaWhQwEvF67bmGLhtRvqKbjQxXkzn9xxUzoUAeahrbM2agCzSQPjnlP+hFw/x09d
         SXaTgbEBGt7G9xtrtu/Zv3EEPEcasJgLH27I19KO5KeO/1KPTRuzhZa6irK2CJrfeQwy
         B2RpHKuhWltI4nlcTwKz4qxhzwgT5imqNzXj0+/00EEIH80mBcOScLOMIAoAynO5Gtc/
         BP2zoyMZk/OYmQEHO1vOGZlaRAiPbehew9M+TzgxUptcOpYpbsfwvKkf6MpmGZb4koKK
         Qgbh12Qv0OLRMOryNyIL5VTiCqIuU5vFAcRgUZp1DnRidXna8XGg/KSKX9kQffKtAocb
         O3Lg==
X-Gm-Message-State: AOAM531grtnx8+iRSaD9AdRk9BQUHtjoy0WW1xW/E3mM56RMx/JGm2Se
        ZkfCfa/3cV++NSBeZVEHv2dAlQ==
X-Google-Smtp-Source: ABdhPJxEGyO7T3nlUqB6e50fC1uv0EoNQcsbNrXvez9Qaf/lr4EOBFDmn+TraUnmRCXK5kuNTZzZFA==
X-Received: by 2002:aa7:908d:0:b029:15f:d774:584 with SMTP id i13-20020aa7908d0000b029015fd7740584mr6966261pfa.6.1604026706713;
        Thu, 29 Oct 2020 19:58:26 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id b128sm3869538pga.80.2020.10.29.19.58.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:26 -0700 (PDT)
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
Subject: [PATCH v6 08/21] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Fri, 30 Oct 2020 10:57:11 +0800
Message-Id: <20201030025724.19157-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 50 ++++++++++++-------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 30d6c987c287..ae68cd788e33 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -274,10 +274,39 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
+				 char *buf, size_t buf_len)
+{
+	int ns, el, idx = packet->index;
+	u64 payload = packet->payload;
+	int err = 0;
+
+	switch (idx) {
+	case 0:
+	case 1:
+		ns = !!(packet->payload & NS_FLAG);
+		el = (packet->payload & EL_FLAG) >> 61;
+		payload &= ~(0xffULL << 56);
+		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				"%s 0x%llx el%d ns=%d",
+				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+	case 2:
+		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+					    "VA 0x%llx", payload);
+	case 3:
+		ns = !!(packet->payload & NS_FLAG);
+		payload &= ~(0xffULL << 56);
+		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+					    "PA 0x%llx ns=%d", payload, ns);
+	default:
+		return 0;
+	}
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ns, el, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	size_t blen = buf_len;
@@ -356,24 +385,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
-		switch (idx) {
-		case 0:
-		case 1: ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-					"%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-						    "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-						    "PA 0x%llx ns=%d", payload, ns);
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_addr(packet, buf, buf_len);
 	case ARM_SPE_CONTEXT:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
 					    name, (unsigned long)payload, idx + 1);
-- 
2.17.1

