Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931322EB9C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbhAFGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:01:52 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29793 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbhAFGBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:01:36 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1065sEgM004598;
        Wed, 6 Jan 2021 13:54:14 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Jan
 2021 13:58:48 +0800
From:   "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <tglx@linutronix.de>, <maz@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/6] arm: aspeed: Add eSPI support
Date:   Wed, 6 Jan 2021 13:59:33 +0800
Message-ID: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1065sEgM004598
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the driver support for the eSPI controller
of Aspeed 6th generation SoCs. This controller is a slave device
communicating with a master over Enhanced Serial Peripheral Interface (eSPI).
It supports all of the 4 eSPI channels, namely peripheral, virtual wire,
out-of-band, and flash, and operates at max frequency of 66MHz.

Chia-Wei, Wang (6):
  dt-bindings: aspeed: Add eSPI controller
  MAINTAINER: Add ASPEED eSPI driver entry
  clk: ast2600: Add eSPI reset bit
  irqchip/aspeed: Add Aspeed eSPI interrupt controller
  soc: aspeed: Add eSPI driver
  ARM: dts: aspeed: Add AST2600 eSPI nodes

 .../devicetree/bindings/soc/aspeed/espi.yaml  | 252 +++++++
 MAINTAINERS                                   |  14 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  57 ++
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-aspeed-espi-ic.c          | 251 +++++++
 drivers/soc/aspeed/Kconfig                    |  49 ++
 drivers/soc/aspeed/Makefile                   |   5 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 197 +++++
 drivers/soc/aspeed/aspeed-espi-flash.c        | 490 ++++++++++++
 drivers/soc/aspeed/aspeed-espi-oob.c          | 706 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-peripheral.c   | 613 +++++++++++++++
 drivers/soc/aspeed/aspeed-espi-vw.c           | 211 ++++++
 include/dt-bindings/clock/ast2600-clock.h     |   1 +
 .../interrupt-controller/aspeed-espi-ic.h     |  15 +
 include/soc/aspeed/espi.h                     | 279 +++++++
 include/uapi/linux/aspeed-espi.h              | 160 ++++
 16 files changed, 3301 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-espi-ic.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-peripheral.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-espi-ic.h
 create mode 100644 include/soc/aspeed/espi.h
 create mode 100644 include/uapi/linux/aspeed-espi.h

-- 
2.17.1

