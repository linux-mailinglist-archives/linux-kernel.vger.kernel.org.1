Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CF32ADAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgKJP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgKJP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:57:34 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E467FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:57:33 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id qfxY230094C55Sk06fxYvS; Tue, 10 Nov 2020 16:57:32 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcW1U-001DZ5-5l; Tue, 10 Nov 2020 16:57:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcW1T-00Dn8E-Km; Tue, 10 Nov 2020 16:57:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] mfd: MFD_SL28CPLD should depends on ARCH_LAYERSCAPE
Date:   Tue, 10 Nov 2020 16:57:27 +0100
Message-Id: <20201110155727.3287083-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Kontron sl28cpld Board Management Controller is found only
on Kontron boards equipped with a Freescale Layerscape SoC.  Hence add a
dependency on ARCH_LAYERSCAPE, to prevent asking the user about a driver
for this controller when configuring a kernel without Layerscape support.

Fixes: a538ad229bbee4f8 ("mfd: simple-mfd-i2c: Add sl28cpld support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Michael Walle <michael@walle.cc>
---
v2:
  - Add Acked-by.
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index cc0b73280c68c7ba..10864cc38c17b4ed 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1199,6 +1199,7 @@ config MFD_SIMPLE_MFD_I2C
 config MFD_SL28CPLD
 	tristate "Kontron sl28cpld Board Management Controller"
 	depends on I2C
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  Say yes here to enable support for the Kontron sl28cpld board
-- 
2.25.1

