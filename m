Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA612A5800
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgKCVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:47:03 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:57326 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbgKCUvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:51:31 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 98851C0121;
        Tue,  3 Nov 2020 21:51:28 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id F2ACFC1D57; Tue,  3 Nov 2020 21:51:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 7F334C1D3F;
        Tue,  3 Nov 2020 21:51:00 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 0/6] Allwinner V3 SL631 Action Camera Support and Related Fixes
Date:   Tue,  3 Nov 2020 21:50:52 +0100
Message-Id: <20201103205058.435207-1-contact@paulk.fr>
X-Mailer: git-send-email 2.29.1
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

Changes since v1:
- Rework commit log messages as requested;
- Fixed v3s nmi controller compatible order in dt bindings doc;
- Changed SL631 compatible vendor to allwinner;
- Fixed LRADC button node names;
- Removed unused LDO4 regulator node;
- Removed merged patches.

Happy reviewing!

Paul Kocialkowski (6):
  dt-bindings: irq: sun7i-nmi: Add binding documentation for the V3s NMI
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
 arch/arm/boot/dts/sun8i-v3-sl631.dtsi         | 138 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  10 +-
 drivers/irqchip/irq-sunxi-nmi.c               |  18 ++-
 8 files changed, 186 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631.dtsi

-- 
2.29.1

