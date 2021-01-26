Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23253304642
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393729AbhAZR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:56:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:10209 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbhAZI4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:56:03 -0500
IronPort-SDR: AUV4skRfobBXu6J7sFNBrbbTxp+yBm8fy5JLnhbXNOjAdrZlRA1/aVgtpnV0878gXZQy06TyWg
 rB0SsehLKqfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264693885"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264693885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:54:11 -0800
IronPort-SDR: iseolxOeUPLakWJlrVGuxEJHpxgCumdhgxeuF7ZK04+CDl8E6w9Cyj96ZY0E490LzV98g/h599
 MsUePUuQOQxw==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577736823"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:54:08 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: bus: add better dev_dbg to track complete() calls
Date:   Tue, 26 Jan 2021 16:54:02 +0800
Message-Id: <20210126085402.4264-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add a dev_dbg() log for both enumeration and initialization completion
to better track suspend-resume issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6e1c988f3845..82df088c9333 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -784,7 +784,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 
 	if (status == SDW_SLAVE_UNATTACHED) {
 		dev_dbg(&slave->dev,
-			"%s: initializing completion for Slave %d\n",
+			"%s: initializing enumeration and init completion for Slave %d\n",
 			__func__, slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
@@ -793,7 +793,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
 		dev_dbg(&slave->dev,
-			"%s: signaling completion for Slave %d\n",
+			"%s: signaling enumeration completion for Slave %d\n",
 			__func__, slave->dev_num);
 
 		complete(&slave->enumeration_complete);
@@ -1758,8 +1758,13 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
-		if (attached_initializing)
+		if (attached_initializing) {
+			dev_dbg(&slave->dev,
+				"%s: signaling initialization completion for Slave %d\n",
+				__func__, slave->dev_num);
+
 			complete(&slave->initialization_complete);
+		}
 	}
 
 	return ret;
-- 
2.17.1

