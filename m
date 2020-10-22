Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB2296154
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368451AbgJVO7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505086AbgJVO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t9so2811236wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSzLTxMVqlkO2IBi43EFiTi/owieV/XdOMfxVuezLa0=;
        b=SKPbAl+XAWLUuDQgOY5vHR0sARr8gwKPKZFSwXtutK+LkNSqG+gyfuARWUnax7Iw8p
         WdUftNsIBR6dqU3FbOw08s2FGygjQL9Z++AxAPMezuP4NSTOiPIdW7V0zQiT8Awx2lNY
         vgj74hjwmjKsEBpmyzaOkffJ1p1sZ03iiGOdTI8Bm1MIp/Ce/EWtAjP5BKFj4x8HgnFl
         GdMWMc/w3fbh+lbNLU/pbwxGRq95GsdwKY3qSxwN2Q4GusoP3gWDTtmXStY4Zkfy4M5D
         xr2GyvTXOp2K3wz9mynp/ou3uIe5zYMSbFd4/AlKamBeKgfL9sEPmx7Owu1RThkvuovN
         zBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSzLTxMVqlkO2IBi43EFiTi/owieV/XdOMfxVuezLa0=;
        b=PwDAxWpduTsS77xeQm9lCMyQiG2jmTxJAvxQBj+2hs43W6MGPIk0umD5nhPmLLaFfe
         vz3tH8J0b6DOX5Y/g8NUNhj+fR3dlD9KmoGAdeXSBNJuNQPnZhpcrWKZFMfD+0K6MTom
         XtI4EU3cn0mxC26GCNav1q2QP3eVxopeJTET3UCEx+wsV1U/1cSJzbyyqjq9dTRid9Gp
         anTzFGtU6vZMFQcOmhLRiebCf+bbh/E2DxPnt/nZsh1eXVP1DxmTnEddOZIuu+rKXEPQ
         Y8M+cSrATXrcw/nV1jmIC29lphAwANPMd+hMdidu1ru/PJDzsFjITDEshwx0nClvjBbG
         CtgQ==
X-Gm-Message-State: AOAM53227N+eb8584l+u9DuMCh4vt2kMqol5XrESETs9sjbjx/Z2S8Yw
        s/PN1vfOyvZ4uWDDRA6fzdT9wg==
X-Google-Smtp-Source: ABdhPJwT4qquVvFPXRX/o1qpz+JlJLU/P+HLWE05YgY/tp/HHxUxoYZHg3afOhkXLKKctvXmZew0yw==
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr3473978wrn.204.1603378728412;
        Thu, 22 Oct 2020 07:58:48 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:47 -0700 (PDT)
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
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 15/20] perf arm-spe: Remove size condition checking for events
Date:   Thu, 22 Oct 2020 15:58:11 +0100
Message-Id: <20201022145816.14069-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
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
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  9 ++----
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 30 +++++++++----------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 776b3e6628bb..a5d7509d5daa 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -178,16 +178,13 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
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
index 58a1390b7a43..2cb019999016 100644
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

