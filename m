Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50572487A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHROfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:35:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:50397 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgHROfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:16 -0400
IronPort-SDR: Dlh81/SrqVgNah3rZAXEa+XBIIKO2BdHjErurBptIRuiwiWMw4NUmbed5RXrGABpUOj7eMWVHj
 TM3Q6hCx5Fuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134972097"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="134972097"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:16 -0700
IronPort-SDR: WyHsuadT6jVo+CUsor5B5qJYHT8X3rCEZB3gty/TmdwcpcbIeFrAaYs5I8fkMhfRY6pUTbtpf+
 61chcvHzMSSQ==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830291"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:12 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 01/11] soundwire: intel: disable shim wake on suspend
Date:   Tue, 18 Aug 2020 10:41:10 +0800
Message-Id: <20200818024120.20721-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

If we enabled the clock stop mode and suspend, we need to disable the
shim wake. We do so only if the parent is pm_runtime active due to
power rail dependencies.

GitHub issue: https://github.com/thesofproject/linux/issues/1678
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index dbcbe2708563..fe9b92fd48db 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1532,6 +1532,7 @@ static int intel_suspend(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1543,6 +1544,23 @@ static int intel_suspend(struct device *dev)
 	if (pm_runtime_suspended(dev)) {
 		dev_dbg(dev, "%s: pm_runtime status: suspended\n", __func__);
 
+		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+
+		if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET ||
+		     !clock_stop_quirks) &&
+		    !pm_runtime_suspended(dev->parent)) {
+
+			/*
+			 * if we've enabled clock stop, and the parent
+			 * is still active, disable shim wake. The
+			 * SHIM registers are not accessible if the
+			 * parent is already pm_runtime suspended so
+			 * it's too late to change that configuration
+			 */
+
+			intel_shim_wake(sdw, false);
+		}
+
 		return 0;
 	}
 
-- 
2.17.1

