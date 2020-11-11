Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3078D2AE9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKKHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKKHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:55 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:54 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b3so495976pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7dfr0gdU7QkmojWsQ1BqOPkq46FhU/zAtg88uY4LJA=;
        b=IucPxSSBVPYnphlppoBN3gdz4yrBqNUNpAfg3Itb7UUCJUqSxI37GgPltvlRILoIKq
         5XXEfbA9+AvXp4B5fozmEZG0VFV/VbQSgEuCwhsBKrlYx0ciJwNj+Oq6chq6PoBXPn7A
         qvKSYBrQuBLIYDNSUvMIwqtIAf9GzhK8df9sX6pDh0YxIW3ev/DKFFytmE7IMPnaV1ZK
         GTmLhgBileaSzv7fodBYYbtn9Yna2g1E4YlS2dcj5rEAUNVcuXNyGcNHf9VobWF/C1Lw
         fl+tPiRvLM9McT22QTzclzaFJqVefsXIRqAqa5votVJ8ydWW62VRcaTY6c8EcZ78dayY
         3bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7dfr0gdU7QkmojWsQ1BqOPkq46FhU/zAtg88uY4LJA=;
        b=orzGai9wx3/aGoiNjrz7Lt/GZXLg2L8h6sZrWqQpv3tAUOP8L4FAx3Iwe5JcBDLqIt
         D+5zKwhDJ9UqTO//oGFuiCZnB8k0fAYCd+uCsFKToHMr//glPPl6RdZc9ZdmLKWHOik4
         Luudl1g85eUedUEXkng6WJDUAF/yfsh2FOhUKfS8t7QKI+IpaGMbk9tev2zNHtSYfQ/C
         WgOdqVfpbTWdWEEmvaxNHIPCRJhtdY7C40ECKoOjSsD3vnV5mznTsxEc0i1jtF9H8re7
         b+NXpZJFKETIxvyrcAN5UVzStd2DgeTlFZEzSLQ6XeaIezTK3uzvrz695zQI0Juhv0Tw
         qn6Q==
X-Gm-Message-State: AOAM532fwVBBj75NwF1Vcz8s2LYDsyhI8YJkbywcWf5xMq8HAjBNzYyG
        h069odM6mwKN2cEWtRH9XIpJuw==
X-Google-Smtp-Source: ABdhPJxAB2Km/ZlMaRSHoCoESJ8k4oMCo0OQ+oUu8EU/fVING09pFauVTqzqzwtfcD6SiNghJf5RnQ==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr2360390pju.99.1605078774245;
        Tue, 10 Nov 2020 23:12:54 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id u10sm1323776pfn.101.2020.11.10.23.12.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:53 -0800 (PST)
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
Subject: [PATCH v8 09/22] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Wed, 11 Nov 2020 15:11:36 +0800
Message-Id: <20201111071149.815-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 64 +++++++++++--------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a43880e06547..0aa15632e87b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -288,10 +288,46 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
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
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				"%s 0x%llx el%d ns=%d",
+				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				     "VA 0x%llx", payload);
+		break;
+	case 3:
+		ns = !!(packet->payload & NS_FLAG);
+		payload &= ~(0xffULL << 56);
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				     "PA 0x%llx ns=%d", payload, ns);
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
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ns, el, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	char *buf_orig = buf;
@@ -373,31 +409,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
 		break;
 	case ARM_SPE_ADDRESS:
-		switch (idx) {
-		case 0:
-		case 1:
-			ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					"%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     "VA 0x%llx", payload);
-			break;
-		case 3:
-			ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     "PA 0x%llx ns=%d", payload, ns);
-			break;
-		default:
-			/* Unknown index */
-			err = -1;
-			break;
-		}
+		err = arm_spe_pkt_desc_addr(packet, buf, buf_len);
 		break;
 	case ARM_SPE_CONTEXT:
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
-- 
2.17.1

