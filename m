Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD01B999C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD0ITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 04:19:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34318 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgD0ITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:19:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 0F8022A018F
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 00/10] Genericize DW MIPI DSI bridge and add i.MX 6 driver
Date:   Mon, 27 Apr 2020 11:19:42 +0300
Message-Id: <20200427081952.3536741-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

The dt-binding added in this series depends on [1] for
"make dt_binding_check" to pass.

The biggest change in v8 is a conversion of the imx6 host controller
driver to drm_bridge and an extension to dw_mipi_dsi.c which allows
platform drivers to daisy-chain bridges between the encoder and the
Synopsis DSI bridge.

Obviously a lot more work can be done on this front, for example to
convert the Rockchip and STM platform drivers to drm_bridge (the STM
driver doesn't even use the current dw_mipi_dsi.c bind API to attach)
or to improve the API itself.

Another kind of related work is refactoring the existng IMX drivers
to drm_bridge and move the empty encoder management to imx-drm-core.

Because this patch is already quite big, I did only the minimum
changes to get the imx6 mipi dsi driver in good shape, all the other
changes should be done in separate patch series.

I also just realized imx6qdl.dtsi was missing some properties to get
the DSI host controller working so I've added them as a new patch.

All received feedback up to this point has been addressed.

Thank you and best wishes,
Adrian

[1] https://lore.kernel.org/linux-devicetree/20200423100058.1734009-1-adrian.ratiu@collabora.com/

Adrian Ratiu (10):
  drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
  drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
  drm: bridge: dw_mipi_dsi: add dsi v1.01 support
  drm: bridge: dw_mipi_dsi: allow bridge daisy chaining
  drm: imx: Add i.MX 6 MIPI DSI host platform driver
  ARM: dts: imx6qdl: add missing mipi dsi properties
  dt-bindings: display: add i.MX6 MIPI DSI host controller doc
  drm: stm: dw-mipi-dsi: let the bridge handle the HW version check
  drm: bridge: dw-mipi-dsi: split low power cfg register into fields
  drm: bridge: dw-mipi-dsi: fix bad register field offsets

 .../display/imx/fsl,mipi-dsi-imx6.yaml        | 145 ++++
 arch/arm/boot/dts/imx6qdl.dtsi                |   8 +
 drivers/gpu/drm/bridge/synopsys/Kconfig       |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 698 +++++++++++++-----
 drivers/gpu/drm/imx/Kconfig                   |   8 +
 drivers/gpu/drm/imx/Makefile                  |   1 +
 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 399 ++++++++++
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |   2 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |  12 +-
 include/drm/bridge/dw_mipi_dsi.h              |   5 +-
 10 files changed, 1070 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
 create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c

-- 
2.26.0

