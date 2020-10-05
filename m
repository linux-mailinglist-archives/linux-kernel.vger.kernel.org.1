Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF132835EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJEMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:49:53 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:49:53 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id cCpr2300d4C55Sk01CpsPl; Mon, 05 Oct 2020 14:49:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPPw7-0006ZN-Tg; Mon, 05 Oct 2020 14:49:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPPw7-0006z9-RL; Mon, 05 Oct 2020 14:49:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Khalil Blaiech <kblaiech@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] i2c: mlxbf: I2C_MLXBF should depend on MELLANOX_PLATFORM
Date:   Mon,  5 Oct 2020 14:49:49 +0200
Message-Id: <20201005124949.26810-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mellanox BlueField I2C controller is only present on Mellanox
BlueField SoCs.  Hence add a dependency on MELLANOX_PLATFORM, to prevent
asking the user about this driver when configuring a kernel without
Mellanox platform support.

Fixes: b5b5b32081cd206b ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 96685b273f637176..424dee8b33600057 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -732,7 +732,7 @@ config I2C_LPC2K
 
 config I2C_MLXBF
         tristate "Mellanox BlueField I2C controller"
-        depends on ARM64
+        depends on MELLANOX_PLATFORM && ARM64
         help
           Enabling this option will add I2C SMBus support for Mellanox BlueField
           system.
-- 
2.17.1

