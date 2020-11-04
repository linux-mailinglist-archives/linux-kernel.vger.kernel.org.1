Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4692A65E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgKDOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKDOJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:18 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B7721734;
        Wed,  4 Nov 2020 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498957;
        bh=IoANH0sgA1cy9XR6+wV4BeMA/lYXYAGO7EpcvPVt3ok=;
        h=From:To:Cc:Subject:Date:From;
        b=UC8TwkOppaMW4yQe6OxrCJkGv7cDou8tHfnyBlgOy0KMcoZGpyQCpTdlJ/55n2eFH
         PPnqz2DuzEnY7f8O5uIf4EZj+npEXZeUPoLmRl72mTcXsKbpBkZdRKQ3A/rDtSbo5J
         NWZGpbTc55cDWNxpz1u1vNlitC7ZeidLb9SkSyrc=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: add 'needs reset' state in driver
Date:   Wed,  4 Nov 2020 16:08:57 +0200
Message-Id: <20201104140908.10178-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

The new state indicates that device should be reset in order
to re-gain funcionality.
This unique state can occur if reset_on_lockup is disabled
and an actual lockup has occurred.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  5 +--
 .../habanalabs/common/command_submission.c    |  7 ++--
 drivers/misc/habanalabs/common/debugfs.c      |  6 ++--
 drivers/misc/habanalabs/common/device.c       | 33 ++++++++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h   | 14 ++++++--
 .../misc/habanalabs/common/habanalabs_drv.c   | 17 +++++++---
 .../misc/habanalabs/common/habanalabs_ioctl.c | 12 ++++---
 drivers/misc/habanalabs/common/hw_queue.c     |  6 ++--
 drivers/misc/habanalabs/common/hwmon.c        |  4 +--
 drivers/misc/habanalabs/common/memory.c       |  5 +--
 drivers/misc/habanalabs/common/sysfs.c        |  8 +++--
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c   |  8 ++---
 drivers/misc/habanalabs/goya/goya_hwmgr.c     | 28 ++++++++--------
 include/uapi/misc/habanalabs.h                |  3 +-
 14 files changed, 101 insertions(+), 55 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 1fb05bf02340..360dc340b2f4 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -380,13 +380,14 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cb_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
+	enum hl_device_status status;
 	u64 handle = 0;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is %s. Can't execute CB IOCTL\n",
-			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+			hdev->status[status]);
 		return -EBUSY;
 	}
 
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 662b19663839..ec014ef39484 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -427,6 +427,8 @@ static void cs_timedout(struct work_struct *work)
 
 	if (hdev->reset_on_lockup)
 		hl_device_reset(hdev, false, false);
+	else
+		hdev->needs_reset = true;
 }
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
@@ -689,12 +691,13 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
 	u32 cs_type_flags, num_chunks;
+	enum hl_device_status status;
 	enum hl_cs_type cs_type;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is %s. Can't submit new CS\n",
-			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+			hdev->status[status]);
 		return -EBUSY;
 	}
 
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index b44193ec3d12..104b9686e57b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -24,7 +24,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	struct cpucp_packet pkt;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -EBUSY;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -50,7 +50,7 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	struct cpucp_packet pkt;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -EBUSY;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -76,7 +76,7 @@ static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
 	struct cpucp_packet pkt;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return;
 
 	memset(&pkt, 0, sizeof(pkt));
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 3b82020648c7..59308a612b36 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -15,14 +15,6 @@
 
 #define HL_PLDM_PENDING_RESET_PER_SEC	(HL_PENDING_RESET_PER_SEC * 10)
 
-bool hl_device_disabled_or_in_reset(struct hl_device *hdev)
-{
-	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
-		return true;
-	else
-		return false;
-}
-
 enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
@@ -31,12 +23,34 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 		status = HL_DEVICE_STATUS_MALFUNCTION;
 	else if (atomic_read(&hdev->in_reset))
 		status = HL_DEVICE_STATUS_IN_RESET;
+	else if (hdev->needs_reset)
+		status = HL_DEVICE_STATUS_NEEDS_RESET;
 	else
 		status = HL_DEVICE_STATUS_OPERATIONAL;
 
 	return status;
 }
 
+bool hl_device_operational(struct hl_device *hdev,
+		enum hl_device_status *status)
+{
+	enum hl_device_status current_status;
+
+	current_status = hl_device_status(hdev);
+	if (status)
+		*status = current_status;
+
+	switch (current_status) {
+	case HL_DEVICE_STATUS_IN_RESET:
+	case HL_DEVICE_STATUS_MALFUNCTION:
+	case HL_DEVICE_STATUS_NEEDS_RESET:
+		return false;
+	case HL_DEVICE_STATUS_OPERATIONAL:
+	default:
+		return true;
+	}
+}
+
 static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
