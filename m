Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649CB2D3AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgLIFhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:37:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:56116 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgLIFhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:37:00 -0500
IronPort-SDR: JB6KfPQ7hRXsDK+pY62c3wSBMk5DDjRnAUTW/9MhWCYH6xwMv7Xqkjos3nCVclTBrKszSMt0Mv
 darqQyUTRCFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171449609"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="171449609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:14 -0800
IronPort-SDR: SqsF4JCaPhSGxeewJv150yNVO2p5IcnHlRUSn/pOnl6ZazRIJy7vhVEpjIcZybrrV8SVbBnNdi
 oWzrAfY3r5/g==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363989388"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:09 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/9] soundwire: bus: use sdw_update_no_pm when initializing a device
Date:   Wed,  9 Dec 2020 13:34:51 +0800
Message-Id: <20201209053459.5515-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
References: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When a Slave device is resumed, it may resume the bus and restart the
enumeration. During that process, we absolutely don't want to call
regular read/write routines which will wait for the resume to
complete, otherwise a deadlock occurs.

Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d1e8c3a54976..60c42508c6c6 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -489,6 +489,18 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 		return buf;
 }
 
+static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
+{
+	int tmp;
+
+	tmp = sdw_read_no_pm(slave, addr);
+	if (tmp < 0)
+		return tmp;
+
+	tmp = (tmp & ~mask) | val;
+	return sdw_write_no_pm(slave, addr, tmp);
+}
+
 /**
  * sdw_nread() - Read "n" contiguous SDW Slave registers
  * @slave: SDW Slave
@@ -1256,7 +1268,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	val = slave->prop.scp_int1_mask;
 
 	/* Enable SCP interrupts */
-	ret = sdw_update(slave, SDW_SCP_INTMASK1, val, val);
+	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
 			"SDW_SCP_INTMASK1 write failed:%d\n", ret);
@@ -1271,7 +1283,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	val = prop->dp0_prop->imp_def_interrupts;
 	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
 
-	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
+	ret = sdw_update_no_pm(slave, SDW_DP0_INTMASK, val, val);
 	if (ret < 0)
 		dev_err(slave->bus->dev,
 			"SDW_DP0_INTMASK read failed:%d\n", ret);
-- 
2.17.1

