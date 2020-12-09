Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD72D3ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgLIFig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:38:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:56120 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgLIFiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:38:25 -0500
IronPort-SDR: Q+6J7FmAdKede13nEuw7C/1ftgtEtgw8svCS42waLGyLP/blJOVyBmjyohKwWsxbRLwD+fssGP
 tbaA3YCe7ciA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171449642"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="171449642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:28 -0800
IronPort-SDR: ELm9CyWqAPE1MVxRL0Bw4Hihy+Io02oim/2D0+QVo9FD1ZnyurxcgHs5K3u7dEnnNU4pDplSsy
 0MW15q6LrWEw==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363989524"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:35:24 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 5/9] regmap: sdw: use _no_pm functions in regmap_read/write
Date:   Wed,  9 Dec 2020 13:34:55 +0800
Message-Id: <20201209053459.5515-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
References: <20201209053459.5515-1-yung-chuan.liao@linux.intel.com>
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

