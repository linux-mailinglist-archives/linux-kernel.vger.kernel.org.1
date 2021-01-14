Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0A2F61BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbhANNRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:17:08 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:20485 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbhANNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:17:07 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10EDB0vQ082196;
        Thu, 14 Jan 2021 21:11:00 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 21:16:02 +0800
From:   "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linus.walleij@linaro.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     <BMC-SW@aspeedtech.com>, <haiyue.wang@linux.intel.com>,
        <cyrilbur@gmail.com>, <rlippert@google.com>
Subject: [PATCH v5 0/5] Remove LPC register partitioning
Date:   Thu, 14 Jan 2021 21:16:17 +0800
Message-ID: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10EDB0vQ082196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPC controller has no concept of the BMC and the Host partitions.
The incorrect partitioning can impose unnecessary range restrictions
on register access through the syscon regmap interface.

For instance, HICRB contains the I/O port address configuration
of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
HICRB as it is located at the other LPC partition.

In addition, to be backward compatible, the newly added HW control
bits could be located at any reserved bits over the LPC addressing
space.

Thereby, this patch series aims to remove the LPC partitioning for
better driver development and maintenance. This requires the change
to both the device tree and the driver implementation. To ensure
both sides are synchronously updated, a v2 binding check is added.

Chagnes since v4:
	- Add child node example in dt-bindings.

Chagnes since v3:
	- Revise binding check as suggested by Haiyue Wang.

Changes since v2:
	- Add v2 binding check to ensure the synchronization between the
	  device tree change and the driver register offset fix.

Changes since v1:
	- Add the fix to the aspeed-lpc binding documentation.

Chia-Wei, Wang (5):
  dt-bindings: aspeed-lpc: Remove LPC partitioning
  ARM: dts: Remove LPC BMC and Host partitions
  ipmi: kcs: aspeed: Adapt to new LPC DTS layout
  pinctrl: aspeed-g5: Adapt to new LPC device tree layout
  soc: aspeed: Adapt to new LPC device tree layout

 .../devicetree/bindings/mfd/aspeed-lpc.txt    | 100 ++++---------
 arch/arm/boot/dts/aspeed-g4.dtsi              |  74 ++++------
 arch/arm/boot/dts/aspeed-g5.dtsi              | 135 ++++++++----------
 arch/arm/boot/dts/aspeed-g6.dtsi              | 135 ++++++++----------
 drivers/char/ipmi/kcs_bmc_aspeed.c            |  27 ++--
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    |  17 ++-
 drivers/soc/aspeed/aspeed-lpc-ctrl.c          |  20 ++-
 drivers/soc/aspeed/aspeed-lpc-snoop.c         |  23 +--
 8 files changed, 229 insertions(+), 302 deletions(-)

-- 
2.17.1

