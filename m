Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8281127AB03
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1Jo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:44:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:52595 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgI1Jo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:44:27 -0400
IronPort-SDR: deao8A7ukp81kaHi6Nk52caPkMlNpavCT0V4jSe2ZhY5GphyBKmEGVvoBi/vg9mopW8Qx+/meG
 iEpPsZXL144g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162852555"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="162852555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 02:44:25 -0700
IronPort-SDR: AgT5WIzwW2L4a5X7RTdYr7C+dXajwXI93pawwVdhzxuNoUujsKs2Q5BywGcXv6hy1BwqdA2a8t
 hGHugTl0CUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="338117456"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2020 02:44:22 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/2] Add hwmon driver for Moortec PVT controller
Date:   Mon, 28 Sep 2020 17:44:17 +0800
Message-Id: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 adds DT bindings schema in YAML format.
Patch 2 adds driver for MR75203 PVT controller.

v2:
- Address below review concerns from Andy Shevchenko
 * Add more info in comments for clamp_val usage for clk sys cycles.
 * Add mod_devicetable.h & property.h and remove of.h
 * Remove unnecessary additional mutex lock from driver. Rely on regmap's
   internal lock.
 * Use units in timeout macros.
 * Use HZ_PER_MHZ instead of direct values.
 * Use devm_platform_ioremap_resource_byname() instead of separate calls.
 * Use device property read API instead of OF API.
- Address below review concerns from Guenter Roeck
 * Improve commit message - add hardware monitoring driver.
 * Remove unnecessary platform_set_drvdata. Instead add driver data in
   function args at one place where it is used. Fix a issue related to it.
 * Remove unnecessary NULL assignment.
- Address below review concerns from Philipp Zabel
 * Switch to devm_reset_control_get_exclusive().
 * Move reset_deassert at the last after clk_enable in probe.
- Resolve make dt_binding_check error.
- Add MODULE_LICENSE

v1:
- Initial version.


Rahul Tanwar (2):
  Add DT bindings schema for PVT controller
  Add hardware monitoring driver for Moortec MR75203 PVT controller

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |  70 +++
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/mr75203.c                            | 605 +++++++++++++++++++++
 4 files changed, 686 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
 create mode 100644 drivers/hwmon/mr75203.c

-- 
2.11.0

