Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA71303B66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392055AbhAZLUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:20:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:35246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390381AbhAZIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:39:48 -0500
IronPort-SDR: emmuRrNYHatoMrQ8hfD/oxtGaAj8P9s93G8k8Sa0yAU/erLKoDBGZdl4yomvhQYCctZSjElGKX
 jI951424aa/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176357419"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="176357419"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:38:02 -0800
IronPort-SDR: y0edbAUzfmdnuDr9NgUYYHiPQIKnrIy+RDtFJeHKWNm0l8iOSsKCXBZh3oZryM8m7h1dYvChZs
 GjAiCFNzZ2vA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577731234"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:37:59 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: intel: add SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk
Date:   Tue, 26 Jan 2021 16:37:45 +0800
Message-Id: <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing we can do to handle the bus clash interrupt before
interrupt mask is enabled.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a2d5cdaa9998..f7ba1a77a1df 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1286,6 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		prop->hw_disabled = true;
 
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
+
 	return 0;
 }
 
-- 
2.17.1

