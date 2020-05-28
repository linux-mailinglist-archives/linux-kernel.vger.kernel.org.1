Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE81E6B03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbgE1TbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:31:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43924 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406318AbgE1TbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:31:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C9B9B80307C3;
        Thu, 28 May 2020 19:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a4oQGUg_uqxW; Thu, 28 May 2020 22:31:18 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] bus: bt1-apb: Build the driver into the kernel
Date:   Thu, 28 May 2020 22:31:12 +0300
Message-ID: <20200528193113.17372-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing trigger_all_cpu_backtrace() isn't exported from the kernel and
since calling it is a very important part of driver, which may provide
a better description of a possible cause of the error, let's disable the
ability to build the driver as a loadable kernel module.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 030f0e59f193..18858f560d1f 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -30,7 +30,7 @@ config BRCMSTB_GISB_ARB
 	  and internal bus master decoding.
 
 config BT1_APB
-	tristate "Baikal-T1 APB-bus driver"
+	bool "Baikal-T1 APB-bus driver"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
 	select REGMAP_MMIO
 	help
-- 
2.26.2

