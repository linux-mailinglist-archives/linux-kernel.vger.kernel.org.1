Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0AC1A6791
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgDMOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgDMOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:10:22 -0400
X-Greylist: delayed 1439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Apr 2020 07:10:22 PDT
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A94C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:10:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 11B5C26DA92
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Dan Murphy <dmurphy@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] can: tcan4x5x: Replace depends on REGMAP_SPI with depends on SPI
Date:   Mon, 13 Apr 2020 16:10:13 +0200
Message-Id: <20200413141013.506613-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap is a library function that gets selected by drivers that need
it. No driver modules should depend on it. Instead depends on SPI and
select REGMAP_SPI. Depending on REGMAP_SPI makes this driver only build
if another driver already selected REGMAP_SPI, as the symbol can't be
selected through the menu kernel configuration.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/net/can/m_can/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 1ff0b7fe81d6..c10932a7f1fe 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -16,7 +16,8 @@ config CAN_M_CAN_PLATFORM
 
 config CAN_M_CAN_TCAN4X5X
 	depends on CAN_M_CAN
-	depends on REGMAP_SPI
+	depends on SPI
+	select REGMAP_SPI
 	tristate "TCAN4X5X M_CAN device"
 	---help---
 	  Say Y here if you want support for Texas Instruments TCAN4x5x
-- 
2.25.1

