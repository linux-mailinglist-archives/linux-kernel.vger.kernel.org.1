Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7F2AE864
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgKKFtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:49:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:41158 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKKFtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:49:25 -0500
IronPort-SDR: WYikmZmHJvJh3uQTPfFrqyy8xi1Ow7Iy4y5xUcYNwqgyW6f9cS4HvsH4W/fgsx60UCr0aEjtxr
 xjfpmwLdGHZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="166589608"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="166589608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:49:23 -0800
IronPort-SDR: b5aaRZJ/SGcyw5exFfNK11WMFGIAkLM6s0Ja2PauYO8fy1JcvsvSLWerkWszD7xvEGqY25Uits
 N2PA8H9iN75w==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308336400"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:49:20 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/4][RFC] e1000e: Introduce workqueue to disable the power management
Date:   Wed, 11 Nov 2020 13:51:49 +0800
Message-Id: <659e3a4977a7d9e1276d06882ea838d27d7c9ff1.1605073208.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a workqueue to disable the power management of this device.
It is supposed to be triggered when e1000e hardware error is detected
during resume from S3.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index ba7a0f8f6937..f50e5716d609 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -309,6 +309,7 @@ struct e1000_adapter {
 	struct work_struct downshift_task;
 	struct work_struct update_phy_task;
 	struct work_struct print_hang_task;
+	struct work_struct pm_remove_task;
 
 	int phy_hang_count;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f7c08426c0d7..45e0b1901440 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6030,6 +6030,16 @@ static void e1000_reset_task(struct work_struct *work)
 	e1000e_reinit_locked(adapter);
 }
 
+static void e1000_pm_remove_task(struct work_struct *work)
+{
+	struct e1000_adapter *adapter;
+	struct device *dev;
+
+	adapter = container_of(work, struct e1000_adapter, pm_remove_task);
+	dev = &adapter->pdev->dev;
+	device_pm_remove(dev);
+}
+
 /**
  * e1000_get_stats64 - Get System Network Statistics
  * @netdev: network interface device structure
@@ -7589,6 +7599,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->downshift_task, e1000e_downshift_workaround);
 	INIT_WORK(&adapter->update_phy_task, e1000e_update_phy_task);
 	INIT_WORK(&adapter->print_hang_task, e1000_print_hw_hang);
+	INIT_WORK(&adapter->pm_remove_task, e1000_pm_remove_task);
 
 	/* Initialize link parameters. User can change them with ethtool */
 	adapter->hw.mac.autoneg = 1;
@@ -7731,6 +7742,7 @@ static void e1000_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->downshift_task);
 	cancel_work_sync(&adapter->update_phy_task);
 	cancel_work_sync(&adapter->print_hang_task);
+	cancel_work_sync(&adapter->pm_remove_task);
 
 	if (adapter->flags & FLAG_HAS_HW_TIMESTAMP) {
 		cancel_work_sync(&adapter->tx_hwtstamp_work);
-- 
2.17.1

