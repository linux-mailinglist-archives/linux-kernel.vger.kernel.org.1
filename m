Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7399929A306
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442758AbgJ0DLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:36 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:45771 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442678AbgJ0DLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:35 -0400
Received: by mail-pl1-f181.google.com with SMTP id v22so7119ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qOym5/lSZDBwaaFrzZdUwcNg3UFFc3d1PExE0VWdwVo=;
        b=iFXmIIpW46qGMCjK3CvYzVgxBzurnPaVfn70NYojceWALCT78WA/SW5IPbIM0a4XZq
         KCa53EkygpFCqzvay9RjPPnOryAWu1MxbXPuzjPJmc75J5OuBkBdTkGAly0kqkq9azRB
         e5pFXEjLQn/prVZsnq9U2eimy6hLuhzlzUImgUTI94MlhxF9B7PLHxlBctMuPo/BiRT5
         IrQHq9YZ5LoVm5ErOpnp48r0XB10dbK9pTNb68BS8B9u8OQkd72nG03Rd0Xw3Wtl5bdZ
         yIBXNF0XjSRzwMIZe/ewgcYVFkoOLqHtXOoKTlksoOQ2TtPyra+BnaSN5BkFJBBJRJjl
         nLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qOym5/lSZDBwaaFrzZdUwcNg3UFFc3d1PExE0VWdwVo=;
        b=HMB77mAU3i6kFjz1S0mb7aFB5XovZe3uWrmQFBtz8lK/AZyWdxqbYjzbdOnLvaHngy
         hpTX3aavTz7+oD/eYOVxOvrKNOBEPaIPjid0PBHV1t2xh+BfhAi8R6hr1Xuu98yQJ0aD
         JHIkJnyxnjtrtHV79qx8pfTZU2I73NeRePxCmqllU9ya02A2KL6AYKmqkaGwPZNY3Cqg
         J/n1sasGJLIQkeIP435XS1nq6N3IYIIASHKcdB2S/ICmjzY0DcnlXT2jfGwdaW4eLKtl
         0cCy6G0cQrtklEdKta4UXbVjLo8splh6iK71pUuR4Ui+y4h6UT8LV5h8GavTIdh1L70f
         8Nwg==
X-Gm-Message-State: AOAM533lOZKUbkaS+JVGwyqgxBdDXaYamaMaAWVK4iJVSY4kYn1pWuGC
        3Of9gvLtt5Nu3BkSeK9bxG53Mw==
X-Google-Smtp-Source: ABdhPJxQalPuIWbeAtLwZtGMMv4Ujco09M4v843YuO8Aqts41aIFZ+QJb8JOGkX5BOOUTNA2AoYzfg==
X-Received: by 2002:a17:90b:111:: with SMTP id p17mr61846pjz.159.1603768293345;
        Mon, 26 Oct 2020 20:11:33 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d7sm149108pjx.33.2020.10.26.20.11.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 16/21] perf arm-spe: Remove size condition checking for events
Date:   Tue, 27 Oct 2020 11:09:12 +0800
Message-Id: <20201027030917.15404-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  9 ++----
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 30 +++++++++----------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index e135ac01d94a..db93e8130916 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -196,16 +196,13 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
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
index 8e4c4c90eeb0..74f5fcebdc56 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -317,22 +317,20 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		if (ret < 0)
 			return ret;
 	}
-	if (packet->index > 1) {
-		if (payload & BIT(EV_LLC_ACCESS)) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & BIT(EV_LLC_MISS)) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & BIT(EV_REMOTE_ACCESS)) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
-			if (ret < 0)
-				return ret;
-		}
+	if (payload & BIT(EV_LLC_ACCESS)) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & BIT(EV_LLC_MISS)) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & BIT(EV_REMOTE_ACCESS)) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
+		if (ret < 0)
+			return ret;
 	}
 
 	return buf_len - blen;
-- 
2.17.1

