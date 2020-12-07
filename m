Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C232D1354
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgLGOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:15:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:48786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLGOPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:15:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31175ABE9;
        Mon,  7 Dec 2020 14:14:56 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sgi-ioc3: Turn Kconfig option into a bool
Date:   Mon,  7 Dec 2020 15:14:46 +0100
Message-Id: <20201207141446.53898-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module builds of ioc3 fail with following errors:

ERROR: "spurious_interrupt" [drivers/mfd/ioc3.ko] undefined!
ERROR: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!

Exporting pci_find_host_bridge got rejected by maintainer, so easiest
fix is to disable module building, which even makes sense since both
SGI Origin and Octane always contain at least one IOC3 chip.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b99a13669bf..2732d2899234 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2141,7 +2141,7 @@ config RAVE_SP_CORE
 	  device found on several devices in RAVE line of hardware.
 
 config SGI_MFD_IOC3
-	tristate "SGI IOC3 core driver"
+	bool "SGI IOC3 core driver"
 	depends on PCI && MIPS && 64BIT
 	select MFD_CORE
 	help
-- 
2.16.4

