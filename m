Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B02CDF0F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbgLCTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCCC08E860
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:38 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d3so3727679wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgAsHJwaQfvdzO4opyvR7eMh5LHGQXtnVUxJy3rVvxU=;
        b=r8cWEJG3K0GJZA9QIG02ZF3KHL+OWEBJ8beFzuciOrtXmafOkfdh49lguvEpBUjIaa
         YO0V0lk1HYGfZUWVL+5B1kj60xvyLTQFF6J7qQC6KamAJtwSJpAlg4j0k6/536xMXRHc
         jhzpQyDuwEQs71Wh6DUwIni+DyMO0tt7ve3eaWlWubTOdTm/8+OPQbWWYAzDXaOcFndp
         PX7tJRXTsvDC7q5Eli7clo/b04k9zdBcTSaEEXWgKuuIfU2Nfjh1owxQVER3MMZuYbLe
         CfRZVI91pA0J5zVFiX0LXJCR/n5sfmrQYu9C0qRtk5w+VbIdomxFILh6dNpjV2ggBMgA
         QBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgAsHJwaQfvdzO4opyvR7eMh5LHGQXtnVUxJy3rVvxU=;
        b=FIcLn5sghmKmjtyBybjvrkI/MdNL9y9D6pp6r9FYLB6GSvHwuFumu2/Vj8lLY58+Hd
         3gsMARVapFPWQUN/rJbL/uOMrKmoECyaF5zsH06/wx4/x4DZPbQorO7AMi4Cg3aYdeL1
         RuLT/rfztnYrX+XSbHnC5G7J1FSSMNDRo+IJKep+K6l4ev9lQkVabfnnCIjz2psMHvjJ
         PgP9Azxr8zHZdAuK5ORDsKRqPt1Lz3ZtWvQU4uS0oMQQod9vPUIi4mnZEzOUqAq15iX3
         lDPCAsgmc/R1hVWihEP59q1oyYPMl3njLLC31f2WE03yzPY1qEkR/SWaM4y9uwG/k2UE
         RUpA==
X-Gm-Message-State: AOAM530JXrIMy+2a0XYWY0XkfCJXTgzBYBbDbywuwspIvnjrt09blW7z
        UMDsACkgQK4nYHCNV9rQkr36Wg==
X-Google-Smtp-Source: ABdhPJw0B3Oy1fP83n1iTECFTKOmOk76v26pc9jwWOD6CFbM1MbQMpgcefm6PjzACae2xpkk2WTk3Q==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr367305wml.155.1607024016624;
        Thu, 03 Dec 2020 11:33:36 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] clocksource/drivers/ingenic: Fix section mismatch
Date:   Thu,  3 Dec 2020 20:33:00 +0100
Message-Id: <20201203193301.2405835-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ingenic_tcu_get_clock() is annotated for the __init
section but it is actually called from the online cpu callback.

That will lead to a crash if a CPU is hotplugged after boot time.

Remove the __init annotation for the ingenic_tcu_get_clock()
function.

Fixes: f19d838d08fc (clocksource/drivers/ingenic: Add high resolution timer support for SMP/SMT)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Link: https://lore.kernel.org/r/20201125102346.1816310-1-daniel.lezcano@linaro.org
---
 drivers/clocksource/ingenic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 58fd9189fab7..905fd6b163a8 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -127,7 +127,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct clk * __init ingenic_tcu_get_clock(struct device_node *np, int id)
+static struct clk *ingenic_tcu_get_clock(struct device_node *np, int id)
 {
 	struct of_phandle_args args;
 
-- 
2.25.1

