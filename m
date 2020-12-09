Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B92D3AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLIFjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:39:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:56107 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgLIFjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:39:36 -0500
IronPort-SDR: 4pqDQEWRKAsUgkCiUD+cJuTriHs1XVVYjwlptdJ9n+CotHTXaxiDjP7t6L+jdB4gLQYTa20Zad
 6GYtYlXQo5Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171449648"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="171449648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:32 -0800
IronPort-SDR: 6sVhimHoUq2X7jFeiif9HamdLL4aq/hpilS0JeqWr2EjVYUgRBxP5Wxwav2i2waHttAD6VGjEk
 g8F7Fb3WwxRg==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363989551"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:28 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 6/9] regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
Date:   Wed,  9 Dec 2020 13:34:56 +0800
Message-Id: <20201209053459.5515-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
References: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use no_pm versions for write and read.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 8ce30650b97c..6675c3a4b829 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -15,11 +15,11 @@ static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int va
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	int ret;
 
-	ret = sdw_write(slave, SDW_SDCA_MBQ_CTL(reg), (val >> 8) & 0xff);
+	ret = sdw_write_no_pm(slave, SDW_SDCA_MBQ_CTL(reg), (val >> 8) & 0xff);
 	if (ret < 0)
 		return ret;
 
-	return sdw_write(slave, reg, val & 0xff);
+	return sdw_write_no_pm(slave, reg, val & 0xff);
 }
 
 static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *val)
@@ -29,11 +29,11 @@ static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *va
 	int read0;
 	int read1;
 
-	read0 = sdw_read(slave, reg);
+	read0 = sdw_read_no_pm(slave, reg);
 	if (read0 < 0)
 		return read0;
 
-	read1 = sdw_read(slave, SDW_SDCA_MBQ_CTL(reg));
+	read1 = sdw_read_no_pm(slave, SDW_SDCA_MBQ_CTL(reg));
 	if (read1 < 0)
 		return read1;
 
-- 
2.17.1

