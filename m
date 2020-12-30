Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7BA2E768D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgL3G3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:29:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:39722 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL3G3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:29:51 -0500
IronPort-SDR: MUsKRgF4JqlnjKrYWKcGBpg5APpmr9uTl46g0PNRxadXzcE1D6RZmivXkkTachW4OkNS8Bz88B
 dqzoQCsjfATg==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="175798658"
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="175798658"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 22:29:10 -0800
IronPort-SDR: iXDd3ReQIYKIjRrJh73QhDSWF/ZEtBpMVL3lxzIztO0LLtoLjIRKplC6WxBEaGtjd9Y5zoqTmM
 wp+zBjwhUZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="460372421"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2020 22:29:07 -0800
From:   vijayakannan.ayyathurai@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, chen.yong.seow@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v2 0/2] Add drivers for Intel Keem Bay SoC timer block
Date:   Wed, 30 Dec 2020 14:25:25 +0800
Message-Id: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Hi,

This patch set adds the driver for Intel Keem Bay SoC timer block, which
contains 32-bit general purpose timers, a 64 bit free running counter.

Patch 1 holds the Device Tree binding documentation and
Patch 2 holds the Device Driver for clocksource and clockevent.

It was tested on the Keem Bay evaluation module board.

Thanks,
Vijay

Changes since v1:
 - Add support for KEEMBAY_TIMER to get selected through Kconfig.platforms.
 - Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
 - Avoid overlapping reg regions across 2 device nodes.
 - Simplify 2 device nodes as 1 because both are from same IP block.
 - Adapt the driver code according to the new simplified devicetree.

Vijayakannan Ayyathurai (2):
  dt-bindings: timer: Add bindings for Intel Keem Bay SoC timer
  clocksource: Add Intel Keem Bay Timer Support

 .../bindings/timer/intel,keembay-timer.yaml   |  52 ++++
 arch/arm64/Kconfig.platforms                  |   1 +
 drivers/clocksource/Kconfig                   |  10 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-keembay.c           | 225 ++++++++++++++++++
 5 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
prerequisite-patch-id: bbb340c3a34059ea6960e8b96f5ad3bf0b4ae7b0
prerequisite-patch-id: b71b548284a57a38ce96d9bb523eadfccabd6e02
-- 
2.17.1

