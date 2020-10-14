Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA828E10B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJNNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJNNMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:12:20 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C061C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:12:20 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id fpCH2300o4C55Sk06pCHTt; Wed, 14 Oct 2020 15:12:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSgZl-0007tY-No; Wed, 14 Oct 2020 15:12:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSgZl-0005mP-M7; Wed, 14 Oct 2020 15:12:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee.jones@linaro.org>, Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mfd: MFD_SL28CPLD should depends on ARCH_LAYERSCAPE
Date:   Wed, 14 Oct 2020 15:12:16 +0200
Message-Id: <20201014131216.21891-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Kontron sl28cpld Board Management Controller is found only
on Kontron boards equipped with a Freescale Layerscape SoC.  Hence add a
dependency on ARCH_LAYERSCAPE, to prevent asking the user about a driver
for this controller when configuring a kernel without Layerscape support.

Fixes: a538ad229bbee4f8 ("mfd: simple-mfd-i2c: Add sl28cpld support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b99a13669bfc594..4789507f325b82ee 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1189,6 +1189,7 @@ config MFD_SIMPLE_MFD_I2C
 config MFD_SL28CPLD
 	tristate "Kontron sl28cpld Board Management Controller"
 	depends on I2C
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  Say yes here to enable support for the Kontron sl28cpld board
-- 
2.17.1

