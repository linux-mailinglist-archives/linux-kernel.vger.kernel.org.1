Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9422D225C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLHExw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgLHExw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:53:52 -0500
From:   Vinod Koul <vkoul@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?=E6=BC=86=E9=B9=8F=E6=8C=AF=20=28Qi=20Pengzhen=29?= 
        <aric.pzqi@ingenic.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: ingenic: depend on HAS_IOMEM
Date:   Tue,  8 Dec 2020 10:23:00 +0530
Message-Id: <20201208045300.3637026-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses devm_ioremap_resource() which will not be built if
CONFIG_HAS_IOMEM is not selected, so add depends on it to fix the build
failure on few archs

s390-linux-ld: drivers/phy/ingenic/phy-ingenic-usb.o: in function `ingenic_usb_phy_probe':
>> phy-ingenic-usb.c:(.text+0xb66): undefined reference to `devm_platform_ioremap_resource'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/ingenic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ingenic/Kconfig b/drivers/phy/ingenic/Kconfig
index 912b14e512cb..f23cc109324b 100644
--- a/drivers/phy/ingenic/Kconfig
+++ b/drivers/phy/ingenic/Kconfig
@@ -6,6 +6,7 @@ config PHY_INGENIC_USB
 	tristate "Ingenic SoCs USB PHY Driver"
 	depends on MIPS || COMPILE_TEST
 	depends on USB_SUPPORT
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	help
 	  This driver provides USB PHY support for the USB controller found
-- 
2.26.2

