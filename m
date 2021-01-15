Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3042F725B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbhAOFkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:40:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:21258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733015AbhAOFkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:40:51 -0500
IronPort-SDR: Tf9CgBRZqNlpIc2dvvPgXWi43+AAnqd+giuFZ0F44kxWBJMbVqinEVGHNdef91WoNKMdBiU6cG
 7569IWl758UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158276402"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="158276402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:53 -0800
IronPort-SDR: 184qEtKU3MGXr7ct/YeK4whfi7YNr0pETtiitEaWzRPRDWp9xRgfpf1kvEcnaeh4fW1MxFJBXe
 FmSbOr3QwYgg==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382542488"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:50 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH 5/5] soundwire: cadence: adjust verbosity in response handling
Date:   Fri, 15 Jan 2021 13:37:38 +0800
Message-Id: <20210115053738.22630-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There are too many logs on startup, e.g.

[ 8811.851497] cdns_fill_msg_resp: 2 callbacks suppressed
[ 8811.851497] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851498] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851499] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851499] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851500] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851500] intel-sdw intel-sdw.0: Msg Ack not received
[ 8811.851502] intel-sdw intel-sdw.0: Msg ignored for Slave 0
[ 8811.851503] soundwire sdw-master-0: No more devices to enumerate

We can skip the 'Msg Ack not received' since it's typical of the
enumeration end, and conversely add the information on which command
fails.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d3c9cf920cbd..8d7166ffd4ad 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -483,11 +483,11 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 	for (i = 0; i < count; i++) {
 		if (!(cdns->response_buf[i] & CDNS_MCP_RESP_ACK)) {
 			no_ack = 1;
-			dev_dbg_ratelimited(cdns->dev, "Msg Ack not received\n");
+			dev_vdbg(cdns->dev, "Msg Ack not received, cmd %d\n", i);
 		}
 		if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
 			nack = 1;
-			dev_err_ratelimited(cdns->dev, "Msg NACK received\n");
+			dev_err_ratelimited(cdns->dev, "Msg NACK received, cmd %d\n", i);
 		}
 	}
 
-- 
2.17.1

