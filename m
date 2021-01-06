Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA942EBDE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbhAFMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAFMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:54:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128FC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:53:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so1547359pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PyWDubPE7bDQlqfk8UIpEmsm+9VUy6BtD0d93J0jbw=;
        b=BvqeiOejm5t74mEbD1T9szJiGG8swq3q9dD28NmWlaz2gG0PmLihFTn+0cv5+ilm3f
         pGjos2fnfT/p32UFiwVey47V7pW2o8XRvBUWZdYZXzK+ft407LvHJxAzRPn/qSMY1w2N
         degyLQKFZ6y59ZjkLHg06mBBeiEeyzFxMCeKuul2Vvq0Zd4LTN7kM7y1DXsRqocusLMC
         3H6pfgtd3+tMTKhMSXfunZgbMKgdwG6zqIaL9MdfvUJjAsj9z20wyCcgX1vRtNJZ1JB/
         pze5M0l3qqNnIMcWYzUmJIniSJApPZjMaD83YApFDkyFvaFF1EaY9gXSqMOyrGGGRkjy
         Azcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PyWDubPE7bDQlqfk8UIpEmsm+9VUy6BtD0d93J0jbw=;
        b=jm/lZlW2g28l91re4+nUWl23kipIEUS5oRmX0/nG0Y0t9Xk4TkE5dNgf49kZf/ot2v
         JjBMzGTCjDTLsus78cS6y6cuhq7baI3Jy2AArThr38YHURg7as2FmnMhXb7yeQf8yF5K
         QXpKPUHVPMX/n+CykYF1OLHCQ2bwcZ1EcNZXPg2MIkcaBrIB7Zak19zM/5oRfmb3bkPR
         90W008eQLIFYuY7Kxpk7lAv2MYxjDdNMSVMGHXPjL+bOp7YLjFso8qNmoJH7inXNbLMN
         OY0hiV3jvop11NgEyvv7bEtoSO395Eg+WnFduBRfALQVRaX3Zh6dwTsi7a6zf0/grzI+
         NDTQ==
X-Gm-Message-State: AOAM531F4p48PiMRgHcA8kAaaEzomMGPPLyib3f8dnVk1AzQGKt+Dg6N
        TcGzs2dAUsIZGC/9M0G1Nkii
X-Google-Smtp-Source: ABdhPJymo2jDyvADA7s7nqxyY5xoaHg7KOPIVHqvqVbSkCnFWOXBCRPM2Yi6MqJZ/9eHq/107S2UJg==
X-Received: by 2002:a17:90a:d18c:: with SMTP id fu12mr4246121pjb.50.1609937619732;
        Wed, 06 Jan 2021 04:53:39 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:53:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/18] Devicetree update for SDX55 platform
Date:   Wed,  6 Jan 2021 18:23:04 +0530
Message-Id: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This series updates devicetree for the SDX55 platform and the MTP board.
Most of the SDX55 specific driver codes are already merged and some of
existing driver support got reused.

Thanks,
Mani

Changes in v3:

* Dropped interrupts property in spmi-gpio node
* Used dma-controller node name
* Reworked tcsr mutex node
* Sorted binding compatibles
* Collected reviews from Vinod

Changes in v2:

* Changed "SoC" to "platform" and modified FIXME in commit message

Bjorn Andersson (1):
  ARM: dts: qcom: sdx55: Enable ARM SMMU

Manivannan Sadhasivam (9):
  dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
  ARM: dts: qcom: sdx55: Add support for SDHCI controller
  dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
  ARM: dts: qcom: sdx55: Add support for TCSR Mutex
  ARM: dts: qcom: sdx55: Add Shared memory manager support
  ARM: dts: qcom: sdx55: Add QPIC BAM support
  ARM: dts: qcom: sdx55: Add QPIC NAND support
  ARM: dts: qcom: sdx55-mtp: Enable BAM DMA
  ARM: dts: qcom: sdx55-mtp: Enable QPIC NAND

Vinod Koul (8):
  ARM: dts: qcom: sdx55: Add pincontrol node
  ARM: dts: qcom: sdx55: Add reserved memory nodes
  ARM: dts: qcom: sdx55: Add spmi node
  ARM: dts: qcom: sdx55-mtp: Add pm8150b pmic
  ARM: dts: qcom: sdx55-mtp: Add pmx55 pmic
  ARM: dts: qcom: sdx55: Add rpmpd node
  ARM: dts: qcom: Add PMIC pmx55 dts
  ARM: dts: qcom: sdx55-mtp: Add regulator nodes

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt     |   5 +-
 arch/arm/boot/dts/qcom-pmx55.dtsi             |  84 +++++++
 arch/arm/boot/dts/qcom-sdx55-mtp.dts          | 203 +++++++++++++++++
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 214 ++++++++++++++++++
 5 files changed, 505 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-pmx55.dtsi

-- 
2.25.1

