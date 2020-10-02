Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20158280DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgJBHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:04:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:7176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBHEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:04:36 -0400
IronPort-SDR: CrUY5BW27JmOR1hIEHYhkzv9XTQKc5xLhd71+0nymlIP/vyZZdzxNLoCsFBaJxGfh1IiMhy9c0
 0GWwAi1OdIyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="247670838"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="247670838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 00:04:34 -0700
IronPort-SDR: CqtDPQA2IJwfAuHcwRxr6bL6aK47Eih2VhqXdNMX7BnFRUyi7DTEX9bl5ytC/rF5XgAW2IT3zX
 IdwBfMCDqvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="339881518"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2020 00:04:31 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v4 0/2] Add hwmon driver for Moortec PVT controller
Date:   Fri,  2 Oct 2020 15:04:25 +0800
Message-Id: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 adds DT bindings schema in YAML format.
Patch 2 adds driver for MR75203 PVT controller.

v4:
- Fix a spelling mistake in comments.
- Add return value error checking for all regmap_reads/writes.
- Remove unnecessary else statement and a validation check.

v3:
- Resolve make dt_binding_check errors.
- Add vendor prefix and type reference for one property in yaml schema.
- Update new property name in the driver.

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

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |  71 +++
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/mr75203.c                            | 651 +++++++++++++++++++++
 4 files changed, 733 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
 create mode 100644 drivers/hwmon/mr75203.c

-- 
2.11.0

