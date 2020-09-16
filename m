Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00EB26C9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgIPTVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE4C061355
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f1so3714552plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRmm8bmeMmrl//Bh/Ohg4sjapVcVZVx2mLqHhA1BT1E=;
        b=YtgtRm6TEPQvXCCQlKgRxDG0S9XeFfuisPV0mES7rQozmfBpG5lrpS588yY1oBbI5j
         xlID4XzrtSFfGPpHD0b3cOkkmXzZ8p5fuNJQciDrQex4Sg0WcT/XHxsver3FlqKWyfmJ
         Sxv9k3XT9xtRmkNnCBfsdESg/J7TCgKnbH8MWiu+yIyB1CtJRFou8LGJxebilCWiWOvp
         gK52G2bLycPM7FhnDbG1EJxVM3LZiTLkXhvHuDRuetHavFy7Ytwq5WI1Y5uA5J3XiUuL
         AJHC4XV8l19lO380HPRoBKQw7dmCupL8GHaHt7xMkywIkcQGKWJlKM0XYI225SJXhA9g
         Duew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRmm8bmeMmrl//Bh/Ohg4sjapVcVZVx2mLqHhA1BT1E=;
        b=rK6ePYfdPMIMNEjWN+BBWi43VzRoAHc5KqOKe6tPCi13mIBKDL2WDLIyZXZDLvfBYv
         jRCVvHuSp1GxvXmiHLS4IyPNa/yHe/2xK+oxHOwWvqXDM+w8vTrM1Hrs/8gN+V37TGpf
         PnmB/Ido+Hm/OWjGUOYvCpkmsH050TTybg3cHyMqkzdnECofrr1O00k0QSEWR7oIlWeE
         RXmr9vbMR8cDRhTR34PCoGye5i+OIoicollW2Aj9FoHX6/d2iRxXNdyipdKhbEwUupOn
         hdViUt13kQmSz3JI+LG44pdq5/fmoXSXpY4YVQFL54+tU7DNBrAtFMtjgnHmhEKYDHqu
         07WA==
X-Gm-Message-State: AOAM5318wY/BkGpfLZUnO/qPHM09R3Si3f9lrAY1GKncpP2O8QvZzwjn
        yhvrEQzPqEDM7MuDhhou1PFzYw==
X-Google-Smtp-Source: ABdhPJyS90vU7UFhu+3Ljfr6q8tDhE2e9b1N/bzcYtV307XVKEF5v+8dvOcsbZ6QSd7yIayFFIe7yw==
X-Received: by 2002:a17:902:bf4b:b029:d1:cc21:985b with SMTP id u11-20020a170902bf4bb02900d1cc21985bmr13973978pls.32.1600283871628;
        Wed, 16 Sep 2020 12:17:51 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:51 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] coresight: etm4x: Fix issues on trcseqevr access
Date:   Wed, 16 Sep 2020 13:17:32 -0600
Message-Id: <20200916191737.4001561-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

The TRCSEQEVR(3) is reserved, using '@nrseqstate - 1' instead to avoid
accessing the reserved register.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: lizixian@hisilicon.com
Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[Fixed capital letter in title]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 63cb1e0d5953..b29ad4f7fac2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1193,7 +1193,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcvdsacctlr = readl(drvdata->base + TRCVDSACCTLR);
 	state->trcvdarcctlr = readl(drvdata->base + TRCVDARCCTLR);
 
-	for (i = 0; i < drvdata->nrseqstate; i++)
+	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		state->trcseqevr[i] = readl(drvdata->base + TRCSEQEVRn(i));
 
 	state->trcseqrstevr = readl(drvdata->base + TRCSEQRSTEVR);
@@ -1298,7 +1298,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trcvdsacctlr, drvdata->base + TRCVDSACCTLR);
 	writel_relaxed(state->trcvdarcctlr, drvdata->base + TRCVDARCCTLR);
 
-	for (i = 0; i < drvdata->nrseqstate; i++)
+	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		writel_relaxed(state->trcseqevr[i],
 			       drvdata->base + TRCSEQEVRn(i));
 
-- 
2.25.1

