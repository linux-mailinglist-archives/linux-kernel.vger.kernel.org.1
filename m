Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BD2AE9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKKHUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgKKHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:14:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1505C061A4A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id oc3so261983pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2waR9GAfwY4C4f9s3qvORLvd2idxfYhKHbgDXLhsSc=;
        b=xxZL17LwjAPgSZNu8aqm8nMfeJ1ffKXDS2P8YREl9w8wEcf1YfTNaerGuf/CMqdpX1
         jit/B8NUgb39fy8ZJsSERnQjfzFMm5nmAInmqXMVWZpB9ripJcL7kFUVrfTOdTF3WNPe
         NDdU9WqzDw8WddF9NguKM+R2Frl4/s5lOp/GCBpJ7JQvrtGQnB5pdTMpvUR/M4b4klbd
         1gh4zVuxp2YLj9QwrzlNW8syDAsLFl6Y5M4ryWrMq55k1hebkjIqKzHT+RZp8ppZNIGe
         dpTgRRD6a7nohEf7JCde5QS4+qZXrkCG+r8Qfz7+Fgl2i8i2ZcDO6rVZdUniJFk8RCpI
         0nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2waR9GAfwY4C4f9s3qvORLvd2idxfYhKHbgDXLhsSc=;
        b=pjHcxcAeJfvR8PBLq7UMLzWXJAyQ9hlEe2ZGou8ZoCBYB88szZ5gMf22f1NQ00VOC6
         Fb/aOwpRHyR2l7ya4RHjMKqhvLUytevdU4+yln2x5LIxHxBpbgys2EO1CMlpu2K4N3BF
         Ti7D5cbmDRDDwNmED4X97GFpG4YG8NsGPd+I/v8uV7JBKiVWDZoXorpO5eoJXUsZJB1K
         JT16NXVGwN8IlAqvu8VMG29c/qpkfHDKP6v2mrbhWRWj4Sqo29a55lta1RsSHvP+f21G
         06kmOFWNTbZD7Qeq5c53W6uCnkCQ+qDzn3pzy6DhKZLxVf63zh+Ph7G666X65hSCMTUI
         YYFw==
X-Gm-Message-State: AOAM5337zd4vu9zwUzL1I6+ZqI2xKWOSbl72gxJ/MtbnsnJ79BUCkkyv
        tKKTTPNxpJaFxgU9MO1qsj41KA==
X-Google-Smtp-Source: ABdhPJw07Hl2ehXoAbaaIKB5xa5mLMqRho5A62FTGzM7Rt5e/kdgtUdHI9SVBsq73qFc8epMdNM/Dw==
X-Received: by 2002:a17:90a:430b:: with SMTP id q11mr2541004pjg.129.1605078803448;
        Tue, 10 Nov 2020 23:13:23 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id y16sm1340515pfl.144.2020.11.10.23.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:22 -0800 (PST)
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
Subject: [PATCH v8 17/22] perf arm-spe: Remove size condition checking for events
Date:   Wed, 11 Nov 2020 15:11:44 +0800
Message-Id: <20201111071149.815-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index 2ebbd75d9b6a..64811021f36c 100644
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

