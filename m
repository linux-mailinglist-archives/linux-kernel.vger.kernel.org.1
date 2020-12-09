Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119812D3AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLIFiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:38:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:56107 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgLIFiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:38:16 -0500
IronPort-SDR: bEng9YwZ9TVgs5kZROCUmmwxLPy7xx8DEudFx95dufI4+okOE6X5IXZomgu8pTB5+LtHUQ4pj/
 EQp4cs7ZhwLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171449632"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="171449632"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:20 -0800
IronPort-SDR: O99JrVXAUy+jhyslBgmo6HOP/RkfH54h2UB8hiQkzp+lo8QV+M2qBesujOTFlWnNLoXY0cvoMv
 TahI5W6hKc0w==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363989464"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:17 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 3/9] soundwire: bus: use no_pm IO routines for all interrupt handling
Date:   Wed,  9 Dec 2020 13:34:53 +0800
Message-Id: <20201209053459.5515-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
References: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There is no need to play with pm_runtime reference counts, if needed
the codec drivers are already explicitly resumed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b1830032b052..86c339d77a39 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1295,7 +1295,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 	u8 clear, impl_int_mask;
 	int status, status2, ret, count = 0;
 
-	status = sdw_read(slave, SDW_DP0_INT);
+	status = sdw_read_no_pm(slave, SDW_DP0_INT);
 	if (status < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_DP0_INT read failed:%d\n", status);
@@ -1334,7 +1334,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		}
 
 		/* clear the interrupts but don't touch reserved and SDCA_CASCADE fields */
-		ret = sdw_write(slave, SDW_DP0_INT, clear);
+		ret = sdw_write_no_pm(slave, SDW_DP0_INT, clear);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_DP0_INT write failed:%d\n", ret);
@@ -1342,7 +1342,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 		}
 
 		/* Read DP0 interrupt again */
-		status2 = sdw_read(slave, SDW_DP0_INT);
+		status2 = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (status2 < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_DP0_INT read failed:%d\n", status2);
@@ -1373,7 +1373,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		return sdw_handle_dp0_interrupt(slave, slave_status);
 
 	addr = SDW_DPN_INT(port);
-	status = sdw_read(slave, addr);
+	status = sdw_read_no_pm(slave, addr);
 	if (status < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_DPN_INT read failed:%d\n", status);
@@ -1407,7 +1407,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		}
 
 		/* clear the interrupt but don't touch reserved fields */
-		ret = sdw_write(slave, addr, clear);
+		ret = sdw_write_no_pm(slave, addr, clear);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_DPN_INT write failed:%d\n", ret);
@@ -1415,7 +1415,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		}
 
 		/* Read DPN interrupt again */
-		status2 = sdw_read(slave, addr);
+		status2 = sdw_read_no_pm(slave, addr);
 		if (status2 < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_DPN_INT read failed:%d\n", status2);
@@ -1457,7 +1457,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	}
 
 	/* Read Intstat 1, Intstat 2 and Intstat 3 registers */
-	ret = sdw_read(slave, SDW_SCP_INT1);
+	ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_SCP_INT1 read failed:%d\n", ret);
@@ -1465,7 +1465,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	}
 	buf = ret;
 
-	ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, buf2);
+	ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, buf2);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_SCP_INT2/3 read failed:%d\n", ret);
@@ -1473,7 +1473,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	}
 
 	if (slave->prop.is_sdca) {
-		ret = sdw_read(slave, SDW_DP0_INT);
+		ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_DP0_INT read failed:%d\n", ret);
@@ -1570,7 +1570,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		}
 
 		/* Ack interrupt */
-		ret = sdw_write(slave, SDW_SCP_INT1, clear);
+		ret = sdw_write_no_pm(slave, SDW_SCP_INT1, clear);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT1 write failed:%d\n", ret);
@@ -1584,7 +1584,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * Read status again to ensure no new interrupts arrived
 		 * while servicing interrupts.
 		 */
-		ret = sdw_read(slave, SDW_SCP_INT1);
+		ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT1 read failed:%d\n", ret);
@@ -1592,7 +1592,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		}
 		_buf = ret;
 
-		ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, _buf2);
+		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
 				"SDW_SCP_INT2/3 read failed:%d\n", ret);
@@ -1600,7 +1600,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		}
 
 		if (slave->prop.is_sdca) {
-			ret = sdw_read(slave, SDW_DP0_INT);
+			ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 			if (ret < 0) {
 				dev_err(slave->bus->dev,
 					"SDW_DP0_INT read failed:%d\n", ret);
-- 
2.17.1

