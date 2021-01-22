Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8F7300C82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbhAVTYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:24:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:51120 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbhAVTFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:05:44 -0500
IronPort-SDR: /jpTk+u8HXt8y3lV/2OOiHPiqWVnbfBH+YvV5Sr+v1KZWWN50jWm9U2eQ0hruvRIE++amNezAJ
 c1Y+2sZ4eG9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="166592011"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="166592011"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 11:02:33 -0800
IronPort-SDR: Cwrxm77xPp3rN48hLE5+kOgZXpxPaBd13rMx+pMkgfE6upZ2BMcd2OpLE4AuvcvoOhKOST8+7P
 D363dUQmGRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="407936839"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2021 11:02:33 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v9 20/20] dlb: queue map/unmap workqueue
Date:   Fri, 22 Jan 2021 13:01:38 -0600
Message-Id: <20210122190138.7414-21-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210122190138.7414-1-mike.ximing.chen@intel.com>
References: <20210122190138.7414-1-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add workqueue support for asynchronous queue map/unmap operations.

When mapping or unmapped a queue, it's possible that the thread that
requires the map/unmap is the same one which is responsible for doing the
processing that would quiesce the queue/port, thus the driver may have to
complete the operation asynchronously.

To that end, the driver uses a workqueue that periodically checks whether
any outstanding operations can be completed. This workqueue function is
only scheduled when there is at least one outstanding map/unmap operation.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_main.c     |   5 ++
 drivers/misc/dlb/dlb_main.h     |   2 +
 drivers/misc/dlb/dlb_resource.c | 110 +++++++++++++++++++++++++++++++-
 drivers/misc/dlb/dlb_resource.h |   2 +
 4 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index 69ab9b532ed4..678be16d103d 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -440,6 +440,9 @@ static int dlb_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
 
 	dlb->ops->init_hardware(dlb);
 
+	/* Initialize a workqueue for queue-port linking. */
+	dlb_init_work(dlb);
+
 	/*
 	 * Undo the 'get' operation by the PCI layer during probe and
 	 * (if PF) immediately suspend the device. Since the device is only
@@ -596,6 +599,8 @@ static int __init dlb_init_module(void)
 
 static void __exit dlb_exit_module(void)
 {
+	flush_scheduled_work();
+
 	pci_unregister_driver(&dlb_pci_driver);
 
 	cdev_del(&dlb_cdev);
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 5942fbf22cbb..097b070b98fa 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -140,11 +140,13 @@ struct dlb {
 	 * hardware registers.
 	 */
 	struct mutex resource_mutex;
+	struct work_struct work;
 	enum dlb_device_type type;
 	int id;
 	u32 inode_cnt;
 	dev_t dev_number;
 	u8 domain_reset_failed;
+	u8 worker_launched;
 };
 
 /* Prototypes for dlb_ioctl.c */
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index f4bd2049557a..084ff6857f15 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -2509,6 +2509,61 @@ static int dlb_ldb_port_finish_map_qid_dynamic(struct dlb_hw *hw,
 	return 0;
 }
 
+static unsigned int dlb_finish_unmap_qid_procedures(struct dlb_hw *hw);
+static unsigned int dlb_finish_map_qid_procedures(struct dlb_hw *hw);
+
+/*
+ * The workqueue callback runs until it completes all outstanding QID->CQ
+ * map and unmap requests. To prevent deadlock, this function gives other
+ * threads a chance to grab the resource mutex and configure hardware.
+ */
+static void dlb_complete_queue_map_unmap(struct work_struct *work)
+{
+	struct dlb *dlb = container_of(work, struct dlb, work);
+	int ret;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	ret = dlb_finish_unmap_qid_procedures(&dlb->hw);
+	ret += dlb_finish_map_qid_procedures(&dlb->hw);
+
+	if (ret != 0)
+		/*
+		 * Relinquish the CPU so the application can process its CQs,
+		 * so this function doesn't deadlock.
+		 */
+		schedule_work(&dlb->work);
+	else
+		dlb->worker_launched = false;
+
+	mutex_unlock(&dlb->resource_mutex);
+}
+
+void dlb_init_work(struct dlb *dlb)
+{
+	INIT_WORK(&dlb->work, dlb_complete_queue_map_unmap);
+}
+
+/**
+ * dlb_schedule_work() - launch a thread to process pending map and unmap work
+ * @hw: dlb_hw handle for a particular device.
+ *
+ * This function launches a kernel thread that will run until all pending
+ * map and unmap procedures are complete.
+ */
+static void dlb_schedule_work(struct dlb_hw *hw)
+{
+	struct dlb *dlb = container_of(hw, struct dlb, hw);
+
+	/* Nothing to do if the worker is already running */
+	if (dlb->worker_launched)
+		return;
+
+	schedule_work(&dlb->work);
+
+	dlb->worker_launched = true;
+}
+
 /**
  * dlb_ldb_port_map_qid_dynamic() - perform a "dynamic" QID->CQ mapping
  * @hw: dlb_hw handle for a particular device.
@@ -2561,8 +2616,16 @@ static int dlb_ldb_port_map_qid_dynamic(struct dlb_hw *hw,
 
 	infl_cnt = DLB_CSR_RD(hw, LSP_QID_LDB_INFL_CNT(queue->id.phys_id));
 
-	if (BITS_GET(infl_cnt, LSP_QID_LDB_INFL_CNT_COUNT))
+	if (BITS_GET(infl_cnt, LSP_QID_LDB_INFL_CNT_COUNT)) {
+		/*
+		 * The queue is owed completions so it's not safe to map it
+		 * yet. Schedule a kernel thread to complete the mapping later,
+		 * once software has completed all the queue's inflight events.
+		 */
+		dlb_schedule_work(hw);
+
 		return 1;
