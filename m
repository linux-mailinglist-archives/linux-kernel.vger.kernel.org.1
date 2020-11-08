Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018512AAC4B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgKHQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgKHQvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:51:36 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD303206ED;
        Sun,  8 Nov 2020 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604854294;
        bh=UrX4KeSIGMomVwyPVn82iYxQ5sxGWXj1d3kAc9QWPFk=;
        h=From:To:Cc:Subject:Date:From;
        b=FEqXbHJx67buK+kBcQ2QD5thlLWohCDZSOkoICkwsd9kuAdABER/uca6uklsEMb49
         1mOcyDDMTIlXaozJdAMrcUEeXX/Fx/2mttBb+fGbMPOSI8kmWThBW7lx48uuECSI94
         oeVOOPvAe+B4WAVTA9538N1PSZEKLGCk7XrrQ7og=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: improve hard reset procedure
Date:   Sun,  8 Nov 2020 18:51:27 +0200
Message-Id: <20201108165129.13100-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We want to handle the scenario in which the driver was not able
to kill all user processes due to many memory mappings.
We need to retry again after some period while releasing the cores.
The devices will be unusable and "in-reset" status during that time.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 128 ++++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h |  16 ++-
 2 files changed, 106 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ce0a1270e5ff..c9011541c647 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -13,8 +13,6 @@
 #include <linux/hwmon.h>
 #include <uapi/misc/habanalabs.h>
 
-#define HL_PLDM_PENDING_RESET_PER_SEC	(HL_PENDING_RESET_PER_SEC * 10)
-
 enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
@@ -256,6 +254,26 @@ static void device_cdev_sysfs_del(struct hl_device *hdev)
 	cdev_device_del(&hdev->cdev, hdev->dev);
 }
 
+static void device_hard_reset_pending(struct work_struct *work)
+{
+	struct hl_device_reset_work *device_reset_work =
+		container_of(work, struct hl_device_reset_work,
+				reset_work.work);
+	struct hl_device *hdev = device_reset_work->hdev;
+	int rc;
+
+	rc = hl_device_reset(hdev, true, true);
+	if ((rc == -EBUSY) && !hdev->device_fini_pending) {
+		dev_info(hdev->dev,
+			"Could not reset device. will try again in %u seconds",
+			HL_PENDING_RESET_PER_SEC);
+
+		queue_delayed_work(device_reset_work->wq,
+			&device_reset_work->reset_work,
+			msecs_to_jiffies(HL_PENDING_RESET_PER_SEC * 1000));
+	}
+}
+
 /*
  * device_early_init - do some early initialization for the habanalabs device
  *
@@ -340,6 +358,19 @@ static int device_early_init(struct hl_device *hdev)
 
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
+	hdev->device_reset_work.wq =
+			create_singlethread_workqueue("hl_device_reset");
+	if (!hdev->device_reset_work.wq) {
+		rc = -ENOMEM;
+		dev_err(hdev->dev, "Failed to create device reset WQ\n");
+		goto free_cb_mgr;
+	}
+
+	INIT_DELAYED_WORK(&hdev->device_reset_work.reset_work,
+			device_hard_reset_pending);
+	hdev->device_reset_work.hdev = hdev;
+	hdev->device_fini_pending = 0;
+
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
 	mutex_init(&hdev->mmu_cache_lock);
@@ -351,6 +382,8 @@ static int device_early_init(struct hl_device *hdev)
 
 	return 0;
 
+free_cb_mgr:
+	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 free_idle_busy_ts_arr:
 	kfree(hdev->idle_busy_ts_arr);
 free_chip_info:
@@ -393,6 +426,7 @@ static void device_early_fini(struct hl_device *hdev)
 	kfree(hdev->hl_chip_info);
 
 	destroy_workqueue(hdev->eq_wq);
+	destroy_workqueue(hdev->device_reset_work.wq);
 
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		destroy_workqueue(hdev->cq_wq[i]);
@@ -771,16 +805,12 @@ int hl_device_resume(struct hl_device *hdev)
 	return rc;
 }
 
-static int device_kill_open_processes(struct hl_device *hdev)
+static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 {
-	u16 pending_total, pending_cnt;
 	struct hl_fpriv	*hpriv;
 	struct task_struct *task = NULL;
+	u32 pending_cnt;
 
-	if (hdev->pldm)
-		pending_total = HL_PLDM_PENDING_RESET_PER_SEC;
-	else
-		pending_total = HL_PENDING_RESET_PER_SEC;
 
 	/* Giving time for user to close FD, and for processes that are inside
 	 * hl_device_open to finish
@@ -788,6 +818,19 @@ static int device_kill_open_processes(struct hl_device *hdev)
 	if (!list_empty(&hdev->fpriv_list))
 		ssleep(1);
 
+	if (timeout) {
+		pending_cnt = timeout;
+	} else {
+		if (hdev->process_kill_trial_cnt) {
+			/* Processes have been already killed */
+			pending_cnt = 1;
+			goto wait_for_processes;
+		} else {
+			/* Wait a small period after process kill */
+			pending_cnt = HL_PENDING_RESET_PER_SEC;
+		}
+	}
+
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	/* This section must be protected because we are dereferencing
@@ -816,29 +859,27 @@ static int device_kill_open_processes(struct hl_device *hdev)
 	 * continuing with the reset.
 	 */
 
