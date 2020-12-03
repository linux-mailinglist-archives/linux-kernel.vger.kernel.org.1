Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972252CE24E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgLCXFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgLCXFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:05:47 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: intel: fix another unused-function warning
Date:   Fri,  4 Dec 2020 00:04:56 +0100
Message-Id: <20201203230502.1480063-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_PM, there is another warning about an unused function:

drivers/soundwire/intel.c:530:12: error: 'intel_link_power_down' defined but not used [-Werror=unused-function]

After a previous fix, the driver already uses both an #ifdef and
a __maybe_unused annotation but still gets it wrong. Remove the
ifdef and instead use __maybe_unused consistently to avoid the
problem for good.

Fixes: f046b2334083 ("soundwire: intel: fix intel_suspend/resume defined but not used warning")
Fixes: ebf878eddbb4 ("soundwire: intel: add pm_runtime support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soundwire/intel.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6a1e862b16c3..66adb258a425 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1585,8 +1585,6 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
  * PM calls
  */
 
-#ifdef CONFIG_PM
-
 static int __maybe_unused intel_suspend(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
@@ -1641,7 +1639,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_suspend_runtime(struct device *dev)
+static int __maybe_unused intel_suspend_runtime(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1796,7 +1794,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	return ret;
 }
 
-static int intel_resume_runtime(struct device *dev)
+static int __maybe_unused intel_resume_runtime(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1969,8 +1967,6 @@ static int intel_resume_runtime(struct device *dev)
 	return ret;
 }
 
-#endif
-
 static const struct dev_pm_ops intel_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
 	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
-- 
2.27.0

