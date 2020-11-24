Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677152C2711
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbgKXN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:26:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:19615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388045AbgKXN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:26:10 -0500
IronPort-SDR: Fr1b2p2+81q32+N9+inPn3iRTrc1aUJHErLCZIpBrnPCUdKFzmhD24viVnhS3kf4OoNTQd9v8g
 h3FnlM+Sqwrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039556"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172039556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:10 -0800
IronPort-SDR: fHdFmb8eD5rqHQHfgTS7u9kPrLx9ko70HZtRBx70s+S7BzIwmwr4GApkTc4UgBAdcJ39+fv15g
 5dFHJydQTw8w==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546830617"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:26:06 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 3/5] soundwire: registers: add definitions for clearable interrupt fields
Date:   Tue, 24 Nov 2020 09:33:16 +0800
Message-Id: <20201124013318.8963-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

DP0 has reserved fields and the read-only SDCA_CASCADE bit. We should
not try to write values in these fields, so add a formal definition
for clearable interrupts to be used in DP0 interrupt handling.

DPN also has reserved fields so add definitions for clearable
interrupts as well.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index f420e8059779..0cb1a22685b8 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -41,6 +41,12 @@
 #define SDW_DP0_INT_IMPDEF1			BIT(5)
 #define SDW_DP0_INT_IMPDEF2			BIT(6)
 #define SDW_DP0_INT_IMPDEF3			BIT(7)
+#define SDW_DP0_INTERRUPTS			(SDW_DP0_INT_TEST_FAIL | \
+						 SDW_DP0_INT_PORT_READY | \
+						 SDW_DP0_INT_BRA_FAILURE | \
+						 SDW_DP0_INT_IMPDEF1 | \
+						 SDW_DP0_INT_IMPDEF2 | \
+						 SDW_DP0_INT_IMPDEF3)
 
 #define SDW_DP0_PORTCTRL_DATAMODE		GENMASK(3, 2)
 #define SDW_DP0_PORTCTRL_NXTINVBANK		BIT(4)
@@ -241,6 +247,11 @@
 #define SDW_DPN_INT_IMPDEF1			BIT(5)
 #define SDW_DPN_INT_IMPDEF2			BIT(6)
 #define SDW_DPN_INT_IMPDEF3			BIT(7)
+#define SDW_DPN_INTERRUPTS			(SDW_DPN_INT_TEST_FAIL | \
+						 SDW_DPN_INT_PORT_READY | \
+						 SDW_DPN_INT_IMPDEF1 | \
+						 SDW_DPN_INT_IMPDEF2 | \
+						 SDW_DPN_INT_IMPDEF3)
 
 #define SDW_DPN_PORTCTRL_FLOWMODE		GENMASK(1, 0)
 #define SDW_DPN_PORTCTRL_DATAMODE		GENMASK(3, 2)
-- 
2.17.1