-	pending_cnt = pending_total;
-
+wait_for_processes:
 	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
-		dev_info(hdev->dev,
-			"Waiting for all user contexts to get closed before hard reset\n");
+		dev_dbg(hdev->dev,
+			"Waiting for all unmap operations to finish before hard reset\n");
 
 		pending_cnt--;
 
 		ssleep(1);
 	}
 
-	return list_empty(&hdev->fpriv_list) ? 0 : -EBUSY;
-}
+	/* All processes exited successfully */
+	if (list_empty(&hdev->fpriv_list))
+		return 0;
 
-static void device_hard_reset_pending(struct work_struct *work)
-{
-	struct hl_device_reset_work *device_reset_work =
-		container_of(work, struct hl_device_reset_work, reset_work);
-	struct hl_device *hdev = device_reset_work->hdev;
+	/* Give up waiting for processes to exit */
+	if (hdev->process_kill_trial_cnt == HL_PENDING_RESET_MAX_TRIALS)
+		return -ETIME;
 
-	hl_device_reset(hdev, true, true);
+	hdev->process_kill_trial_cnt++;
 
-	kfree(device_reset_work);
+	return -EBUSY;
 }
 
 /*
@@ -875,6 +916,10 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		hard_reset = true;
 	}
 
+	/* Re-entry of reset thread */
+	if (from_hard_reset_thread && hdev->process_kill_trial_cnt)
+		goto kill_processes;
+
 	/*
 	 * Prevent concurrency in this function - only one reset should be
 	 * done at any given time. Only need to perform this if we didn't
@@ -920,26 +965,17 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 
 again:
 	if ((hard_reset) && (!from_hard_reset_thread)) {
-		struct hl_device_reset_work *device_reset_work;
-
 		hdev->hard_reset_pending = true;
 
-		device_reset_work = kzalloc(sizeof(*device_reset_work),
-						GFP_ATOMIC);
-		if (!device_reset_work) {
-			rc = -ENOMEM;
-			goto out_err;
-		}
+		hdev->process_kill_trial_cnt = 0;
 
 		/*
 		 * Because the reset function can't run from interrupt or
 		 * from heartbeat work, we need to call the reset function
 		 * from a dedicated work
 		 */
-		INIT_WORK(&device_reset_work->reset_work,
-				device_hard_reset_pending);
-		device_reset_work->hdev = hdev;
-		schedule_work(&device_reset_work->reset_work);
+		queue_delayed_work(hdev->device_reset_work.wq,
+			&hdev->device_reset_work.reset_work, 0);
 
 		return 0;
 	}
@@ -965,12 +1001,25 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
 
