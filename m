Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0202FFD21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbhAVHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:12:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:54262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbhAVHLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:11:55 -0500
IronPort-SDR: pu2hh4BYzS3VioSfb9UY0SdaliZ/788ievRoUxFB8P+uNkvbSBT5NWXXdtdmBY8IusHD6qG9FC
 m/6UOSW7dRXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264222027"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264222027"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:58 -0800
IronPort-SDR: iCH+sD5cGjcAPoyFUf02Y8ojQ3vclpF/DWQwyROD/8p5HZjpTj2wXgS0O8a2ht4NYd0dnRc/vh
 67vZ22JCASaA==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427863817"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 23:06:54 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v2 7/9] regmap: sdw-mbq: use MODULE_LICENSE("GPL")
Date:   Fri, 22 Jan 2021 15:06:32 +0800
Message-Id: <20210122070634.12825-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"GPL v2" is the same as "GPL". It exists for historic reasons.
See Documentation/process/license-rules.rst

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 6675c3a4b829..fe3ac26b66ad 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -98,4 +98,4 @@ struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
 EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw_mbq);
 
 MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.17.1

