Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8129E3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgJ2HVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJ2HVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1DC0604C0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c20so1593172pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPQbmyrDRY2ZKKxVpQZL7kKPj+via0NPR+oKilXdmEQ=;
        b=MSyrIJBYdYzXSera9cU5JrWegpRyWCYURa31vwTypNe0uZPT+GFb0m/CCcR3cyqei1
         e/EPMCM9KKZXNhSMwmxNG215j9IoSYVr9SOIZmEZhaYoqh4OejTNNlJybFHJwImCvffj
         4/7FMX4JCdL8BE1LozsdKITPmuSyygIDtI3y+qwuao2s/zmEUsMBW/LDwCrJiJMyxBpT
         oCJf5BXgc0ULS2nSxeV7xIMrxGFJAdj8PFqMwSAOlrKKTMYlhMXuPRwZiBKwbVT77kxK
         CKuwnS62bqIiAtEvHSlffVjltG9ZFuVah1lJyeonyCLIgybspJs8DpIV6SxwHHrTgUDX
         5SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPQbmyrDRY2ZKKxVpQZL7kKPj+via0NPR+oKilXdmEQ=;
        b=aNRdtaUZ8hhXtKws74HwncIdF0zcJuYGgH7XdeKz2GUaDP1OC9baW5ctnSmDuwbgv9
         yFeaLuEj1lkYSqy69z1kJzE4SPZV/nlPoSPRj5nQIsabtm6XSH3gMUose09zPwz0Y8pr
         WUCDQi3umdERkBW7LmqqNZ6WvEvFdcS+2dOTQWJ68lnChbUTil45YZ9NDMzU67NAOoce
         b06IscC1V6UfhgWU0q++LvZFuHQLdR55CIoMZ3lrUyywM+EEs3zZcC4RT5ri1zECMzsC
         Co/82Mo++k1OOcsIeqb3PVy0glkbRgVSDpQQcyqb+kHNO6HBhJQNRDb6mmIoH1XzXZ6h
         lFaw==
X-Gm-Message-State: AOAM530rwV9nF3ozSeCy0QTJpQjDQhEwMN10RrSOeB9G7N+/7kNyMrih
        wIeTDbwy8WV/1EDXvOhCQGOPNg==
X-Google-Smtp-Source: ABdhPJzkpZ7ZLmI06yC03rb4fgx+352ww68etwNWwhh+6okUefbIikEEvWLppFkl+WUsPHLGmsD7xA==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr2951052pjb.75.1603956058674;
        Thu, 29 Oct 2020 00:20:58 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id fy24sm1541531pjb.35.2020.10.29.00.20.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:58 -0700 (PDT)
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
Subject: [PATCH v5 16/21] perf arm-spe: Remove size condition checking for events
Date:   Thu, 29 Oct 2020 15:19:22 +0800
Message-Id: <20201029071927.9308-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index e8c334f19316..b42ba64274c1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -294,14 +294,12 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
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

