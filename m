Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE69B2C35DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKYBAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:00:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:21076 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKYBAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:00:23 -0500
IronPort-SDR: cAwvY2yR98pya5Y00Jq0aCZG5vIs5WdLMvjJ9Phz2YumnlFYa57Jl320s6tIkJ9azj67XgmpVG
 khUTetXzPHhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172140205"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="172140205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 17:00:22 -0800
IronPort-SDR: wqtsynaXEuKC8omiAFywZvNW6esy3Q8b5g946HV+w66hUJYtyQCudyYuJAyJUiIiukUNBW5c17
 LshZzceMJ2rg==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="478717652"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 17:00:18 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Date:   Tue, 24 Nov 2020 21:07:42 +0800
Message-Id: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The 'master' device acts as a glue layer used during bus
initialization only, and it needs to be 'transparent' for pm_runtime
management. Its behavior should be that it becomes active when one of
its children becomes active, and suspends when all of its children are
suspended.

In our tests on Intel platforms, we routinely see these sort of
warnings on the initial boot:

[ 21.447345] rt715 sdw:3:25d:715:0: runtime PM trying to activate
child device sdw:3:25d:715:0 but parent (sdw-master-3) is not active

This is root-caused to a missing setup to make the device 'active' on
probe. Since we don't want the device to remain active forever after
the probe, the autosuspend configuration is also enabled at the end of
the probe - the device will actually autosuspend only in the case
where there are no devices physically attached. In practice, the
master device will suspend when all its children are no longer active.

Fixes: bd84256e86ecf ('soundwire: master: enable pm runtime')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/master.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 3488bb824e84..9b05c9e25ebe 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -8,6 +8,15 @@
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
 
+/*
+ * The 3s value for autosuspend will only be used if there are no
+ * devices physically attached on a bus segment. In practice enabling
+ * the bus operation will result in children devices become active and
+ * the master device will only suspend when all its children are no
+ * longer active.
+ */
+#define SDW_MASTER_SUSPEND_DELAY_MS 3000
+
 /*
  * The sysfs for properties reflects the MIPI description as given
  * in the MIPI DisCo spec
@@ -154,7 +163,12 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	bus->dev = &md->dev;
 	bus->md = md;
 
+	pm_runtime_set_autosuspend_delay(&bus->md->dev, SDW_MASTER_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&bus->md->dev);
+	pm_runtime_mark_last_busy(&bus->md->dev);
+	pm_runtime_set_active(&bus->md->dev);
 	pm_runtime_enable(&bus->md->dev);
+	pm_runtime_idle(&bus->md->dev);
 device_register_err:
 	return ret;
 }
-- 
2.17.1

