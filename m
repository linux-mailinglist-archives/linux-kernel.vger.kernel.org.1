Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49B22B4E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgKPRwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbgKPRwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:52:31 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE41E20B80;
        Mon, 16 Nov 2020 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605549151;
        bh=M6rz3GRAM8KSfflWgZzT1R8LzsRa8A4Cidui6O2rwR8=;
        h=From:To:Cc:Subject:Date:From;
        b=wpmvsghvIjGxSDJtmXg3Pi/aW3NMWGkeVKPC2Dfw3DybQwdnvFOYJ+9kAyxD1DMmO
         5iKyc8463DqoYejDrvUaWnYqPA6KmFmXZNAA7RYefe7VVL+Lr1AP31qXng1hq48vM/
         3YYQgBuq2hGSkEupbAI8Ij7IvwCoAJEPFfePmyfE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: tegra: depend on COMMON_CLK to fix compile tests
Date:   Mon, 16 Nov 2020 18:52:23 +0100
Message-Id: <20201116175223.402674-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra USB PHY driver uses Common Clock Framework thus it cannot be
built on platforms without it (e.g. compile test on MIPS with RALINK and
SOC_RT305X):

    /usr/bin/mips-linux-gnu-ld: drivers/usb/phy/phy-tegra-usb.o: in function `tegra_usb_phy_init':
    phy-tegra-usb.c:(.text+0x1dd4): undefined reference to `clk_get_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index ef4787cd3d37..0015697470ef 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -162,7 +162,7 @@ config USB_MXS_PHY
 
 config USB_TEGRA_PHY
 	tristate "NVIDIA Tegra USB PHY Driver"
-	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST && COMMON_CLK
 	select USB_COMMON
 	select USB_PHY
 	select USB_ULPI
-- 
2.25.1

