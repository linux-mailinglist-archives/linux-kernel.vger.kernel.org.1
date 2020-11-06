Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA32A8C42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbgKFBno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgKFBnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89483C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g12so2694093pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GVIYvdvqgBcMYIiBi2B3seSzyCLIyhGMyIR38RUNnyE=;
        b=mZk7VuDD4aiI4ZTakfajZTDsmadcGD4y1xeTh47bKwMx0Xy87ec/8cyCQKiZ7pH+jr
         dDS6GUjU6GUDq2w6Gj1BitMECO+vTfHV2GMeog5alz6425JH5JUmdHIuDDbXDcwVRK9x
         f/YZfy6mPKRnV98TVdkVqoQG+T5pa+POyznFbwBCXp7RIhZ+39HuWYZrmyD3uzIrhf4z
         yVB6w5lKvyXWL+6vP5U7LMwDnbEezVZDM0Qgul5yk9vULDIFmUAlQtDwEItt0u0Uh8f1
         AqHp9afBEUP/h41fZtulUoaAiMDuEFRoI3+bQwsrO5eIufQQRVOiylWAquPGwdsZVAKA
         mSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GVIYvdvqgBcMYIiBi2B3seSzyCLIyhGMyIR38RUNnyE=;
        b=FyGa2hf37Z1KfLJs0dZ6S5SsZug8BkSdcRZ8NvGRA5VdBw0WDZ2wqc2FtOGnnyqJS3
         rPlUtJgJljMeVhRX2/nFK/mW2QtZ5w5Dxl6jAsxit/uxplns6byXdDapvrlsihunQ5rm
         5NeKoPUp5CtXSCDNkT6tMIKsScH7opr4l6527H3daV63G6xHt10OCNoJcVHryNT5KNQC
         uJ6vYMwH/yHbts017VN5RqsZrwZj7lSKXor+/YZ0D8zs76Mgf6e5zjqGpl3GbCV4DUwm
         6n3+viEpHalGTfJjj3TG+sy1CEF+rkf7ajdWXCWgM0LK9ceP/REk1D5h1Rgp75YxtO1x
         VjeQ==
X-Gm-Message-State: AOAM530qmm5IjjGt9zS/DYR5c/e5wWI4r+3bzFJoF78evqYGN1Jp2WUY
        IYEXH4fx+gdTLLQX0Jd3fUg9aA==
X-Google-Smtp-Source: ABdhPJyZBhiMzXSGCoRtL9Rfxa68K9urUjBKhTnmvYwmAAsmlPyr5Z9bvzSfa/a4GZcuP37pdq8scA==
X-Received: by 2002:a17:90a:4f06:: with SMTP id p6mr5508258pjh.227.1604627023048;
        Thu, 05 Nov 2020 17:43:43 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id r127sm3873028pfc.159.2020.11.05.17.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:42 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 17/22] perf arm-spe: Remove size condition checking for events
Date:   Fri,  6 Nov 2020 09:41:31 +0800
Message-Id: <20201106014136.14103-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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
index 6df3f18d1a5f..87ef8866221e 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -311,14 +311,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " NOT-TAKEN");
 	if (payload & BIT(EV_MISPRED))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " MISPRED");
-	if (packet->index > 1) {
-		if (payload & BIT(EV_LLC_ACCESS))
-			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-ACCESS");
-		if (payload & BIT(EV_LLC_MISS))
-			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-REFILL");
-		if (payload & BIT(EV_REMOTE_ACCESS))
-			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " REMOTE-ACCESS");
-	}
+	if (payload & BIT(EV_LLC_ACCESS))
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-ACCESS");
+	if (payload & BIT(EV_LLC_MISS))
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-REFILL");
+	if (payload & BIT(EV_REMOTE_ACCESS))
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " REMOTE-ACCESS");
 
 	return err;
 }
-- 
2.17.1

