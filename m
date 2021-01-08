Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69A2EF2B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAHM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:58:03 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44968 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbhAHM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:58:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 92781FB03;
        Fri,  8 Jan 2021 13:57:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HwL-KFf8YOXo; Fri,  8 Jan 2021 13:57:15 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9DC9040445; Fri,  8 Jan 2021 13:57:10 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v3 1/4] arm64: defconfig: Enable Librem 5 devkit components
Date:   Fri,  8 Jan 2021 13:57:07 +0100
Message-Id: <5636a3d6e3217475e2a479248250d5c0e0a50e26.1610110514.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610110514.git.agx@sigxcpu.org>
References: <cover.1610110514.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem 5 devkit is based on NXP's i.MX8MQ. Schematics are at
https://source.puri.sm/Librem5/dvk-mx8m-bsb.

This enables drivers for the following hardware components that aren't
yet enabled in defconfig:

- Goodix GT5688 touchscreen
- iMX8MQ's PWM for the LCD backlight
- TI BQ25896 charge controller
- NXP SGTL5000 audio codec
- Microcrystal RV-4162-C7 RTC
- magnetometer: CONFIG_IIO_ST_MAGN_3AXIS
- the SIMCom SIM7100E/A modem
- NXP PTN5110HQZ usb-c controller

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/configs/defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4bb16b93e5d9..078d3d86289f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -417,6 +417,7 @@ CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
+CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
@@ -566,6 +567,7 @@ CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
@@ -747,6 +749,7 @@ CONFIG_SND_SOC_FSL_ASRC=m
 CONFIG_SND_SOC_FSL_MICFIL=m
 CONFIG_SND_SOC_FSL_EASRC=m
 CONFIG_SND_IMX_SOC=m
+CONFIG_SND_SOC_IMX_SGTL5000=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
 CONFIG_SND_SOC_FSL_ASOC_CARD=m
@@ -773,6 +776,7 @@ CONFIG_SND_SOC_TEGRA210_ADMAIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
+CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
@@ -810,6 +814,7 @@ CONFIG_USB_ISP1760=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
@@ -829,6 +834,7 @@ CONFIG_USB_CONFIGFS_MASS_STORAGE=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_TYPEC=m
 CONFIG_TYPEC_TCPM=m
+CONFIG_TYPEC_TCPCI=m
 CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_TPS6598X=m
@@ -879,6 +885,7 @@ CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_PCF85363=m
+CONFIG_RTC_DRV_M41T80=m
 CONFIG_RTC_DRV_RX8581=m
 CONFIG_RTC_DRV_RV8803=m
 CONFIG_RTC_DRV_S5M=y
@@ -1043,11 +1050,13 @@ CONFIG_IIO_ST_LSM6DSX=m
 CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=m
 CONFIG_VCNL4000=m
+CONFIG_IIO_ST_MAGN_3AXIS=m
 CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_MPL3115=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
+CONFIG_PWM_IMX27=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
-- 
2.29.2