@@ -411,7 +425,7 @@ static void hl_device_heartbeat(struct work_struct *work)
 	struct hl_device *hdev = container_of(work, struct hl_device,
 						work_heartbeat.work);
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		goto reschedule;
 
 	if (!hdev->asic_funcs->send_heartbeat(hdev))
@@ -1091,6 +1105,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	}
 
 	atomic_set(&hdev->in_reset, 0);
+	hdev->needs_reset = false;
 
 	if (hard_reset)
 		hdev->hard_reset_cnt++;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2e3021adc824..05e53b5ffcfe 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1432,6 +1432,10 @@ struct hl_dbg_device_entry {
  * DEVICES
  */
 
+#define HL_STR_MAX	32
+
+#define HL_DEV_STS_MAX (HL_DEVICE_STATUS_NEEDS_RESET + 1)
+
 /* Theoretical limit only. A single host can only contain up to 4 or 8 PCIe
  * x16 cards. In extreme cases, there are hosts that can accommodate 16 cards.
  */
@@ -1706,6 +1710,7 @@ struct hl_mmu_funcs {
  * @hwmon_dev: H/W monitor device.
  * @pm_mng_profile: current power management profile.
  * @hl_chip_info: ASIC's sensors information.
+ * @device_status_description: device status description.
  * @hl_debugfs: device's debugfs manager.
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
@@ -1774,6 +1779,8 @@ struct hl_mmu_funcs {
  * @supports_coresight: is CoreSight supported.
  * @supports_soft_reset: is soft reset supported.
  * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
+ * @needs_reset: true if reset_on_lockup is false and device should be reset
+ *               due to lockup.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1786,7 +1793,8 @@ struct hl_device {
 	struct device			*dev_ctrl;
 	struct delayed_work		work_freq;
 	struct delayed_work		work_heartbeat;
-	char				asic_name[32];
+	char				asic_name[HL_STR_MAX];
+	char				status[HL_DEV_STS_MAX][HL_STR_MAX];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
 	struct workqueue_struct		**cq_wq;
@@ -1876,6 +1884,7 @@ struct hl_device {
 	u8				supports_coresight;
 	u8				supports_soft_reset;
 	u8				supports_cb_mapping;
+	u8				needs_reset;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -1978,7 +1987,8 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 
 int hl_device_open(struct inode *inode, struct file *filp);
 int hl_device_open_ctrl(struct inode *inode, struct file *filp);
-bool hl_device_disabled_or_in_reset(struct hl_device *hdev);
+bool hl_device_operational(struct hl_device *hdev,
+		enum hl_device_status *status);
 enum hl_device_status hl_device_status(struct hl_device *hdev);
 int hl_device_set_debug_mode(struct hl_device *hdev, bool enable);
 int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 20458bd82c5a..aac798f3296e 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -92,6 +92,7 @@ static enum hl_asic_type get_asic_type(u16 device)
  */
 int hl_device_open(struct inode *inode, struct file *filp)
 {
+	enum hl_device_status status;
 	struct hl_device *hdev;
 	struct hl_fpriv *hpriv;
 	int rc;
@@ -124,10 +125,10 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	mutex_lock(&hdev->fpriv_list_lock);
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		dev_err_ratelimited(hdev->dev,
-			"Can't open %s because it is disabled or in reset\n",
-			dev_name(hdev->dev));
+			"Can't open %s because it is %s\n",
+			dev_name(hdev->dev), hdev->status[status]);
 		rc = -EPERM;
 		goto out_err;
 	}
@@ -204,7 +205,7 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 	mutex_lock(&hdev->fpriv_list_lock);
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		dev_err_ratelimited(hdev->dev_ctrl,
 			"Can't open %s because it is disabled or in reset\n",
 			dev_name(hdev->dev_ctrl));
@@ -287,6 +288,14 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		hdev->asic_type = asic_type;
 	}
 
+	/* Assign status description string */
+	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION],
+					"disabled", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET],
+					"in reset", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET],
+					"needs reset", HL_STR_MAX);
+
 	hdev->major = hl_major;
 	hdev->reset_on_lockup = reset_on_lockup;
 	hdev->memory_scrub = memory_scrub;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 1d8bea626e78..0729cd43f297 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -406,8 +406,10 @@ static int total_energy_consumption_info(struct hl_fpriv *hpriv,
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
+	enum hl_device_status status;
 	struct hl_info_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
+
 	int rc;
 
 	/*
@@ -428,10 +430,10 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 		break;
 	}
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		dev_warn_ratelimited(dev,
 			"Device is %s. Can't execute INFO IOCTL\n",
-			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+			hdev->status[status]);
 		return -EBUSY;
 	}
 
@@ -501,12 +503,14 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_debug_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
+	enum hl_device_status status;
+
 	int rc = 0;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is %s. Can't execute DEBUG IOCTL\n",
-			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+			hdev->status[status]);
 		return -EBUSY;
 	}
 
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 84a7458f3363..606d27112dca 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -516,6 +516,7 @@ static void init_signal_wait_cs(struct hl_cs *cs)
  */
 int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 {
+	enum hl_device_status status;
 	struct hl_cs_counters_atomic *cntr;
 	struct hl_ctx *ctx = cs->ctx;
 	struct hl_device *hdev = ctx->hdev;
@@ -528,11 +529,10 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		atomic64_inc(&ctx->cs_counters.device_in_reset_drop_cnt);
-		atomic64_inc(&cntr->device_in_reset_drop_cnt);
 		dev_err(hdev->dev,
-			"device is disabled or in reset, CS rejected!\n");
+			"device is %s, CS rejected!\n", hdev->status[status]);
 		rc = -EPERM;
 		goto out;
 	}
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 892a5e2b0b9d..ab96401c3752 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -114,7 +114,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	switch (type) {
@@ -192,7 +192,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	switch (type) {
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 5c1dae6aaf4d..e00ad11dc5f7 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1237,6 +1237,7 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 
 int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 {
+	enum hl_device_status status;
 	union hl_mem_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
@@ -1244,10 +1245,10 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 	u32 handle = 0;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, &status)) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is %s. Can't execute MEMORY IOCTL\n",
-			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+			hdev->status[status]);
 		return -EBUSY;
 	}
 
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 3ceae87016b1..94ca68e62000 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -276,6 +276,8 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 		str = "In reset";
 	else if (hdev->disabled)
 		str = "Malfunction";