+kill_processes:
 	if (hard_reset) {
 		/* Kill processes here after CS rollback. This is because the
 		 * process can't really exit until all its CSs are done, which
 		 * is what we do in cs rollback
 		 */
-		rc = device_kill_open_processes(hdev);
+		rc = device_kill_open_processes(hdev, 0);
+
+		if (rc == -EBUSY) {
+			if (hdev->device_fini_pending) {
+				dev_crit(hdev->dev,
+					"Failed to kill all open processes, stopping hard reset\n");
+				goto out_err;
+			}
+
+			/* signal reset thread to reschedule */
+			return rc;
+		}
+
 		if (rc) {
 			dev_crit(hdev->dev,
 				"Failed to kill all open processes, stopping hard reset\n");
@@ -1408,11 +1457,14 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
  */
 void hl_device_fini(struct hl_device *hdev)
 {
-	int i, rc;
 	ktime_t timeout;
+	int i, rc;
 
 	dev_info(hdev->dev, "Removing device\n");
 
+	hdev->device_fini_pending = 1;
+	flush_delayed_work(&hdev->device_reset_work.reset_work);
+
 	/*
 	 * This function is competing with the reset function, so try to
 	 * take the reset atomic and if we are already in middle of reset,
@@ -1468,7 +1520,11 @@ void hl_device_fini(struct hl_device *hdev)
 	 * can't really exit until all its CSs are done, which is what we
 	 * do in cs rollback
 	 */
-	rc = device_kill_open_processes(hdev);
+	dev_info(hdev->dev,
+		"Waiting for all processes to exit (timeout of %u seconds)",
+		HL_PENDING_RESET_LONG_SEC);
+
+	rc = device_kill_open_processes(hdev, HL_PENDING_RESET_LONG_SEC);
 	if (rc)
 		dev_crit(hdev->dev, "Failed to kill all open processes\n");
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eb968c30adb9..87060cd2c525 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -40,7 +40,9 @@
 #define HL_MMAP_OFFSET_VALUE_MASK	(0x3FFFFFFFFFFFull >> PAGE_SHIFT)
 #define HL_MMAP_OFFSET_VALUE_GET(off)	(off & HL_MMAP_OFFSET_VALUE_MASK)
 
-#define HL_PENDING_RESET_PER_SEC	30
+#define HL_PENDING_RESET_PER_SEC	10
+#define HL_PENDING_RESET_MAX_TRIALS	60 /* 10 minutes */
+#define HL_PENDING_RESET_LONG_SEC	60
 
 #define HL_HARD_RESET_MAX_TIMEOUT	120
 
@@ -1588,11 +1590,13 @@ struct hwmon_chip_info;
 
 /**
  * struct hl_device_reset_work - reset workqueue task wrapper.
+ * @wq: work queue for device reset procedure.
  * @reset_work: reset work to be done.
  * @hdev: habanalabs device structure.
  */
 struct hl_device_reset_work {
-	struct work_struct		reset_work;
+	struct workqueue_struct		*wq;
+	struct delayed_work		reset_work;
 	struct hl_device		*hdev;
 };
 
@@ -1691,6 +1695,7 @@ struct hl_mmu_funcs {
  * @dev_ctrl: related kernel device structure for the control device
  * @work_freq: delayed work to lower device frequency if possible.
  * @work_heartbeat: delayed work for CPU-CP is-alive check.
+ * @device_reset_work: delayed work which performs hard reset
  * @asic_name: ASIC specific name.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
@@ -1790,6 +1795,10 @@ struct hl_mmu_funcs {
  * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
  * @needs_reset: true if reset_on_lockup is false and device should be reset
  *               due to lockup.
+ * @process_kill_trial_cnt: number of trials reset thread tried killing
+ *                          user processes
+ * @device_fini_pending: true if device_fini was called and might be
+ *                       waiting for the reset thread to finish
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1802,6 +1811,7 @@ struct hl_device {
 	struct device			*dev_ctrl;
 	struct delayed_work		work_freq;
 	struct delayed_work		work_heartbeat;
+	struct hl_device_reset_work	device_reset_work;
 	char				asic_name[HL_STR_MAX];
 	char				status[HL_DEV_STS_MAX][HL_STR_MAX];
 	enum hl_asic_type		asic_type;
@@ -1894,6 +1904,8 @@ struct hl_device {
 	u8				supports_soft_reset;
 	u8				supports_cb_mapping;
 	u8				needs_reset;
+	u8				process_kill_trial_cnt;
+	u8				device_fini_pending;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
-- 
2.17.1

