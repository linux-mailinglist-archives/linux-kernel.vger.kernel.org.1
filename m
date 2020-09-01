Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5225A371
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 05:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIBDAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 23:00:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:23996 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgIBDAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:00:11 -0400
IronPort-SDR: heCGLnjK2VJQkNuazii6U6DfsIPRKr5qKAgarnMAAEFxS40lH7EkIOaeZzuJGAd6jZ2PrLZI45
 J1h1+CQW6/zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860128"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 20:00:11 -0700
IronPort-SDR: mTk9y5kQaV0jCQIOaOAx1/+oRola6e0yPJG1/wFHORiIVZuR5TQk+Jh9eRfu6XTrcYz4C+soUO
 ZZTiVUsmgJwA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588208"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 20:00:07 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 08/10] soundwire: intel: add error log for clock-stop invalid configs
Date:   Tue,  1 Sep 2020 23:05:54 +0800
Message-Id: <20200901150556.19432-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Detect cases where the clock is assumed to be stopped but the IP is
not in the relevant state. There is no real way to recover here, but
adding an error log can help detect bad programming sequences or race
conditions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 272826973426..97c8cfc54ddd 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1931,6 +1931,11 @@ static int intel_resume_runtime(struct device *dev)
 			}
 		}
 	} else if (!clock_stop_quirks) {
+
+		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+		if (!clock_stop0)
+			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
+
 		ret = intel_init(sdw);
 		if (ret) {
 			dev_err(dev, "%s failed: %d", __func__, ret);
-- 
2.17.1

