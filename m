Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE62F61B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbhANNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbhANNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:16:26 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979BDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:15:45 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id GdFj2400Z4C55Sk06dFjo9; Thu, 14 Jan 2021 14:15:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l02TX-003Ym1-Dl; Thu, 14 Jan 2021 14:15:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l02TW-009NXO-Au; Thu, 14 Jan 2021 14:15:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 resend] ahci: qoriq: Add platform dependencies
Date:   Thu, 14 Jan 2021 14:15:41 +0100
Message-Id: <20210114131541.2235386-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale QorIQ AHCI SATA controller is only present on Freescale
Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
symbol, to avoid asking the user about it when configuring a kernel
without Layerscape support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
v2:
  - Add Acked-by.
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 030cb32da980fc47..9ec6bce27c91511b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -264,6 +264,7 @@ config AHCI_XGENE
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
 	depends on OF
+	depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
-- 
2.25.1

