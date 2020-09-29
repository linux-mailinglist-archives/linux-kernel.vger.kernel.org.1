Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78B127CF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgI2Nk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgI2Nkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F797C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so5490663wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5ZGpB0t8mpRAldtVWf/zzw+mXqUI+Sptv52PfJkwe4=;
        b=Znnwfhs4VYM5sOzZDG5chJWBX7Q2kLk+s0PO/UbTc0wIzIxu2r7sBeb4NMSVndFxuN
         yTkmmmEnhrNG4ROGoTyFZiDDtwkS5QW9urNhmSQqOFOeXe5VczsgFJW60NorHjUm2DDG
         1rEMuE7m6gq7FG4sZoSNRDYHsyu9hbjIycu7I6eR4lrFJb/MSKhDMAqOo9lkXl90EG4o
         FVy2hSb54+ZlkqdJ8ttfay4hbRZcp8IHoLZwGpQUXFtXO5aXDU7lFdC1+LYYOR9P/xZ4
         X++3fIJ01pr8lm58N00M3otnO1zdZmH6VI+1qvNPdWDLD8L0vHrnW2aMc+6Wy9U2lYpx
         k4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5ZGpB0t8mpRAldtVWf/zzw+mXqUI+Sptv52PfJkwe4=;
        b=hBk10KAttYr2RIJV20w4LF61tDymqkk43Yi2zVWh0fb+T8ArYY8XjI1prK8B1mpct9
         GLa0jUWZ5qXjJHWTw5X/+O7U5Tc+XPiFHrKp+IhwUPW2aUQM2LOnhMkOCj7bJncy+pXz
         JfyDRlm0WkSfCReGowDZuhzKbf15eHUasKUISlyuSFyw004OyBrPU2cSajOSefJzpoW+
         xyPZgtGn0bRc0Sywp6GlW4XKANRXAHujR6kwfgxbjBph0FUcvlRaO9RwYVPJFldCUkSF
         Hn2cKX1cAKoa+7vlC5eDaruUxw5+ow/qp6THGCrcZVf4yE/R6SUTQb5Bcm7OTg71hxaV
         Kjhg==
X-Gm-Message-State: AOAM532sydOdpNQ9QK5Yv11pkSZX+DWqi45C3mS2GS3Sq8RDx5BRi/6c
        gUIZSV5WAleF2XGuZ75OCniQcw==
X-Google-Smtp-Source: ABdhPJzOdU9gKCOJYaziJy7SnxPt72dOwYrd2t6fgId0sQEqP0uIByyjHNfibe4lSqxsDnxv3dN4EQ==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr4280290wro.86.1601386849672;
        Tue, 29 Sep 2020 06:40:49 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:48 -0700 (PDT)
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
Subject: [PATCH v2 02/14] perf arm-spe: Fix a typo in comment
Date:   Tue, 29 Sep 2020 14:39:05 +0100
Message-Id: <20200929133917.9224-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: s/iff/if.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 46ddb53a6457..7c7b5eb09fba 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -142,7 +142,7 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 
 	/* we use index to identify Events with a less number of
 	 * comparisons in arm_spe_pkt_desc(): E.g., the LLC-ACCESS,
-	 * LLC-REFILL, and REMOTE-ACCESS events are identified iff
+	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
 	packet->index = ret - 1;
-- 
2.20.1

