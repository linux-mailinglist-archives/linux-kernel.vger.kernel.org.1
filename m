Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7951E2448B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHNLHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 07:07:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:43675 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgHNLHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:07:40 -0400
IronPort-SDR: Mo+AbIdmW5s1xPSQsLEoimLGrxLOaAP28LP/nCYuuhXqIDlk8jozTq1NMDBhBsubdYxJNgwW3r
 VBS/wNh7AG2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="142229951"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="142229951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 04:07:39 -0700
IronPort-SDR: sknYMxwwD9yR/zUZHlAfvix6BJJJe3IwgbAve7p7mTA2iH0+cr5vcux7S02xS7O8hAexJDwggh
 25wj9gUY7xEg==
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="440082398"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 04:07:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: SDCA: add helper macro to access controls
Date:   Fri, 14 Aug 2020 07:13:45 +0800
Message-Id: <20200813231345.26194-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The upcoming SDCA (SoundWire Device Class Audio) specification defines
a hiearchical encoding to interface with Class-defined capabilities,
based on which audio function, entity, control and channel being used.

The specification is not yet accessible to the general public but this
information is released with explicit permission from the MIPI Board
to avoid delays with SDCA support on Linux platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 5d3c271af7d1..3ca09a02b9fc 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -305,4 +305,14 @@
 #define SDW_CASC_PORT_MASK_INTSTAT3		1
 #define SDW_CASC_PORT_REG_OFFSET_INTSTAT3	2
 
+/* v1.2 device - SDCA address mapping */
+#define SDW_SDCA_CTL(fun, ent, ctl, ch) (BIT(30) |	\
+					 (((fun) & 0x7) << 22) |	\
+					 (((ent) & 0x40) << 15) |	\
+					 (((ent) & 0x3f) << 7) |	\
+					 (((ctl) & 0x30) << 15) |	\
+					 (((ctl) & 0x0f) << 3) |	\
+					 (((ch) & 0x38) << 12) |	\
+					 ((ch) & 0x07))
+
 #endif /* __SDW_REGISTERS_H */
-- 
2.17.1

