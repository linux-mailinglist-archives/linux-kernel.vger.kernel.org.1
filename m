Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C446D294CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442528AbgJUMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:40:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54020 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbgJUMk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:40:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 997A5200AB3;
        Wed, 21 Oct 2020 14:40:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D08920194A;
        Wed, 21 Oct 2020 14:40:53 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D9BF2033F;
        Wed, 21 Oct 2020 14:40:53 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/2] clk: imx: Make the dram_apb and dram_alt as read-only
Date:   Wed, 21 Oct 2020 15:40:41 +0300
Message-Id: <1603284043-27059-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8M platforms the dram_apb and dram_alt are controlled from EL3.
So in order to keep track of the actual clock tree in kernel, we need
to actually declare the clocks but never actually change their parents
or divider settings. We do that by marking the mux and the div as read-only
with CLK_DIVIDER_READ_ONLY and CLK_MUX_READ_ONLY flags.

Abel Vesa (2):
  clk: imx: composite-8m: Add DRAM clock registration variant
  clk: imx8m: Use dram variant registration for dram clocks

 drivers/clk/imx/clk-composite-8m.c | 7 +++++++
 drivers/clk/imx/clk-imx8mm.c       | 4 ++--
 drivers/clk/imx/clk-imx8mn.c       | 4 ++--
 drivers/clk/imx/clk-imx8mp.c       | 4 ++--
 drivers/clk/imx/clk-imx8mq.c       | 4 ++--
 drivers/clk/imx/clk.h              | 6 ++++++
 6 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.7.4

