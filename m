Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8452F9D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbhARLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:04:52 -0500
Received: from comms.puri.sm ([159.203.221.185]:59470 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389525AbhARKza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:55:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C24ABDF4DD;
        Mon, 18 Jan 2021 02:54:48 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DUi6fFlDqo52; Mon, 18 Jan 2021 02:54:47 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 0/9] Config and devicetree updates for the Librem 5 phone
Date:   Mon, 18 Jan 2021 11:54:16 +0100
Message-Id: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another set of updates in order to maintain support for the
Librem 5 phone:

revision history
----------------
v2: thanks Shawn and Krzysztof
* fix dts style issues in "enable the LCD panel"
* reorder for the bindings to go before the dts usage
* add ack and review tags

v1: https://lore.kernel.org/linux-arm-kernel/20210112095151.4995-1-martin.kepplinger@puri.sm/

Guido Günther (5):
  arm64: defconfig: Enable vibra-pwm
  arm64: dts: imx8mq-librem5: Mark charger IRQ as High-Z
  arm64: dts: imx8mq-librem5: Don't mark buck3 as always on
  arm64: dts: imx8mq-librem5: Add usb-c chip as supplier for the charger
  arm64: dts: imx8mq-librem5: Add LCD_1V8 regulator

Martin Kepplinger (4):
  arm64: dts: imx8mq-librem5: enable the LCD panel
  arm64: dts: imx8mq-librem5: set regulators boot-on
  dt-bindings: arm: fsl: Add the librem 5 Evergreen revision
  arm64: dts: Add Librem5 Evergreen

 .../devicetree/bindings/arm/fsl.yaml          |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/imx8mq-librem5-r4.dts  | 35 ++++++++
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 85 ++++++++++++++++++-
 arch/arm64/configs/defconfig                  |  1 +
 5 files changed, 119 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts

-- 
2.20.1

