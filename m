Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75B29B130
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759124AbgJ0O1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:27:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:19115 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759058AbgJ0O11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:27:27 -0400
IronPort-SDR: vlIj7CnQzk86FJakkjCT9RxVQkb1OkpX2nV0HQDQWySE8hMNpsLUr4R8fRfdls5/HeIleNSBT5
 d9ZBdfvJ7dMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155867520"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="155867520"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:27:27 -0700
IronPort-SDR: xhBn0Zrry2aYw+lnSTStOOgfvyUkk0U5YLitxi1kcFmbTv6NpqviWQv/R8n7c4LNmPpKhlDc9B
 r3m6zkQukAXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="303892410"
Received: from lkp-server01.sh.intel.com (HELO ef28dff175aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2020 07:27:25 -0700
Received: from kbuild by ef28dff175aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXPwa-0000Ka-N6; Tue, 27 Oct 2020 14:27:24 +0000
Date:   Tue, 27 Oct 2020 22:27:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC PATCH] platform/chrome: cros_ec_typec:
 cros_typec_cmds_supported() can be static
Message-ID: <20201027142714.GA59601@b3e12f4a23db>
References: <20201021205317.708008-6-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021205317.708008-6-pmalani@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 cros_ec_typec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 98d22720b365fe..f578d0bfbe5a75 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -695,7 +695,7 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 }
 
 /* Check the EC feature flags to see if TYPEC_* commands are supported. */
-int cros_typec_cmds_supported(struct cros_typec_data *typec)
+static int cros_typec_cmds_supported(struct cros_typec_data *typec)
 {
 	struct ec_response_get_features resp = {};
 	int ret;
