Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945F529A302
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442518AbgJ0DLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:14 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55352 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411710AbgJ0DLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:14 -0400
Received: by mail-pj1-f68.google.com with SMTP id c17so34008pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TwK8FYF5isbHTe2mW4uB6e/QlMKOc/WIVS9naE0IJpw=;
        b=aGYSpURZ4QKXXIi1WglJKPjV9t/JF06/V9HqYCEtH8S2/zhMcez5DucQBQHA2Wyg+K
         XXKl8doZPxI344DRIDXAd/rHPWhdsnFCcOdB5e8gDA6KaAftp3efA6Xr0w5vgXoygSt7
         eo9FlXo35K2PgZjyRQnd/pMiY+wxKxGYayvKT7h6EGW5s7AXcXvxo+s5feUM+0nsdeBx
         EbJLPIkwPAsMhpfcKxgPCc/Rwv0qIEIU87nbYP9ZBDNOLr2/Cp3IMz8RqpCvLmLdJfpg
         MrJULY3k+2U5ItZgsFHA2I4I1zWRb4fnLyHi7cwnD2MsJ6mz/YqQUiZt2MmFz2sCgB0z
         qYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TwK8FYF5isbHTe2mW4uB6e/QlMKOc/WIVS9naE0IJpw=;
        b=Nm3UepSAdFpcc/P/92ii5CtIkTrYxm/5J0SvaEz+RL9MJ+ZX9e7eAMucblNy80uEEz
         APSEFnUuDEVmdmf640Lu6SEaXRyl3Y06p1nQJ+i6Voo18o50iKZeJI69W1RTXWYCSgaa
         e6yR/CXmKvA0/lUnoelbaQuCZpu+PncKH02NMwUg7wmMwXCvoZaNS8O5KVHVvWr775py
         54cMgTeZIhTWQnpQBuUNhE+owqHdN3DZ8/VZGT/tJFfq09CfBXe7fPi1CkVQFbAa2+yl
         X57r1bt8xRvqpHyPsSPFVGphAMolPKmfHQ8C82oV91UV40h0CWAGkcOLekJV3Zw4Ke/i
         2UrA==
X-Gm-Message-State: AOAM530DozYQVRpPkCCH9T3NDojE01BDbM4RhtIRRnmbHAog9/H+Zbsv
        X611ku9ajSmVBRVxFGIAQVxmTw==
X-Google-Smtp-Source: ABdhPJyPXouv4vwxHwQaX2jyQZq4KrcILFR2SgAB8ygP1FUzR1eDt/0GdqtAYdKGD5aimENO9xg5Ow==
X-Received: by 2002:a17:902:c697:b029:d3:df24:163e with SMTP id r23-20020a170902c697b02900d3df24163emr120342plx.18.1603768271742;
        Mon, 26 Oct 2020 20:11:11 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id f17sm165549pfq.141.2020.10.26.20.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:11 -0700 (PDT)
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
Subject: [PATCH v4 12/21] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Tue, 27 Oct 2020 11:09:08 +0800
Message-Id: <20201027030917.15404-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the counter packet parsing code from
arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 64 +++++++++++--------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 9304dfe72ebd..8f481c6ea054 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -293,6 +293,42 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	}
 }
 
+static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+	size_t blen = buf_len;
+	int ret;
+
+	ret = arm_spe_pkt_snprintf(&buf, &blen, "%s %d ", name,
+				   (unsigned short)payload);
+	if (ret < 0)
+		return ret;
+
+	switch (packet->index) {
+	case 0:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
+		if (ret < 0)
+			return ret;
+		break;
+	case 1:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
+		if (ret < 0)
+			return ret;
+		break;
+	case 2:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		break;
+	}
+
+	return buf_len - blen;
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
@@ -435,33 +471,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%lx el%d",
 					    name, (unsigned long)payload, idx + 1);
 	case ARM_SPE_COUNTER:
-		ret = arm_spe_pkt_snprintf(&buf, &blen, "%s %d ", name,
-					   (unsigned short)payload);
-		if (ret < 0)
-			return ret;
-
-		switch (idx) {
-		case 0:
-			ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
-			if (ret < 0)
-				return ret;
-			break;
-		case 1:
-			ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
-			if (ret < 0)
-				return ret;
-			break;
-		case 2:
-			ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
-			if (ret < 0)
-				return ret;
-			break;
-		default:
-			break;
-		}
-
-		return buf_len - blen;
-
+		return arm_spe_pkt_desc_counter(packet, buf, buf_len);
 	default:
 		break;
 	}
-- 
2.17.1

