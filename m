Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2624E2D0625
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLFQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLFQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:52:31 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72899C0613D0;
        Sun,  6 Dec 2020 08:51:51 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 1EE30C0139;
        Sun,  6 Dec 2020 17:51:48 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 866B5C1D4D; Sun,  6 Dec 2020 17:51:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id F2121C1D31;
        Sun,  6 Dec 2020 17:51:32 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 0/5] Allwinner V3 SL631 Action Camera Support and Related Fixes
Date:   Sun,  6 Dec 2020 17:51:26 +0100
Message-Id: <20201206165131.1041983-1-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
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

Changes since v2:
- Reused A80 binding for V3s NMI since registers are the same;
- Changes SL631 buttons (up/down/ok) which better reflect reality.

Changes since v1:
- Rework commit log messages as requested;
- Fixed v3s nmi controller compatible order in dt bindings doc;
- Changed SL631 compatible vendor to allwinner;
- Fixed LRADC button node names;
- Removed unused LDO4 regulator node;
- Removed merged patches.

Paul Kocialkowski (5):
  dt-bindings: irq: sun7i-nmi: Add binding documentation for the V3s NMI
  ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
  ARM: dts: sun8i: Cleanup the Pinecube AXP209 node
  dt-bindings: arm: sunxi: Add SL631 with IMX179 bindings
  ARM: dts: sun8i-v3: Add support for the SL631 Action Camera with
    IMX179

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../allwinner,sun7i-a20-sc-nmi.yaml           |   3 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-s3-pinecube.dts       |   8 +-
 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts   |  12 ++
 arch/arm/boot/dts/sun8i-v3-sl631.dtsi         | 138 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  11 +-
 7 files changed, 172 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631.dtsi

-- 
2.29.2

