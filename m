Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55BC2B9627
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgKSPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgKSPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF41C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 10so4820746pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RNtEb68izJVAcV9f+qMY6oQBAbB/qZEtMrJUW/skAUU=;
        b=qBCDcY6uYTiPqr2967myhbeYRI1KluGpbxUHw07NadjjGGFQ8HybJK8/S2Z/cd/dwI
         22Mfj9f9FMC2Jj9aJEDrYFNcj6SZSZGX4PBEWDxM7wcfzIua3NJxKGHlk4iNJLAHWz+7
         harPa9AC2B50O/rlarAqy1sBpcGg4EK360LajqLYa030e9lQHmAJr4H+oKde0xVTO+1O
         QpJhwjKPbo2EvVOKbTEBQeRc5nUpJP6HMx6EhOPcZelDRqJ2dk2P2YwsrtzRk4Us8giI
         AtG13ylh70AnyBhUPlUsNny03zqheEeuJJo26k2r00jtayymq0JGJNH/8GHSLTRiETWF
         eSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RNtEb68izJVAcV9f+qMY6oQBAbB/qZEtMrJUW/skAUU=;
        b=MkZr0YLBIqxd1Vb7kNsitfHDL8rEygfBXHCMiXRAxXQTXDdByj6hjmt7Ia5TXsnwxs
         fnJd/gjZQJ5Tq0V1qbn2SfwmfzyPSPprPlTy9sQ7NnDSzmdrzwQFJCydI2j7BGgQ5j++
         jtja77/UQlSkeya4RiyDthIVk5iReYf93PVC/qc9+QDPe8c6wy6XMrNTGAsDjyw23DRT
         A5oG1zpZG0bBU11Tzl2TFZS9hSTY6GA7lMkl28+zpVFFAfR6GmZI6E2IKO/7YM7/sdNh
         gYdieJB88N0p7ZRn4i7i6bS4wb256rwYGaQoxyfRLavw7LuFnZs09SksZHwpBHL0m13b
         gqhw==
X-Gm-Message-State: AOAM533ALOT1KawcOf8LJGrU92D/XX9dVPVRDrHuz5ORhnrY4uFoxChS
        uUtpwoP//cK8EAUQ1oj5y5nBSA==
X-Google-Smtp-Source: ABdhPJz6fgAwQCQlc5i+1VUf368xcuqdFmqi3UwjxKYjnPkJVCYg4aCsLGSGXTkMFdpM+1Z5G0zaVQ==
X-Received: by 2002:a17:90a:5c83:: with SMTP id r3mr4164808pji.134.1605799538813;
        Thu, 19 Nov 2020 07:25:38 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 144sm130250pfb.71.2020.11.19.07.25.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:38 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 11/16] perf arm-spe: Remove size condition checking for events
Date:   Thu, 19 Nov 2020 23:24:36 +0800
Message-Id: <20201119152441.6972-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 3f30b2937715..88bcf7e5be76 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -311,14 +311,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN");
 	if (payload & BIT(EV_MISPRED))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
-	if (packet->index > 1) {
-		if (payload & BIT(EV_LLC_ACCESS))
-			arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
-		if (payload & BIT(EV_LLC_MISS))
-			arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
-		if (payload & BIT(EV_REMOTE_ACCESS))
-			arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
-	}
+	if (payload & BIT(EV_LLC_ACCESS))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
+	if (payload & BIT(EV_LLC_MISS))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
+	if (payload & BIT(EV_REMOTE_ACCESS))
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
 
 	return err;
 }
-- 
2.17.1

