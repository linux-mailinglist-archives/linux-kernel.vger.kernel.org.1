Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6A293F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407503AbgJTPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407186AbgJTPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:02:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:02:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f37so1946167otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wA7leJ3r329vjuShQjin2/YX33n4txaRPx7BAT6IFiY=;
        b=Cvbf3WPCAnEloUeJQsig/ltKiMYzrByTjlTuRmzEZ8A9Na4Uy7ovbruvo1GF1zIv9T
         Isjq2MtLW9tp4BD7jKyckOihW+fyZjiV48m1pXTjgB1wyKCA9zt2mNKXOGMfSTM2ImIz
         FQxfgoRh64HaUn1KYR86rh9mXDC5T2S2kXNKkLVnC3MtXPl4P9QMnn2TX5MIUYawjlN/
         7L6ATQSG6S1l/uq13hVIc56WChdD9mKonjNCmQGbbGpf34UKBs/2fvr1ZdnoNwmis8/l
         7H/qXbmHCRyfhFwsFIuisLnV2B1GI6gblp2hi/4E0aAAOZ3A+V0oP1jiWTJb2XAac3CX
         Kvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wA7leJ3r329vjuShQjin2/YX33n4txaRPx7BAT6IFiY=;
        b=RlVKBxY8xj9s8Lfkt/odEi5ceF6za6JRRJH2K/bSTkB6hGUAgPi3BN5KHHArYL5/CQ
         W8hP8Oppr3qKxztJ+PfnUXoV4SVxJ6dsYVj1vekF22sJhHNTBXXTRXEuT9pF8IHP2nV3
         g9SLNJOaCIJvIFf3Rcl3hRTDfg+lhJe2GnHgz7QCmS8v6hpgLBjrMFIPn21ylqIZk0iB
         WjiGad4FMfwV0Hrpo6AOi5Riq+aWSvnR2SeCeIlFOVYmhRBLpyQUEj+t6HWvM5TGh7N8
         9Q8iDef1vF9A9sMzfG3a59zvhAlb7HKtn8BNstVtzkJofsZcB2Rd5mveLIIHnfnA9DHW
         /uKA==
X-Gm-Message-State: AOAM5339Te/Wr4Cw75toOj/HqUTDFbZM4R0JACOmiTa9uDMqLsLR+3IH
        X/BynfmvWEbLZZdWS3iNJLTbdA==
X-Google-Smtp-Source: ABdhPJzxU5HWzcCVST4Xx2Iv1CHt6jDtD3iktDJRDA8bxSGq5XzqTloe5QDsJkJ/VB8zOm4PBxgokQ==
X-Received: by 2002:a9d:6307:: with SMTP id q7mr2072814otk.218.1603206143816;
        Tue, 20 Oct 2020 08:02:23 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m10sm511658oon.27.2020.10.20.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:02:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH] arm64: dts: sdm845: Add iommus property to qup
Date:   Tue, 20 Oct 2020 08:03:01 -0700
Message-Id: <20201020150301.3259814-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

The SMMU that sits in front of the QUP needs to be programmed properly
so that the i2c geni driver can allocate DMA descriptors. Failure to do
this leads to faults when using devices such as an i2c touchscreen where
the transaction is larger than 32 bytes and we use a DMA buffer.

arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000006c0, GFSYNR2 0x00000000

Add the right SID and mask so this works.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
[bjorn: Define for second QUP as well]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8eb5a31346d2..7d635bc919cb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -811,6 +811,7 @@ qupv3_id_0: geniqup@8c0000 {
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x0 0x3>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -1119,6 +1120,7 @@ qupv3_id_1: geniqup@ac0000 {
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x6c0 0x3>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.28.0

