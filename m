Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC12F58E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbhANDEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:04:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:53821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbhANDEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:04:32 -0500
IronPort-SDR: Mzo08sNhm8ZXYr0FAQBOjJjoJAlpDm9dNzNFItWf+Bipk4TS5TYGP7EamXr4UXpoYCHrS7InOy
 kAYJHMkOG33A==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="178391955"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="178391955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 19:02:46 -0800
IronPort-SDR: hAwrv6X7KX6ipNg11iCmAaRWauiNhWvyIBFDk9zpNBbic3yVa+WRdaD9KQQRb6WAzzB+qCFxXr
 dfgBbvrlvPuA==
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="382106774"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 19:02:43 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: intel: don't return error when clock stop failed
Date:   Thu, 14 Jan 2021 11:02:48 +0800
Message-Id: <20210114030248.9005-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->power.runtime_error will be set to the return value of the runtime
suspend callback function, and runtime resume function will return
-EINVAL if dev->power.runtime_error is not 0.

Somehow the codec rarely doesn't return an ACK to the clock prepare
command. If we stop the runtime suspend process and return error, we
will not be able to resume again. Likewise, if the codec lost sync and
did not rejoin, the resume operation will also fail. As a result, the
SoundWire bus can not be used anymore.

This patch suggests to finish the runtime suspend process even if we fail
to stop sdw bus clock. In the case where we do a hardware reset, the codecs
will be reconfigured completely. In the case where we use the regular clock
stop, the codecs keep their state and worst case will fall off the bus and
reattach.

The only drawback is that the power consumption may be higher and
device-initiated interrupts may be lost, but at least audio function can
still work after resume.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 10b60b7b17bb..a2d5cdaa9998 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1673,10 +1673,12 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET ||
 		   !clock_stop_quirks) {
+		bool wake_enable = true;
+
 		ret = sdw_cdns_clock_stop(cdns, true);
 		if (ret < 0) {
 			dev_err(dev, "cannot enable clock stop on suspend\n");
-			return ret;
+			wake_enable = false;
 		}
 
 		ret = sdw_cdns_enable_interrupt(cdns, false);
@@ -1691,7 +1693,7 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 			return ret;
 		}
 
-		intel_shim_wake(sdw, true);
+		intel_shim_wake(sdw, wake_enable);
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.17.1

