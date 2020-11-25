Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED52C4C51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgKZAyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:54:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:48272 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgKZAyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:54:05 -0500
IronPort-SDR: nMyDp00whi6YJfvRMpm0IJ++3BOCZX2bPwHdkalZiPMx8bUXaunineKVciE6PTTIINqWFTNPTQ
 dsmfaNOYeLpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="168710689"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="168710689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 16:54:04 -0800
IronPort-SDR: SrrbN0b6v7dx7bfysd7tsBcutPGvi+ETIV4375n90Ue2cTAiEN7vINTmsVoOh1koz+Ic3esWGn
 aTeVhRY3EYHg==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="547514945"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 16:54:00 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] regmap: sdw: add required header files
Date:   Wed, 25 Nov 2020 21:01:28 +0800
Message-Id: <20201125130128.15952-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Explicitly add header files used by regmap SoundWire support.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index c92d614b4943..c83be26434e7 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -2,7 +2,9 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
 #include "internal.h"
 
-- 
2.17.1

