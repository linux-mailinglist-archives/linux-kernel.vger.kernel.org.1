Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4029614B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368385AbgJVO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368370AbgJVO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d78so2444128wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/uXM46Lw7RKSevaAXgrz8Xxu18xpKRv8MksLZaYBUEs=;
        b=ofwXN2UnIKRZGw1ENyxdZkRKfl2fqd4pmTbljJy/hB5zcvtvM4V6m3dPIKvUmdFvLE
         ynX2Di2OqHl0T7mYBmBU65b8zSJY/NTpXaZb9ujIZYgVaIBBZFHg7D/TpXHENzHhwoXO
         xDvvo4j79KE7i7G10RyvV9v9zJ3Its32JF4L5urMj10kDwYUi4TzReSNQAwVYsKAN3Se
         opJ5H3PcoeSasn7Rw1K6aq5+CBM6OQ10YmnCg4/mddVPsONB2uC59MtbvnIsC6HBBag9
         096Da/hfFerU/N9zZvh1d9/Wt3aFsIzrilweTCiwzXysR3dtFK41VIDLqORHMeqHuACW
         ztdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/uXM46Lw7RKSevaAXgrz8Xxu18xpKRv8MksLZaYBUEs=;
        b=cajF81j94dSpF+7AWrF8zVEurFFlS8P4iC9RhjIYUs+Qf62O7aJ2mtVAocpiHf4+Dq
         WSVF8pxMYuiqYyWK+F0IqCrszPpNm48tudCej7xt8nWsRuyU//qYgWwZjAX1Q54dIHDr
         M1maf8JG0on0WaEgUACrygQ8WL7FJb9PyVDh62TIFrKg/XfNPVF6kChZC6V1tQgJu+LB
         n/Jc2T6lz0W67ECSXeauIw1DV6LqJRCJwSKTEAbEEFfPlVzk2mV/Z6Ny7kmnaQGrErmA
         9k00job9ceJ+cMJ8JxzGsnmvDPAyowes0chfWJUIfiU9ds4Dvcfa+8TZbrOcuuW685rf
         USNQ==
X-Gm-Message-State: AOAM531TPvLFDxtRDw2PuJvjJDejsP/cBx0r+nmi7JJy5lyj46l9mNgW
        jNpOc30iqiNddKNdv2bJrF4rhw==
X-Google-Smtp-Source: ABdhPJxJ7YZeLTeSw0HyU1XNDtmk/SqvCMsA1QqF0OMD/awmwS4vIfc70JrWZQCLcaoMcDHzeRcNWg==
X-Received: by 2002:a1c:89:: with SMTP id 131mr2806751wma.162.1603378723080;
        Thu, 22 Oct 2020 07:58:43 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:42 -0700 (PDT)
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
Subject: [PATCH v3 11/20] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Thu, 22 Oct 2020 15:58:07 +0100
Message-Id: <20201022145816.14069-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the counter packet parsing code from
arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 64 +++++++++++--------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 1fc07c693640..023bcc9be3cc 100644
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

