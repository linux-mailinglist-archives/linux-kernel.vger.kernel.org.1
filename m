Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D48E303B65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbhAZLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:20:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:35244 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390379AbhAZIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:39:48 -0500
IronPort-SDR: v5Acn/CH/7QECZZDwjV85X2MGELD7QX6YUKRRWxddQch0JRWxPWS9UeSjhRqsSsFTdpgga22gR
 U2ad+EWUyYoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176357415"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="176357415"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:37:59 -0800
IronPort-SDR: 8bmCHHC/GO89cpya/Zc4H5EOzdOzGuGl34sxhsdi9m3qpSR2jjbQBU3eFB+cUdn4ihd1DfXyHv
 9x56m0kMX5iA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577731222"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:37:57 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the mask is enabled
Date:   Tue, 26 Jan 2021 16:37:44 +0800
Message-Id: <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoundWire specification allows a Slave device to report a bus clash
with the in-band interrupt mechanism when it detects a conflict while
driving a bitSlot it owns. This can be a symptom of an electrical conflict
or a programming error, and it's vital to detect reliably.

Unfortunately, on some platforms, bus clashes are randomly reported by
Slave devices after a bus reset, with an interrupt status set even before
the bus clash interrupt is enabled. These initial spurious interrupts are
not relevant and should optionally be filtered out, while leaving the
interrupt mechanism enabled to detect 'true' issues.

This patch suggests the addition of a Master level quirk to discard such
interrupts. The quirk should in theory have been added at the Slave level,
but since the problem was detected with different generations of Slave
devices it's hard to point to a specific IP. The problem might also be
board-dependent and hence dealing with a Master quirk is simpler.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c       | 10 ++++++++++
 include/linux/soundwire/sdw.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6e1c988f3845..d394905936e4 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1240,6 +1240,7 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 static int sdw_initialize_slave(struct sdw_slave *slave)
 {
 	struct sdw_slave_prop *prop = &slave->prop;
+	int status;
 	int ret;
 	u8 val;
 
@@ -1247,6 +1248,15 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
+	if (slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH) {
+		/* Clear bus clash interrupt before enabling interrupt mask */
+		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
+		if (status & SDW_SCP_INT1_BUS_CLASH) {
+			dev_warn(&slave->dev, "Bus clash detected before INT mask is enabled\n");
+			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_BUS_CLASH);
+		}
+	}
+
 	/*
 	 * Set SCP_INT1_MASK register, typically bus clash and
 	 * implementation-defined interrupt mask. The Parity detection
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f0b01b728640..a2766c3b603d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -405,6 +405,7 @@ struct sdw_slave_prop {
  * command
  * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
  * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
+ * @quirks: bitmask identifying optional behavior beyond the scope of the MIPI specification
  */
 struct sdw_master_prop {
 	u32 revision;
@@ -421,8 +422,11 @@ struct sdw_master_prop {
 	u32 err_threshold;
 	u32 mclk_freq;
 	bool hw_disabled;
+	u32 quirks;
 };
 
+#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
+
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
 
-- 
2.17.1

