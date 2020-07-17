Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4529D223838
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGQJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 05:24:33 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:33614 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:24:32 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id D71EDCA71D;
        Fri, 17 Jul 2020 17:24:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26706T140360697231104S1594977862492603_;
        Fri, 17 Jul 2020 17:24:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a9a0c001448a5b4a8697249ca3fef0f7>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v8 0/8] Add Rockchip NFC drivers for RK3308 and others
Date:   Fri, 17 Jul 2020 17:24:16 +0800
Message-Id: <20200717092420.19798-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rockchp's NFC(Nand Flash Controller) has four versions: V600, V622, V800 and
V900.This series patch can support all four versions.


Changes in v8:
- Fix make dt_binding_check error

Changes in v7:
- Fix some wrong define
- Rebase to linux-next.
- Fix coding style.
- Reserved 4 bytes at the begining of the oob area.
- Page raw read and write included ecc data.

Changes in v6:
- Fix some wrong define
- Modified the definition of compatible
- The mtd->name set by NAND label property.
- Add some comments.
- Fix compile error.

Changes in v5:
- Fix some wrong define.
- Add boot-medium define.
- Remove some compatible define.
- Add boot blocks support  with different ECC for bootROM.
- Rename rockchip-nand.c to rockchip-nand-controller.c.
- Unification of other variable names.
- Remove some compatible define.

Changes in v4:
- The compatible define with rkxx_nfc.
- Add assigned-clocks.
- Fix some wrong defineChanges in.
- Define platform data structure for the register offsets.
- The compatible define with rkxx_nfc.
- Use SET_SYSTEM_SLEEP_PM_OPS to define PM_OPS.
- Use exec_op instead of legacy hooks.

Changes in v3:
- Change the title for the dt-bindings.

Changes in v2:
- Fix compile error.
- Include header files sorted by file name.

Yifeng Zhao (8):
  dt-bindings: mtd: Describe Rockchip RK3xxx NAND flash controller
  mtd: rawnand: rockchip: NFC drivers for RK3308, RK2928 and others
  MAINTAINERS: add maintainers to ROCKCHIP NFC
  arm64: dts: rockchip: Add NFC node for RK3308 SoC
  arm64: dts: rockchip: Add NFC node for PX30 SoC
  arm: dts: rockchip: Add NFC node for RV1108 SoC
  arm: dts: rockchip: Add NFC node for RK2928 and other SoCs
  arm: dts: rockchip: Add NFC node for RK3036 SoC

 .../mtd/rockchip,nand-controller.yaml         |  162 ++
 MAINTAINERS                                   |    4 +-
 arch/arm/boot/dts/rk3036.dtsi                 |   52 +
 arch/arm/boot/dts/rk3xxx.dtsi                 |    9 +
 arch/arm/boot/dts/rv1108.dtsi                 |   11 +
 arch/arm64/boot/dts/rockchip/px30.dtsi        |   15 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |   15 +
 drivers/mtd/nand/raw/Kconfig                  |   12 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 .../mtd/nand/raw/rockchip-nand-controller.c   | 1422 +++++++++++++++++
 10 files changed, 1701 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
 create mode 100644 drivers/mtd/nand/raw/rockchip-nand-controller.c

-- 
2.17.1



