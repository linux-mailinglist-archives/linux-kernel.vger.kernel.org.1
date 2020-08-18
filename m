Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05252487AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHROfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:35:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgHROfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:51 -0400
IronPort-SDR: cpFjaGuLeJnazvHufe9kzVuX1CpVd67hVpTdG0H/fLJlP6kNkCds0Yj67GBhRZQ25cR9HnvRmW
 jt8y4Yug9vIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170553"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170553"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:50 -0700
IronPort-SDR: AIhjxwyM/gfQSxofSktFFoxr2OoyARo0h0simTSsqnoe5EB4uk2nh/bTMpBp5WJIXwwfmz8CS0
 zNwFVoSKeEwg==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830737"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:46 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 09/11] soundwire: intel: add dynamic debug trace for clock-stop invalid configs
Date:   Tue, 18 Aug 2020 10:41:18 +0800
Message-Id: <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Detect cases where the clock is assumed to be stopped but the IP is
not in the relevant state, and add a dynamic debug trace.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 7c63581270fd..b82d02af3c4f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1964,6 +1964,11 @@ static int intel_resume_runtime(struct device *dev)
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

