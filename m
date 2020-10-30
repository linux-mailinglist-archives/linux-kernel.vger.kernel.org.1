Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC229FBE3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgJ3C7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgJ3C7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so3968533pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sTNe3Zd7B5SpS7Hi4RQBJC3PX5OjdjEn2Jtv1u845po=;
        b=yGzvSfMDC9c1DemaJB81yLNGlF+FZTwdDJkMWnDNi6+WXjnHtBy9d8cJ21RMjJuTGt
         1WUPlNRG8Sw5OJXV6bKyW2xOY6ewUlzTPyRGFAmyoXy5ZnPhg+qye+CZn2m6iyJBG+I5
         scOn36hI38XkuY613P6Cg50twmVdFce0erLl8YA98R5tnSCWHcj+yphc/+3wWgYv56Xd
         xd/LHlbZUuCGjE/Craj6hYlGEkbmeChOxj0PEtzVFnv31m+TE5aJNJpEUuTL5uq/WpvL
         vhQnbRjboS1CTmyFV+YoMC3hzQyqL6SSsm2ZJ5JOsTAECeYRsiUUdThwWIroLLqBGwQp
         G7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sTNe3Zd7B5SpS7Hi4RQBJC3PX5OjdjEn2Jtv1u845po=;
        b=EivTcTX05ZPO2N5ggEv8uwyyge3bWMbI+mHNu7JMhob37EcQ54Wqb/nkxLiNndOP2y
         L9WK75dZ4SPZX60lXhdMx5GoICKRbwb6SI0z3RIuUnt7FcBC9Z3PTW9N9Vp3iFmyRNAh
         tS8y+xORvEfiGZ0vbtrhWZfrMJFph+x4fTHNnMkuXRZZ/k5iD5QZJTsEZYPE8pTFWvrP
         cQrgrKoVS7kD+R7FRqaxlUYFv7+u9tb9ZZ4dh6e4BnXjrMjGaBVd9AzuJYg4nrCh3K1C
         rABdA9rHJ4WL2sjifddcd2SP3IJKeh4YoM8XLHZKnLqY1a9s41KujZ23Ecd5Rhch+OEe
         /9DA==
X-Gm-Message-State: AOAM531SlA8rb9DizYFy55uo3lCoHI6g53/CFCc4aZoP3Exry0J0UgEv
        W+Lg9JIR5z7Nn338ASXvY/HJaQ==
X-Google-Smtp-Source: ABdhPJyqh6PGsBjiTS2aEobmPcyVXr4Ux03TjWmRnWC16vhMn86ybgYhb+5bVgHM2ZThuXyPj91n1Q==
X-Received: by 2002:a63:d245:: with SMTP id t5mr272349pgi.283.1604026749783;
        Thu, 29 Oct 2020 19:59:09 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id hg15sm1194679pjb.39.2020.10.29.19.59.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:59:09 -0700 (PDT)
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
Subject: [PATCH v6 16/21] perf arm-spe: Remove size condition checking for events
Date:   Fri, 30 Oct 2020 10:57:19 +0800
Message-Id: <20201030025724.19157-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Armv8 ARM (ARM DDI 0487F.c), chapter "D10.2.6 Events packet", it
describes the event bit is valid with specific payload requirement.  For
example, the Last Level cache access event, the bit is defined as:

  E[8], byte 1 bit [0], when SZ == 0b01 , when SZ == 0b10 ,
  		     or when SZ == 0b11

It requires the payload size is at least 2 bytes, when byte 1 (start
counting from 0) is valid, E[8] (bit 0 in byte 1) can be used for LLC
access event type.  For safety, the code checks the condition for
payload size firstly, if meet the requirement for payload size, then
continue to parse event type.

If review function arm_spe_get_payload(), it has used cast, so any bytes
beyond the valid size have been set to zeros.

For this reason, we don't need to check payload size anymore afterwards
when parse events, thus this patch removes payload size conditions.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |  9 +++------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 14 ++++++--------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index cac2ef79c025..90d575cee1b9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -192,16 +192,13 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			if (payload & BIT(EV_TLB_ACCESS))
 				decoder->record.type |= ARM_SPE_TLB_ACCESS;
 
-			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_LLC_MISS)))
+			if (payload & BIT(EV_LLC_MISS))
 				decoder->record.type |= ARM_SPE_LLC_MISS;
 
-			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_LLC_ACCESS)))
+			if (payload & BIT(EV_LLC_ACCESS))
 				decoder->record.type |= ARM_SPE_LLC_ACCESS;
 
-			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_REMOTE_ACCESS)))
+			if (payload & BIT(EV_REMOTE_ACCESS))
 				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
 
 			if (payload & BIT(EV_MISPRED))
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 0d57a72859c5..07934e1eedca 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -298,14 +298,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
 	if (payload & BIT(EV_MISPRED))
 		arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
-	if (packet->index > 1) {
-		if (payload & BIT(EV_LLC_ACCESS))
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
-		if (payload & BIT(EV_LLC_MISS))
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
-		if (payload & BIT(EV_REMOTE_ACCESS))
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
-	}
+	if (payload & BIT(EV_LLC_ACCESS))
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
+	if (payload & BIT(EV_LLC_MISS))
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
+	if (payload & BIT(EV_REMOTE_ACCESS))
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
 
 	return err ?: (int)(buf_len - blen);
 }
-- 
2.17.1

