Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08E229389
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgGVIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:32:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:32:06 -0400
IronPort-SDR: eWwjv9o48MyjF/bkfvVFMznMlYIY2q+Ur+KMpjg29ufe9IGUi8zlfn2czIX+ZA2VGBMod1vd0G
 MN206OTMfM+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147788007"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147788007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:05 -0700
IronPort-SDR: XfwTBYf8p8Mk18Xqx03kndlbp1fDDIUckDfO3M0iS5yxQDvxtnOM1CGq/zwRT2xMbpEzN8VPwl
 BC20PJMM0w/g==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303260"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:32:01 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 05/13] soundwire: intel: call helper to reset Slave states on resume
Date:   Wed, 22 Jul 2020 04:37:15 +0800
Message-Id: <20200721203723.18305-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This helps make sure they are all UNATTACHED and reset the state
machines.

At the moment we perform a bus reset both for system resume and
pm_runtime resume, this will be modified when clock-stop mode is
supported

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b7d8ea6b331e..758387e345da 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1519,6 +1519,12 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts during resume\n");
@@ -1565,6 +1571,12 @@ static int intel_resume_runtime(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * make sure all Slaves are tagged as UNATTACHED and provide
+	 * reason for reinitialization
+	 */
+	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts during resume\n");
-- 
2.17.1

