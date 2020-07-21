Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECC229385
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGVIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:31:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:31:48 -0400
IronPort-SDR: gwdzrZV8kkag3RT1g+/TVhA83eo7EZMwtpzFMRt+5Em2pG2QXJdTxKokhrB5oSSTA/KPEsuNWH
 qNg8SotQxTDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147787951"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147787951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:48 -0700
IronPort-SDR: PvAEKZv+qpQ+GdZaWS5N/8uJnBcw2oEDj56hyXGUACViOog9I07fC1uBSGQVW6dteYspJvl8AW
 lsP+4lpwdTAw==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303146"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 01/13] soundwire: intel: Add basic power management support
Date:   Wed, 22 Jul 2020 04:37:11 +0800
Message-Id: <20200721203723.18305-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Implement suspend/resume capabilities (not runtime_pm for now)
The resume part is essentially a full-blown re-enumeration.

When S0ix is supported, we will select clock stop mode when the ACPI
target state is S0, and tear down the link for S3.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 81 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 23b66dcf9966..eb628f255cf5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -463,7 +463,7 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
-static int __maybe_unused intel_link_power_down(struct sdw_intel *sdw)
+static int intel_link_power_down(struct sdw_intel *sdw)
 {
 	int link_control, spa_mask, cpa_mask;
 	unsigned int link_id = sdw->instance;
@@ -1375,12 +1375,89 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * PM calls
+ */
+
+#ifdef CONFIG_PM
+
+static int intel_suspend(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, false);
+	if (ret < 0) {
+		dev_err(dev, "cannot disable interrupts on suspend\n");
+		return ret;
+	}
+
+	ret = intel_link_power_down(sdw);
+	if (ret) {
+		dev_err(dev, "Link power down failed: %d", ret);
+		return ret;
+	}
+
+	intel_shim_wake(sdw, false);
+
+	return 0;
+}
+
+static int intel_resume(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	ret = intel_init(sdw);
+	if (ret) {
+		dev_err(dev, "%s failed: %d", __func__, ret);
+		return ret;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable interrupts during resume\n");
+		return ret;
+	}
+
+	ret = sdw_cdns_exit_reset(cdns);
+	if (ret < 0) {
+		dev_err(dev, "unable to exit bus reset sequence during resume\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+#endif
+
+static const struct dev_pm_ops intel_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+};
+
 static struct platform_driver sdw_intel_drv = {
 	.probe = intel_master_probe,
 	.remove = intel_master_remove,
 	.driver = {
 		.name = "intel-sdw",
-	},
+		.pm = &intel_pm,
+	}
 };
 
 module_platform_driver(sdw_intel_drv);
-- 
2.17.1

