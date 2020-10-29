Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0C29E3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJ2HVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJ2HUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A913C08EAE0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 15so1588306pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cSmHu4EUUJVBsmxSi/EBeDxShofygH43OHCIiPWqSuU=;
        b=komciMs+pMZ3VGDPRPkI7eAff4iTS5zJrshNxF399+FXVs+WaVkZe7yIW9JX3O9GcS
         JGXTvQh8rFwM1ZwXmI8OfOrzTDDXxAPYazXxMAzT6bnfD45i9hxGULtiV8ZTuTGfV4as
         +MKBuZFx9LVXoBWglST9EhcUPr8QteHO0xUTP0b5dQpZgxqCM/Z7ZLqjORS60ACu7bB8
         Bevw12SYWDZ1Ntic1boX3rJr0a7dQkdv0AgqMcZUvH/BrMkndXDwfY0fOlv0+2QzkuOw
         WaIRl6HbYy4q6Bkp8uG0+SzLT182jLUi7rO/dNWRqjME6DGod2ezKXKSufgpnn3ptOo3
         /wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cSmHu4EUUJVBsmxSi/EBeDxShofygH43OHCIiPWqSuU=;
        b=F1WRGWA4GwViND/aqH5Dj8y48V0dTDkY749wDQxF6B+7a2pZRhVoVMme/hCKsL7gZo
         ldY5+0yjaNAcSkA07vhTI669/rb5M2D5EUxx037NYS4Li9ahJeHtL4Z/4orv6v1L2eKE
         0+h+4u7j9LaYaucxU0x4XPeOtlBu6knS48HrgUCjEpBiskz1OV6sBOjA9Sek+l0V3Vmq
         ILmzRpQMwXdS59Yg2eAw2zQjGv20jsGmjoZQRLzwCFMge5stonvfjxgqnNnyUj3C50xA
         OKNcgmJAYti53m9XdrHec7MX0V6HTarNwW5uscyXhwb+gJUqI2oMkTf7JRw4bz0eqkYs
         dlAQ==
X-Gm-Message-State: AOAM533k12zIQDg/KMzGMLNmWDn85tW4wDt2PQiNi7ORnlYaMr/z53jZ
        55E/6IKPBtTSrUxEm3u+guvLHA==
X-Google-Smtp-Source: ABdhPJz3BEqsYJzvvB0PJgEPHWoF4VSwb2lTdqjtcA/YsJ/hEHJhKQL+9un4eX8Q6Va6lo87tuPAog==
X-Received: by 2002:a17:90b:8c3:: with SMTP id ds3mr2807389pjb.91.1603956053947;
        Thu, 29 Oct 2020 00:20:53 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id lt22sm1702054pjb.13.2020.10.29.00.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 15/21] perf arm-spe: Refactor event type handling
Date:   Thu, 29 Oct 2020 15:19:21 +0800
Message-Id: <20201029071927.9308-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index 6e4896327e56..e8c334f19316 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -278,28 +278,28 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 
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

