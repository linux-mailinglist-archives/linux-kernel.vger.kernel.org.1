Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F239304643
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393747AbhAZR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:56:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:31638 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390029AbhAZI4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:56:41 -0500
IronPort-SDR: 4B4g9XMn0HkCQA/6g1ojOT/hoob26oV2NkOuiq2Vw4NkoGozaLJJW4knX8eQRNkQWjArym89xh
 FSbwuz5R/kEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179091784"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179091784"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:54:48 -0800
IronPort-SDR: KETQn8n0cYfo66tl7EI/stZzeC0TYas9jeyvygLCNiTRh3SuD/IWoXiSjNN6dhwddE/FCarKFk
 FRpeeAHCLceA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577736991"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:54:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: return earlier if no slave is attached
Date:   Tue, 26 Jan 2021 16:54:39 +0800
Message-Id: <20210126085439.4349-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Song <chao.song@linux.intel.com>

If there is no slave attached to soundwire bus, we
can return earlier from sdw_bus_prep_clk_stop() and
sdw_bus_exit_clk_stop(), this saves a redundant value
check.

Signed-off-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 82df088c9333..d9deafdcf495 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -951,17 +951,17 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus)
 			simple_clk_stop = false;
 	}
 
-	if (is_slave && !simple_clk_stop) {
+	/* Skip remaining clock stop preparation if no Slave is attached */
+	if (!is_slave)
+		return ret;
+
+	if (!simple_clk_stop) {
 		ret = sdw_bus_wait_for_clk_prep_deprep(bus,
 						       SDW_BROADCAST_DEV_NUM);
 		if (ret < 0)
 			return ret;
 	}
 
-	/* Don't need to inform slaves if there is no slave attached */
-	if (!is_slave)
-		return ret;
-
 	/* Inform slaves that prep is done */
 	list_for_each_entry(slave, &bus->slaves, node) {
 		if (!slave->dev_num)
@@ -1075,16 +1075,13 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
 				 "clk stop deprep failed:%d", ret);
 	}
 
-	if (is_slave && !simple_clk_stop)
+	/* Skip remaining clock stop de-preparation if no Slave is attached */
+	if (!is_slave)
+		return 0;
+
+	if (!simple_clk_stop)
 		sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
 
-	/*
-	 * Don't need to call slave callback function if there is no slave
-	 * attached
-	 */
-	if (!is_slave)
-		return 0;
-
 	list_for_each_entry(slave, &bus->slaves, node) {
 		if (!slave->dev_num)
 			continue;
-- 
2.17.1

