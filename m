Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218E5223167
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 05:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGQDE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 23:04:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:31668 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgGQDEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:23 -0400
IronPort-SDR: s9TqZX/S2CVN99RvVW3bybHiKK1YuoUXJow6Xxk6pvSs4rHn2WDpaouGqefWZmWS8kn8V8TNYL
 Ib8DKMdUr5FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148689952"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="148689952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:10 -0700
IronPort-SDR: TbWSlI9E+jFBu+df2ZhQKp+sYj8K/Ln8HBy1DZTrAvTwyNzcqH0AWec7s1LwLaz9dPAGjsYPPJ
 U5SDq6MNQS4w==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699645"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:06 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/9] soundwire: intel: revisit SHIM programming sequences.
Date:   Thu, 16 Jul 2020 23:09:40 +0800
Message-Id: <20200716150947.22119-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Somehow the existing code is not aligned with the steps described in
the documentation, refactor code and make sure the register
programming sequences are correct. Also add missing power-up,
power-down and wake capabilities (the last two are used in follow-up
patches but introduced here for consistency).

Some of the SHIM registers exposed fields that are link specific, and
in addition some of the power-related registers (SPA/CPA) take time to
be updated. Uncontrolled access leads to timeouts or errors. Add a
mutex, shared by all links, so that all accesses to such registers are
serialized, and follow a pattern of read-modify-write.

This includes making sure SHIM_SYNC is programmed only once, before
the first master is powered on. We use a 'shim_mask' field, shared
between all links and protected by a mutex, to deal with power-up and
power-down sequences.

Note that the SYNCPRD value is tied only to the XTAL value and not the
current bus frequency or the frame rate.

BugLink: https://github.com/thesofproject/linux/issues/1555
Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 241 +++++++++++++++++++++++-----
 drivers/soundwire/intel.h           |   4 +
 drivers/soundwire/intel_init.c      |   4 +
 include/linux/soundwire/sdw_intel.h |   2 +
 4 files changed, 215 insertions(+), 36 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 8c7ae07c0fe1..4792613e8e5a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -46,7 +46,8 @@
 #define SDW_SHIM_LCTL_SPA		BIT(0)
 #define SDW_SHIM_LCTL_CPA		BIT(8)
 
-#define SDW_SHIM_SYNC_SYNCPRD_VAL	0x176F
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
 #define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
 #define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
@@ -272,8 +273,46 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	unsigned int link_id = sdw->instance;
 	void __iomem *shim = sdw->link_res->shim;
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	struct sdw_bus *bus = &sdw->cdns.bus;
+	struct sdw_master_prop *prop = &bus->prop;
 	int spa_mask, cpa_mask;
-	int link_control, ret;
+	int link_control;
+	int ret = 0;
+	u32 syncprd;
+	u32 sync_reg;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/*
+	 * The hardware relies on an internal counter, typically 4kHz,
+	 * to generate the SoundWire SSP - which defines a 'safe'
+	 * synchronization point between commands and audio transport
+	 * and allows for multi link synchronization. The SYNCPRD value
+	 * is only dependent on the oscillator clock provided to
+	 * the IP, so adjust based on _DSD properties reported in DSDT
+	 * tables. The values reported are based on either 24MHz
+	 * (CNL/CML) or 38.4 MHz (ICL/TGL+).
+	 */
+	if (prop->mclk_freq % 6000000)
+		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
+	else
+		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
+
+	if (!*shim_mask) {
+		/* we first need to program the SyncPRD/CPU registers */
+		dev_dbg(sdw->cdns.dev,
+			"%s: first link up, programming SYNCPRD\n", __func__);
+
+		/* set SyncPRD period */
+		sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+		sync_reg |= (syncprd <<
+			     SDW_REG_SHIFT(SDW_SHIM_SYNC_SYNCPRD));
+
+		/* Set SyncCPU bit */
+		sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
+		intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
+	}
 
 	/* Link power up sequence */
 	link_control = intel_readl(shim, SDW_SHIM_LCTL);
