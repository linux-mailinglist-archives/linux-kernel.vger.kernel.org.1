Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C488D2AE9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgKKHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgKKHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:13:40 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i26so883755pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FaLmdZ0I6jgP6YSJFBUYhpBKfN2HD5cDIF4yGhnbicM=;
        b=nYfknJ5YFeA7E6EDvksXJ7BIlSYzfMxrN3NEsVNVnR6NaHRAqO/MPVvt9M85iHYFwP
         vSllDACK4lIpb+oON2Gvev9Fibvha3B3gMnjKZ9Bgn1XmKWcgIWmNGq16/yZidjnhPFa
         8chGTv1vVnUzXwqPii5FTXJsKFmRVO9embWBdutHRFzB5epVk9Xe6vsN7OPo5gaVQkJp
         fP9Y9cYNxT6MQrD+fbyfWwG6E7beP41/d8krO+XfVym429mI6xMN9wA64an2sZ1q6Umc
         AXZPT34HIFIVA5Zo1q1ASrZpMw2GS2oeGIk/SEfIIjlUw8Rj3KJyOLgWCP0uwAWJWMRv
         JEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FaLmdZ0I6jgP6YSJFBUYhpBKfN2HD5cDIF4yGhnbicM=;
        b=iU59wpZsSnCS3uedKFiozDQ4hM6Gd+kh93LTT21vwHh9y6nRhHXEMIDMQK5dO29cTZ
         64mhMX1HEg1FBcxGPPzMKBoAWuyVj6KXnsKJ445Hm8DIVQ83mgURODMbrRPaLHI8+1mA
         o5czwPWyjYWOgkI5l2iHKi3nK3aAwvhUtdk9iGWmu8GtuwOnSfRCSg1oJC9MaZ9fTTIq
         iiBlUydWipLdRYH2vpTeuWq3Em+GpsYFKSoMlY3oC3Pp7huifyUf9Iq9nJrpGh8TClC7
         9OUscp/JRvgseCWGh0Vwj8TMGfKj20p+H+jRrIUeUdzzV/FmQPUafjgp0x11oUblB6Bt
         cnZQ==
X-Gm-Message-State: AOAM531TWaN/fL/M+u1PexZlcgDCAnlGXUogG01o5V39FPVAT0Rq+TEg
        LEU6NxtMfHz+iEduPDeoUsDbqw==
X-Google-Smtp-Source: ABdhPJwRKmt6823DNEdwD9GXA4ytNmCCz5NlQ7wnXahT0YTrlkx3uHEgRY8Fj9GFEsStqKisgMUUwA==
X-Received: by 2002:a63:1906:: with SMTP id z6mr7262603pgl.409.1605078785718;
        Tue, 10 Nov 2020 23:13:05 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id j11sm1129786pgp.82.2020.11.10.23.13.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:05 -0800 (PST)
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
Subject: [PATCH v8 12/22] perf arm-spe: Refactor context packet handling
Date:   Wed, 11 Nov 2020 15:11:39 +0800
Message-Id: <20201111071149.815-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor refactoring to use macro for index mask.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 05d63e77f741..7b0f654e5cd6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -136,7 +136,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_CONTEXT;
-	packet->index = buf[0] & 0x3;
+	packet->index = SPE_CTX_PKT_HDR_INDEX(buf[0]);
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index f97d6840be3a..9bc876bffd35 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -79,6 +79,9 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_EL2			2
 #define SPE_ADDR_PKT_EL3			3
 
+/* Context packet header */
+#define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

