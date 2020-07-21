Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A46229394
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgGVIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:32:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:1943 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbgGVIcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:47 -0400
IronPort-SDR: k85liYhtV3y3vcw7drWy9O2Qyx4hTAVpUstUsBx+58vcDlAH9Namw3NJNdvLDLHnzRkYkbKoLL
 HwaY0uVH/c3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="235155458"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="235155458"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:47 -0700
IronPort-SDR: pXEWJDpn08l8BTPm5z4BChuJJNapL7xCaXjinmkBuCIO7WFNBWX8dLSHKAkU153hIVtnip5lq2
 kOA9WqqqGdcg==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303446"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:40 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 13/13] soundwire: intel: refine runtime pm for SDW_INTEL_CLK_STOP_BUS_RESET
Date:   Wed, 22 Jul 2020 04:37:23 +0800
Message-Id: <20200721203723.18305-14-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

When all the links are suspended, the HDaudio controller may suspend
and the power rails to the SoundWire IP may be disabled, requiring a
complete re-initialization/enumeration on resume. However, if one or
more Masters remained active, the HDaudio controller will remain active
and the power rails will remain enabled. As a result, during the link
resume step we can check if the context was preserved by verifying if
the clock was stopped, and avoid doing a complete bus reset and
re-enumeration.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 22b3359855c5..da279b175848 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1701,6 +1701,8 @@ static int intel_resume_runtime(struct device *dev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	u32 clock_stop_quirks;
+	bool clock_stop0;
+	int status;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1742,11 +1744,24 @@ static int intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
+		/*
+		 * An exception condition occurs for the CLK_STOP_BUS_RESET
+		 * case if one or more masters remain active. In this condition,
+		 * all the masters are powered on for they are in the same power
+		 * domain. Master can preserve its context for clock stop0, so
+		 * there is no need to clear slave status and reset bus.
+		 */
+		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+
 		/*
 		 * make sure all Slaves are tagged as UNATTACHED and
 		 * provide reason for reinitialization
 		 */
-		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+		if (!clock_stop0) {
+			status = SDW_UNATTACH_REQUEST_MASTER_RESET;
+			sdw_clear_slave_status(bus, status);
+		}
+
 
 		ret = sdw_cdns_enable_interrupt(cdns, true);
 		if (ret < 0) {
@@ -1754,7 +1769,7 @@ static int intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
-		ret = sdw_cdns_clock_restart(cdns, true);
+		ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
 		if (ret < 0) {
 			dev_err(dev, "unable to restart clock during resume\n");
 			return ret;
-- 
2.17.1

