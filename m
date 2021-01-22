Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B904B2FFD18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhAVHJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:09:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:54253 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbhAVHJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:09:11 -0500
IronPort-SDR: +6G9qXBZLMwIlDcxhzaDgHHhuoOpiY7ltsuS5QqSe/nIZP/0bvspYVdMKUtti/W1Ihdn4/nDgI
 Sj1uMkxmTqzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264221980"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264221980"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:39 -0800
IronPort-SDR: oYqTuGnPlx3bavlIO+RwvOPzYlc42hJh959xBd3+3VyxFKXpm6yRd3YV3vOmKocfIXsS/ucP/e
 mhzYWoYMr2vA==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863478"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:36 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 2/9] soundwire: bus: use sdw_write_no_pm when setting the bus scale registers
Date:   Fri, 22 Jan 2021 15:06:27 +0800
Message-Id: <20210122070634.12825-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When a Slave device is resumed, it may resume the bus and restart the
enumeration. During that process, we absolutely don't want to call
regular read/write routines which will wait for the resume to
complete, otherwise a deadlock occurs.

This patch fixes the same problem as the previous one, but is split to
make the life of linux-stable maintainers less painful.

Fixes: 29d158f90690 ('soundwire: bus: initialize bus clock base and scale registers')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 60c42508c6c6..b1830032b052 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1222,7 +1222,7 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 	}
 	scale_index++;
 
-	ret = sdw_write(slave, SDW_SCP_BUS_CLOCK_BASE, base);
+	ret = sdw_write_no_pm(slave, SDW_SCP_BUS_CLOCK_BASE, base);
 	if (ret < 0) {
 		dev_err(&slave->dev,
 			"SDW_SCP_BUS_CLOCK_BASE write failed:%d\n", ret);
@@ -1230,13 +1230,13 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 	}
 
 	/* initialize scale for both banks */
-	ret = sdw_write(slave, SDW_SCP_BUSCLOCK_SCALE_B0, scale_index);
+	ret = sdw_write_no_pm(slave, SDW_SCP_BUSCLOCK_SCALE_B0, scale_index);
 	if (ret < 0) {
 		dev_err(&slave->dev,
 			"SDW_SCP_BUSCLOCK_SCALE_B0 write failed:%d\n", ret);
 		return ret;
 	}
-	ret = sdw_write(slave, SDW_SCP_BUSCLOCK_SCALE_B1, scale_index);
+	ret = sdw_write_no_pm(slave, SDW_SCP_BUSCLOCK_SCALE_B1, scale_index);
 	if (ret < 0)
 		dev_err(&slave->dev,
 			"SDW_SCP_BUSCLOCK_SCALE_B1 write failed:%d\n", ret);
-- 
2.17.1

