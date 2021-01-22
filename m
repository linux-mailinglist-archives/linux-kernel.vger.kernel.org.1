Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439982FFD22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbhAVHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:12:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:54253 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbhAVHL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:11:56 -0500
IronPort-SDR: wmelHFZBaGd2PDSZfTKhJCB64N7U2bIVR1L8hIkXMnDvLqz9GzPOfbpjVklIwNCNKBZUk2ZPJp
 rs34W5rtvm0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264222034"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264222034"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:07:01 -0800
IronPort-SDR: gVId4Dm6yjVptWTSN4ZBxZE2u2jLuFalRA5AEOHGwnkkVOMNVvHE+L2383+RuDkmJrKhWq2tMh
 CRxt6CH2bRaQ==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863882"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:58 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 8/9] soundwire: bus: fix confusion on device used by pm_runtime
Date:   Fri, 22 Jan 2021 15:06:33 +0800
Message-Id: <20210122070634.12825-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Intel stress-tests routinely report IO timeouts and invalid power
management transitions. Upon further analysis, we seem to be using the
wrong devices in pm_runtime calls.

Before reading and writing registers, we first need to make sure the
Slave is fully resumed. The existing code attempts to do such that,
however because of a confusion dating from 2017 and copy/paste, we
end-up resuming the parent only instead of resuming the codec device.

This can lead to accesses to the Slave registers while the bus is
still being configured and the Slave not enumerated, and as a result
IO errors occur.

This is a classic problem, similar confusions happened for HDaudio
between bus and codec device, leading to power management issues.

Fix by using the relevant device for all uses of pm_runtime functions.

Fixes: 60ee9be255712 ('soundwire: bus: add PM/no-PM versions of read/write functions')
Fixes: aa79293517b39 ('soundwire: bus: fix io error when processing alert event')
Fixes: 9d715fa005ebc ('soundwire: Add IO transfer')
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4eaeeb4090f0..7c4717dd9a34 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -513,16 +513,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
-		pm_runtime_put_noidle(slave->bus->dev);
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
 	}
 
 	ret = sdw_nread_no_pm(slave, addr, count, val);
 
-	pm_runtime_mark_last_busy(slave->bus->dev);
-	pm_runtime_put(slave->bus->dev);
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put(&slave->dev);
 
 	return ret;
 }
@@ -539,16 +539,16 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
-		pm_runtime_put_noidle(slave->bus->dev);
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
 	}
 
 	ret = sdw_nwrite_no_pm(slave, addr, count, val);
 
-	pm_runtime_mark_last_busy(slave->bus->dev);
-	pm_runtime_put(slave->bus->dev);
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put(&slave->dev);
 
 	return ret;
 }
@@ -1453,7 +1453,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err(&slave->dev, "Failed to resume device: %d\n", ret);
-		pm_runtime_put_noidle(slave->bus->dev);
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
 	}
 
-- 
2.17.1

