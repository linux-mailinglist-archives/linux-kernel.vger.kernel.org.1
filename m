Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906632C6B06
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbgK0Rx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbgK0RxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D60C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b6so5178098pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cid2rogdw3HyRMBHSUqYcWLnZZWMdByPGWRumoY2L3E=;
        b=d2rAkHuwXjfII83cJZ8mHH/OZZOJtv/Lfz3a0FEiWIQ7/xvX4UjOycMjbHSEOzjJCY
         sSDx5MOi73q3crZdety8Xe6DXihd6jpsgU2cQ0CfU5NX0FR88K/kPwjggeq/wz88LkN/
         EUip0ygyVabW9c8d+cmrswk/TbgcOh7dMPBhKK4Wyd8gCeatcrx8PgXI+tZO18oMlRcl
         YwB1oeDWEm9XIlBE7NTzOHC29KSNxHkJHlTx3I4/0iLvtUMjRYsIesWPjOmf4PiW1K5j
         tQ57p+WH1d4rI8u+Ju+sDix5Oy+RwQ44r/sPpnhPQUOowR8vWch75zkR8U4ssFPEH0eh
         cnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cid2rogdw3HyRMBHSUqYcWLnZZWMdByPGWRumoY2L3E=;
        b=QSn50xgC0/Cx12Eu3M4wuWSWFNnH7FKXjuXDwDEls9MGIh39a6UsztxLg+n7gNOnHA
         vWE9cRcRyaI4gvFBwRlEyPLnSpFQIBvU6qiFhxVp7YrZFoVqmtcXIZiOQZ7Sbc+Buj1A
         UXBtq4eW8GXw7j6TrUpHO0CY4YfusyppVAMJ0F8focFWodBG/QMYWgj++nqQcNnLE5+a
         pHnjkmltEmAb+MMMV4BdOfHHULpeu0p02UttEc9doprIh6qi/vGlJh2mwVZfKX6FBvAJ
         kOBBPNXUM5o92uhF2lotzFI+NA90o5/wov5obGwIj8gt3R8r0qYYkevkvEWgj0hDFcmg
         Ee7A==
X-Gm-Message-State: AOAM532R+/1r8FzGaaLZEDa24q6FrV10Sq3zb2FH8UgoSAitKk5kr8Yp
        6Izm7q0qEqlTFo0IU+yaTGTuWA==
X-Google-Smtp-Source: ABdhPJzX03QPJ1AncNxktfzMKPvm4FOWCk5HFFLOeENGfPc1NebStysshBIinjjFzCAfMGy6p7wi8Q==
X-Received: by 2002:a63:4f03:: with SMTP id d3mr7430174pgb.184.1606499584025;
        Fri, 27 Nov 2020 09:53:04 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] coresight: etm4x: Fix accesses to TRCPROCSELR
Date:   Fri, 27 Nov 2020 10:52:47 -0700
Message-Id: <20201127175256.1092685-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

TRCPROCSELR is not implemented if the TRCIDR3.NUMPROC == 0. Skip
accessing the register in such cases.

Cc: stable@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index cbbe755d1d16..28dd278f6d47 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -124,8 +124,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
-
-	writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
+	if (drvdata->nr_pe)
+		writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
 	writel_relaxed(config->cfg, drvdata->base + TRCCONFIGR);
 	/* nothing specific implemented */
 	writel_relaxed(0x0, drvdata->base + TRCAUXCTLR);
@@ -1185,7 +1185,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state = drvdata->save_state;
 
 	state->trcprgctlr = readl(drvdata->base + TRCPRGCTLR);
-	state->trcprocselr = readl(drvdata->base + TRCPROCSELR);
+	if (drvdata->nr_pe)
+		state->trcprocselr = readl(drvdata->base + TRCPROCSELR);
 	state->trcconfigr = readl(drvdata->base + TRCCONFIGR);
 	state->trcauxctlr = readl(drvdata->base + TRCAUXCTLR);
 	state->trceventctl0r = readl(drvdata->base + TRCEVENTCTL0R);
@@ -1292,7 +1293,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
 	writel_relaxed(state->trcprgctlr, drvdata->base + TRCPRGCTLR);
-	writel_relaxed(state->trcprocselr, drvdata->base + TRCPROCSELR);
+	if (drvdata->nr_pe)
+		writel_relaxed(state->trcprocselr, drvdata->base + TRCPROCSELR);
 	writel_relaxed(state->trcconfigr, drvdata->base + TRCCONFIGR);
 	writel_relaxed(state->trcauxctlr, drvdata->base + TRCAUXCTLR);
 	writel_relaxed(state->trceventctl0r, drvdata->base + TRCEVENTCTL0R);
-- 
2.25.1

