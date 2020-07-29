Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9157C23287E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 02:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgG3ADJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 20:03:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51056 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgG3ADJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:03:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A52971A12AB;
        Thu, 30 Jul 2020 02:03:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 18E4C1A029A;
        Thu, 30 Jul 2020 02:03:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BFDB0402D0;
        Thu, 30 Jul 2020 02:02:51 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V8 0/6] Support building i.MX ARMv8 platforms clock driver as module
Date:   Thu, 30 Jul 2020 07:58:34 +0800
Message-Id: <1596067120-1193-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays, there are more and more requirements of building SoC specific drivers as
modules, such as Android GKI (generic kernel image), this patch set supports building
i.MX ARMv8 SoCs clock drivers as modules,

The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to make the build
options aligned, the reason why i.MX ARMv7 platforms clock driver do NOT support
module build and COMPILE_TEST is because, some drivers like i.MX GPT timer driver
depends on clock driver to be ready before it, GPT driver uses TIMER_OF_DECLARE(),
while i.MX6/7 clock drivers use CLK_OF_DECLARE(), and GPT driver is critical for
i.MX6/7 platforms kernel boot up, so GPT driver needs to be changed to support
loadable clock driver first, then the i.MX6/7 clock drivers can support loadable
module, this will be done later.

Changes since V7:
	- remove unnecessary inlude of linux/bitfield in patch #1.

Anson Huang (6):
  clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31
    bits
  clk: composite: Export clk_hw_register_composite()
  clk: imx: Support building i.MX common clock driver as module
  clk: imx: Add clock configuration for ARMv7 platforms
  clk: imx8m: Support module build
  clk: imx8qxp: Support building i.MX8QXP clock driver as module

 drivers/clk/clk-composite.c        |  1 +
 drivers/clk/imx/Kconfig            | 94 ++++++++++++++++++++++++++++++++------
 drivers/clk/imx/Makefile           | 79 ++++++++++++++++----------------
 drivers/clk/imx/clk-composite-8m.c |  2 +
 drivers/clk/imx/clk-cpu.c          |  2 +
 drivers/clk/imx/clk-frac-pll.c     |  2 +
 drivers/clk/imx/clk-gate2.c        |  2 +
 drivers/clk/imx/clk-imx6sl.c       | 14 +++---
 drivers/clk/imx/clk-imx8mm.c       |  4 ++
 drivers/clk/imx/clk-imx8mn.c       |  4 ++
 drivers/clk/imx/clk-imx8mp.c       |  4 ++
 drivers/clk/imx/clk-imx8mq.c       |  4 ++
 drivers/clk/imx/clk-imx8qxp-lpcg.c |  4 ++
 drivers/clk/imx/clk-imx8qxp.c      |  4 ++
 drivers/clk/imx/clk-pll14xx.c      |  5 ++
 drivers/clk/imx/clk-sscg-pll.c     |  2 +
 drivers/clk/imx/clk.c              | 17 +++++--
 drivers/clk/imx/clk.h              |  6 +++
 18 files changed, 185 insertions(+), 65 deletions(-)

-- 
2.7.4

