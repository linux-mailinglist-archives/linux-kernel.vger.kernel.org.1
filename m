Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE272F9A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbhARGw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:52:28 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:32518 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732733AbhARGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:52:09 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10I6jxbE030933;
        Mon, 18 Jan 2021 14:45:59 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Jan
 2021 14:51:16 +0800
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
Subject: [PATCH v3 2/4] hwmon: Add Aspeed AST2600 support
Date:   Mon, 18 Jan 2021 06:50:50 +0000
Message-ID: <20210118065059.2478078-3-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
References: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10I6jxbE030933
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating index.rst and adding aspeed2600-pwm-tachometer.rst to address
the driver.

Changes since v1:
 - rename to aspeed2600-pwm-tachometer.rst
 - add license identifier

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 .../hwmon/aspeed2600-pwm-tachometer.rst       | 27 +++++++++++++++++++
 Documentation/hwmon/index.rst                 |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/hwmon/aspeed2600-pwm-tachometer.rst

diff --git a/Documentation/hwmon/aspeed2600-pwm-tachometer.rst b/Documentation/hwmon/aspeed2600-pwm-tachometer.rst
new file mode 100644
index 000000000000..cf0d31a19597
--- /dev/null
+++ b/Documentation/hwmon/aspeed2600-pwm-tachometer.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+Kernel driver aspeed2600-pwm-tachometer
+===================================
+
+Supported chips:
+	ASPEED AST2600
+
+Authors:
+	Ryan Chen <ryan_chen@aspeedtech.com>
+
+Description:
+------------
+This driver implements support for ASPEED AST2600 PWM and Fan Tacho
+controller. The PWM controller supports upto 16 PWM outputs. The Fan tacho
+controller supports up to 16 tachometer inputs.
+
+The driver provides the following sensor accesses in sysfs:
+
+=============== ======= =====================================================
+fanX_input	ro	provide current fan rotation value in RPM as reported
+			by the fan to the device.
+
+pwmX		rw	get or set PWM fan control value. This is an integer
+			value between 0(off) and 255(full speed).
+=============== ======= =====================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fcb870ce6286..02020c282549 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -44,6 +44,7 @@ Hardware Monitoring Kernel Drivers
    asb100
    asc7621
    aspeed-pwm-tacho
+   aspeed2600-pwm-tachometer
    bcm54140
    bel-pfe
    bt1-pvt
-- 
2.25.1

