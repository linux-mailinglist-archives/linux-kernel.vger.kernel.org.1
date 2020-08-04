Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC023BBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgHDOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:04:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbgHDOAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:00:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BA712F1DC4162C8526D;
        Tue,  4 Aug 2020 22:00:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 4 Aug 2020 22:00:32 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v4 09/10] crypto: hisilicon/qm - fix the call trace when unbind device
Date:   Tue, 4 Aug 2020 21:58:29 +0800
Message-ID: <1596549510-2373-10-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596549510-2373-1-git-send-email-shenyang39@huawei.com>
References: <1596549510-2373-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weili Qian <qianweili@huawei.com>

Call trace will appear in the Hisilicon crypto driver unbinding or
disabling SRIOV during task running with TFMs on the corresponding
function.
The log looks like this:
	[  293.908078] Call trace:
	[  293.908080]  __queue_work+0x494/0x548
	[  293.908081]  queue_work_on+0x84/0xd8
	[  293.908092]  qm_irq+0x4c/0xd0 [hisi_qm]
	[  293.908096]  __handle_irq_event_percpu+0x74/0x2a0
	[  293.908098]  handle_irq_event_percpu+0x40/0x98
	[  293.908099]  handle_irq_event+0x4c/0x80
	[  293.908101]  handle_fasteoi_irq+0xb0/0x170
	[  293.908102]  generic_handle_irq+0x3c/0x58
	[  293.908103]  __handle_domain_irq+0x68/0xc0
	[  293.908104]  gic_handle_irq+0xb4/0x298
	[  293.908105]  el1_irq+0xcc/0x180
	[  293.908107]  arch_cpu_idle+0x38/0x228
	[  293.908110]  default_idle_call+0x20/0x40
	[  293.908113]  do_idle+0x1cc/0x2b8
	[  293.908114]  cpu_startup_entry+0x2c/0x30
	[  293.908115]  rest_init+0xdc/0xe8
	[  293.908117]  arch_call_rest_init+0x14/0x1c
	[  293.908117]  start_kernel+0x490/0x4c4

This patch adds a waiting logic as user doing the above two
operations to avoid panic. The two operations will hold on in the driver
remove function until the tasks release all their relative TFMs.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  3 +-
 drivers/crypto/hisilicon/qm.c             | 95 +++++++++++++++++++++++++++++--
 drivers/crypto/hisilicon/qm.h             |  4 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  |  3 +-
 drivers/crypto/hisilicon/zip/zip_main.c   |  3 +-
 5 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index bbf3efb..fc06770 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -903,10 +903,11 @@ static void hpre_remove(struct pci_dev *pdev)
 	struct hisi_qm *qm = &hpre->qm;
 	int ret;

+	hisi_qm_wait_task_finish(qm, &hpre_devices);
 	hpre_algs_unregister();
 	hisi_qm_del_from_list(qm, &hpre_devices);
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num) {
-		ret = hisi_qm_sriov_disable(pdev);
+		ret = hisi_qm_sriov_disable(pdev, qm->is_frozen);
 		if (ret) {
 			pci_err(pdev, "Disable SRIOV fail!\n");
 			return;
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 03393dd..9ee973a 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -180,6 +180,8 @@
 #define QM_DBG_TMP_BUF_LEN		22
 #define QM_PCI_COMMAND_INVALID		~0

+#define WAIT_PERIOD			20
+#define REMOVE_WAIT_DELAY		10
 #define QM_SQE_ADDR_MASK		GENMASK(7, 0)
 #define QM_EQ_DEPTH			(1024 * 2)

@@ -2224,6 +2226,82 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 }

 /**
+ * qm_frozen() - Try to froze QM to cut continuous queue request. If
+ * there is user on the QM, return failure without doing anything.
+ * @qm: The qm needed to be fronzen.
+ *
+ * This function frozes QM, then we can do SRIOV disabling.
+ */
+static int qm_frozen(struct hisi_qm *qm)
+{
+	down_write(&qm->qps_lock);
+
+	if (qm->is_frozen) {
+		up_write(&qm->qps_lock);
+		return 0;
+	}
+
+	if (!qm->qp_in_used) {
+		qm->qp_in_used = qm->qp_num;
+		qm->is_frozen = true;
+		up_write(&qm->qps_lock);
+		return 0;
+	}
+
+	up_write(&qm->qps_lock);
+
+	return -EBUSY;
+}
+
+static int qm_try_frozen_vfs(struct pci_dev *pdev,
+			     struct hisi_qm_list *qm_list)
+{
+	struct hisi_qm *qm, *vf_qm;
+	struct pci_dev *dev;
+	int ret = 0;
+
+	if (!qm_list || !pdev)
+		return -EINVAL;
+
+	/* Try to frozen all the VFs as disable SRIOV */
+	mutex_lock(&qm_list->lock);
+	list_for_each_entry(qm, &qm_list->list, list) {
+		dev = qm->pdev;
+		if (dev == pdev)
+			continue;
+		if (pci_physfn(dev) == pdev) {
+			vf_qm = pci_get_drvdata(dev);
+			ret = qm_frozen(vf_qm);
+			if (ret)
+				goto frozen_fail;
+		}
+	}
+
+frozen_fail:
+	mutex_unlock(&qm_list->lock);
+
+	return ret;
+}
+
+/**
+ * hisi_qm_wait_task_finish() - Wait until the task is finished
+ * when removing the driver.
+ * @qm: The qm needed to wait for the task to finish.
+ * @qm_list: The list of all available devices.
+ */
+void hisi_qm_wait_task_finish(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
+{
+	while (qm_frozen(qm) ||
+	       ((qm->fun_type == QM_HW_PF) &&
+	       qm_try_frozen_vfs(qm->pdev, qm_list))) {
+		msleep(WAIT_PERIOD);
+	}
+
+	udelay(REMOVE_WAIT_DELAY);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_wait_task_finish);
+
+/**
  * hisi_qm_get_free_qp_num() - Get free number of qp in qm.
  * @qm: The qm which want to get free qp.
  *
@@ -2347,6 +2425,7 @@ static void hisi_qm_pre_init(struct hisi_qm *qm)
 	mutex_init(&qm->mailbox_lock);
 	init_rwsem(&qm->qps_lock);
 	qm->qp_in_used = 0;
+	qm->is_frozen = false;
 }

 /**
@@ -3092,11 +3171,12 @@ EXPORT_SYMBOL_GPL(hisi_qm_sriov_enable);

 /**
  * hisi_qm_sriov_disable - disable virtual functions
- * @pdev: the PCI device
+ * @pdev: the PCI device.
+ * @is_frozen: true when all the VFs are frozen.
  *
- * Return failure if there are VFs assigned already.
+ * Return failure if there are VFs assigned already or VF is in used.
  */
-int hisi_qm_sriov_disable(struct pci_dev *pdev)
+int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);

@@ -3105,7 +3185,12 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev)
 		return -EPERM;
 	}

