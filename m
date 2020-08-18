Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30532487AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHROfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:35:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgHROfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:39 -0400
IronPort-SDR: lKA/V50jUJ72r0nEoaDkHpvgpRlj0y1hiHK+5W+40riG68cCLE9ryC2KRrQx8NSMzIJPwqnGel
 XQ3oD3amo0Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170517"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170517"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:39 -0700
IronPort-SDR: Nm5sXXdIiKloF9WkqN4c5PIQZLYiuslrQENHSkOpmHr6kagJ77jfHpkmRUNlSd2RYqyvt7HdB5
 OZGwBLlp9tDw==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830602"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 06/11] soundwire: intel: add multi-link hw_synchronization information
Date:   Tue, 18 Aug 2020 10:41:15 +0800
Message-Id: <20200818024120.20721-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

set the flags as required by hardware implementation

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index f4441684bd7e..89a8ad1f80e8 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1400,7 +1400,14 @@ int intel_master_startup(struct platform_device *pdev)
 		dev_dbg(dev, "Multi-link is disabled\n");
 		bus->multi_link = false;
 	} else {
+		/*
+		 * hardware-based synchronization is required regardless
+		 * of the number of segments used by a stream: SSP-based
+		 * synchronization is gated by gsync when the multi-master
+		 * mode is set.
+		 */
 		bus->multi_link = true;
+		bus->hw_sync_min_links = 1;
 	}
 
 	/* Initialize shim, controller */
-- 
2.17.1