@@ -282,70 +321,182 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	link_control |=  spa_mask;
 
 	ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "Failed to power up link: %d\n", ret);
+		goto out;
+	}
+
+	if (!*shim_mask) {
+		/* SyncCPU will change once link is active */
+		ret = intel_wait_bit(shim, SDW_SHIM_SYNC,
+				     SDW_SHIM_SYNC_SYNCCPU, 0);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev,
+				"Failed to set SHIM_SYNC: %d\n", ret);
+			goto out;
+		}
+	}
+
+	*shim_mask |= BIT(link_id);
 
 	sdw->cdns.link_up = true;
-	return 0;
+out:
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
 }
 
-static int intel_shim_init(struct sdw_intel *sdw)
+/* this needs to be called with shim_lock */
+static void intel_shim_glue_to_master_ip(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
-	int sync_reg, ret;
-	u16 ioctl = 0, act = 0;
-
-	/* Initialize Shim */
-	ioctl |= SDW_SHIM_IOCTL_BKE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl |= SDW_SHIM_IOCTL_WPDD;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl |= SDW_SHIM_IOCTL_DO;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-
-	ioctl |= SDW_SHIM_IOCTL_DOE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	u16 ioctl;
 
 	/* Switch to MIP from Glue logic */
 	ioctl = intel_readw(shim,  SDW_SHIM_IOCTL(link_id));
 
 	ioctl &= ~(SDW_SHIM_IOCTL_DOE);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
 	ioctl &= ~(SDW_SHIM_IOCTL_DO);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
 	ioctl |= (SDW_SHIM_IOCTL_MIF);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
 
 	ioctl &= ~(SDW_SHIM_IOCTL_BKE);
 	ioctl &= ~(SDW_SHIM_IOCTL_COE);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Master IP has full control of the I/Os */
+}
+
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
 
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Integration Glue has full control of the I/Os */
+}
+
+static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	int ret = 0;
+	u16 ioctl = 0, act = 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/* Initialize Shim */
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_WPDD;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_DO;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_DOE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	intel_shim_glue_to_master_ip(sdw);
 
 	act |= 0x1 << SDW_REG_SHIFT(SDW_SHIM_CTMCTL_DOAIS);
 	act |= SDW_SHIM_CTMCTL_DACTQE;
 	act |= SDW_SHIM_CTMCTL_DODS;
 	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
+	usleep_range(10, 15);
 
-	/* Now set SyncPRD period */
-	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
-	sync_reg |= (SDW_SHIM_SYNC_SYNCPRD_VAL <<
-			SDW_REG_SHIFT(SDW_SHIM_SYNC_SYNCPRD));
-
-	/* Set SyncCPU bit */
-	sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
-	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-			      SDW_SHIM_SYNC_SYNCCPU);
-	if (ret < 0)
-		dev_err(sdw->cdns.dev, "Failed to set sync period: %d\n", ret);
+	mutex_unlock(sdw->link_res->shim_lock);
 
 	return ret;
 }
 
+static void __maybe_unused intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	u16 wake_en, wake_sts;
+
+	mutex_lock(sdw->link_res->shim_lock);
+	wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
+
+	if (wake_enable) {
+		/* Enable the wakeup */
+		wake_en |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+	} else {
+		/* Disable the wake up interrupt */
+		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+
+		/* Clear wake status */
+		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+		wake_sts |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKESTS_STATUS, wake_sts);
+	}
+	mutex_unlock(sdw->link_res->shim_lock);
+}
+
+static int __maybe_unused intel_link_power_down(struct sdw_intel *sdw)
+{
+	int link_control, spa_mask, cpa_mask;
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	int ret = 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	intel_shim_master_ip_to_glue(sdw);
+
+	/* Link power down sequence */
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+	spa_mask = ~(SDW_SHIM_LCTL_SPA << link_id);
+	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
+	link_control &=  spa_mask;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+
+	if (!(*shim_mask & BIT(link_id)))
+		dev_err(sdw->cdns.dev,
+			"%s: Unbalanced power-up/down calls\n", __func__);
+
+	*shim_mask &= ~BIT(link_id);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	if (ret < 0)
+		return ret;
+
+	sdw->cdns.link_up = false;
+	return 0;
+}
+
 /*
  * PDI routines
  */
