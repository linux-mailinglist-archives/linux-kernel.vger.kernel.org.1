Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9222CD18F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgLCInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:43:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:64109 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgLCIng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:43:36 -0500
IronPort-SDR: gpDFsgLC7QnAR3mQ7EXO39ghX75utDSYmmfjAAnvsDn/fKhTJHDd4/Nuxh1qEsIHec8V5NMTB8
 /omq8ZIRDe7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152984903"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="152984903"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:39:46 -0800
IronPort-SDR: VFUREQocESCJFWv1qROt6/HkdNs9EdbGpIBD/PPhuYjztZkGSk4JZBsg4UsMCvUMFJevNOXHji
 K8zp0bMI7Pjg==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="481881071"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:39:42 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 7/7] soundwire: bus: clarify dev_err/dbg device references
Date:   Thu,  3 Dec 2020 04:46:45 +0800
Message-Id: <20201202204645.23891-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire bus code confuses bus and Slave device levels for
dev_err/dbg logs. That's not impacting functionality but the accuracy
of kernel logs.

We should only use bus->dev for bus-level operations and handling of
Device0. For all other logs where the device number is not zero, we
should use &slave->dev to provide more precisions to the
user/integrator.

Reported-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 63 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index c317f41eba4e..7d07cacef740 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -637,6 +637,7 @@ static int sdw_get_device_num(struct sdw_slave *slave)
 
 static int sdw_assign_device_num(struct sdw_slave *slave)
 {
+	struct sdw_bus *bus = slave->bus;
 	int ret, dev_num;
 	bool new_device = false;
 
@@ -647,7 +648,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 			dev_num = sdw_get_device_num(slave);
 			mutex_unlock(&slave->bus->bus_lock);
 			if (dev_num < 0) {
-				dev_err(slave->bus->dev, "Get dev_num failed: %d\n",
+				dev_err(bus->dev, "Get dev_num failed: %d\n",
 					dev_num);
 				return dev_num;
 			}
@@ -660,7 +661,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	}
 
 	if (!new_device)
-		dev_dbg(slave->bus->dev,
+		dev_dbg(bus->dev,
 			"Slave already registered, reusing dev_num:%d\n",
 			slave->dev_num);
 
@@ -670,7 +671,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 
 	ret = sdw_write_no_pm(slave, SDW_SCP_DEVNUMBER, dev_num);
 	if (ret < 0) {
-		dev_err(&slave->dev, "Program device_num %d failed: %d\n",
+		dev_err(bus->dev, "Program device_num %d failed: %d\n",
 			dev_num, ret);
 		return ret;
 	}
@@ -749,7 +750,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 				 */
 				ret = sdw_assign_device_num(slave);
 				if (ret) {
-					dev_err(slave->bus->dev,
+					dev_err(bus->dev,
 						"Assign dev_num failed:%d\n",
 						ret);
 					return ret;
@@ -789,9 +790,11 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 static void sdw_modify_slave_status(struct sdw_slave *slave,
 				    enum sdw_slave_status status)
 {
-	mutex_lock(&slave->bus->bus_lock);
+	struct sdw_bus *bus = slave->bus;
 
-	dev_vdbg(&slave->dev,
+	mutex_lock(&bus->bus_lock);
+
+	dev_vdbg(bus->dev,
 		 "%s: changing status slave %d status %d new status %d\n",
 		 __func__, slave->dev_num, slave->status, status);
 
@@ -812,7 +815,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 		complete(&slave->enumeration_complete);
 	}
 	slave->status = status;
-	mutex_unlock(&slave->bus->bus_lock);
+	mutex_unlock(&bus->bus_lock);
 }
 
 static enum sdw_clk_stop_mode sdw_get_clk_stop_mode(struct sdw_slave *slave)
@@ -1141,7 +1144,7 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 
 	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
 	if (ret < 0)
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DPN_INTMASK write failed:%d\n", val);
 
 	return ret;
@@ -1272,7 +1275,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	/* Enable SCP interrupts */
 	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
 	if (ret < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_SCP_INTMASK1 write failed:%d\n", ret);
 		return ret;
 	}
@@ -1287,7 +1290,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 
 	ret = sdw_update_no_pm(slave, SDW_DP0_INTMASK, val, val);
 	if (ret < 0)
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DP0_INTMASK read failed:%d\n", ret);
 	return ret;
 }
@@ -1299,7 +1302,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 
 	status = sdw_read_no_pm(slave, SDW_DP0_INT);
 	if (status < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DP0_INT read failed:%d\n", status);
 		return status;
 	}
@@ -1338,7 +1341,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		/* clear the interrupts but don't touch reserved and SDCA_CASCADE fields */
 		ret = sdw_write_no_pm(slave, SDW_DP0_INT, clear);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DP0_INT write failed:%d\n", ret);
 			return ret;
 		}
@@ -1346,7 +1349,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		/* Read DP0 interrupt again */
 		status2 = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (status2 < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DP0_INT read failed:%d\n", status2);
 			return status2;
 		}
@@ -1359,7 +1362,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 	} while ((status & SDW_DP0_INTERRUPTS) && (count < SDW_READ_INTR_CLEAR_RETRY));
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
-		dev_warn(slave->bus->dev, "Reached MAX_RETRY on DP0 read\n");
+		dev_warn(&slave->dev, "Reached MAX_RETRY on DP0 read\n");
 
 	return ret;
 }
@@ -1377,7 +1380,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	addr = SDW_DPN_INT(port);
 	status = sdw_read_no_pm(slave, addr);
 	if (status < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DPN_INT read failed:%d\n", status);
 
 		return status;
@@ -1411,7 +1414,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		/* clear the interrupt but don't touch reserved fields */
 		ret = sdw_write_no_pm(slave, addr, clear);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DPN_INT write failed:%d\n", ret);
 			return ret;
 		}
@@ -1419,7 +1422,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		/* Read DPN interrupt again */
 		status2 = sdw_read_no_pm(slave, addr);
 		if (status2 < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DPN_INT read failed:%d\n", status2);
 			return status2;
 		}
@@ -1432,7 +1435,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	} while ((status & SDW_DPN_INTERRUPTS) && (count < SDW_READ_INTR_CLEAR_RETRY));
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
-		dev_warn(slave->bus->dev, "Reached MAX_RETRY on port read");
+		dev_warn(&slave->dev, "Reached MAX_RETRY on port read");
 
 	return ret;
 }
