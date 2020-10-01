Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F028036C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgJAQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:02:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJAQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:02:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 910D529D755
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 00/12] soc: mediatek: pm-domains: Add new driver for SCPSYS power domains controller
Date:   Thu,  1 Oct 2020 18:01:42 +0200
Message-Id: <20201001160154.3587848-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This is a new driver with the aim to deprecate the mtk-scpsys driver.
The problem with that driver is that, in order to support more Mediatek
SoCs you need to add some logic to handle properly the power-up
sequence of newer Mediatek SoCs, doesn't handle parent-child power
domains and need to hardcode all the clocks in the driver itself. The
result is that the driver is getting bigger and bigger every time a
new SoC needs to be supported.

All this information can be getted from a properly defined binding, so
can be cleaner and smaller, hence, we implemented a new driver. For
now, only MT8173 and MT8183 is supported but should be fairly easy to
add support for new SoCs.

Note that the MT8183 support is not ready to land yet because has some
dependencies, i.e. mmsys support is still missing. So, only patches from
1 to 9 are ready, the others are provided for reference and test.

Best regards,
  Enric

Enric Balletbo i Serra (4):
  dt-bindings: power: Add bindings for the Mediatek SCPSYS power domains
    controller
  soc: mediatek: Add MediaTek SCPSYS power domains
  arm64: dts: mediatek: Add mt8173 power domain controller
  dt-bindings: power: Add MT8183 power domains

Matthias Brugger (8):
  soc: mediatek: pm-domains: Add bus protection protocol
  soc: mediatek: pm_domains: Make bus protection generic
  soc: mediatek: pm-domains: Add SMI block as bus protection block
  soc: mediatek: pm-domains: Add extra sram control
  soc: mediatek: pm-domains: Add subsystem clocks
  soc: mediatek: pm-domains: Allow bus protection to ignore clear ack
  soc: mediatek: pm-domains: Add support for mt8183
  arm64: dts: mediatek: Add mt8183 power domains controller

 .../power/mediatek,power-controller.yaml      |  184 +++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  164 ++-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  162 +++
 drivers/soc/mediatek/Kconfig                  |   13 +
 drivers/soc/mediatek/Makefile                 |    1 +
 drivers/soc/mediatek/mtk-infracfg.c           |    5 -
 drivers/soc/mediatek/mtk-mmsys.c              |    4 -
 drivers/soc/mediatek/mtk-pm-domains.c         | 1019 +++++++++++++++++
 include/dt-bindings/power/mt8183-power.h      |   26 +
 include/linux/soc/mediatek/infracfg.h         |   57 +
 10 files changed, 1577 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
 create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
 create mode 100644 include/dt-bindings/power/mt8183-power.h

-- 
2.28.0

