Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949129FBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgJ3C7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgJ3C7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2EFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so4010772pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=msdAQPJiSwNOElHOhS4iiiGMpAa0bN+qeiLD7PH4AsA=;
        b=cY2XBEnW/W1dzpKXmeV+VFqebNxlcIjVw4adKrhGck8wlaO6kL67fPyNp/6Mo6B4UY
         I8vrJzhPOMZu+taAKHd+U8AdDZYzbV/h/SoEOKctcUdZVllffMQSxH1lTlje7Xi5rZ1P
         mejN0MQrDfYUkWey5b8/wXrgk4QUpEJoqWVLLrxHUTDb4k9SU7HErPtNBbo1LynjIxp7
         ATuEKbe0Uzr3hOGlO2yoq0gNelp+c2mw0PISVvCoZbvSGcuIHKlFx7NueEHEF+WbbmVG
         cejx26VVB41fYVdmSFT5wPnAmYtQw43AGBzs1J/mMcpBgCnCDvqhDHOegUNI63XBG4y9
         aFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=msdAQPJiSwNOElHOhS4iiiGMpAa0bN+qeiLD7PH4AsA=;
        b=D9i6G7VjcIQO5YAxs1xsgCsWIMuYKOXa7MLOi7zJXCvW0N+M6Svkwx8qTeSpbxG0iF
         P9mlAZ3yeuHFJ+b2deSN94PbYqDy13mszL7YIxSROqLyAlm59VqKHyFnePRoq2Ll2JXs
         UEVrcE0228cbx2AKWFwrSnzPvrotQG2KxE54O11RuKQmlTCgKbIO7gY9MaLopI7ZbjHD
         wcE0pe9GmzzBplSONSKGry6ZgL/e8aZwbDpmj3lb3L6uiDDdAVe1OGAlzdJZ4wjo2K/J
         XAUhimxwLRIEp3C66ttX810RLT543qiU69KnOalRQTZh6HWqZJ6EZL+0ADrYpYpREExr
         YECg==
X-Gm-Message-State: AOAM532Uo8uwI8UNY7i3iOsDIrtp0d+7j4m6qF9HbmiXTmQDxWlN3X4+
        Ps6m5ImpS3myjefZImdhrPGjDw==
X-Google-Smtp-Source: ABdhPJy4sgAuQpWj6gy63/nlZqkLL9YFCj0qsZUxT90DuWT14KMsrXmTPxlpyccasJZ/74IiaGdfCg==
X-Received: by 2002:a17:90a:4488:: with SMTP id t8mr207217pjg.43.1604026744290;
        Thu, 29 Oct 2020 19:59:04 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w66sm4073769pgb.63.2020.10.29.19.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:59:03 -0700 (PDT)
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
Subject: [PATCH v6 15/21] perf arm-spe: Refactor event type handling
Date:   Fri, 30 Oct 2020 10:57:18 +0800
Message-Id: <20201030025724.19157-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enums of event types to arm-spe-pkt-decoder.h, thus function
arm_spe_pkt_desc() can them for bitmasks.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++++++++++++
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index a5111a8d4360..24727b8ca7ff 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -13,23 +13,6 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-enum arm_spe_events {
-	EV_EXCEPTION_GEN	= 0,
-	EV_RETIRED		= 1,
-	EV_L1D_ACCESS		= 2,
-	EV_L1D_REFILL		= 3,
-	EV_TLB_ACCESS		= 4,
-	EV_TLB_WALK		= 5,
-	EV_NOT_TAKEN		= 6,
-	EV_MISPRED		= 7,
-	EV_LLC_ACCESS		= 8,
-	EV_LLC_MISS		= 9,
-	EV_REMOTE_ACCESS	= 10,
-	EV_ALIGNMENT		= 11,
-	EV_PARTIAL_PREDICATE	= 17,
-	EV_EMPTY_PREDICATE	= 18,
-};
-
 enum arm_spe_sample_type {
 	ARM_SPE_L1D_ACCESS	= 1 << 0,
 	ARM_SPE_L1D_MISS	= 1 << 1,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 04ae4b760840..0d57a72859c5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -282,28 +282,28 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 
 	arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
 
-	if (payload & 0x1)
+	if (payload & BIT(EV_EXCEPTION_GEN))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
-	if (payload & 0x2)
+	if (payload & BIT(EV_RETIRED))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
-	if (payload & 0x4)
+	if (payload & BIT(EV_L1D_ACCESS))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
-	if (payload & 0x8)
+	if (payload & BIT(EV_L1D_REFILL))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
-	if (payload & 0x10)
+	if (payload & BIT(EV_TLB_ACCESS))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
-	if (payload & 0x20)
+	if (payload & BIT(EV_TLB_WALK))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
-	if (payload & 0x40)
+	if (payload & BIT(EV_NOT_TAKEN))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
-	if (payload & 0x80)
+	if (payload & BIT(EV_MISPRED))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
 	if (packet->index > 1) {
-		if (payload & 0x100)
+		if (payload & BIT(EV_LLC_ACCESS))
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
-		if (payload & 0x200)
+		if (payload & BIT(EV_LLC_MISS))
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
-		if (payload & 0x400)
+		if (payload & BIT(EV_REMOTE_ACCESS))
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
 	}
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 7d8e34e35f05..42ed4e61ede2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -87,6 +87,24 @@ struct arm_spe_pkt {
 #define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
 #define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
 
+/* Event packet payload */
+enum arm_spe_events {
+	EV_EXCEPTION_GEN	= 0,
+	EV_RETIRED		= 1,
+	EV_L1D_ACCESS		= 2,
+	EV_L1D_REFILL		= 3,
+	EV_TLB_ACCESS		= 4,
+	EV_TLB_WALK		= 5,
+	EV_NOT_TAKEN		= 6,
+	EV_MISPRED		= 7,
+	EV_LLC_ACCESS		= 8,
+	EV_LLC_MISS		= 9,
+	EV_REMOTE_ACCESS	= 10,
+	EV_ALIGNMENT		= 11,
+	EV_PARTIAL_PREDICATE	= 17,
+	EV_EMPTY_PREDICATE	= 18,
+};
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

