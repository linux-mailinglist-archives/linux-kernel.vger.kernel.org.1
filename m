Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753252AB03D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgKIEmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgKIEmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:42:46 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 20:42:45 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id e7so6912534pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 20:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwiurH2l8Zwz9gTv+T6kLiDq4NyDv11yqIhydKPiYYk=;
        b=Og4mDjCy2M19p2jzIA3lWbuU2F3HPDWhkfq9y6X3DptISf640ca+GxKMerReG3eehW
         40bS8LXwYk73+s/h8O2Ip7lsbFmbusTG51sTb1TiOx/k73DiWXtkxNlZgqgsn0K36u+Z
         KW3+4+XmqAO2kDmvSDYedW1q3lq0zvqZzHnlWDYU2MI5MLl0Nc/2moK/NZ4jwnkAe8j1
         EydI4vLhSciD89t7cVGUbJCN2d+Ng3yju8CvH825yi/AFR6c1Mpx+PRLMase/41Sq7Ug
         9k+lkiXlMPwrAVd7OReoXMaFvc7pm9D+oiMU5+uqgHB836KjE80lOtcICZxLIUOFr1RA
         C6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwiurH2l8Zwz9gTv+T6kLiDq4NyDv11yqIhydKPiYYk=;
        b=ue9NhBy90qGOu3OB/s07EcYQnfYFAHwIvqjmcQpjU203A5+OPWpuqmO5LYZUWjdNv+
         vwSklFtgVDlSY/AGdQ/zA6PXXTxOEIvoDsAMeR7DEixxh5OWkVN9LicfJpVbRNthgdQs
         AjhMboVd4xFAjxU4moEWYSzeQrh2FArxOchnoj2BSYCqqsoDaMLNVQKx48Ri5RshzA91
         AJQAy2wiFbO98uPhwAsWDEeLqdRxH6/dwj8vtMubymX7xgMZbxYre61M1F8yjL2AqN9c
         nNqqEuYmU7XDshkLeEiFFX2uywq53UPx7nWFHdj2jNcHnpvDhzaWskxDBvbHHVl+xOX5
         dQKg==
X-Gm-Message-State: AOAM533uGz1cxtyQGnYdOH+nLIziERRiKQOfy3KHLngrzZMxsKcHEmO4
        w6G5aGe3ertqTJJMt4CPtmg=
X-Google-Smtp-Source: ABdhPJxU8iSabECHTavUpjfPIEcMBZgyMCtMs+jnPjp9Xwp97y12hiDenQyV1igDWWjA+/P0BZ3XNg==
X-Received: by 2002:a65:53cc:: with SMTP id z12mr11873702pgr.333.1604896965488;
        Sun, 08 Nov 2020 20:42:45 -0800 (PST)
Received: from 1G5JKC2.Broadcom.net (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id m12sm9329209pgl.90.2020.11.08.20.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 20:42:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        linux-kernel@vger.kernel.org (open list),
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable ARM SCMI protocol and drivers
Date:   Sun,  8 Nov 2020 20:42:27 -0800
Message-Id: <20201109044228.6836-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109044228.6836-1-f.fainelli@gmail.com>
References: <20201109044228.6836-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ARM SCMI protocol and the common clock, cpufreq and sensors
drivers. Broadcom STB platforms (ARCH_BRCMSTB) implement SCMI to provide
support for CPU frequency scaling, clock configuration and temperature
and current sensors.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a611b0c1e540..10facef5558c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -109,6 +109,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_IMX6Q_CPUFREQ=y
+CONFIG_ARM_SCMI_CPUFREQ=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_CPU_IDLE=y
@@ -117,6 +118,7 @@ CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
+CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_BCM47XX_NVRAM=y
@@ -488,6 +490,7 @@ CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_MAX8997=m
 CONFIG_CHARGER_MAX8998=m
 CONFIG_CHARGER_TPS65090=y
+CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ASPEED=m
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_SENSORS_LM90=y
@@ -959,6 +962,7 @@ CONFIG_CROS_EC_I2C=m
 CONFIG_CROS_EC_SPI=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_RK808=m
+CONFIG_COMMON_CLK_SCMI=y
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_CLK_RASPBERRYPI=y
 CONFIG_COMMON_CLK_QCOM=y
-- 
2.25.1

