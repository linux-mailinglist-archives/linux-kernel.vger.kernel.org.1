Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087582C6B07
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgK0Rxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbgK0RxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:01 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6410FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:01 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so5203475pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNGHnO9ll6HTBICKLE2sbKPUjh4enI7FVT3THmvmgNs=;
        b=wrVkR2nMhM8v7NM00CWN5a3ThJr5gXMulS6pXdD0AiXNkBYGXwCr7Pe6U6dJk+8A6i
         9oyADOpw2GbdktgpAEftptupUJEeySVT1kospscOhWTq1RQmRAsQ6EwGKN8tqu87X5U1
         vai1Ao8TdZvmqM0DKOBw1gQzCiW3DbMbaPRnWv783DER6Hc3IhLN8d9yU1RGDY324SBC
         lW4UIVN5ThxkBN87ostReqg+MDSE03m8smDrqzkjno+02JeiJ8eftEX7vjOvmYPwW/PM
         XGx0p/N9TPU25SggjAFMx/OE52wMYK75CSzIW8lCa29Z2enbFpf5E59ADRv5UF7jHGGD
         2gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNGHnO9ll6HTBICKLE2sbKPUjh4enI7FVT3THmvmgNs=;
        b=KHvpxIZmi7tbdSXJQN9q5FFYm3IWDxzNZS0iaH4MVGtbIuoyUvXphj96lIOhpYgN6c
         2w5+33qNHovneTd/iBdRXZsV8S+jJx25Eoom8TmqN6kezhy7H12GIoG65xkE4smNDbOe
         7+ONCry+IHeDGdpDUc/D4JbkOMxIPF+jI584Yaebc4TCtfuai/pMKwJjhMs5QvD6vZCd
         O5EClZX54nQtwpwjp2fAdu/LXo0ThKeF5XwsW9zG5ARU1L497IxbnmnGog3V2oUtOAI2
         lerOGqKqb/8DYEWAlGlM2nhlcL+e1RvI/uZODQxqb2BWGJmKtqr98T7y19yNroOk29xy
         wm8A==
X-Gm-Message-State: AOAM532FrWwsdvVtI3RSSk8c3ZI4qVDeukYVAf8BaLZ+OFyE4RWJdXgM
        VQQ1zuqzcLlaPoDWr9mcFROcQg==
X-Google-Smtp-Source: ABdhPJy15OTUg7zTZP2A3vmkY5WIjhUbqmSPPjAHisxkL2kmDw2eFs9rQf+lX6xPoEpgFREo5E4D7Q==
X-Received: by 2002:aa7:957c:0:b029:198:34c2:ccd9 with SMTP id x28-20020aa7957c0000b029019834c2ccd9mr8235299pfq.1.1606499580995;
        Fri, 27 Nov 2020 09:53:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:00 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] coresight: etm4x: Fix accesses to TRCVMIDCTLR1
Date:   Fri, 27 Nov 2020 10:52:44 -0700
Message-Id: <20201127175256.1092685-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

TRCVMIDCTRL1 is only implemented only if the TRCIDR4.NUMVMIDC > 4.
We must not touch the register otherwise.

Cc: stable@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 6096d7abf80d..e67365d1ce28 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -193,7 +193,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		writeq_relaxed(config->vmid_val[i],
 			       drvdata->base + TRCVMIDCVRn(i));
 	writel_relaxed(config->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
-	writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
+	if (drvdata->numvmidc > 4)
+		writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
 
 	if (!drvdata->skip_power_up) {
 		/*
@@ -1243,7 +1244,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
 
 	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR0);
-	state->trcvmidcctlr1 = readl(drvdata->base + TRCVMIDCCTLR1);
+	if (drvdata->numvmidc > 4)
+		state->trcvmidcctlr1 = readl(drvdata->base + TRCVMIDCCTLR1);
 
 	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
 
@@ -1353,7 +1355,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
 
 	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR0);
-	writel_relaxed(state->trcvmidcctlr1, drvdata->base + TRCVMIDCCTLR1);
+	if (drvdata->numvmidc > 4)
+		writel_relaxed(state->trcvmidcctlr1, drvdata->base + TRCVMIDCCTLR1);
 
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
-- 
2.25.1

