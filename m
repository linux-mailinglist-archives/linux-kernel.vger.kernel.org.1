Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87F327CF83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgI2Nku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgI2Nku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so4669173wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdeJ8Lynvwr/Zz89EBHVjeEXN3vc7uIPsENw1d3XA5A=;
        b=Ql30bAseeTVi88yf8Tdcu4a8u28R8S+boj/y44RnqQisSDTCeWyBXZUV1/Dzgm0Td9
         30CztqZNIgvmOrvzYijq7qH/Dh98SW7QA2Ham8zoyuK+d9pAXkS4V9vhvXDN6l+ycsk2
         4lZeUkqNZxJ3jwPARJkGOW90A745g/OP206IbJMJ2uJTH/7pQhuSytpup3NdAupL0kPe
         jBKPJh+VOEHbM2MxOk3v3nn3guiQ2fb6UNo0FzttXufSxuf7WyynMqY/iLaIIihRcc3x
         /U5wahx2CD502KTnOSvFVGhWyHQ36bx9/QOnWflKAXG0XYJElytzIhv+PJ/FtQBR8dJE
         3YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdeJ8Lynvwr/Zz89EBHVjeEXN3vc7uIPsENw1d3XA5A=;
        b=gDeXJwZFUD0dsPSF/Go0lQC3z0u4Cf9gME2YW87ggHeknLMgOelWp6KxmaTUFN9zWw
         VeJPu6oSuyDH1Yq8zKGP3IbRg9Bxr1A6T2qV2zAPC2nMFp2XqQ4bItbyodD53t4Pchlg
         RwlvYAI55/MuwKY6xZ1D3C19e7W3aUoQca/JOX461BAwV9XVBi+ztssv31z1+lHk25AQ
         2w7hz75TNNAw/0aAfai6SzjxJxZjXIns4yuEMM2nhxu30KnlwreLLHpo9Y/QK0SrjIjR
         Mo4B5qO4WsBh/M0fhzLUfqYwQunq0qUrddhlX5HzozfyinGeBAWGxFWFOQC8YKAMxoBq
         7CpQ==
X-Gm-Message-State: AOAM530Z0XVjmH3BR5cTffU/tfXub0z1NOzvgzaQKNpFD2L+X9GYZpeB
        GWMi5/B7EuUSxB46RLbWmHzM9A==
X-Google-Smtp-Source: ABdhPJymeuX9TceLGsL15ARW+8XrHQCWvpwa8GQtCb7bvkuY0VT4IDe73trcIe0KbZyJFdTG229xWQ==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr2774891wmc.1.1601386848357;
        Tue, 29 Sep 2020 06:40:48 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:47 -0700 (PDT)
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
Subject: [PATCH v2 01/14] perf arm-spe: Include bitops.h for BIT() macro
Date:   Tue, 29 Sep 2020 14:39:04 +0100
Message-Id: <20200929133917.9224-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include header linux/bitops.h, directly use its BIT() macro and remove
the self defined macros.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c     | 5 +----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 93e063f22be5..cc18a1e8c212 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
 
@@ -21,10 +22,6 @@
 
 #include "arm-spe-decoder.h"
 
-#ifndef BIT
-#define BIT(n)		(1UL << (n))
-#endif
-
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
 	u8 *addr = (u8 *)&payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b94001b756c7..46ddb53a6457 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -8,11 +8,10 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/bitops.h>
 
 #include "arm-spe-pkt-decoder.h"
 
-#define BIT(n)		(1ULL << (n))
-
 #define NS_FLAG		BIT(63)
 #define EL_FLAG		(BIT(62) | BIT(61))
 
-- 
2.20.1

