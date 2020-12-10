Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926C12D539F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbgLJGLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:11:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:21004 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbgLJGLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:11:22 -0500
IronPort-SDR: blkyVcqrfBd9+8/KfSnTYRNpndBla5KtIPBB9f3TDnjcMbU4eFLnqywEWsm9xEsPxFCkAq+B9l
 tMwl6d9qejhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="258920617"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="258920617"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:10:30 -0800
IronPort-SDR: 1+V+b/Xa14Ktqley73euezP8KCLL6auZXFlOCL770BeV4cHEFg+PT16kfMjzcRbwsaVXNyFIx8
 LiZE/7H/lUvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="368644872"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 22:10:30 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        pmalani@chromium.org, bleung@chromium.org
Cc:     heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 1/2] platform/chrome: cros_ec_typec: Parameterize cros_typec_cmds_supported()
Date:   Wed,  9 Dec 2020 22:09:02 -0800
Message-Id: <20201210060903.2205-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_typec_cmds_supported() is currently being used to check only one
feature flag.
Add a new feature parameter to it so that it can be used to check
multiple feature flags supported in cros_ec.
Rename cros_typec_cmds_supported() to cros_typec_feature_supported().

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ce031a10eb1b..650aa5332055 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -829,8 +829,8 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
-/* Check the EC feature flags to see if TYPEC_* commands are supported. */
-static int cros_typec_cmds_supported(struct cros_typec_data *typec)
+/* Check the EC feature flags to see if TYPEC_* features are supported. */
+static int cros_typec_feature_supported(struct cros_typec_data *typec, enum ec_feature_code feature)
 {
 	struct ec_response_get_features resp = {};
 	int ret;
@@ -839,11 +839,12 @@ static int cros_typec_cmds_supported(struct cros_typec_data *typec)
 				    &resp, sizeof(resp));
 	if (ret < 0) {
 		dev_warn(typec->dev,
-			 "Failed to get features, assuming typec commands unsupported.\n");
+			 "Failed to get features, assuming typec feature=%d unsupported.\n",
+			 feature);
 		return 0;
 	}
 
-	return resp.flags[EC_FEATURE_TYPEC_CMD / 32] & EC_FEATURE_MASK_1(EC_FEATURE_TYPEC_CMD);
+	return resp.flags[feature / 32] & EC_FEATURE_MASK_1(feature);
 }
 
 static void cros_typec_port_work(struct work_struct *work)
@@ -905,7 +906,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	typec->typec_cmd_supported = !!cros_typec_cmds_supported(typec);
+	typec->typec_cmd_supported = !!cros_typec_feature_supported(typec,
+					EC_FEATURE_TYPEC_CMD);
 
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
-- 
2.25.1

