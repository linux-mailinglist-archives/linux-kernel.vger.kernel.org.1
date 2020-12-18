Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCE2DDEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgLRGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:41:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:64726 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgLRGlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:41:17 -0500
IronPort-SDR: iOcRbpcCiJ1DpKLPHkCLLB473nEl9NJriO42+JJpr/JuxhWkDzdrPmDswbJauXyDkK6WsHJtxp
 El2TUSgb1Dqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="193795794"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="193795794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 22:40:36 -0800
IronPort-SDR: nyGPM35DiinEQcWbUDRrcgWfNk46Mwdkfdy4d/Ac3tMDTNGXY9YrnYGW3pbCmnpEVrUqPGlZ+k
 0KMkLKghacmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="343058865"
Received: from lkp-server02.sh.intel.com (HELO c4fb2a2464e8) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2020 22:40:34 -0800
Received: from kbuild by c4fb2a2464e8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kq9RJ-000036-AT; Fri, 18 Dec 2020 06:40:33 +0000
Date:   Fri, 18 Dec 2020 14:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org, Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH] driver core: fw_devlink_relax_cycle() can be static
Message-ID: <20201218063934.GA66003@e60698be8304>
References: <20201218031703.3053753-5-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218031703.3053753-5-saravanak@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4cc0303611650c..4e15193aafad6a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1519,7 +1519,7 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
  *
  * Return 1 if a cycle is found. Otherwise, return 0.
  */
-int fw_devlink_relax_cycle(struct device *con, void *sup)
+static int fw_devlink_relax_cycle(struct device *con, void *sup)
 {
 	struct device_link *link;
 	int ret;
