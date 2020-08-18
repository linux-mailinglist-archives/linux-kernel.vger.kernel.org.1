Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F202492A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 04:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHSCA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 22:00:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:3696 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgHSCA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:00:56 -0400
IronPort-SDR: +Y73BobdWPUjw8OlIZKQ7iJJaPrU8XoOZdhI7yUGKKnNa/ZTyp/EeFk2Bw9OrO/CfLQcIydi2O
 zX+XKDYayIRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152449450"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152449450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:55 -0700
IronPort-SDR: HFiMK+71vzfjaqILvMSnlPx1j6EU1tA9p1crHxcCqaYooaBg6YhuRwu297xKIyqYq9zUP5EMNm
 Kf01NPYtBPSg==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279565085"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:51 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: slave: add first_interrupt_done status
Date:   Tue, 18 Aug 2020 22:06:52 +0800
Message-Id: <20200818140656.29014-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Some Slaves report incorrect information in their interrupt status
registers after a master/bus reset, track the initial interrupt
handling so that quirks can be introduced to filter out incorrect
information while keeping interrupts enabled in steady state.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 7 ++++++-
 drivers/soundwire/slave.c     | 1 +
 include/linux/soundwire/sdw.h | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 9e5bcd0dd115..cddf39e3adfc 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1472,6 +1472,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			goto io_err;
 		}
 
+		/* at this point all initial interrupt sources were handled */
+		slave->first_interrupt_done = true;
+
 		/*
 		 * Read status again to ensure no new interrupts arrived
 		 * while servicing interrupts.
@@ -1674,8 +1677,10 @@ void sdw_clear_slave_status(struct sdw_bus *bus, u32 request)
 		if (!slave)
 			continue;
 
-		if (slave->status != SDW_SLAVE_UNATTACHED)
+		if (slave->status != SDW_SLAVE_UNATTACHED) {
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+			slave->first_interrupt_done = false;
+		}
 
 		/* keep track of request, used in pm_runtime resume */
 		slave->unattach_request = request;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 0839445ee07b..755d43eba63b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -57,6 +57,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev_num = 0;
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
+	slave->first_interrupt_done = false;
 
 	mutex_lock(&bus->bus_lock);
 	list_add_tail(&slave->node, &bus->slaves);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 6d91f2ca20b2..3550ab530c43 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -608,6 +608,8 @@ struct sdw_slave_ops {
  * between the Master suspending and the codec resuming, and make sure that
  * when the Master triggered a reset the Slave is properly enumerated and
  * initialized
+ * @first_interrupt_done: status flag tracking if the interrupt handling
+ * for a Slave happens for the first time after enumeration
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -629,6 +631,7 @@ struct sdw_slave {
 	struct completion enumeration_complete;
 	struct completion initialization_complete;
 	u32 unattach_request;
+	bool first_interrupt_done;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
-- 
2.17.1