@@ -1461,7 +1464,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	/* Read Intstat 1, Intstat 2 and Intstat 3 registers */
 	ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 	if (ret < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_SCP_INT1 read failed:%d\n", ret);
 		goto io_err;
 	}
@@ -1469,7 +1472,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 	ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, buf2);
 	if (ret < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_SCP_INT2/3 read failed:%d\n", ret);
 		goto io_err;
 	}
@@ -1477,7 +1480,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	if (slave->prop.is_sdca) {
 		ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DP0_INT read failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1574,7 +1577,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		/* Ack interrupt */
 		ret = sdw_write_no_pm(slave, SDW_SCP_INT1, clear);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_SCP_INT1 write failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1588,7 +1591,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 */
 		ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_SCP_INT1 read failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1596,7 +1599,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_SCP_INT2/3 read failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1604,7 +1607,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		if (slave->prop.is_sdca) {
 			ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 			if (ret < 0) {
-				dev_err(slave->bus->dev,
+				dev_err(&slave->dev,
 					"SDW_DP0_INT read failed:%d\n", ret);
 				goto io_err;
 			}
@@ -1630,7 +1633,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	} while (stat != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
-		dev_warn(slave->bus->dev, "Reached MAX_RETRY on alert read\n");
+		dev_warn(&slave->dev, "Reached MAX_RETRY on alert read\n");
 
 io_err:
 	pm_runtime_mark_last_busy(&slave->dev);
@@ -1736,7 +1739,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		case SDW_SLAVE_ALERT:
 			ret = sdw_handle_slave_alerts(slave);
 			if (ret)
-				dev_err(bus->dev,
+				dev_err(&slave->dev,
 					"Slave %d alert handling failed: %d\n",
 					i, ret);
 			break;
@@ -1755,21 +1758,21 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 			ret = sdw_initialize_slave(slave);
 			if (ret)
-				dev_err(bus->dev,
+				dev_err(&slave->dev,
 					"Slave %d initialization failed: %d\n",
 					i, ret);
 
 			break;
 
 		default:
-			dev_err(bus->dev, "Invalid slave %d status:%d\n",
+			dev_err(&slave->dev, "Invalid slave %d status:%d\n",
 				i, status[i]);
 			break;
 		}
 
 		ret = sdw_update_slave_status(slave, status[i]);
 		if (ret)
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"Update Slave status failed:%d\n", ret);
 		if (attached_initializing)
 			complete(&slave->initialization_complete);
-- 
2.17.1

