Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36022F44E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAMHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:11:44 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:52876 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbhAMHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:11:44 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10D73sa0005372;
        Wed, 13 Jan 2021 15:03:54 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 13 Jan
 2021 15:08:54 +0800
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     <openbmc@lists.ozlabs.org>, Jean Delvare <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
CC:     <chiawei_wang@aspeedtech.com>, <leetroy@gmail.com>,
        <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/4] hwmon: aspeed2600-pwm-tacho: Add driver support
Date:   Wed, 13 Jan 2021 07:08:44 +0000
Message-ID: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10D73sa0005372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aspeed AST2600 is a server management SoC which has 16 PWM channels and
16 fan tacho channel.

This series of patch provides AST2600 PWM/Fan tacho support in hwmon
class.

The driver provides a sysfs interface, and user can configure PWM duty
cycle and read current FAN speed in RPM.


Change since v1:
- dt-binding rewrote with dt schema format
- register hwmon driver with devm_hwmon_device_register_with_info()
- moving default configurations to device tree

*** BLURB HERE ***

Troy Lee (4):
  dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
  hwmon: Add Aspeed AST2600 support
  ARM: dts: aspeed: Add Aspeed AST2600 PWM/Fan node in devicetree
  hwmon: Support Aspeed AST2600 PWM/Fan tachometer

 .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 137 ++++
 .../hwmon/aspeed2600-pwm-tachometer.rst       |  27 +
 Documentation/hwmon/index.rst                 |   1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 152 ++++
 arch/arm/boot/dts/aspeed-g6.dtsi              |  10 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/aspeed2600-pwm-tacho.c          | 756 ++++++++++++++++++
 8 files changed, 1094 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
 create mode 100644 Documentation/hwmon/aspeed2600-pwm-tachometer.rst
 create mode 100644 drivers/hwmon/aspeed2600-pwm-tacho.c

-- 
2.25.1

