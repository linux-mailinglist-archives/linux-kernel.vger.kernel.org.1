Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC129A2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441367AbgJ0DKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38322 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441245AbgJ0DKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so20448plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bRpApwwncU6dD1jy31O3HNoDwJk5z93hMofjzwSGj8I=;
        b=E/Saxvh+rq9RHqQcQBfebJJQmRtCOVeGvSmRGYx7ftLraH91Dxhyiw8+fMwJeXXtLp
         DzqSf0jbY83azPE2FowuVq8/pAes1DIXDIF5zpVA823GuVfl3g1TGEnJXsez0Nr80Ggg
         kXiW25a1hv+Xj9z6EZ8yYlBMuVGoymWRkvozqVgteyWVWnkpW/NJs5a3g9I7+Bf3PZsh
         dnh9y7E1TIfTdUSPLN5eaworks7Fkoar6/qBHrFCLx4Xkgb5BpWnmyLoHl3mE1vAsecI
         X1K25dgFMVJlXt1wujwjE9yfYSSmeE4toiasXmIJESXFs1Syv2p5BkYv5tOdSzqH1MJ9
         u5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bRpApwwncU6dD1jy31O3HNoDwJk5z93hMofjzwSGj8I=;
        b=ZunDyR9Oo8YqrqwnGfmXifGI7k7SYuFQMdzsfqbblXPwdHQFW1AzHJ8Q46niwzE2/6
         nkzdzQEx+zp+z/7+p4xyP6f9pvlQ0U5FY/S087IHhRfUlIUubhzth2ccgtlrB/plm+tr
         nLgcGJS+r4IQq7gIplpAO71GFi1zSilZ5gilFTGMJKkWh36KoTVvoutM4i37TqGKG7rz
         nzeGZtiBEDHziPs3glVxw7GNt/rd7JvUDCkfY1bZpRKVRUJ58urx21Wrk+9piVXuG5Rj
         gR6/htyEIIsOXpJZ+6GqBkjDyMcquUAmQXwv8gqrHCdpuGyC0AYud6fTlldFupW98WbY
         1yKg==
X-Gm-Message-State: AOAM532H9Dar+sfkugHBmjF+UsM9P2mS27KTmQ5D6vQbigK65VHp3jVR
        vqzKasfU9R9pcm418flP46QOzw==
X-Google-Smtp-Source: ABdhPJxYqpzxkrqlMbImagDAkAB81SWw2OlZKPMSAjINXZMm0t7TiXNDzr5J8bZVONuMJXtrktQP3w==
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr102712pjb.70.1603768250571;
        Mon, 26 Oct 2020 20:10:50 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l18sm160059pfd.210.2020.10.26.20.10.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:50 -0700 (PDT)
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
Subject: [PATCH v4 08/21] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Tue, 27 Oct 2020 11:09:04 +0800
Message-Id: <20201027030917.15404-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 49 ++++++++++++-------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 40007c3a28bc..e372e85e1c14 100644
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

