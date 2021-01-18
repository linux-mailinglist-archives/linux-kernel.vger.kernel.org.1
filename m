Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803B2F9A27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbhARGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:51:58 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40358 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbhARGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:51:55 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10I6jhCh030899;
        Mon, 18 Jan 2021 14:45:43 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Jan
 2021 14:51:00 +0800
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
CC:     <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
        <leetroy@gmail.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/4] hwmon: aspeed2600-pwm-tacho: Add driver support
Date:   Mon, 18 Jan 2021 06:50:48 +0000
Message-ID: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10I6jhCh030899
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aspeed AST2600 is a server management SoC which has 16 PWM channels and
16 fan tacho channel.

This series of patch provides AST2600 PWM/Fan tacho support in hwmon
class.

The driver provides a sysfs interface, and user can configure PWM duty
cycle and read current FAN speed in RPM.

Changes since v2:
 - declare local function as static function
 - fixed dt binding yamllint warnings/errors
 - rename dt property property name from pwm-freq to pwm-freq-hz

Changes since v1:
 - dt-binding rewrote with dt schema format
 - register hwmon driver with devm_hwmon_device_register_with_info()
 - moving default configurations to device tree

Troy Lee (4):
  dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
  hwmon: Add Aspeed AST2600 support
  ARM: dts: aspeed: Add Aspeed AST2600 PWM/Fan node in devicetree
  hwmon: Support Aspeed AST2600 PWM/Fan tachometer

 .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 131 +++
 .../hwmon/aspeed2600-pwm-tachometer.rst       |  27 +
 Documentation/hwmon/index.rst                 |   1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 152 ++++
 arch/arm/boot/dts/aspeed-g6.dtsi              |  10 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/aspeed2600-pwm-tacho.c          | 756 ++++++++++++++++++
 8 files changed, 1088 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
 create mode 100644 Documentation/hwmon/aspeed2600-pwm-tachometer.rst
 create mode 100644 drivers/hwmon/aspeed2600-pwm-tacho.c


base-commit: 1d011777cdbe7ae38a854a0cbeb6bdfbf724cce0
-- 
2.25.1

