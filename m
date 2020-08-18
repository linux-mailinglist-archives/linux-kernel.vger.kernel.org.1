Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408A62487A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHROf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:35:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgHROfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:23 -0400
IronPort-SDR: tSHcMHsobdSul9tyH2XLliJ0z7/QXwPNgbTGp4ycpp2INfEZALnzwPUA1SHF/rN9Lqdr99zhaj
 zhveQoKJP1lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170454"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170454"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:22 -0700
IronPort-SDR: mJdXbCWdxOR7a6Q4QjeYKaPcZxbFWdVEEGC0RP0aoEQ+EeiHREsNbOYHR2uyrXUIg5KeDuAppf
 QcCeS+6DyOqw==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830344"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 02/11] soundwire: intel: ignore software command retries
Date:   Tue, 18 Aug 2020 10:41:11 +0800
Message-Id: <20200818024120.20721-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

with multiple links synchronized in hardware, retrying commands in
software is not recommended.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fe9b92fd48db..c9ba706e20c6 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1355,6 +1355,11 @@ static int intel_master_probe(struct platform_device *pdev)
 		dev_info(dev,
 			 "SoundWire master %d is disabled, will be ignored\n",
 			 bus->link_id);
+	/*
+	 * Ignore BIOS err_threshold, it's a really bad idea when dealing
+	 * with multiple hardware synchronized links
+	 */
+	bus->prop.err_threshold = 0;
 
 	return 0;
 }
-- 
2.17.1

