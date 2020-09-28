Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6577B27B204
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgI1Qfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgI1Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ADAC0613DC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so1331791pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBPXQODSosAA+MQnNKR7oefcB4hNA176v8zrJGqKyUw=;
        b=Wd/VIwRVSx+9sHI+Ujp5RSkIne7iWqEu8pQJ2s9PA5c/Q28fOHPKGkGKiF1Dnxp6Kk
         J0e9guXqYtMuDvOeOckVpHjL17VDFfKdTO+WEDeDUh9e/UT1QoUewgD1fCThdrITyAw9
         DcKhukZ9KLPUKvDcVDJAA00stRVKvzQDHuRk2ETUxB7BEE4GF2BFPaQFM4kD4K8vYk8d
         T3q0uk8y5g/QndncVIZXTUbsDKWNZiE4CH8xTupAlHCLmZI33tjAws+WsbSScsv4m1Mv
         L8ECYGHkMxhcXaNtHlHkQX8HqcecLE64voBVgC8ZVjNWHgnH9SZhIAtSnOtZYwlbJ67i
         E0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBPXQODSosAA+MQnNKR7oefcB4hNA176v8zrJGqKyUw=;
        b=ti5Vwi0opnceAD5/kOKAyzMoq+Z51xKAz+p8vRZphBY9/U+puAQkG9ClRgAWRB+bQF
         PFcDan7FmwSwBewt08PJKeYT/9xkXKAgZoq12+3wJ3rBaKGAG9q1u8hmnz9rjapQL8di
         GuBXmsy1YaLU0Bpw0ElyPMiYMN+11iro6kLq2VTy3+8XUsIBm/XYf4jwIzCGvnGsmRRx
         EHgEJ18jQxqebgwIvtWfy6PAN55NN1hOzZcKcT8y/oHq2cGQSjtxM61FKGvr2PS13DXm
         H53DbMwklqcfnZPQbCVtDQl0w3TJ3gnWInAjBwN8OWF30x5TGr6uT/u5SQjp84CMC4S+
         urOw==
X-Gm-Message-State: AOAM532xHFVQA51MA7upxyuy+6YwARSmG4K6AfyazYvVtNcQ/Oe5LLGo
        M+kPaXFvo29T6F+ao8YaR67s8Q==
X-Google-Smtp-Source: ABdhPJxNoF7c/7JPLSrL8Y9rewdCqbxcmCrsMYIS63nGaLriVkjjzWUx2gnt5y2Mx+6aG+ujqJwSEw==
X-Received: by 2002:a62:1542:0:b029:150:e3f5:d8fc with SMTP id 63-20020a6215420000b0290150e3f5d8fcmr250068pfv.66.1601310941899;
        Mon, 28 Sep 2020 09:35:41 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] coresight: etm4x: Fix save and restore of TRCVMIDCCTLR1 register
Date:   Mon, 28 Sep 2020 10:35:13 -0600
Message-Id: <20200928163513.70169-26-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

In commit f188b5e76aae ("coresight: etm4x: Save/restore state
across CPU low power states"), mistakenly TRCVMIDCCTLR1 register
value was saved in trcvmidcctlr0 state variable which is used to
store TRCVMIDCCTLR0 register value in etm4x_cpu_save() and then
same value is written back to both TRCVMIDCCTLR0 and TRCVMIDCCTLR1
in etm4x_cpu_restore(). There is already a trcvmidcctlr1 state
variable available for TRCVMIDCCTLR1, so use it.

Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index de76d57850bc..abd706b216ac 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1243,7 +1243,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
 
 	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR0);
-	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR1);
+	state->trcvmidcctlr1 = readl(drvdata->base + TRCVMIDCCTLR1);
 
 	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
 
@@ -1353,7 +1353,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
 
 	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR0);
-	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR1);
+	writel_relaxed(state->trcvmidcctlr1, drvdata->base + TRCVMIDCCTLR1);
 
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
-- 
2.25.1

