Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92952CA355
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgLANAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:00:34 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44932 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbgLANAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:00:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6DCD8FB02;
        Tue,  1 Dec 2020 13:59:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GaQEwOE91eEA; Tue,  1 Dec 2020 13:59:50 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4EF634026B; Tue,  1 Dec 2020 13:59:50 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 1/2] usb: typec: tps6598x: Select USB_ROLE_SWITCH and REGMAP_I2C
Date:   Tue,  1 Dec 2020 13:59:49 +0100
Message-Id: <af9cbe1691d4fe9ab4dcdd4657b555520be8fb0d.1606827507.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606827507.git.agx@sigxcpu.org>
References: <cover.1606827507.git.agx@sigxcpu.org>
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

