Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA88296150
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368422AbgJVO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368408AbgJVO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4534C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so2844386wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+Qb9Q/ZmcbIp8Pe27lI1Rpv+0UAMYpN4sqqu2GMj+k=;
        b=XLHUg9R1nN9rHkLqfa6ExhrmV0lfr9kNDVfWsJeHPzIKPnss8VkhZBL+2ylERrsInp
         Fa8wJ6U8ybfMIcMXVewT7pcGVthzgp0QagmBq2x+vIgBl79xU5bQa2ZIqmJ5Y5lPqYGG
         +FkRhznWhtbso3B+m4+Dn7aii/d2fSbTn89fRyu4C6qbnSaYmV9zOM0+0mL4ODaKwBHq
         +b0cfkMwyE15h+WpaYvMnq6MC7uw4/YUKNgvd1pfwsRmE23VLA9ZCCLlUaYsb4a0l2SS
         ncMtk5PLFkV5pn9FAb4ZoNvYp5SbDJDPUBjKFCEfcgsw/rB66nXPLKknr6iccBtBX/V1
         jV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+Qb9Q/ZmcbIp8Pe27lI1Rpv+0UAMYpN4sqqu2GMj+k=;
        b=nVtzrlAASXmkrUPPUrVEyW3XAqNjZIYvNp4E7l/Y/6deabIjoM5RTk8k5Artm9IJDh
         vcoPzPrmVh9TYOpYTR/qHCr8NAEuRuEfe9Gi8dMETRTWBFe+YXbTqD2VlOAs2k4KVMy/
         iRoYGDYOh76qqD+G+s0svJdy1UY3fccickIczAk6MSJTKm5WCLM0eesrRy9CQ0PChHSm
         tRkdusVujX1yl9i9hJ4hNkIRFBMn7neJ+1Q0VoaBh6XApuqN7UT5bBfm3swkmoUu9xge
         VFA/mhM7W9ZD9lL81T36huK4pDoJOH45q+kOqJh5eE77CPUYyPmCQymTQi9h6n1OJqVD
         rYNA==
X-Gm-Message-State: AOAM531p4GZGOiqEPz7oEo2ggEmithg9IsTdFNRDPaYpC+yVOmewEK9V
        8R3DT3+tsfJ2rj/u6qFKgPx6eg==
X-Google-Smtp-Source: ABdhPJxjuCM0sDoRAj0+ZqMdEKCQGHHOODjltB24ip04cRgyPfPfP/5ccsqKJWExOKKAFo1aAWeHYA==
X-Received: by 2002:a5d:4451:: with SMTP id x17mr3096996wrr.176.1603378733669;
        Thu, 22 Oct 2020 07:58:53 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:53 -0700 (PDT)
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
Subject: [PATCH v3 19/20] perf arm_spe: Decode memory tagging properties
Date:   Thu, 22 Oct 2020 15:58:15 +0100
Message-Id: <20201022145816.14069-20-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

When SPE records a physical address, it can additionally tag the event
with information from the Memory Tagging architecture extension.

Decode the two additional fields in the SPE event payload.

[leoy: Refined patch to use predefined macros]

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index c1a3b0afd1de..74ac12cbec69 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -432,6 +432,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
 	int ns, el, idx = packet->index;
+	int ch, pat;
 	u64 payload = packet->payload;
 
 	switch (idx) {
@@ -448,9 +449,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 					    "VA 0x%llx", payload);
 	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
 		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		ch = !!SPE_ADDR_PKT_GET_CH(payload);
+		pat = SPE_ADDR_PKT_GET_PAT(payload);
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		return arm_spe_pkt_snprintf(&buf, &buf_len,
-					    "PA 0x%llx ns=%d", payload, ns);
+					    "PA 0x%llx ns=%d ch=%d, pat=%x",
+					    payload, ns, ch, pat);
 	default:
 		return 0;
 	}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 31dbb8c0fde3..d69af0d618ea 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -75,6 +75,8 @@ struct arm_spe_pkt {
 
 #define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT(63)) >> 63)
 #define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
+#define SPE_ADDR_PKT_GET_CH(v)			(((v) & BIT(62)) >> 62)
+#define SPE_ADDR_PKT_GET_PAT(v)			(((v) & GENMASK_ULL(59, 56)) >> 56)
 
 #define SPE_ADDR_PKT_EL0			0
 #define SPE_ADDR_PKT_EL1			1
-- 
2.17.1

