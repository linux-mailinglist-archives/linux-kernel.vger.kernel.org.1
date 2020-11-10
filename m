Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7932AD920
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgKJOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgKJOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:46:04 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB76C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:46:03 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id qem22300G4C55Sk06em2XF; Tue, 10 Nov 2020 15:46:02 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUuH-001CUI-Rc; Tue, 10 Nov 2020 15:46:01 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUuH-00DlDz-CV; Tue, 10 Nov 2020 15:46:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: intel: PHY_INTEL_KEEMBAY_EMMC should depend on ARCH_KEEMBAY
Date:   Tue, 10 Nov 2020 15:46:00 +0100
Message-Id: <20201110144600.3279752-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Keem Bay eMMC PHY is only present on Intel Keem Bay SoCs.
Hence add a dependency on ARCH_KEEMBAY, to prevent asking the user about
this driver when configuring a kernel without Intel Keem Bay platform
support.

Fixes: 885c4f4d6cf448f6 ("phy: intel: Add Keem Bay eMMC PHY support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 58ec695c92ec8fb9..62c24764654b2e5d 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -4,7 +4,7 @@
 #
 config PHY_INTEL_KEEMBAY_EMMC
 	tristate "Intel Keem Bay EMMC PHY driver"
-	depends on (OF && ARM64) || COMPILE_TEST
+	depends on ARCH_KEEMBAY || COMPILE_TEST
 	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select REGMAP_MMIO
-- 
2.25.1

