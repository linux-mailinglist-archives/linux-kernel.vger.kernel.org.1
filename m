Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACD2CFB23
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 12:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgLELZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 06:25:25 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:56904 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbgLELQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 06:16:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 91FE6FB05;
        Sat,  5 Dec 2020 12:13:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sb6WI9UUhkql; Sat,  5 Dec 2020 12:13:27 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6CBCB4070F; Sat,  5 Dec 2020 12:13:26 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 1/2] usb: typec: tps6598x: Select USB_ROLE_SWITCH and REGMAP_I2C
Date:   Sat,  5 Dec 2020 12:13:25 +0100
Message-Id: <6d11417c42d82caf66e08af160397959eb7d0d60.1607166657.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607166657.git.agx@sigxcpu.org>
References: <cover.1607166657.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is more in line with what tcpm does and will be needed
to avoid recursive dependency like

 > drivers/power/supply/Kconfig:2:error: recursive dependency detected!
   drivers/power/supply/Kconfig:2: symbol POWER_SUPPLY is selected by TYPEC_TPS6598X
   drivers/usb/typec/Kconfig:64: symbol TYPEC_TPS6598X depends on REGMAP_I2C
   drivers/base/regmap/Kconfig:19: symbol REGMAP_I2C is selected by CHARGER_ADP5061
   drivers/power/supply/Kconfig:93: symbol CHARGER_ADP5061 depends on POWER_SUPPLY
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"

when selecting POWER_SUPPLY.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/usb/typec/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 6c5908a37ee8..772b07e9f188 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -64,8 +64,8 @@ config TYPEC_HD3SS3220
 config TYPEC_TPS6598X
 	tristate "TI TPS6598x USB Power Delivery controller driver"
 	depends on I2C
-	depends on REGMAP_I2C
-	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
+	select REGMAP_I2C
+	select USB_ROLE_SWITCH
 	help
 	  Say Y or M here if your system has TI TPS65982 or TPS65983 USB Power
 	  Delivery controller.
-- 
2.29.2

