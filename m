Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFED72FFD23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAVHMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:12:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:54246 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbhAVHL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:11:56 -0500
IronPort-SDR: ch1T9T/9LAS4oxYDlkPq+oYJ2ibnbM/9lyC5PWtP/KzFTdGAZu5FBnh3Q9w/SyGCmsOOC41gxI
 pciR42LkeSoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264222042"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264222042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:07:05 -0800
IronPort-SDR: DOiYsH58nSY+Qh5ppPOnUNCIFM6C3sqciYqR3+LpzyuuPO6t0wRG4CKICjrPEeeXzNPf1y4eF6
 xlEgmUgqLOqw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863951"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:07:01 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 9/9] soundwire: bus: clarify dev_err/dbg device references
Date:   Fri, 22 Jan 2021 15:06:34 +0800
Message-Id: <20210122070634.12825-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
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
index 7c4717dd9a34..39edf87cf832 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -636,6 +636,7 @@ static int sdw_get_device_num(struct sdw_slave *slave)
 
 static int sdw_assign_device_num(struct sdw_slave *slave)
 {
+	struct sdw_bus *bus = slave->bus;
 	int ret, dev_num;
 	bool new_device = false;
 
@@ -646,7 +647,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 			dev_num = sdw_get_device_num(slave);
 			mutex_unlock(&slave->bus->bus_lock);
 			if (dev_num < 0) {
-				dev_err(slave->bus->dev, "Get dev_num failed: %d\n",
+				dev_err(bus->dev, "Get dev_num failed: %d\n",
 					dev_num);
 				return dev_num;
 			}
@@ -659,7 +660,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	}
 
 	if (!new_device)
-		dev_dbg(slave->bus->dev,
+		dev_dbg(bus->dev,
 			"Slave already registered, reusing dev_num:%d\n",
 			slave->dev_num);
 
@@ -669,7 +670,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 
 	ret = sdw_write_no_pm(slave, SDW_SCP_DEVNUMBER, dev_num);
 	if (ret < 0) {
-		dev_err(&slave->dev, "Program device_num %d failed: %d\n",
+		dev_err(bus->dev, "Program device_num %d failed: %d\n",
 			dev_num, ret);
 		return ret;
 	}
@@ -748,7 +749,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 				 */
 				ret = sdw_assign_device_num(slave);
 				if (ret) {
-					dev_err(slave->bus->dev,
+					dev_err(bus->dev,
 						"Assign dev_num failed:%d\n",
 						ret);
 					return ret;
@@ -788,9 +789,11 @@ static int sdw_program_device_num(struct sdw_bus *bus)
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
 
@@ -811,7 +814,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 		complete(&slave->enumeration_complete);
 	}
 	slave->status = status;
-	mutex_unlock(&slave->bus->bus_lock);
+	mutex_unlock(&bus->bus_lock);
 }
 
 static enum sdw_clk_stop_mode sdw_get_clk_stop_mode(struct sdw_slave *slave)
@@ -1140,7 +1143,7 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 
 	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
 	if (ret < 0)
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DPN_INTMASK write failed:%d\n", val);
 
 	return ret;
@@ -1271,7 +1274,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	/* Enable SCP interrupts */
 	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
 	if (ret < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_SCP_INTMASK1 write failed:%d\n", ret);
 		return ret;
 	}
@@ -1286,7 +1289,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 
 	ret = sdw_update_no_pm(slave, SDW_DP0_INTMASK, val, val);
 	if (ret < 0)
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DP0_INTMASK read failed:%d\n", ret);
 	return ret;
 }
@@ -1298,7 +1301,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 
 	status = sdw_read_no_pm(slave, SDW_DP0_INT);
 	if (status < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DP0_INT read failed:%d\n", status);
 		return status;
 	}
@@ -1337,7 +1340,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		/* clear the interrupts but don't touch reserved and SDCA_CASCADE fields */
 		ret = sdw_write_no_pm(slave, SDW_DP0_INT, clear);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DP0_INT write failed:%d\n", ret);
 			return ret;
 		}
@@ -1345,7 +1348,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		/* Read DP0 interrupt again */
 		status2 = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (status2 < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DP0_INT read failed:%d\n", status2);
 			return status2;
 		}
@@ -1358,7 +1361,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 	} while ((status & SDW_DP0_INTERRUPTS) && (count < SDW_READ_INTR_CLEAR_RETRY));
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
-		dev_warn(slave->bus->dev, "Reached MAX_RETRY on DP0 read\n");
+		dev_warn(&slave->dev, "Reached MAX_RETRY on DP0 read\n");
 
 	return ret;
 }
