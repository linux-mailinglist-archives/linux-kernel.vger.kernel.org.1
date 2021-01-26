Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DB303B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392281AbhAZLVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:21:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:35240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390190AbhAZIlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:41:09 -0500
IronPort-SDR: hgpmuC9E7i9cj+3YMB5x3UV8jNH+XPIr7LozaNELpX8yVENWfiZdhaqiQ0KJXb2HfVaxEUY0sf
 Y7h+G8Vn3nXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176357423"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="176357423"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:38:05 -0800
IronPort-SDR: 1d9CLidnFpCJ+x7uxzkeQmk0n5naV+VadWcUvdkWpRRML1ryGTjUzELBuhOLcP4LdTjA/yLTXB
 BMzmT9WIYtwQ==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577731243"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:38:02 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: bus: clear parity interrupt before the mask is enabled
Date:   Tue, 26 Jan 2021 16:37:46 +0800
Message-Id: <20210126083746.3238-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We recently added the ability to discard bus clash interrupts reported
on startup. These bus clash interrupts can happen randomly on some
platforms and don't seem to be valid. A master-level quirk helped
squelch those spurious errors.

Additional tests on a new platform with the Maxim 98373 amplifier
showed a rare case where the parity interrupt is also thrown on
startup, at the same time as bus clashes. This issue only seems to
happen infrequently and was only observed during suspend-resume stress
tests while audio is streaming. We could make the problem go away by
adding a Slave-level quirk, but there is no evidence that the issue is
actually a Slave problem: the parity is provided by the Master, which
could also set an invalid parity in corner cases.

This patch suggests an additional bus-level quirk for parity, which is
only applied when the codec device is not known to have an issue with
parity. The initial parity error will be ignored, but a trace will be
logged to help identify potential root causes (likely a combination of
issues on both master and slave sides influenced by board-specific
electrical parameters).

BugLink: https://github.com/thesofproject/linux/issues/2533
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 9 +++++++++
 drivers/soundwire/intel.c     | 3 ++-
 include/linux/soundwire/sdw.h | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d394905936e4..57581fdb2ea9 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1256,6 +1256,15 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_BUS_CLASH);
 		}
 	}
+	if ((slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY) &&
+	    !(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
+		/* Clear parity interrupt before enabling interrupt mask */
+		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
+		if (status & SDW_SCP_INT1_PARITY) {
+			dev_warn(&slave->dev, "PARITY error detected before INT mask is enabled\n");
+			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_PARITY);
+		}
+	}
 
 	/*
 	 * Set SCP_INT1_MASK register, typically bus clash and
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index f7ba1a77a1df..c1fdc85d0a74 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1286,7 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		prop->hw_disabled = true;
 
-	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
 
 	return 0;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a2766c3b603d..30415354d419 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -426,6 +426,7 @@ struct sdw_master_prop {
 };
 
 #define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
+#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
 
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
-- 
2.17.1

