Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2782FE2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbhAUGYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbhAUGPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:15:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E9C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:14:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t6so720721plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWNPq5tM5lqX5/zedEBYeld5UMgLH1ZRvHHInCrsJks=;
        b=W2hKOdGMnelumlsRqeBsS8X/SVWWRS1ZiLqcN46tn6qmVeUClcJlai63N/hWswgpFM
         +sNmeMOpA4cMhPv4HN5VNvmsRQ72Dp9o1rI//zT+JGuKUWGKlW5ieC4Ad2Eeq2KmRuSd
         R+GM6dQ8DRKI6XOhNskpzozRbg61BgubFjiJsrb+tcDsndOCAODBel0cwb/1TwKZNnWP
         +WByqsWrP41cWzlj/VRPxfYtBxAbJ+l0mYlnnl2HTIOPMno/FhCSVe9E5WEUpZtkorrg
         pNjU7+x84vZKezKKccHikPiKnvO4Hoc6Ii/thkmn/gAWeJo/XoQtRFFLCxuIpxXG7gr+
         nlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mWNPq5tM5lqX5/zedEBYeld5UMgLH1ZRvHHInCrsJks=;
        b=HZb6CwuOaO8IUVKwfYDwrAo9unFeRRVv/VsXP3iE0lDwoH/pEB1qKBq1WmlT4cjspa
         EoS4j0cuqQsIz0Iq4MqYjWm+0Vx2e1Y7b+qP0eF6Cqqaq0b20+QFvglKQqyS/nYcvFsB
         N6vJoD5I3oxW7fyqiMzDiqipvxBbv6aRVV0Dph3kGGux8uhJue8WzzVctBv1A7P6ZjbU
         pLvEg0HopsVhqVMWgPd3ukhrUOsITSyRa6GBiE+t+/aqCO5xV38Myvl0vB/QZF7NlzRu
         6HfOD3/BsKqcGUOP3grDkaA7kWTtd9vYf/t9AAe+OLjgdxJeiYgmF6UhFAsXLbhufTDM
         LX2Q==
X-Gm-Message-State: AOAM531YIDe2sjC+3fXjBFIvMUxbLNxmkeKvdNDMvau1yo0aPDG6ZkJF
        Ujv8SmC0cANpPzfyZFYVU2H3eNKbZ+NL
X-Google-Smtp-Source: ABdhPJz8Nb3Y9k8FnhjUO5mjSJ8WHQ77xlEw+6vTBZvVxmjSrxutQwemyWmViMqt9OoIxS8B2QiQVQ==
X-Received: by 2002:a17:903:22cc:b029:de:191c:1bdb with SMTP id y12-20020a17090322ccb02900de191c1bdbmr13737843plg.14.1611209698718;
        Wed, 20 Jan 2021 22:14:58 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id h12sm4415759pgk.70.2021.01.20.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 22:14:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        afaerber@suse.de, linux-actions@lists.infradead.org, arnd@arndb.de,
        cristian.ciocaltea@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Actions Semi platform and drivers
Date:   Thu, 21 Jan 2021 11:44:47 +0530
Message-Id: <20210121061447.26517-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for Actions Semi ARM32 platform has matured enough in the
mainline. So let's enable it in multi_v7_defconfig along with the
relevant drivers. The platform can now boot a distro from eMMC or uSD
without any out of tree patch.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c5f25710fedc..99f8815ef753 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_VIRT=y
+CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_ARTPEC=y
 CONFIG_MACH_ARTPEC6=y
@@ -377,6 +378,8 @@ CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
+CONFIG_SERIAL_OWL=y
+CONFIG_SERIAL_OWL_CONSOLE=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_ASPEED_KCS_IPMI_BMC=m
@@ -401,6 +404,7 @@ CONFIG_I2C_EMEV2=m
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
+CONFIG_I2C_OWL=y
 CONFIG_I2C_RIIC=y
 CONFIG_I2C_RK3X=y
 CONFIG_I2C_S3C2410=y
@@ -449,6 +453,8 @@ CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_RZA2=y
 CONFIG_PINCTRL_STMFX=y
 CONFIG_PINCTRL_PALMAS=y
+CONFIG_PINCTRL_OWL=y
+CONFIG_PINCTRL_S500=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
 CONFIG_PINCTRL_IPQ8064=y
@@ -878,6 +884,7 @@ CONFIG_MMC_SH_MMCIF=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_BCM2835=y
 CONFIG_MMC_SDHCI_OMAP=y
+CONFIG_MMC_OWL=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=m
@@ -947,6 +954,7 @@ CONFIG_IMX_DMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_MV_XOR=y
 CONFIG_MXS_DMA=y
+CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
 CONFIG_SIRF_DMA=y
 CONFIG_STE_DMA40=y
@@ -977,6 +985,8 @@ CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_SCMI=y
 CONFIG_COMMON_CLK_S2MPS11=m
+CONFIG_CLK_ACTIONS=y
+CONFIG_CLK_OWL_S500=y
 CONFIG_CLK_RASPBERRYPI=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_RPM=y
-- 
2.25.1

