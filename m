Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB82F7259
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbhAOFkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:40:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:21251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbhAOFko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:40:44 -0500
IronPort-SDR: KOw1pE3iUicZLDm1UQA8WNI+lhlKg69bWhhYiVj2ptbS2A2R681CeBGD/3hezXBnJVQ2SZUucA
 OIBdNcxE0h4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158276391"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="158276391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:47 -0800
IronPort-SDR: ewqWG8xDgNFLSwPtAA30s5IyQgMGygfb2JfnHnzckq47SJB6bdlNFvsM1xcxCaZoRT/dqSH6jH
 9oedpshJ5RGw==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382542456"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:44 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH 3/5] soundwire: bus: add more details to track failed transfers
Date:   Fri, 15 Jan 2021 13:37:36 +0800
Message-Id: <20210115053738.22630-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current error log does not provide details on the type of
transfers and which address/count was requested. All this information
can help locate in which parts of the configuration process an error
occurred.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3cc006bfae71..6e1c988f3845 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -267,8 +267,10 @@ static int sdw_transfer_unlocked(struct sdw_bus *bus, struct sdw_msg *msg)
 
 	ret = do_transfer(bus, msg);
 	if (ret != 0 && ret != -ENODATA)
-		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
-			msg->dev_num, ret);
+		dev_err(bus->dev, "trf on Slave %d failed:%d %s addr %x count %d\n",
+			msg->dev_num, ret,
+			(msg->flags & SDW_MSG_FLAG_WRITE) ? "write" : "read",
+			msg->addr, msg->len);
 
 	if (msg->page)
 		sdw_reset_page(bus, msg->dev_num);
-- 
2.17.1

