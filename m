Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A501296156
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368376AbgJVO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368362AbgJVO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122ADC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s9so2823934wro.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OgGjxpkeydMUU6UDd0+1qg/lNsn/jSRkPqYApF8I2Aw=;
        b=od5tlUsAKlFtccAyauZSeiQHJNBDSUORyQQ1J+1doUfYhhKC3YyTBusau4hj51yzZm
         Yh26IVldbllLwFAI772i5uJGOcgiBWueU42fAxQLDhzm2HMoF6q0c6Gg33tM59HEeRFu
         /0/syj5+pJoe76UMPL+WBvz+nAdDueIhuIbt0CcpjN1jvtwR6+vJLrSdyKb0zpsB7MSo
         yVGirglbkyrfn36c8JhpVCIYVHQQFCJ2zt7kEoxiYiDgs3eh8kUwrRN/qqCEqGc97hrj
         dd7M24HCnLHgrKpaeHtVB8MaxmMrR2jFOQ62xFvMEnZ8eWm+UXno5Gmlk18Mp7N2eM4u
         6G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OgGjxpkeydMUU6UDd0+1qg/lNsn/jSRkPqYApF8I2Aw=;
        b=JJZXBHmln22R4M9gjsK76VOXEymZhxtuvmxZAvv4svLeOPIbrfKh7pLB9J03pLcw/X
         5n2fulgJvWWHZ7QdYKli6Bwql0GA9i/wvEP7oJ7dZtTFN9tCxISMAqWnQoPY2HvbaBcm
         q7fGMTnlysFCe1jzoWNfK5nfPQlBuDkanM1SnAEQYaNsULU3LDm9cnvGD5N9OX8V4wmg
         hYt9sY21osEiXVfTSK+JykEpNGvzR6BcHwT/zQL0JSxqyBrxITSBxE82clLjE5hLlOCD
         aBaYm2ox/ADH1ykviGx34W977C/nPgja70EhFhNpS5r2IzaPcy6JYvDTzlGtNshR9prZ
         9MbA==
X-Gm-Message-State: AOAM532VvgzJYNsHv5iLjPyoWylhuyI5dTF/ACjM90r/+BbyFkQVneQP
        4/rxxxajNd2i+6dx5MDyFAQR2g==
X-Google-Smtp-Source: ABdhPJxYTwqAnYiI23sqCvT81/B8tfp1nTWo6HFQyy28yrYQ8QSVJkqEXwWQlomevbhV8Fx12KAS3A==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr3091205wrq.282.1603378721756;
        Thu, 22 Oct 2020 07:58:41 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:41 -0700 (PDT)
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
Subject: [PATCH v3 10/20] perf arm-spe: Refactor context packet handling
Date:   Thu, 22 Oct 2020 15:58:06 +0100
Message-Id: <20201022145816.14069-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
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
index 156f98d6b8b2..1fc07c693640 100644
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
index 4111550d2bde..8808f2d0b6e4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -81,6 +81,9 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_EL2			2
 #define SPE_ADDR_PKT_EL3			3
 
+/* Context packet header */
+#define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

