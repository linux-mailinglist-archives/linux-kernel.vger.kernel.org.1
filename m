Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8662996E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793154AbgJZTc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:32:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39424 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793143AbgJZTc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B4641A0A87;
        Mon, 26 Oct 2020 20:32:53 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68CD21A09FD;
        Mon, 26 Oct 2020 20:32:53 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AB12C20308;
        Mon, 26 Oct 2020 20:32:52 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 00/14] Add BLK_CTL support for i.MX8MP
Date:   Mon, 26 Oct 2020 21:32:16 +0200
Message-Id: <1603740750-10385-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

Changes since v3:
 * added R-b tags
 * renamed the imx_blk_ctl_probe to imx_blk_ctl_register since
   it's gonna be used by all the i.MX8M for their paltform blk_ctl
   driver.
 * added dedicated probe function for i.MX8MP blk_ctl driver
 * fixed the reset deassert first issue reported by Aisheng Dong

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
 drivers/clk/imx/clk-blk-ctl-imx8mp.c               | 316 +++++++++++++++++++++
 drivers/clk/imx/clk-blk-ctl.c                      | 302 ++++++++++++++++++++
 drivers/clk/imx/clk-blk-ctl.h                      |  80 ++++++
 drivers/clk/imx/clk-imx8mp.c                       |  12 +-
 include/dt-bindings/clock/imx8mp-clock.h           | 200 +++++++++----
 include/dt-bindings/reset/imx8mp-reset.h           |  45 +++
 9 files changed, 991 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mp.c
 create mode 100644 drivers/clk/imx/clk-blk-ctl.c
 create mode 100644 drivers/clk/imx/clk-blk-ctl.h

-- 
2.7.4

