Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBFF2C36E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgKYCie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKYCie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:38:34 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE36C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:38:33 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id l10so153010ooh.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtaxpQIzT+P5D4l8XAcFikRycvnMGmoexIGQvL81jcQ=;
        b=TAS0PihWvQmWNbOpYQ2b4aXOeCNXradWK5U+Sn9d+9yo2oyYdSRk+Bniwu08PpNnGl
         VNBQm3bBkJX/B/5ZDjWDLVsshbKzW1P0Ncg4iYg4Xlu0DttKUfPqDUxtCzAn9pZnng4D
         r0EzRRCSpRTKG/PFejWAzCeU5aPbykl6BNOkgorzFYiI3ounv/V9d7PCXsIJHkBWHZFK
         P7CelOqYHA35X/fEJu83yH7kn8Vfx+s+ePBCo1yh3Bjqxa33MCobfRWTnu1kGAvCP0Mf
         Xc10kO/INSbAPaiG7RbKCQdzDwkkX6W9lLMRlM35jhJ7RTaN7QGz6QuXOOxRi8W6THyi
         BaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtaxpQIzT+P5D4l8XAcFikRycvnMGmoexIGQvL81jcQ=;
        b=H3PUPLQrYAXZCP5ByFxnAUMt6EcRjD7gmG8qgp3fDr6EU6WDQ0iRGDLAv5DHdGRF0B
         w7jXP9gxH29fe7yOxn310eGi9aUlO8zKMqzdkgaHBFZewnfcvSih7SWkhLWqIqzEJ1Uu
         tC6RrdZkiLG66+rqVteRi6CUcpZvT2Z2PZRJFz8hMrWKh0XOy3WJhMPuj7p0Y+Jg932e
         4mEPMF8Qb5tz7kVMROYoX9YF85wOmfWkWBsBlm1bzaqzH/7TjwIMRqU2iBPmyWQKT/HL
         EnLSPlvfKoxSYonRQn+HIKYvGvmBb2qS88EzAzzRJnh5WnTox+9dA38up2mXpi9jMCuu
         XU/w==
X-Gm-Message-State: AOAM530iiNJPiUv5nBzc8rTJtnWFVsu+VxIs031HhhHeCaO6RoGgtcJa
        nffRjrIZ2EPEoCPAmI+Mtv2SaA==
X-Google-Smtp-Source: ABdhPJz8UgPUCPHZALMWRtGlGsfojZc3lxSaqf7cWPibEqoeLMcwNinuUQ0lQXk29kZyeOhmPVBapA==
X-Received: by 2002:a4a:d347:: with SMTP id d7mr347703oos.47.1606271913101;
        Tue, 24 Nov 2020 18:38:33 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c136sm610602oib.7.2020.11.24.18.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 18:38:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm PON driver
Date:   Tue, 24 Nov 2020 20:38:31 -0600
Message-Id: <20201125023831.99774-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PON block in the PMIC provides, among other things, support for
"reboot reason", power key and reset "key" handling. Let's enable the
driver for this block.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9246f51085f..8e3ed05b655a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -521,6 +521,7 @@ CONFIG_POWER_AVS=y
 CONFIG_QCOM_CPR=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
+CONFIG_POWER_RESET_QCOM_PON=m
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SYSCON_REBOOT_MODE=y
-- 
2.29.2

