Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5D263423
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgIIROo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:14:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730236AbgIIP3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:29:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 742603448DFDBD0050E8;
        Wed,  9 Sep 2020 21:37:34 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:37:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soundwire: intel: Remove ununsed function
Date:   Wed, 9 Sep 2020 21:15:31 +0800
Message-ID: <20200909131531.31380-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set, build warns:

drivers/soundwire/intel.c:488:12: warning: 'intel_link_power_down' defined but not used [-Wunused-function]

Move this to #ifdef block.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soundwire/intel.c | 137 +++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e047910d73f5..ea53291c80dd 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -399,27 +399,6 @@ static void intel_shim_glue_to_master_ip(struct sdw_intel *sdw)
 	/* at this point Master IP has full control of the I/Os */
 }
 
-/* this needs to be called with shim_lock */
-static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
-{
-	unsigned int link_id = sdw->instance;
-	void __iomem *shim = sdw->link_res->shim;
-	u16 ioctl;
-
-	/* Glue logic */
-	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
-	ioctl |= SDW_SHIM_IOCTL_BKE;
-	ioctl |= SDW_SHIM_IOCTL_COE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	/* at this point Integration Glue has full control of the I/Os */
-}
-
 static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
 {
 	void __iomem *shim = sdw->link_res->shim;
@@ -485,54 +464,6 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
-static int intel_link_power_down(struct sdw_intel *sdw)
-{
-	u32 link_control, spa_mask, cpa_mask;
-	unsigned int link_id = sdw->instance;
-	void __iomem *shim = sdw->link_res->shim;
-	u32 *shim_mask = sdw->link_res->shim_mask;
-	int ret = 0;
-
-	mutex_lock(sdw->link_res->shim_lock);
-
-	intel_shim_master_ip_to_glue(sdw);
-
-	if (!(*shim_mask & BIT(link_id)))
-		dev_err(sdw->cdns.dev,
-			"%s: Unbalanced power-up/down calls\n", __func__);
-
-	*shim_mask &= ~BIT(link_id);
-
-	if (!*shim_mask) {
-
-		dev_dbg(sdw->cdns.dev, "%s: powering down all links\n", __func__);
-
-		/* Link power down sequence */
-		link_control = intel_readl(shim, SDW_SHIM_LCTL);
-
-		/* only power-down enabled links */
-		spa_mask = FIELD_PREP(SDW_SHIM_LCTL_SPA_MASK, ~sdw->link_res->link_mask);
-		cpa_mask = FIELD_PREP(SDW_SHIM_LCTL_CPA_MASK, sdw->link_res->link_mask);
-
-		link_control &=  spa_mask;
-
-		ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-	}
-
-	link_control = intel_readl(shim, SDW_SHIM_LCTL);
-
-	mutex_unlock(sdw->link_res->shim_lock);
-
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "%s: could not power down link\n", __func__);
-
-		return ret;
-	}
-
-	sdw->cdns.link_up = false;
-	return 0;
-}
-
 static void intel_shim_sync_arm(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
@@ -1541,6 +1472,74 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
  */
 
 #ifdef CONFIG_PM
+/* this needs to be called with shim_lock */
+static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
+{
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u16 ioctl;
+
+	/* Glue logic */
+	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	ioctl |= SDW_SHIM_IOCTL_COE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Integration Glue has full control of the I/Os */
+}
+
+static int intel_link_power_down(struct sdw_intel *sdw)
+{
+	u32 link_control, spa_mask, cpa_mask;
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	int ret = 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	intel_shim_master_ip_to_glue(sdw);
+
+	if (!(*shim_mask & BIT(link_id)))
+		dev_err(sdw->cdns.dev,
+			"%s: Unbalanced power-up/down calls\n", __func__);
+
+	*shim_mask &= ~BIT(link_id);
+
+	if (!*shim_mask) {
+
+		dev_dbg(sdw->cdns.dev, "%s: powering down all links\n", __func__);
+
+		/* Link power down sequence */
+		link_control = intel_readl(shim, SDW_SHIM_LCTL);
+
+		/* only power-down enabled links */
+		spa_mask = FIELD_PREP(SDW_SHIM_LCTL_SPA_MASK, ~sdw->link_res->link_mask);
+		cpa_mask = FIELD_PREP(SDW_SHIM_LCTL_CPA_MASK, sdw->link_res->link_mask);
+
+		link_control &=  spa_mask;
+
+		ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	}
+
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "%s: could not power down link\n", __func__);
+
+		return ret;
+	}
+
+	sdw->cdns.link_up = false;
+	return 0;
+}
 
 static int __maybe_unused intel_suspend(struct device *dev)
 {
-- 
2.17.1


