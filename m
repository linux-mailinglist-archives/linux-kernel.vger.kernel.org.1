Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E109B2C2710
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbgKXN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:26:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:19615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgKXN0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:26:09 -0500
IronPort-SDR: bAvoZ2ND8boBhUp6BXupKrJoQGjWisAtPnc/8NcTzCmBgnK7FqzLRyLmqalAmeg0XazIHinPE2
 yIr50rJoPzbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039546"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172039546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:06 -0800
IronPort-SDR: Z79BzXFxMMG9aF5DZvuzBcD+PMBJrwiMM724QUDfhkr9qZfLupN9lZPLLxScMMUuGddpYWwL/u
 Wxys2rA3CMYg==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546830597"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:02 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 2/5] soundwire: bus: reset slave_notify status at each loop
Date:   Tue, 24 Nov 2020 09:33:15 +0800
Message-Id: <20201124013318.8963-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The code loops multiple times to deal with pending interrupts, but we
never reset the slave_notify status.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 45131b9f5080..d6e646521819 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1425,7 +1425,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	u8 clear = 0, bit, port_status[15] = {0};
 	int port_num, stat, ret, count = 0;
 	unsigned long port;
-	bool slave_notify = false;
+	bool slave_notify;
 	u8 sdca_cascade = 0;
 	u8 buf, buf2[2], _buf, _buf2[2];
 	bool parity_check;
@@ -1467,6 +1467,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	}
 
 	do {
+		slave_notify = false;
+
 		/*
 		 * Check parity, bus clash and Slave (impl defined)
 		 * interrupt
-- 
2.17.1

