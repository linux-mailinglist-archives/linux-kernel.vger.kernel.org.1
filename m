Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B082C270F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgKXN0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:26:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:19615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgKXN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:26:03 -0500
IronPort-SDR: LZ6cVZ8EFJlrJC3o9kbp+VdvkW9iX76+OxrFJviOaWFb21drLuX8ABcMHzMeWd1Go9qcMTg+Oj
 wfle1JFUkG9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039534"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172039534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:02 -0800
IronPort-SDR: P15K+84n5V1KVJuVxYWzDy/ZvAifjRJWVPqU2AXI91CyqvbGYti6bxqQY52QJYsnKPqbO6x9UW
 XNL3nl0jeb/g==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546830578"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:25:58 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 1/5] soundwire: bus: add comments to explain interrupt loop filter
Date:   Tue, 24 Nov 2020 09:33:14 +0800
Message-Id: <20201124013318.8963-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The interrupt handling in SoundWire requires software to re-read the
interrupt status after clearing an interrupt. In case the interrupt is
still outstanding, the code in bus.c will loop a number of times,
however that loop is limited to the interrupts detected in the first
read. This strategy helps meet SoundWire requirements without
remaining forever in an interrupt handler.

Add a couple of comments to document this design.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index ffe4600fd95b..45131b9f5080 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1334,6 +1334,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 				"SDW_DP0_INT read failed:%d\n", status2);
 			return status2;
 		}
+		/* filter to limit loop to interrupts identified in the first status read */
 		status &= status2;
 
 		count++;
@@ -1404,6 +1405,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 				"SDW_DPN_INT read failed:%d\n", status2);
 			return status2;
 		}
+		/* filter to limit loop to interrupts identified in the first status read */
 		status &= status2;
 
 		count++;
@@ -1589,7 +1591,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			sdca_cascade = ret & SDW_DP0_SDCA_CASCADE;
 		}
 
-		/* Make sure no interrupts are pending */
+		/*
+		 * Make sure no interrupts are pending, but filter to limit loop
+		 * to interrupts identified in the first status read
+		 */
 		buf &= _buf;
 		buf2[0] &= _buf2[0];
 		buf2[1] &= _buf2[1];
-- 
2.17.1

