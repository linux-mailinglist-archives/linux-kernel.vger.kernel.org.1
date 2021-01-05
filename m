Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E072EA399
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbhAEDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:00:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:41794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbhAEDAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:00:11 -0500
IronPort-SDR: 4Jz2csKrm4NCV0jkBTfBsGYyn9SeFP3/pRiwmIX6Qq/ExgnHCKdYtiX0+p/sKowEV/rRMy0GmD
 fR4sqGoEb++A==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827539"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827539"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:21 -0800
IronPort-SDR: Z5TjKEvOSFnKoaPkCH2T0uCz8lTbnoeZao5YUGj+nB6syX0Ps+8Y/IxvA3lKemNYOojSbf90ht
 Rziu/4GtQyow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632195"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:20 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 20/20] dlb: queue map/unmap workqueue
Date:   Mon,  4 Jan 2021 20:58:39 -0600
Message-Id: <20210105025839.23169-21-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
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
index 97aae4c880d2..2d96cff9223c 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -458,6 +458,9 @@ static int dlb_probe(struct pci_dev *pdev,
 
 	dlb->ops->init_hardware(dlb);
 
+	/* Initialize a workqueue for queue-port linking. */
+	dlb_init_work(dlb);
+
 	/*
 	 * Undo the 'get' operation by the PCI layer during probe and
 	 * (if PF) immediately suspend the device. Since the device is only
@@ -617,6 +620,8 @@ static int __init dlb_init_module(void)
 
 static void __exit dlb_exit_module(void)
 {
+	flush_scheduled_work();
+
 	pci_unregister_driver(&dlb_pci_driver);
 
 	cdev_del(&dlb_cdev);
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 28fef9897e40..35047a8d76ac 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -139,11 +139,13 @@ struct dlb {
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
 
 int dlb_init_domain(struct dlb *dlb, u32 domain_id);
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index 6994fe90bb25..f6dd500645d1 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -2602,6 +2602,61 @@ static int dlb_ldb_port_finish_map_qid_dynamic(struct dlb_hw *hw,
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
@@ -2654,8 +2709,16 @@ static int dlb_ldb_port_map_qid_dynamic(struct dlb_hw *hw,
 
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
@@ -2678,6 +2741,13 @@ static int dlb_ldb_port_map_qid_dynamic(struct dlb_hw *hw,
 
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
 
@@ -3394,6 +3464,20 @@ dlb_domain_finish_unmap_qid_procedures(struct dlb_hw *hw,
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
@@ -3470,6 +3554,20 @@ dlb_domain_finish_map_qid_procedures(struct dlb_hw *hw,
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
 static void dlb_log_map_qid(struct dlb_hw *hw,
 			    u32 domain_id,
 			    struct dlb_map_qid_args *args,
@@ -3750,6 +3848,7 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw,
 	struct dlb_ldb_queue *queue;
 	enum dlb_qid_map_state st;
 	struct dlb_ldb_port *port;
+	bool unmap_complete;
 	int i, ret;
 
 	dlb_log_unmap_qid(hw, domain_id, args, vdev_req, vdev_id);
@@ -3831,7 +3930,14 @@ int dlb_hw_unmap_qid(struct dlb_hw *hw,
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
index 5fbc9d0b5e96..1f4c8efcfc28 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -120,4 +120,6 @@ void dlb_hw_enable_sparse_ldb_cq_mode(struct dlb_hw *hw);
 
 void dlb_hw_enable_sparse_dir_cq_mode(struct dlb_hw *hw);
 
+void dlb_init_work(struct dlb *dlb);
+
 #endif /* __DLB_RESOURCE_H */
-- 
2.17.1

