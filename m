Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC02FFD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAVHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:10:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:54262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbhAVHKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:10:34 -0500
IronPort-SDR: YNGElFFOqwEZKEeW58kYtNWEH3q5GNoPA4+D5UP6sW5oBDmz0wuB3flyhF+QmJt8b4f17xKS6O
 Ri+9GFP/iChg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264222000"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264222000"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:47 -0800
IronPort-SDR: 5+xqaTfKRqBQE5/G3Lk4zCKtNvYZltNAHSXV6GS8QrpOMif/tAx43UuCqAYtSJajo+xpBDwHfp
 BOyc7ker88gw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863586"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:43 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 4/9] soundwire: export sdw_write/read_no_pm functions
Date:   Fri, 22 Jan 2021 15:06:29 +0800
Message-Id: <20210122070634.12825-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw_write_no_pm and sdw_read_no_pm are useful when we want to do IO
without touching PM.

Fixes: 0231453bc08f ('soundwire: bus: add clock stop helpers')
Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of
read/write functions')
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 7 ++++---
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 86c339d77a39..4eaeeb4090f0 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -405,10 +405,11 @@ sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	return sdw_transfer(slave->bus, &msg);
 }
 
-static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
+int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
 {
 	return sdw_nwrite_no_pm(slave, addr, 1, &value);
 }
+EXPORT_SYMBOL(sdw_write_no_pm);
 
 static int
 sdw_bread_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr)
@@ -476,8 +477,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 }
 EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
 
-static int
-sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
+int sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 {
 	u8 buf;
 	int ret;
@@ -488,6 +488,7 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 	else
 		return buf;
 }
+EXPORT_SYMBOL(sdw_read_no_pm);
 
 static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f0b01b728640..d08039d65825 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1005,6 +1005,8 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
 
 int sdw_read(struct sdw_slave *slave, u32 addr);
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
+int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
+int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 
-- 
2.17.1

