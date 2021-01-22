Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44902FFD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAVHKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:10:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:54253 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbhAVHKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:10:34 -0500
IronPort-SDR: cvcxPBArV84pqZOcqYyCmvZ5s9fwD/wLpyMEB4/4jP07YN9WJxmY6NcCG5IQc5LiDzzHj5pAPq
 WsnMf+BRJadg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264222005"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264222005"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:51 -0800
IronPort-SDR: zctXTqIqtrMiJykXZZRmoEmGdTrS0YAR1L6O4CreQbfW/f84tn83kF8JhqH7TRURLOsrTMWshX
 T0hOhJ0y406w==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863648"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:47 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 5/9] regmap: sdw: use _no_pm functions in regmap_read/write
Date:   Fri, 22 Jan 2021 15:06:30 +0800
Message-Id: <20210122070634.12825-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw_update_slave_status will be invoked when a codec is attached,
and the codec driver will initialize the codec with regmap functions
while the codec device is pm_runtime suspended.

regmap routines currently rely on regular SoundWire IO functions,
which will call pm_runtime_get_sync()/put_autosuspend.

This causes a deadlock where the resume routine waits for an
initialization complete signal that while the initialization complete
can only be reached when the resume completes.

The only solution if we allow regmap functions to be used in resume
operations as well as during codec initialization is to use _no_pm
routines. The duty of making sure the bus is operational needs to be
handled above the regmap level.

Fixes: 7c22ce6e21840 ('regmap: Add SoundWire bus support')
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index c92d614b4943..4b8d2d010cab 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -11,7 +11,7 @@ static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
 	struct device *dev = context;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 
-	return sdw_write(slave, reg, val);
+	return sdw_write_no_pm(slave, reg, val);
 }
 
 static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
@@ -20,7 +20,7 @@ static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	int read;
 
-	read = sdw_read(slave, reg);
+	read = sdw_read_no_pm(slave, reg);
 	if (read < 0)
 		return read;
 
-- 
2.17.1

