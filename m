Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17B52C717C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbgK1Vv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:58 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:45966 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731978AbgK1S5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C8A41FB02;
        Sat, 28 Nov 2020 19:56:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SkhrUiKWInlS; Sat, 28 Nov 2020 19:56:24 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1B65A40266; Sat, 28 Nov 2020 19:56:24 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v2 1/1] arm64: defconfig: Enable more Librem 5 hardware
Date:   Sat, 28 Nov 2020 19:56:23 +0100
Message-Id: <2d0b05e9a70790e7b3d7d38703efff95aa059090.1606589670.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606589670.git.agx@sigxcpu.org>
References: <cover.1606589670.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables

- CONFIG_BATTERY_MAX17042: battery chip
- CONFIG_CHARGER_BQ25980: charge controller
- CONFIG_DRM_PANEL_MANTIX_MLAF057WE5: LCD panel
- CONFIG_GNSS/CONFIG_GNSS_MTK_SERIAL: GNSS receiver
- CONFIG_IIO_ST_LSM6DSX: IMU
- CONFIG_IMX_DCSS: 2nd display controller
- CONFIG_LEDS_LM3692X: LCD backlight
- CONFIG_REGULATOR_TPS65132: regulator for the LCD panel
- CONFIG_TOUCHSCREEN_EDT_FT5X06: touch controller
- CONFIG_TYPEC_TPS6598X: USB PD controller
- CONFIG_VCNL4000: ambient light and proximity sensor

as modules.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/configs/defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 270d326d5f28..34b837b866c2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -240,6 +240,8 @@ CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_FSL_MC_BUS=y
 CONFIG_TEGRA_ACONNECT=m
+CONFIG_GNSS=m
+CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -381,6 +383,7 @@ CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
+CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
@@ -521,6 +524,8 @@ CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
+CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
@@ -595,6 +600,7 @@ CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
+CONFIG_REGULATOR_TPS65132=m
 CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
@@ -655,6 +661,7 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
+CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
@@ -669,6 +676,7 @@ CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
+CONFIG_DRM_IMX_DCSS=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_HISI_HIBMC=m
@@ -777,6 +785,7 @@ CONFIG_TYPEC=m
 CONFIG_TYPEC_TCPM=m
 CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_HD3SS3220=m
+CONFIG_TYPEC_TPS6598X=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -806,6 +815,7 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MMC_OWL=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_LM3692X=m
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
 CONFIG_LEDS_SYSCON=y
@@ -978,8 +988,10 @@ CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
+CONFIG_IIO_ST_LSM6DSX=m
 CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=m
+CONFIG_VCNL4000=m
 CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_MPL3115=m
 CONFIG_PWM=y
-- 
2.29.2

