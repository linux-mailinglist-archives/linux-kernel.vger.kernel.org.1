Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36C528FFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405038AbgJPIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:07:19 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:45563 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404980AbgJPIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602835637; x=1634371637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qqsPYb+YojkTxR2LP1DQbi/hkejGq+YSnwS/6E+Ba94=;
  b=DhHzNqoSj0KssFTaydWyea+o61+pdndvDau8LHNzzmdwJeLBIoGS5ilP
   RjRx7wLxzwt9YEzqUHGbRNiXAOUiG86oqCt6NOumWdVJWh8LRv1Mq0y/v
   JFfM+bpVgbZB/A1014vJPYT/nXY2RDYYMSvrvl9IFXK75DvyiDHefoB0h
   jNRg1gwqW3aAmN23Zd4dbGz6i4/pB88IzscMSyWYUqY68hIcRjxP2n/ZV
   7WlXyCQTSHmttcEmpVE0Zqdlal3yP7IO/BbTqXXqx8soIwe0yB+fISA0B
   AWIeCOgAS5Q+J/Dm4lTyTSgVmdhWcCJJjW/7p7oVlsR5TH3R9NxNG6K7P
   A==;
IronPort-SDR: AzjlipmcJ4RkFTmctisRXnvoN1p8Qzn9aXkoVaUQluwsIBSdueimY0hSVI9TzXT7Ho0MPDGu2i
 J7TtBCVTDy7sdtlb+aCj8oemJsLPxTu3aj+Xo3zWxqgnWdhe7PPgv2zdWtuDi5eUFj6LYKM97V
 mZrB7g0DKRy0L2TrSxCxmhYn8/EEUuIRKXfVePgLKOXmP3Fvo5OlLc2JPEXxphI2CCP1IVARdz
 IpSReykf/+psB7olZF14LU/ey6g8YcEVkBdrHKmFsP/pHSqgWU9GZmOfl/RoNH7gVtNgqKudQG
 cU8=
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="30113890"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2020 01:07:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 00:51:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 16 Oct 2020 00:51:31 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama5: resync with media changes
Date:   Fri, 16 Oct 2020 10:51:09 +0300
Message-ID: <20201016075109.287506-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The media tree Kconfig has changed recently, and a lot of modules were
built unintentionally, like the dvb frontends and encoders.
Resync the defconfig to build the sama5 drivers and tested sensors.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 037d3a718a60..2c8a621a8f1f 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -153,9 +153,18 @@ CONFIG_REGULATOR_ACT8945A=y
 CONFIG_REGULATOR_MCP16502=m
 CONFIG_REGULATOR_PWM=m
 CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_SUPPORT_FILTER=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_ATMEL_ISC=y
 CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_VIDEO_OV2640=m
+CONFIG_VIDEO_OV5640=m
+CONFIG_VIDEO_OV7670=m
+CONFIG_VIDEO_OV7740=m
+CONFIG_VIDEO_MT9V032=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_PANEL_SIMPLE=y
-- 
2.25.1

