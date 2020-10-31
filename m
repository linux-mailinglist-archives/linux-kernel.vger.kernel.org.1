Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D952A1990
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgJaS2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:28:55 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:55508 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgJaS2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:28:48 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 97221C0139;
        Sat, 31 Oct 2020 19:22:09 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id F1DE6C1D7A; Sat, 31 Oct 2020 19:22:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (unknown [192.168.1.101])
        by gagarine.paulk.fr (Postfix) with ESMTP id C6153C1D64;
        Sat, 31 Oct 2020 19:21:52 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 0/9] Allwinner V3 SL631 Action Camera Support and Related Fixes
Date:   Sat, 31 Oct 2020 19:21:28 +0100
Message-Id: <20201031182137.1879521-1-contact@paulk.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Allwinner V3-based SL631 family of
Action Cameras, starting with the IMX179 fashion.

A few fixes to V3 support are added along the way, most notably support
for the NMI IRQ controller which is necessary for the AXP209 IRQ.

Note that some patches in this series may have already been submitted
(but not yet merged) by others and are included for the series to build.

Happy reviewing!

Paul Kocialkowski (9):
  ARM: sunxi: Add machine match for the Allwinner V3 SoC
  ARM: dts: sun8i-v3: Add UART1 PG pins description
  ARM: dts: sun8i-v3s: Add I2C1 PB pins description
  dt-bindings: irq: sun7i-nmi: Add binding for the V3s NMI
  irqchip/sunxi-nmi: Add support for the V3s NMI
  ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
  ARM: dts: sun8i: Cleanup the Pinecube AXP209 node
  dt-bindings: arm: sunxi: Add SL631 with IMX179 bindings
  ARM: dts: sun8i-v3: Add support for the SL631 Action Camera with
    IMX179

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../allwinner,sun7i-a20-sc-nmi.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-s3-pinecube.dts       |   8 +-
 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts   |  12 ++
 arch/arm/boot/dts/sun8i-v3-sl631.dtsi         | 145 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-v3.dtsi               |   6 +
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  16 +-
 arch/arm/mach-sunxi/sunxi.c                   |   1 +
 drivers/irqchip/irq-sunxi-nmi.c               |  18 ++-
 10 files changed, 206 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631.dtsi

-- 
2.28.0

