Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B5429FBDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgJ3C6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgJ3C6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613FC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n16so3959105pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVg6OBsxsbQmIwQtlDOxner0Fuqbv+PU43WCDRziE1E=;
        b=hLBgcOkBMH5qbik+IJhfOqY0Aqtp2G/4kr+y5Ngx/H6erC84m9hyRsIx+25MXFnqX6
         EheXvH0rMxLZ7IwTU0j7rEgrxbWc2PVDDryEn6SKcSP5BfkLzautpwOtQzfGdtqB4Sgb
         27TFLMTaiEH/ZnHYEAie94UX46IEp+sKy3VyOPTs2D84IRS6u3Yqc88o+Xfvssrd8RYl
         6vOFbV07V4bUHO8fSukNQbIPUdXimL/HiCWEaK8TUEMANHpGKyp50URqOWPprvgXdxfq
         4kJq29qo/HpmYo1MAq3BBPZTQuPNHXf7oRv73LFbD+7fiJWT9jMsiepP4zCmrL1HStgw
         GdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVg6OBsxsbQmIwQtlDOxner0Fuqbv+PU43WCDRziE1E=;
        b=ozdHRej2fWOvLmvIrjM5DiEz6ggv4c7k0yJ/pqnlMrJOOn60FHzJRZfLHqiSewACgT
         YS7aqazAoqkiu9mD5lAdfOnHu4lyCozy0CV/Hf5lpJllHodA/8ASZoHjBpFy1V6rReON
         m3Fug5lFnDaJvmiJlU5+qtlYtUK8XLVk8kfsrP2dcl53JqLmcySz495k8x8CsoZGDO3p
         AZZCAWELCvPiWJgGMfMJAnfHBIy4IxyX/YqMua4yETsUdsjvlNFdiRltdKMHttNizJxk
         EDVm9t4gPjRXatiev1onB1rMBQSnyDBJtde57mx8TtmC8zbP6PAqAKoZ+lfKfFpDnuNm
         8pDA==
X-Gm-Message-State: AOAM530KRB8D5xfzgoCj5IF4lzPaQLR5xUk2HMhqvA7I3F20p5t/nHWT
        yJ5ovK7pTHomIX1F6yTb6ZB7tg==
X-Google-Smtp-Source: ABdhPJy4NXO2EpZFzeuIc2TzgWstHwgBpI1zJd8Ao0dHdf8/1GyBfkI0A2pJbG/sl4o+oRlM7268/A==
X-Received: by 2002:aa7:990b:0:b029:155:d228:8cad with SMTP id z11-20020aa7990b0000b0290155d2288cadmr6987370pff.29.1604026722924;
        Thu, 29 Oct 2020 19:58:42 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y5sm4115996pgo.5.2020.10.29.19.58.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:42 -0700 (PDT)
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
Subject: [PATCH v6 11/21] perf arm-spe: Refactor context packet handling
Date:   Fri, 30 Oct 2020 10:57:14 +0800
Message-Id: <20201030025724.19157-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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
index e507cd66df01..e4ab43ba80bd 100644
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

