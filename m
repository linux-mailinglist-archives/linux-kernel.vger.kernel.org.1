Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884229EB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJ2MMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:12:38 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58530 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2MMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603973557; x=1635509557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iRw86gHjffp2wGXfO7OrDebD9Gimg9eG/YFM7qqLW3I=;
  b=ialstpJkTDlWpoMC82sqp3wDrY0Im398k2jkEGdNYeshNPo9HaXZOPlD
   9UL0e8UnuSCyoIf5UNuyvUj7x1Zu1ZXiq6js1Fkky+fQlGMx1mzNOdFDB
   DDLJA+7lsoy1HkbRgxL7QQKbN6zjUCHpCU73bnKlr5vaDXq99wTHaIJLY
   S/aFGDT1E7auQJHfjq/K/fYJyfdvT29/Tb/kOXs6j0zz88q0qkxyRhpDT
   uXn997lFKykgxcrlpsshzUhgH6Y5ucTvU405eSTvydlvilBSnS/STKzgN
   JixScgzn32hMxFZBZK9Y4DW6kWzuTIYXrzIQwt5CJfr2hk1VfL+DUejC2
   A==;
IronPort-SDR: NObRIf9nJFwb7EjL+7Gft5IhpZsrRj0rNqEldXUUi8mVesaGEw2+g/W3aQY1/7EnSuIRGIhT0E
 08zvCTkI5uLbyDZ38uwrYvBlbBJqk/hTWJSn0ra1OcZzb1lu2MNPKIpbqUpUp9At2RHNuRbmDg
 JZirl3XKRGa0aNPU2R5SOdRTZ5FNZ1RSFc5zF7Ocm7G7SFiwKjAwtNYnh2WF36r/otnA63c4Q0
 I6XCcpQXRn1cE5/Yq3A2Aco0JIousM3qf+sGKcM8UGyOuiY8N2SRena0/N4sMp8tVRDGU59eFM
 K0I=
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="101405017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2020 05:12:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 29 Oct 2020 05:12:36 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 29 Oct 2020 05:12:34 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: configs: at91_dt: resync with media changes
Date:   Thu, 29 Oct 2020 14:12:23 +0200
Message-ID: <20201029121223.871531-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The media tree Kconfig has changed recently, and a lot of modules were
built unintentionally, like the dvb frontends and encoders.
Resync the defconfig to build the ISI drivers and tested sensors.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Hello Alexandre,

Right now for sam9x60 we only tested ov2640 and MT9v022 monochrome variant

Thanks,
Eugen

 arch/arm/configs/at91_dt_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 4a0ba2ae1a25..91f0f2c41841 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -124,9 +124,14 @@ CONFIG_MFD_ATMEL_HLCDC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_SUPPORT_FILTER=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_VIDEO_OV2640=m
+CONFIG_VIDEO_MT9V032=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_PANEL_SIMPLE=y
-- 
2.25.1

