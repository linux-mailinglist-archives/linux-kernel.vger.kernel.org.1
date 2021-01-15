Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09342F7256
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbhAOFjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:39:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:21258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbhAOFja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:39:30 -0500
IronPort-SDR: zVQiJUUK/GcXkc67AYfGejbqI6iuTdEhJa04a+amURta6ftcfb1sDGHFBtU9UeJYZwwXYtyon0
 Gdz1VBI72Siw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158276384"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="158276384"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:44 -0800
IronPort-SDR: /GwyB3ZhDVFPjQQD538msaTKkPOXuHPagHUk6ZCzHmQjuFKgZq1raBT/Ab1QrxHrdW/lyUJA93
 sccCqziEf4/Q==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382542441"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:41 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH 2/5] soundwire: cadence: add status in dev_dbg 'State change' log
Date:   Fri, 15 Jan 2021 13:37:35 +0800
Message-Id: <20210115053738.22630-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing debug log only mentions a state change, without providing
any details. For integration and stress-tests, it's helpful to see in
the dmesg log the reason for the state change.

The value is intended for power users and isn't converted as
human-readable values. But for the record each device has a 4-bit
status:

BIT(0): Unattached
BIT(1): Attached
BIT(2): Alert
BIT(3): Reserved (should not happen)

Example:

[  121.891288] intel-sdw intel-sdw.0: Slave status change: 0x2

<< this shows a Device0 Attached

[  121.891295] soundwire sdw-master-0: Slave attached, programming device number
[  121.891629] soundwire sdw-master-0: SDW Slave Addr: 30025d071101
[  121.891632] soundwire sdw-master-0: SDW Slave class_id 1, part_id 711, mfg_id 25d, unique_id 0, version 3
[  121.892011] intel-sdw intel-sdw.0: Msg ignored for Slave 0
[  121.892013] soundwire sdw-master-0: No more devices to enumerate
[  121.892200] intel-sdw intel-sdw.0: Slave status change: 0x21

<< this shows the device now Attached as Device1 and Unattached as
Device0, i.e. a successful enumeration.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9fa55164354a..801e1fef59d8 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -734,21 +734,18 @@ static void cdns_read_response(struct sdw_cdns *cdns)
 }
 
 static int cdns_update_slave_status(struct sdw_cdns *cdns,
-				    u32 slave0, u32 slave1)
+				    u64 slave_intstat)
 {
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
-	u64 slave;
 	u32 mask;
 	int i, set_status;
 
-	/* combine the two status */
-	slave = ((u64)slave1 << 32) | slave0;
 	memset(status, 0, sizeof(status));
 
 	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
-		mask = (slave >> (i * CDNS_MCP_SLAVE_STATUS_NUM)) &
-				CDNS_MCP_SLAVE_STATUS_BITS;
+		mask = (slave_intstat >> (i * CDNS_MCP_SLAVE_STATUS_NUM)) &
+			CDNS_MCP_SLAVE_STATUS_BITS;
 		if (!mask)
 			continue;
 
@@ -918,13 +915,17 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 	struct sdw_cdns *cdns =
 		container_of(work, struct sdw_cdns, work);
 	u32 slave0, slave1;
-
-	dev_dbg_ratelimited(cdns->dev, "Slave status change\n");
+	u64 slave_intstat;
 
 	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
 	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
 
-	cdns_update_slave_status(cdns, slave0, slave1);
+	/* combine the two status */
+	slave_intstat = ((u64)slave1 << 32) | slave0;
+
+	dev_dbg_ratelimited(cdns->dev, "Slave status change: 0x%llx\n", slave_intstat);
+
+	cdns_update_slave_status(cdns, slave_intstat);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
 
-- 
2.17.1