+	}
 
 	/*
 	 * Disable the affected CQ, and the CQs already mapped to the QID,
@@ -2585,6 +2648,13 @@ static int dlb_ldb_port_map_qid_dynamic(struct dlb_hw *hw,
 
 		dlb_ldb_queue_enable_mapped_cqs(hw, domain, queue);
 
+		/*
+		 * The queue is owed completions so it's not safe to map it
+		 * yet. Schedule a kernel thread to complete the mapping later,
+		 * once software has completed all the queue's inflight events.
+		 */
+		dlb_schedule_work(hw);
+
 		return 1;
 	}
 
@@ -3236,6 +3306,20 @@ dlb_domain_finish_unmap_qid_procedures(struct dlb_hw *hw,
 	return domain->num_pending_removals;
 }
 
+static unsigned int dlb_finish_unmap_qid_procedures(struct dlb_hw *hw)
+{
+	int i, num = 0;
+
+	/* Finish queue unmap jobs for any domain that needs it */
+	for (i = 0; i < DLB_MAX_NUM_DOMAINS; i++) {
+		struct dlb_hw_domain *domain = &hw->domains[i];
+
+		num += dlb_domain_finish_unmap_qid_procedures(hw, domain);
+	}
+
+	return num;
+}
+
 static void dlb_domain_finish_map_port(struct dlb_hw *hw,
 				       struct dlb_hw_domain *domain,
 				       struct dlb_ldb_port *port)
@@ -3312,6 +3396,20 @@ dlb_domain_finish_map_qid_procedures(struct dlb_hw *hw,
 	return domain->num_pending_additions;
 }
 
+static unsigned int dlb_finish_map_qid_procedures(struct dlb_hw *hw)
+{
+	int i, num = 0;
+
+	/* Finish queue map jobs for any domain that needs it */
+	for (i = 0; i < DLB_MAX_NUM_DOMAINS; i++) {
+		struct dlb_hw_domain *domain = &hw->domains[i];
+
+		num += dlb_domain_finish_map_qid_procedures(hw, domain);
+	}
+
+	return num;
+}
+
 static void dlb_log_map_qid(struct dlb_hw *hw, u32 domain_id,
 			    struct dlb_map_qid_args *args,
 			    bool vdev_req, unsigned int vdev_id)
@@ -3577,6 +3675,7 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw, u32 domain_id,
 	struct dlb_ldb_queue *queue;
 	enum dlb_qid_map_state st;
 	struct dlb_ldb_port *port;
+	bool unmap_complete;
 	int i, ret;
 
 	dlb_log_unmap_qid(hw, domain_id, args, vdev_req, vdev_id);
@@ -3651,7 +3750,14 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw, u32 domain_id,
 	 * outstanding inflights. If that's not the case, this will fail and
 	 * the unmapping will be completed at a later time.
 	 */
-	dlb_domain_finish_unmap_port(hw, domain, port);
+	unmap_complete = dlb_domain_finish_unmap_port(hw, domain, port);
+
+	/*
+	 * If the unmapping couldn't complete immediately, launch the worker
+	 * thread (if it isn't already launched) to finish it later.
+	 */
+	if (!unmap_complete)
+		dlb_schedule_work(hw);
 
 unmap_qid_done:
 	resp->status = 0;
diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
index e3de9eb94d5d..82f14388581b 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -89,4 +89,6 @@ void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw);
 
 void dlb_hw_enable_sparse_dir_cq_mode(struct dlb_hw *hw);
 
+void dlb_init_work(struct dlb *dlb);
+
 #endif /* __DLB_RESOURCE_H */
-- 
2.17.1

