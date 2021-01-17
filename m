Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCA2FB156
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbhASGYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:24:06 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44549 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733045AbhASFlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:41:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B4D78580628;
        Tue, 19 Jan 2021 00:41:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 19 Jan 2021 00:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=yuE+8tr0iy+d/
        z3IRq3Y5UGkEAN3tEbU+2tutGKEPIM=; b=nyae56tV2vdrMjcmyXcjihMSkRtCd
        YVP6ossbbI9ttDMpDcFPSaFgRxrDkHG9rmMuiARGuS+ieEfPEdx6Qn9ZxXbhoOe4
        IaY/phWGEoEPMobMRQFvW9YyNIqU6D/aAdsVVnRD7Ydt9jGBLceJ/xjg/2YjJ8Ai
        KLcusnNxjGsI+KebJoFPZp511lLhnvEXq9T7zGLP6+9j/8pGPmUAOBrOZc4Tu9I4
        KWM++pK2GTIU95SPkdJFhpZcZ/8pE7f0ck/i5lsWncxgvzfFWCuEBdvnZy63g3XV
        T5Y/TCT2Tv0fKPZOnt6eMGNH0bH93zgl8DN/EX6B8Hp73/KtQWXdqMbCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=yuE+8tr0iy+d/z3IRq3Y5UGkEAN3tEbU+2tutGKEPIM=; b=jenjpwfl
        JfZ+/GJ28Yk3O/d5huJznqjaegGO2gfT5urFkvbZbZ+MT8K1JttjtvYy2zCcpPte
        wo/b2PVy0w+5xVvZVx6SMwO1EVhmI3rIjki97A8Ow9b6vaJZG4C0zb+5HcnY0TS8
        Tcf+/RSEn4kHDlyDzY5nAnS04UM1mchi+VnE4LwMygbsMgyi9JR+ctrjgRgsFswM
        Ku9fWCYxrD74heYOc2Azt2EBI3B2gESE3wyUZyImwb0ZelYQoQ7TcAEqJR893qAU
        8L3C98drA9AUeh2Mn3uvnEOeXNSfbO9HXE/6OwbPeIX+T6S7EA9uvPz69WR+L+9a
        VBem5Equf/9ecg==
X-ME-Sender: <xms:8HAGYApu8EGnYdbX1H4pIfrqBy-geUk7n5vpwgcsZaiWNKFsdL4U3Q>
    <xme:8HAGYGryaXvBQjON1ooSjBHEUVE5BFbOo4HEzhNVigpwbHS-qTQTKZM5nu37hQUZ0
    Pya28EZjqDf3JdVdjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecukfhppeejfedrleef
    rdekgedrvddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:8HAGYFPL_xjb1XSl-m6Ir1SNxY8ULrfy1ZzU6JfpS6Ms4og6CcDxuQ>
    <xmx:8HAGYH6Q_SSPeW0eFfTCOSIOiOeiAhQJgxT-6VKbRjB9m-NnehM9fw>
    <xmx:8HAGYP59M0Qb_iCHcQt6hXkvQC18ecuPk5wGjj5UyvQBpgkSDPdWtQ>
    <xmx:8HAGYMHMrzUdvs4n6sui_rDzJkyxU1PMhi4ve27QIOdtvoN6eg0XPA>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 586A4240062;
        Tue, 19 Jan 2021 00:41:03 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 2/3] arch/arm/configs: Regenerate imx_v6_v7_defconfig
Date:   Sun, 17 Jan 2021 10:03:00 -0800
Message-Id: <20210117180301.1956-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117180301.1956-1-alistair@alistair23.me>
References: <20210117180301.1956-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run make imx_v6_v7_defconfig; make savedefconfig to regenerate the
defconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 36 ++++++++--------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 221f5c340c86..55674cb1ffce 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -28,9 +28,6 @@ CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
 CONFIG_SOC_IMX7ULP=y
 CONFIG_SOC_VF610=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
 CONFIG_ARM_PSCI=y
 CONFIG_HIGHMEM=y
@@ -65,9 +62,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_NETFILTER=y
 CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
@@ -80,12 +74,14 @@ CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
 CONFIG_RFKILL_INPUT=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_IMX6=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
-CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
@@ -96,16 +92,13 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_FSL_QUADSPI=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
@@ -139,9 +132,8 @@ CONFIG_SMC91X=y
 CONFIG_SMC911X=y
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
-CONFIG_AT803X_PHY=y
 CONFIG_MICREL_PHY=y
-CONFIG_SMSC_PHY=y
+CONFIG_AT803X_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=y
@@ -202,6 +194,7 @@ CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
+CONFIG_SPI_FSL_QUADSPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
@@ -210,14 +203,13 @@ CONFIG_PINCTRL_IMX8MN=y
 CONFIG_PINCTRL_IMX8MP=y
 CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MXC=y
 CONFIG_GPIO_SIOX=m
 CONFIG_GPIO_MAX732X=y
-CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_74X164=y
-CONFIG_GPIO_MXC=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
@@ -230,8 +222,8 @@ CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_DA9062_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
+CONFIG_DA9062_WATCHDOG=y
 CONFIG_RN5T618_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_IMX7ULP_WDT=y
@@ -242,7 +234,6 @@ CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
-CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
@@ -257,9 +248,6 @@ CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
 CONFIG_MEDIA_SUPPORT=y
-CONFIG_MEDIA_CAMERA_SUPPORT=y
-CONFIG_MEDIA_CONTROLLER=y
-CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
@@ -267,7 +255,6 @@ CONFIG_VIDEO_MUX=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=m
 CONFIG_VIDEO_IMX_PXP=y
-# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV2680=m
 CONFIG_VIDEO_OV5640=m
@@ -302,12 +289,10 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_FSL_ASRC=y
 CONFIG_SND_IMX_SOC=y
-CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
 CONFIG_SND_SOC_IMX_ES8328=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
-CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
 CONFIG_SND_SOC_AC97_CODEC=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
@@ -319,7 +304,6 @@ CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
@@ -334,7 +318,6 @@ CONFIG_USB_EHSET_TEST_FIXTURE=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_FSL_USB2=y
 CONFIG_USB_CONFIGFS=y
 CONFIG_USB_CONFIGFS_SERIAL=y
 CONFIG_USB_CONFIGFS_ACM=y
@@ -383,11 +366,11 @@ CONFIG_RTC_DRV_ISL1208=y
 CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_M41T80=y
+CONFIG_RTC_DRV_RC5T619=y
 CONFIG_RTC_DRV_DA9063=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_MXC_V2=y
-CONFIG_RTC_DRV_RC5T619=y
 CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
@@ -464,13 +447,14 @@ CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC7=m
 CONFIG_LIBCRC32C=m
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_PROVE_LOCKING=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
-- 
2.29.2

