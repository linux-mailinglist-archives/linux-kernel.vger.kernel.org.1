Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB42CF26A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgLDQxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgLDQxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:53:13 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9121: include linux/gpio/consumer.h
Date:   Fri,  4 Dec 2020 17:52:22 +0100
Message-Id: <20201204165229.3754763-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_GPIOLIB is disabled, the declarations from linux/gpio/consumer.h
are not visible:

drivers/regulator/da9121-regulator.c:371:14: error: implicit declaration of function 'fwnode_gpiod_get_index' [-Werror,-Wimplicit-function-declaration]
        ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
                    ^
drivers/regulator/da9121-regulator.c:372:7: error: use of undeclared identifier 'GPIOD_OUT_HIGH'
                                                GPIOD_OUT_HIGH |
                                                ^
drivers/regulator/da9121-regulator.c:373:7: error: use of undeclared identifier 'GPIOD_FLAGS_BIT_NONEXCLUSIVE'
                                                GPIOD_FLAGS_BIT_NONEXCLUSIVE,

Include this explicitly to help compile testing.

Fixes: 46c413d5bb23 ("regulator: da9121: Add support for device variants via devicetree")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/da9121-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 3ead6a171d95..22630eb0b167 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -15,6 +15,7 @@
 
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/driver.h>
-- 
2.27.0

