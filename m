Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A632F72CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbhAOGSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:18:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:21422 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOGSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:18:41 -0500
IronPort-SDR: mpMZkOI1cFRMJSQsT188lGjdsgDBk0q4gQIhoRcFS2tbCq2b6z/iHdnrr6frzXsN1w05c9Yv+f
 usjV4G/AA5QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263296419"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="263296419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:16:55 -0800
IronPort-SDR: EpyIHRxp325nxcKOrFvb0yBL0KutIVSKi2SXM8Sc7BbNi+T1W80XzV3Rh77i9D77feYMtygSbY
 UZV0jnnpmizA==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382551879"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:16:52 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: cadence: reduce timeout on transactions
Date:   Fri, 15 Jan 2021 14:16:51 +0800
Message-Id: <20210115061651.9740-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
References: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Currently the timeout for SoundWire individual transactions is 2s.

This is too large in comparison with the enumeration and completion
timeouts used in codec drivers.

A command will typically be handled in less than 100us, so 500ms for
the command completion is more than generous.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9fa55164354a..f0b0ec173f8b 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -188,7 +188,7 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_PDI_CONFIG_PORT			GENMASK(4, 0)
 
 /* Driver defaults */
-#define CDNS_TX_TIMEOUT				2000
+#define CDNS_TX_TIMEOUT				500
 
 #define CDNS_SCP_RX_FIFOLEVEL			0x2
 
-- 
2.17.1

