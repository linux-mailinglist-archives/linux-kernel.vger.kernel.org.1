Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1027CF92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgI2Nlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgI2Nk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F23CC0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so5450079wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EulW83Z/q2GlTu4wnvNxdyahOY8zWf3/gF9QAPQbXW0=;
        b=VbMGjaCXWbP5UxV2h7Ual72/sgmzsknd8itRZOFR7pQKjJ9aTp4PvlltxIrvODnYkm
         XTtiKvVl4QiVCqEeGMPamo26DzziyXXI3y0K0FAid0/AQmKmWksBa4LnfKPcgQ3KrgPM
         F2jQn1qhmsEEUP6k7Vxeh85R1hEakKmvQYIuPjAggwQkInXvovC8FGcI2twpFhMvoy0L
         oeThjS6Fa4sooR5ln/I8WHr9/+kFFyw0cDRxel5H5w6kiGVn252WU7oDV9PkdEPBmQQb
         fRm5yT04mxr9kBpT6BmUpFf4PaZ3rJuXcpJQcMRW09/Fe1snVQ0MTZUPLkDklhEixj3H
         4+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EulW83Z/q2GlTu4wnvNxdyahOY8zWf3/gF9QAPQbXW0=;
        b=YyhPhps0EwmqCo6l0OZkHhTG8QPKKxUoBYZ0ZgvxYd3gP+6Jf2AH5miHqQuVEAbrwY
         HxCUXYaKHUn8bW4a2c6JA4ojUrsJgKUxzN9ZlABcBLoHI51xRnaDZjqqWyfKQC7cO6tO
         6C3YrNegefuXhrg1do+ca2IGASo3dG1+djGeCi2FEhmPUvOlSbobX223Q5CzfGmirorH
         pBeWGduH++JkJE77PXRQT6pgE3mXbetX8uPXs5Y6nM10b7tpBClsKN94x/PTtyQMu4FM
         jSCsPBj/r2YmsS0UYDUctdJoVaUjvYMbnHNndr5Z3tjpMA7366O2Ffo28G0WQL4fcesj
         JJqg==
X-Gm-Message-State: AOAM5308Y+97m7+zXQZohEgwMccf306NVco/hW1EqCee7UxwzbMgBb5B
        T1d533NAMJXkJcReogSwnyzkSA==
X-Google-Smtp-Source: ABdhPJzBP2C2n4qihxKT28WsQJTCR0u15PjoH2qPbnjQPOEk4AKkbV9FAOh7/dA8Byftep4fLfCZUA==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr4368725wrn.212.1601386856940;
        Tue, 29 Sep 2020 06:40:56 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:56 -0700 (PDT)
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
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 08/14] perf arm-spe: Refactor context packet handling
Date:   Tue, 29 Sep 2020 14:39:11 +0100
Message-Id: <20200929133917.9224-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor refactoring to use macro for index mask.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b51a2207e4a0..00a2cd1af422 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -134,7 +134,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_CONTEXT;
-	packet->index = buf[0] & 0x3;
+	packet->index = buf[0] & SPE_CTX_PKT_HDR_INDEX_MASK;
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 88d2231c76da..62db4ff91832 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -86,6 +86,9 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_INST_VA_EL2		(2)
 #define SPE_ADDR_PKT_INST_VA_EL3		(3)
 
+/* Context packet header */
+#define SPE_CTX_PKT_HDR_INDEX_MASK		GENMASK_ULL(1, 0)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.20.1

