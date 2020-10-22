Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C8296158
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368490AbgJVO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368356AbgJVO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so2850638wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UI+mgE4tbTyna6zih8exUNWsRdMZUNItX/nEsflccks=;
        b=ZORP1MUV7OmTOY0cPI75EHCKLLPFLEBhrvAFFQqrMgoEpAOw1/New/SD6igXiSt/8j
         7S3zlDrOgS8QcwOV/wMN/7Ie3To3vFUikbijVkyil8uYkz1m8TbvOsr7IPDn60+rc82P
         2a32foXkMV5xa4umByVg9xUlhupS4T+6hfR76CQIFemDCd7/3EnrpYMU6+tq1w+Hg8RA
         QrzZaghxV1eIgdosvkznvVpLFR7ucbLdT1mwB+fxqiLW/5+A0UJh2aU/1UL2IEvJb15i
         WxGnhB1hy6PprpOQ1pfCh42gtuk/Q4HIrslNyBVJuzGMa8NKG62gwIsDJSTL4t5fqRt9
         W77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UI+mgE4tbTyna6zih8exUNWsRdMZUNItX/nEsflccks=;
        b=hPblZuU9igi1cSRmwOz/IsVc/Oa35N/Pcj4nXQ9kIN8aBQVTJkYT6x9Nh6N3N0A3eA
         tmBJQUKr2tvEOytYv+1PzQUW1m2Fnj0ImKffHfjkOUN8pgU8VEjJhddXpIiXgbW0D16v
         mUD55wxGvGQyNPTdg0ZwPDeze8uTqH3myaEb2TMZSVU3bvadm0IUOgAMxb9Yn6Gw3zwo
         aHfVdyqg2Cs7aDUDBLQBW98JVIU5NdI3hR2nI49l+/cURudSNaSj8WdKlLcimvQc19A6
         HRJRxgOI6BLn2TyIu7dXDeUkJZuOLkZLg46Cn6VRbdAtwPiFWScj3I3fpznW9R45XS3m
         w8sA==
X-Gm-Message-State: AOAM531/uMvtSmJQyX7j1cB2quortuyKOp/co1MDjvllW/cfJVuTEuLQ
        dTh3cm0Q6rsgXLi5aEAbjLWbrQ1199dlUy7w
X-Google-Smtp-Source: ABdhPJw2F1JuTbBNU457plUlfTbE6jB7+JI72oR0+mto8v0s1dEbRbyIFLxWn3J0NrhJhI+dG/Pkzw==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr3165372wrs.412.1603378719345;
        Thu, 22 Oct 2020 07:58:39 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:38 -0700 (PDT)
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
Subject: [PATCH v3 08/20] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Thu, 22 Oct 2020 15:58:04 +0100
Message-Id: <20201022145816.14069-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 49 ++++++++++++-------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 6f2329990729..550cd7648c73 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -267,10 +267,38 @@ static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
+				 char *buf, size_t buf_len)
+{
+	int ns, el, idx = packet->index;
+	u64 payload = packet->payload;
+
+	switch (idx) {
+	case 0:
+	case 1:
+		ns = !!(packet->payload & NS_FLAG);
+		el = (packet->payload & EL_FLAG) >> 61;
+		payload &= ~(0xffULL << 56);
+		return arm_spe_pkt_snprintf(&buf, &buf_len,
+				"%s 0x%llx el%d ns=%d",
+				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+	case 2:
+		return arm_spe_pkt_snprintf(&buf, &buf_len,
+					    "VA 0x%llx", payload);
+	case 3:
+		ns = !!(packet->payload & NS_FLAG);
+		payload &= ~(0xffULL << 56);
+		return arm_spe_pkt_snprintf(&buf, &buf_len,
+					    "PA 0x%llx ns=%d", payload, ns);
+	default:
+		return 0;
+	}
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ret, ns, el, idx = packet->index;
+	int ret, idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	size_t blen = buf_len;
@@ -404,24 +432,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
-		switch (idx) {
-		case 0:
-		case 1: ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&buf, &blen,
-					"%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:
-			return arm_spe_pkt_snprintf(&buf, &blen,
-						    "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&buf, &blen,
-						    "PA 0x%llx ns=%d", payload, ns);
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_addr(packet, buf, buf_len);
 	case ARM_SPE_CONTEXT:
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%lx el%d",
 					    name, (unsigned long)payload, idx + 1);
-- 
2.17.1

