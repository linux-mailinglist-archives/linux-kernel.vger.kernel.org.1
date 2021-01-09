Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F72EFE94
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAIINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:13:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141FFC061573
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 00:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gRd5CtmqswyZKZy7LtrQDoZEjmZdJDozyJiz6oiIDt8=; b=vbf8bFplXNwdzTQQu4tnULu/EO
        uzZj8juptZGaMIdCxrPc51G/ZSmlLHl2lE7wGQwisNKB/du+lTLMXjRMQxJViRQNh6rNkV9sQMyuG
        LPiW0xNofo7maR9l0VEJZeMYZgHJYJOIqKDu9+sQsU1CyxtmmJP6K0b7KIBJPiYxv9lIUaiK2F55F
        wSUbkypLtrIXc+AT2wD7oS0L892qCDvc2UdxRwTt1wcroAl+nlPKX22urdGeT7AMVs1L3SbnDhR2a
        jd5vKm1QEXBpuuVgCYYQVagEjHNMEMEUw2WsVO2zuKDWQ+7ViDkbT2llqMcJU9eq7fWKMoArSMCDk
        ZXtzuing==;
Received: from [2601:1c0:6280:3f0::79df] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ky9MZ-0003FV-J7; Sat, 09 Jan 2021 08:12:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: mark all linux-arm-kernel@infradead as moderated
Date:   Sat,  9 Jan 2021 00:12:37 -0800
Message-Id: <20210109081237.10082-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently annotate all linux-arm-kernel@lists.infradead.org as
moderated for non-subscribers.

132 entries are already annotated as moderated.
Do the same for the other 28 entries.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 MAINTAINERS |   56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

--- linux-next-20210108.orig/MAINTAINERS
+++ linux-next-20210108/MAINTAINERS
@@ -2240,14 +2240,14 @@ N:	oxnas
 
 ARM/PALM TREO SUPPORT
 M:	Tomas Cech <sleep_walker@suse.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmtreo.*
 
 ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/include/mach/palmld.h
@@ -2261,7 +2261,7 @@ F:	arch/arm/mach-pxa/palmtx.c
 
 ARM/PALMZ72 SUPPORT
 M:	Sergey Lapin <slapin@ossfans.org>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
@@ -2425,7 +2425,7 @@ N:	s5pv210
 
 ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
 M:	Andrzej Hajda <a.hajda@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-g2d/
@@ -2442,14 +2442,14 @@ ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPOR
 M:	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
 M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
 M:	Andrzej Hajda <a.hajda@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-mfc/
@@ -2563,7 +2563,7 @@ F:	arch/arm64/boot/dts/synaptics/
 ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc.w.gonzalez@free.fr>
 M:	Mans Rullgard <mans@mansr.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
 N:	tango
 
@@ -3446,7 +3446,7 @@ BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
 M:	bcm-kernel-feedback-list@broadcom.com
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/bcm470*
 F:	arch/arm/boot/dts/bcm5301*
@@ -3456,7 +3456,7 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 BROADCOM BCM53573 ARM ARCHITECTURE
 M:	Rafał Miłecki <rafal@milecki.pl>
 L:	bcm-kernel-feedback-list@broadcom.com
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/bcm47189*
 F:	arch/arm/boot/dts/bcm53573*
@@ -4623,7 +4623,7 @@ CPUIDLE DRIVER - ARM BIG LITTLE
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 F:	drivers/cpuidle/cpuidle-big_little.c
@@ -4642,14 +4642,14 @@ CPUIDLE DRIVER - ARM PSCI
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-pm@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.c
 
 CPUIDLE DRIVER - ARM PSCI PM DOMAIN
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.h
 F:	drivers/cpuidle/cpuidle-psci-domain.c
@@ -7088,7 +7088,7 @@ F:	include/linux/platform_data/video-imx
 
 FREESCALE IMX DDR PMU DRIVER
 M:	Frank Li <Frank.li@nxp.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
 F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -7172,7 +7172,7 @@ F:	drivers/tty/serial/ucc_uart.c
 FREESCALE SOC DRIVERS
 M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
 F:	Documentation/devicetree/bindings/soc/fsl/
@@ -10656,7 +10656,7 @@ F:	drivers/net/wireless/marvell/libertas
 
 MARVELL MACCHIATOBIN SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
 
@@ -13577,7 +13577,7 @@ F:	drivers/pci/controller/pcie-altera.c
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
 F:	drivers/pci/controller/pci-xgene.c
@@ -13585,7 +13585,7 @@ F:	drivers/pci/controller/pci-xgene.c
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/versatile.yaml
 F:	drivers/pci/controller/pci-versatile.c
@@ -13593,7 +13593,7 @@ F:	drivers/pci/controller/pci-versatile.
 PCI DRIVER FOR ARMADA 8K
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
@@ -13611,7 +13611,7 @@ M:	Mingkai Hu <mingkai.hu@nxp.com>
 M:	Roy Zang <roy.zang@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
 
@@ -13677,7 +13677,7 @@ F:	drivers/pci/controller/pci-tegra.c
 PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -13711,7 +13711,7 @@ PCI DRIVER FOR TI DRA7XX/J721E
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
 F:	drivers/pci/controller/cadence/pci-j721e.c
@@ -13774,7 +13774,7 @@ F:	drivers/pci/controller/pcie-altera-ms
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/controller/pci-xgene-msi.c
@@ -14261,7 +14261,7 @@ F:	kernel/configs/nopm.config
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/firmware/psci/
 F:	include/linux/psci.h
@@ -14762,7 +14762,7 @@ F:	arch/hexagon/
 
 QUALCOMM HIDMA DRIVER
 M:	Sinan Kaya <okaya@kernel.org>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-msm@vger.kernel.org
 L:	dmaengine@vger.kernel.org
 S:	Supported
@@ -16392,7 +16392,7 @@ SECURE MONITOR CALL(SMC) CALLING CONVENT
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/firmware/smccc/
 F:	include/linux/arm-smccc.h
@@ -16509,7 +16509,7 @@ F:	drivers/media/pci/solo6x10/
 
 SOFTWARE DELEGATED EXCEPTION INTERFACE (SDEI)
 M:	James Morse <james.morse@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/firmware/sdei.txt
 F:	drivers/firmware/arm_sdei.c
@@ -17246,7 +17246,7 @@ F:	drivers/mfd/syscon.c
 SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message Protocol drivers
 M:	Sudeep Holla <sudeep.holla@arm.com>
 R:	Cristian Marussi <cristian.marussi@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
 F:	drivers/clk/clk-sc[mp]i.c
@@ -17617,7 +17617,7 @@ TEXAS INSTRUMENTS' SYSTEM CONTROL INTERF
 M:	Nishanth Menon <nm@ti.com>
 M:	Tero Kristo <t-kristo@ti.com>
 M:	Santosh Shilimkar <ssantosh@kernel.org>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
