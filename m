Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86FE299471
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788706AbgJZRzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33786 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781489AbgJZRze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 89D8B1F44FC8
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/16] soc: mediatek: pm-domains: Add new driver for SCPSYS power domains controller
Date:   Mon, 26 Oct 2020 18:55:09 +0100
Message-Id: <20201026175526.2915399-1-enric.balletbo@collabora.com>
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

Two important notes:

1. Support for MT8183 is not ready to land yet because has some
   dependencies, i.e mmsys support is still missing.

2. Support for MT8192. I picked the patches [1] from Weiyi Lu and
   adapted to this new series. I posted only for reference due that this
   new version has some changes that affects that patchset.

Only patches from 1 to 9 are ready, the others are provided for reference and test.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=368821

Best regards,
  Enric

Enric Balletbo i Serra (5):
  dt-bindings: power: Add bindings for the Mediatek SCPSYS power domains
    controller
  soc: mediatek: Add MediaTek SCPSYS power domains
  arm64: dts: mediatek: Add mt8173 power domain controller
  dt-bindings: power: Add MT8183 power domains
  arm64: dts: mediatek: Add smi_common node for MT8183

Matthias Brugger (8):
  soc: mediatek: pm-domains: Add bus protection protocol
  soc: mediatek: pm_domains: Make bus protection generic
  soc: mediatek: pm-domains: Add SMI block as bus protection block
  soc: mediatek: pm-domains: Add extra sram control
  soc: mediatek: pm-domains: Add subsystem clocks
  soc: mediatek: pm-domains: Allow bus protection to ignore clear ack
  soc: mediatek: pm-domains: Add support for mt8183
  arm64: dts: mediatek: Add mt8183 power domains controller

Weiyi Lu (3):
  dt-bindings: power: Add MT8192 power domains
  soc: mediatek: pm-domains: Add default power off flag
  soc: mediatek: pm-domains: Add support for mt8192

 .../power/mediatek,power-controller.yaml      | 293 +++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 164 +++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 172 +++++
 drivers/soc/mediatek/Kconfig                  |  13 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/mt8173-pm-domains.h      |  94 +++
 drivers/soc/mediatek/mt8183-pm-domains.h      | 221 +++++++
 drivers/soc/mediatek/mt8192-pm-domains.h      | 292 +++++++++
 drivers/soc/mediatek/mtk-infracfg.c           |   5 -
 drivers/soc/mediatek/mtk-pm-domains.c         | 615 ++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.h         | 102 +++
 include/dt-bindings/power/mt8183-power.h      |  26 +
 include/dt-bindings/power/mt8192-power.h      |  32 +
 include/linux/soc/mediatek/infracfg.h         | 107 +++
 14 files changed, 2083 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
 create mode 100644 drivers/soc/mediatek/mt8173-pm-domains.h
 create mode 100644 drivers/soc/mediatek/mt8183-pm-domains.h
 create mode 100644 drivers/soc/mediatek/mt8192-pm-domains.h
 create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
 create mode 100644 drivers/soc/mediatek/mtk-pm-domains.h
 create mode 100644 include/dt-bindings/power/mt8183-power.h
 create mode 100644 include/dt-bindings/power/mt8192-power.h

-- 
2.28.0

