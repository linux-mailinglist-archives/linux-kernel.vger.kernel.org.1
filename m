Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8443F27C0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgI2JQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:16:05 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:37324 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgI2JQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:16:05 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id BA9B2EF2FC;
        Tue, 29 Sep 2020 17:08:15 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1665T140084565235456S1601370489886989_;
        Tue, 29 Sep 2020 17:08:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d72ec480e2be19e14e1e747756b417d9>
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
Subject: [PATCH v9 0/8] Add Rockchip NFC drivers for RK3308 and others
Date:   Tue, 29 Sep 2020 17:08:03 +0800
Message-Id: <20200929090807.21511-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rockchp's NFC(Nand Flash Controller) has four versions: V600, V622, V800 and
V900.This series patch can support all four versions.


Changes in v9:
- The nfc->buffer will realloc while the page size of the second mtd
  is large than the first one
- Fix coding style.
- Remove struct rk_nfc_clk.
- Prepend some function with rk_nfc_.
- Replace function readl_poll_timeout_atomic with readl_relaxed_poll_timeout.
- Remove function rk_nfc_read_byte and rk_nfc_write_byte.
- Don't select the die if 'check_only == true' in function rk_nfc_exec_op.
- Modify function rk_nfc_write_page and rk_nfc_write_page_raw.

Changes in v8:
- Fix make dt_binding_check error

Changes in v7:
- Fix some wrong define
- Rebase to linux-next.
- Fix coding style.
- Reserved 4 bytes at the beginning of the oob area.
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
 .../mtd/nand/raw/rockchip-nand-controller.c   | 1454 +++++++++++++++++
 10 files changed, 1733 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
 create mode 100644 drivers/mtd/nand/raw/rockchip-nand-controller.c

-- 
2.17.1