@@ -1376,7 +1379,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	addr = SDW_DPN_INT(port);
 	status = sdw_read_no_pm(slave, addr);
 	if (status < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_DPN_INT read failed:%d\n", status);
 
 		return status;
@@ -1410,7 +1413,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		/* clear the interrupt but don't touch reserved fields */
 		ret = sdw_write_no_pm(slave, addr, clear);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DPN_INT write failed:%d\n", ret);
 			return ret;
 		}
@@ -1418,7 +1421,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		/* Read DPN interrupt again */
 		status2 = sdw_read_no_pm(slave, addr);
 		if (status2 < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DPN_INT read failed:%d\n", status2);
 			return status2;
 		}
@@ -1431,7 +1434,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	} while ((status & SDW_DPN_INTERRUPTS) && (count < SDW_READ_INTR_CLEAR_RETRY));
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
-		dev_warn(slave->bus->dev, "Reached MAX_RETRY on port read");
+		dev_warn(&slave->dev, "Reached MAX_RETRY on port read");
 
 	return ret;
 }
@@ -1460,7 +1463,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	/* Read Intstat 1, Intstat 2 and Intstat 3 registers */
 	ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 	if (ret < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_SCP_INT1 read failed:%d\n", ret);
 		goto io_err;
 	}
@@ -1468,7 +1471,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 	ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, buf2);
 	if (ret < 0) {
-		dev_err(slave->bus->dev,
+		dev_err(&slave->dev,
 			"SDW_SCP_INT2/3 read failed:%d\n", ret);
 		goto io_err;
 	}
@@ -1476,7 +1479,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	if (slave->prop.is_sdca) {
 		ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_DP0_INT read failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1573,7 +1576,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		/* Ack interrupt */
 		ret = sdw_write_no_pm(slave, SDW_SCP_INT1, clear);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_SCP_INT1 write failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1587,7 +1590,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 */
 		ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_SCP_INT1 read failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1595,7 +1598,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
-			dev_err(slave->bus->dev,
+			dev_err(&slave->dev,
 				"SDW_SCP_INT2/3 read failed:%d\n", ret);
 			goto io_err;
 		}
@@ -1603,7 +1606,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		if (slave->prop.is_sdca) {
 			ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 			if (ret < 0) {
-				dev_err(slave->bus->dev,
+				dev_err(&slave->dev,
 					"SDW_DP0_INT read failed:%d\n", ret);
 				goto io_err;
 			}
@@ -1629,7 +1632,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	} while (stat != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
-		dev_warn(slave->bus->dev, "Reached MAX_RETRY on alert read\n");
+		dev_warn(&slave->dev, "Reached MAX_RETRY on alert read\n");
 
 io_err:
 	pm_runtime_mark_last_busy(&slave->dev);
@@ -1735,7 +1738,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		case SDW_SLAVE_ALERT:
 			ret = sdw_handle_slave_alerts(slave);
 			if (ret)
-				dev_err(bus->dev,
+				dev_err(&slave->dev,
 					"Slave %d alert handling failed: %d\n",
 					i, ret);
 			break;
@@ -1754,21 +1757,21 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
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

