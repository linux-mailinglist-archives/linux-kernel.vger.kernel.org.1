Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6BB260FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgIHK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:26:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56116 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgIHK0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 960F22014ED;
        Tue,  8 Sep 2020 12:26:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 868BA2011AF;
        Tue,  8 Sep 2020 12:26:05 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D44EE20327;
        Tue,  8 Sep 2020 12:26:04 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 00/14] Add BLK_CTL support for i.MX8MP
Date:   Tue,  8 Sep 2020 13:24:37 +0300
Message-Id: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BLK_CTL according to HW design is basically the wrapper of the entire
function specific group of IPs and holds GPRs that usually cannot be placed
into one specific IP from that group. Some of these GPRs are used to control
some clocks, other some resets, others some very specific function that does
not fit into clocks or resets. Since the clocks are registered using the i.MX
clock subsystem API, the driver is placed into the clock subsystem, but it
also registers the resets. For the other functionalities that other GPRs might
have, the syscon is used.

Changes since v2:
 * Made the naming consistent with the RM: BLK_CTL (not BLK_CTRL)
 * fixed the reset set procedure as discussed with Philipp Zabel
 * removed the patch that includes the imx8mp-reset header in dtsi
   as there is no user yet.
 * added i.MX8MP specific blk_ctl driver as suggested by Aisheng Dong

Abel Vesa (14):
  dt-bindings: clocks: imx8mp: Rename audiomix ids clocks to
    audio_blk_ctl
  dt-bindings: reset: imx8mp: Add audio blk_ctl reset IDs
  dt-bindings: clock: imx8mp: Add ids for the audio shared gate
  dt-bindings: clock: imx8mp: Add media blk_ctl clock IDs
  dt-bindings: reset: imx8mp: Add media blk_ctl reset IDs
  dt-bindings: clock: imx8mp: Add hdmi blk_ctl clock IDs
  dt-bindings: reset: imx8mp: Add hdmi blk_ctl reset IDs
  clk: imx8mp: Add audio shared gate
  Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
  clk: imx: Add generic blk-ctl driver
  clk: imx: Add blk-ctl driver for i.MX8MP
  arm64: dts: imx8mp: Add audio_blk_ctl node
  arm64: dts: imx8mp: Add media_blk_ctl node
  arm64: dts: imx8mp: Add hdmi_blk_ctl node

 .../devicetree/bindings/clock/fsl,imx-blk-ctl.yaml |  60 ++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  37 +++
 drivers/clk/imx/Makefile                           |   2 +-
 drivers/clk/imx/clk-blk-ctl-imx8mp.c               | 313 +++++++++++++++++++++
 drivers/clk/imx/clk-blk-ctl.c                      | 297 +++++++++++++++++++
 drivers/clk/imx/clk-blk-ctl.h                      |  80 ++++++
 drivers/clk/imx/clk-imx8mp.c                       |  12 +-
 include/dt-bindings/clock/imx8mp-clock.h           | 200 +++++++++----
 include/dt-bindings/reset/imx8mp-reset.h           |  45 +++
 9 files changed, 983 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mp.c
 create mode 100644 drivers/clk/imx/clk-blk-ctl.c
 create mode 100644 drivers/clk/imx/clk-blk-ctl.h

-- 
2.7.4

