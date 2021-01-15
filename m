Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99342F725A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbhAOFkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:40:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:21255 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732003AbhAOFkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:40:47 -0500
IronPort-SDR: GKGVdPqw40EeRxP8TJSaeo32lJbzQGwqOtYCnhmMM/idY/h2n5gsMVteqIwxhM5R0335ZWJ3RR
 Tfi4hqaGHTiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158276399"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="158276399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:50 -0800
IronPort-SDR: mhokcHvfHOx9j9BiXi81wh8un63TEPt4jKAj6DjlXGvCqsA6pMwIM7FT77dMLysqBj3g70x6i1
 b8WzwkYtP34Q==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382542474"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:47 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH 4/5] soundwire: cadence: fix ACK/NAK handling
Date:   Fri, 15 Jan 2021 13:37:37 +0800
Message-Id: <20210115053738.22630-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing code reports a NAK only when ACK=0
This is not aligned with the SoundWire 1.x specifications.

Table 32 in the SoundWire 1.2 specification shows that a Device shall
not set NAK=1 if ACK=1. But Table 33 shows the Combined Response
may very well be NAK=1/ACK=1, e.g. if another Device than the one
addressed reports a parity error.

NAK=1 signals a 'Command_Aborted', regardless of the ACK bit value.

Move the tests for NAK so that the NAK=1/ACK=1 combination is properly
detected according to the specification.

Fixes: 956baa1992f9a ('soundwire: cdns: Add sdw_master_ops and IO transfer support')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 801e1fef59d8..d3c9cf920cbd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -484,10 +484,10 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 		if (!(cdns->response_buf[i] & CDNS_MCP_RESP_ACK)) {
 			no_ack = 1;
 			dev_dbg_ratelimited(cdns->dev, "Msg Ack not received\n");
-			if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
-				nack = 1;
-				dev_err_ratelimited(cdns->dev, "Msg NACK received\n");
-			}
+		}
+		if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
+			nack = 1;
+			dev_err_ratelimited(cdns->dev, "Msg NACK received\n");
 		}
 	}
 
-- 
2.17.1

