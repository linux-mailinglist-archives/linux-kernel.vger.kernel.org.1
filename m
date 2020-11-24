Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573F32C2713
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbgKXN0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:26:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:19615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbgKXN0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:26:18 -0500
IronPort-SDR: yulyMrxRyygMmxsEJNgtVO3+Jr0Y4Y3irgWCpS5Qq/UoeIyRId3lzoreOZFLrPUQ+GLSbu9MK2
 8IBgBmHexlaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039573"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172039573"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:17 -0800
IronPort-SDR: O/T+2ymNcpD6lR9K7QuPFLdxhLVUivm/bSYnoehkIrziTbwPG1MHuwboS+7hmuhEI5GdYYcgbu
 q+G0QbvD5hPw==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546830661"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:13 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 5/5] soundwire: bus: only clear valid DPN interrupts
Date:   Tue, 24 Nov 2020 09:33:18 +0800
Message-Id: <20201124013318.8963-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Mirror the changes made for DP0 and don't modify reserved fields.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index f66a804f9b74..d1e8c3a54976 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1353,7 +1353,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 				     int port, u8 *slave_status)
 {
-	u8 clear = 0, impl_int_mask;
+	u8 clear, impl_int_mask;
 	int status, status2, ret, count = 0;
 	u32 addr;
 
@@ -1370,6 +1370,8 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	}
 
 	do {
+		clear = status & ~SDW_DPN_INTERRUPTS;
+
 		if (status & SDW_DPN_INT_TEST_FAIL) {
 			dev_err(&slave->dev, "Test fail for port:%d\n", port);
 			clear |= SDW_DPN_INT_TEST_FAIL;
@@ -1392,7 +1394,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 			*slave_status = clear;
 		}
 
-		/* clear the interrupt */
+		/* clear the interrupt but don't touch reserved fields */
 		ret = sdw_write(slave, addr, clear);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
@@ -1413,7 +1415,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		count++;
 
 		/* we can get alerts while processing so keep retrying */
-	} while (status != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
+	} while ((status & SDW_DPN_INTERRUPTS) && (count < SDW_READ_INTR_CLEAR_RETRY));
 
 	if (count == SDW_READ_INTR_CLEAR_RETRY)
 		dev_warn(slave->bus->dev, "Reached MAX_RETRY on port read");
-- 
2.17.1