-	/* remove in hpre_pci_driver will be called to free VF resources */
+	/* While VF is in used, SRIOV cannot be disabled. */
+	if (!is_frozen && qm_try_frozen_vfs(pdev, qm->qm_list)) {
+		pci_err(pdev, "Task is using its VF!\n");
+		return -EBUSY;
+	}
+
 	pci_disable_sriov(pdev);
 	return qm_clear_vft_config(qm);
 }
@@ -3121,7 +3206,7 @@ EXPORT_SYMBOL_GPL(hisi_qm_sriov_disable);
 int hisi_qm_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	if (num_vfs == 0)
-		return hisi_qm_sriov_disable(pdev);
+		return hisi_qm_sriov_disable(pdev, 0);
 	else
 		return hisi_qm_sriov_enable(pdev, num_vfs);
 }
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 5fc44cb..5c07cfe 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -243,6 +243,7 @@ struct hisi_qm {

 	const char *algs;
 	bool use_sva;
+	bool is_frozen;
 	resource_size_t phys_base;
 	resource_size_t phys_size;
 	struct uacce_device *uacce;
@@ -367,7 +368,7 @@ int hisi_qm_debug_init(struct hisi_qm *qm);
 enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
 int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs);
-int hisi_qm_sriov_disable(struct pci_dev *pdev);
+int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen);
 int hisi_qm_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void hisi_qm_dev_err_init(struct hisi_qm *qm);
 void hisi_qm_dev_err_uninit(struct hisi_qm *qm);
@@ -391,4 +392,5 @@ int hisi_qm_alloc_qps_node(struct hisi_qm_list *qm_list, int qp_num,
 			   u8 alg_type, int node, struct hisi_qp **qps);
 void hisi_qm_free_qps(struct hisi_qp **qps, int qp_num);
 void hisi_qm_dev_shutdown(struct pci_dev *pdev);
+void hisi_qm_wait_task_finish(struct hisi_qm *qm, struct hisi_qm_list *qm_list);
 #endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 8b388c4..629344c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -917,12 +917,13 @@ static void sec_remove(struct pci_dev *pdev)
 	struct sec_dev *sec = pci_get_drvdata(pdev);
 	struct hisi_qm *qm = &sec->qm;

+	hisi_qm_wait_task_finish(qm, &sec_devices);
 	sec_unregister_from_crypto();

 	hisi_qm_del_from_list(qm, &sec_devices);

 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
-		hisi_qm_sriov_disable(pdev);
+		hisi_qm_sriov_disable(pdev, qm->is_frozen);

 	sec_debugfs_exit(qm);

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 10d2108..f13e520 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -840,8 +840,9 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
 	struct hisi_qm *qm = &hisi_zip->qm;

+	hisi_qm_wait_task_finish(qm, &zip_devices);
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
-		hisi_qm_sriov_disable(pdev);
+		hisi_qm_sriov_disable(pdev, qm->is_frozen);

 	hisi_zip_debugfs_exit(hisi_zip);
 	hisi_qm_stop(qm, QM_NORMAL);
--
2.7.4