@@ -566,11 +717,15 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
 	if (!bus->multi_link)
 		return 0;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Read SYNC register */
 	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
 	sync_reg |= SDW_SHIM_SYNC_CMDSYNC << sdw->instance;
 	intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
 
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	return 0;
 }
 
@@ -585,6 +740,8 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 	if (!bus->multi_link)
 		return 0;
 
+	mutex_lock(sdw->link_res->shim_lock);
+
 	/* Read SYNC register */
 	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
 
@@ -596,9 +753,10 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 	 *
 	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
 	 */
-	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK))
-		return 0;
-
+	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK)) {
+		ret = 0;
+		goto unlock;
+	}
 	/*
 	 * Set SyncGO bit to synchronously trigger a bank switch for
 	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
@@ -608,6 +766,9 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
 			      SDW_SHIM_SYNC_SYNCGO);
+unlock:
+	mutex_unlock(sdw->link_res->shim_lock);
+
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Post bank switch failed: %d\n", ret);
 
@@ -1011,9 +1172,17 @@ static struct sdw_master_ops sdw_intel_ops = {
 
 static int intel_init(struct sdw_intel *sdw)
 {
+	bool clock_stop;
+
 	/* Initialize shim and controller */
 	intel_link_power_up(sdw);
-	intel_shim_init(sdw);
+
+	clock_stop = sdw_cdns_is_clock_stop(&sdw->cdns);
+
+	intel_shim_init(sdw, clock_stop);
+
+	if (clock_stop)
+		return 0;
 
 	return sdw_cdns_init(&sdw->cdns);
 }
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 694117370ac3..d6bdd4d63e08 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -15,6 +15,8 @@
  * @irq: Interrupt line
  * @ops: Shim callback ops
  * @dev: device implementing hw_params and free callbacks
+ * @shim_lock: mutex to handle access to shared SHIM registers
+ * @shim_mask: global pointer to check SHIM register initialization
  */
 struct sdw_intel_link_res {
 	struct platform_device *pdev;
@@ -25,6 +27,8 @@ struct sdw_intel_link_res {
 	int irq;
 	const struct sdw_intel_ops *ops;
 	struct device *dev;
+	struct mutex *shim_lock; /* protect shared registers */
+	u32 *shim_mask;
 };
 
 struct sdw_intel {
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 3f2e884b4f6d..f50a93130d12 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -180,6 +180,7 @@ static struct sdw_intel_ctx
 	ctx->mmio_base = res->mmio_base;
 	ctx->link_mask = res->link_mask;
 	ctx->handle = res->handle;
+	mutex_init(&ctx->shim_lock);
 
 	link = ctx->links;
 	link_mask = ctx->link_mask;
@@ -201,6 +202,9 @@ static struct sdw_intel_ctx
 		link->ops = res->ops;
 		link->dev = res->dev;
 
+		link->shim_lock = &ctx->shim_lock;
+		link->shim_mask = &ctx->shim_mask;
+
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 		pdevinfo.parent = res->parent;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 979b41b5dcb4..120ffddc03d2 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -115,6 +115,7 @@ struct sdw_intel_slave_id {
  * links
  * @link_list: list to handle interrupts across all links
  * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
+ * @shim_mask: flags to track initialization of SHIM shared registers
  */
 struct sdw_intel_ctx {
 	int count;
@@ -126,6 +127,7 @@ struct sdw_intel_ctx {
 	struct sdw_intel_slave_id *ids;
 	struct list_head link_list;
 	struct mutex shim_lock; /* lock for access to shared SHIM registers */
+	u32 shim_mask;
 };
 
 /**
-- 
2.17.1