+	else if (hdev->needs_reset)
+		str = "Needs Reset";
 	else
 		str = "Operational";
 
@@ -304,7 +306,7 @@ static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long val;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	val = hl_get_max_power(hdev);
@@ -319,7 +321,7 @@ static ssize_t max_power_store(struct device *dev,
 	unsigned long value;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -347,7 +349,7 @@ static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
 	char *data;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	if (!max_size)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
index 1076b4932ce2..8c49da4bcbd5 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
@@ -20,7 +20,7 @@ int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 {
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, false);
@@ -54,7 +54,7 @@ static ssize_t clk_max_freq_mhz_show(struct device *dev,
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, false);
@@ -72,7 +72,7 @@ static ssize_t clk_max_freq_mhz_store(struct device *dev,
 	int rc;
 	u64 value;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -97,7 +97,7 @@ static ssize_t clk_cur_freq_mhz_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, true);
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index cdd4903e48fa..3acb36a1a902 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -36,7 +36,7 @@ int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 {
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, false);
@@ -69,7 +69,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, false);
@@ -88,7 +88,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -118,7 +118,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, TPC_PLL, false);
@@ -137,7 +137,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -167,7 +167,7 @@ static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, IC_PLL, false);
@@ -186,7 +186,7 @@ static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -216,7 +216,7 @@ static ssize_t mme_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, true);
@@ -233,7 +233,7 @@ static ssize_t tpc_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, TPC_PLL, true);
@@ -250,7 +250,7 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, IC_PLL, true);
@@ -266,7 +266,7 @@ static ssize_t pm_mng_profile_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	return sprintf(buf, "%s\n",
@@ -280,7 +280,7 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -335,7 +335,7 @@ static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hl_device_disabled_or_in_reset(hdev))
+	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	return sprintf(buf, "%u\n", hdev->high_pll);
@@ -348,7 +348,7 @@ static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
 	long value;
 	int rc;
 
-	if (hl_device_disabled_or_in_reset(hdev)) {
+	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
 		goto out;
 	}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 61f8f9144b54..d9cc782aba21 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -242,7 +242,8 @@ enum gaudi_engine_id {
 enum hl_device_status {
 	HL_DEVICE_STATUS_OPERATIONAL,
 	HL_DEVICE_STATUS_IN_RESET,
-	HL_DEVICE_STATUS_MALFUNCTION
+	HL_DEVICE_STATUS_MALFUNCTION,
+	HL_DEVICE_STATUS_NEEDS_RESET
 };
 
 /* Opcode for management ioctl
-- 
2.17.1

