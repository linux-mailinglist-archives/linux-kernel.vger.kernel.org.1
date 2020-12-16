Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1E2DC187
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLPNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLPNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:47:25 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F1C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:46:45 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id 51mj2400S4C55Sk011mjbC; Wed, 16 Dec 2020 14:46:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpX8d-00BB86-MB; Wed, 16 Dec 2020 14:46:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpX8c-005YG7-Pf; Wed, 16 Dec 2020 14:46:42 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Kun Yi <kunyi@google.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] hwmon: SENSORS_SBTSI should depend on X86
Date:   Wed, 16 Dec 2020 14:46:41 +0100
Message-Id: <20201216134641.1323288-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD SB Temperature Sensor Interface (SB-TSI) is only present on AMD
X86 SoCs.  Hence add a dependency on X86, to prevent asking the user
about this driver when configuring a kernel without AMD X86 platform
support.

Fixes: e7bb1a2ab8c4b156 ("hwmon: (sbtsi) Add basic support for SB-TSI sensors")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 1ecf697d8d99b70c..63d28f98108d4bb5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1536,6 +1536,7 @@ config SENSORS_SL28CPLD
 config SENSORS_SBTSI
 	tristate "Emulated SB-TSI temperature sensor"
 	depends on I2C
+	depends on X86 || COMPILE_TEST
 	help
 	  If you say yes here you get support for emulated temperature
 	  sensors on AMD SoCs with SB-TSI interface connected to a BMC device.
-- 
2.25.1

