Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9997E2B7D33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgKRMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:00:57 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:24526 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKRMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605700857; x=1637236857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFNHlzAD1yDbWea7D4fKD64qSMYeuvUKPdfrAYD+UXo=;
  b=lV9yZR/d+TPUC4Hd+5iUH8FYXGJvbipAek7KGMlx/syYeJOoIjzKAvZJ
   I1gExcQY8uklZrioiLbIHjG0gLZnE7vkzAs+945oDUDSCpxWq/kmFwItJ
   EQYX/31kNPGM6AJJOZ4OvhKXK4mMMzV+8w1XjPTCfZbqD1zOadCQUUpea
   wgJPJUnHO4XZDOmZL4W/qdX6c9sKAVMp+MpzibMOwuoTL2J4kGHrZdrxW
   bLg54cumgD7SL7tih43dV1Ex1GS5sbjAj5e4nTRvUywk6WkoPl7WbP9IK
   BBNtjrwmg1GP+KJL1AR/jwSGJCPu4/na9Lah9C9t9bt9Tql6RY6Fqh3Ac
   A==;
IronPort-SDR: fizs8k8iWz/1tRjxqaEbmWI50CDH6r46lbjs2i8m7vr+N4Rz/9N+VAhZ1unQwMdmk8G9WoNC5i
 BBkIjBsHNWGZ/TAkSoW9aKPMzYsdummceReWRPml7T2UwIGqz+vsaDhN8i+shs5jux26Zu2/W2
 xerr8ErD3xeLPE2cJQ9OmjHDPcggAKr6LL0l8CUz6f5dKdxkzd/Q9j6dSjKLwF1Gcvrsvddahl
 qDsFCcctvfq71LpO1x1ZBsYI7ZjdaSLIWYsQDLQcJohBIKpzHShsWOlTXaOdFqyICRvgw8BPBZ
 B/U=
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="104034977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2020 05:00:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 05:00:53 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 18 Nov 2020 05:00:51 -0700
From:   <cristian.birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 2/3] ARM: dts: at91: sama5d4_xplained: add pincontrol for USB Host
Date:   Wed, 18 Nov 2020 14:00:18 +0200
Message-ID: <20201118120019.1257580-3-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118120019.1257580-1-cristian.birsan@microchip.com>
References: <20201118120019.1257580-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

The pincontrol node is needed for USB Host since Linux v5.7-rc1. Without
it the driver probes but VBus is not powered because of wrong pincontrol
configuration.

Fixes: 38153a017896f ("ARM: at91/dt: sama5d4: add dts for sama5d4 xplained board")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index e5974a17374c..0b3ad1b580b8 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -134,6 +134,11 @@ pinctrl_usba_vbus: usba_vbus {
 						atmel,pins =
 							<AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
 					};
+					pinctrl_usb_default: usb_default {
+						atmel,pins =
+							<AT91_PIOE 11 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+							 AT91_PIOE 14 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
 					pinctrl_key_gpio: key_gpio_0 {
 						atmel,pins =
 							<AT91_PIOE 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
@@ -159,6 +164,8 @@ usb1: ohci@500000 {
 					   &pioE 11 GPIO_ACTIVE_HIGH
 					   &pioE 14 GPIO_ACTIVE_HIGH
 					  >;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb_default>;
 			status = "okay";
 		};
 
-- 
2.25.1

