Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3332824553D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgHPBoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 21:44:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728876AbgHPBoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:44:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01BA5F221DE06C3C19EF;
        Sat, 15 Aug 2020 17:58:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 15 Aug 2020 17:58:24 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v5 06/10] crypto: hisilicon/qm - fix no stop reason when use 'hisi_qm_stop'
Date:   Sat, 15 Aug 2020 17:56:13 +0800
Message-ID: <1597485377-2678-7-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597485377-2678-1-git-send-email-shenyang39@huawei.com>
References: <1597485377-2678-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, there are three reasons of stopping: 'NORMAL', 'SOFT_RESET' and 'FLR'.
In order to keep this, explicitly pass the stop reason as an input
parameter of 'hisi_qm_stop' function.

Fixes: b67202e8ed30("crypto: hisilicon/qm - add state machine for QM")
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c |  4 ++--
 drivers/crypto/hisilicon/qm.c             | 20 ++++++++++----------
 drivers/crypto/hisilicon/qm.h             |  2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  |  4 ++--
 drivers/crypto/hisilicon/zip/zip_main.c   |  4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index b135c74..b9e5214 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -886,7 +886,7 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_with_qm_start:
 	hisi_qm_del_from_list(qm, &hpre_devices);
 	hpre_debugfs_exit(qm);
-	hisi_qm_stop(qm);
+	hisi_qm_stop(qm, QM_NORMAL);
 
 err_with_err_init:
 	hisi_qm_dev_err_uninit(qm);
@@ -918,7 +918,7 @@ static void hpre_remove(struct pci_dev *pdev)
 	}
 
 	hpre_debugfs_exit(qm);
-	hisi_qm_stop(qm);
+	hisi_qm_stop(qm, QM_NORMAL);
 	hisi_qm_dev_err_uninit(qm);
 	hisi_qm_uninit(qm);
 }
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 791a469..6d233b4 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2643,18 +2643,20 @@ static void qm_clear_queues(struct hisi_qm *qm)
 /**
  * hisi_qm_stop() - Stop a qm.
  * @qm: The qm which will be stopped.
+ * @r: The reason to stop qm.
  *
  * This function stops qm and its qps, then qm can not accept request.
  * Related resources are not released at this state, we can use hisi_qm_start
  * to let qm start again.
  */
-int hisi_qm_stop(struct hisi_qm *qm)
+int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 {
 	struct device *dev = &qm->pdev->dev;
 	int ret = 0;
 
 	down_write(&qm->qps_lock);
 
+	qm->status.stop_reason = r;
 	if (!qm_avail_state(qm, QM_STOP)) {
 		ret = -EPERM;
 		goto err_unlock;
@@ -3300,10 +3302,10 @@ static int qm_set_msi(struct hisi_qm *qm, bool set)
 	return 0;
 }
 
-static int qm_vf_reset_prepare(struct hisi_qm *qm)
+static int qm_vf_reset_prepare(struct hisi_qm *qm,
+			       enum qm_stop_reason stop_reason)
 {
 	struct hisi_qm_list *qm_list = qm->qm_list;
-	int stop_reason = qm->status.stop_reason;
 	struct pci_dev *pdev = qm->pdev;
 	struct pci_dev *virtfn;
 	struct hisi_qm *vf_qm;
@@ -3316,8 +3318,7 @@ static int qm_vf_reset_prepare(struct hisi_qm *qm)
 			continue;
 
 		if (pci_physfn(virtfn) == pdev) {
-			vf_qm->status.stop_reason = stop_reason;
-			ret = hisi_qm_stop(vf_qm);
+			ret = hisi_qm_stop(vf_qm, stop_reason);
 			if (ret)
 				goto stop_fail;
 		}
@@ -3356,15 +3357,14 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 	}
 
 	if (qm->vfs_num) {
-		ret = qm_vf_reset_prepare(qm);
+		ret = qm_vf_reset_prepare(qm, QM_SOFT_RESET);
 		if (ret) {
 			pci_err(pdev, "Fails to stop VFs!\n");
 			return ret;
 		}
 	}
 
-	qm->status.stop_reason = QM_SOFT_RESET;
-	ret = hisi_qm_stop(qm);
+	ret = hisi_qm_stop(qm, QM_SOFT_RESET);
 	if (ret) {
 		pci_err(pdev, "Fails to stop QM!\n");
 		return ret;
@@ -3705,7 +3705,7 @@ void hisi_qm_reset_prepare(struct pci_dev *pdev)
 	}
 
 	if (qm->vfs_num) {
-		ret = qm_vf_reset_prepare(qm);
+		ret = qm_vf_reset_prepare(qm, QM_FLR);
 		if (ret) {
 			pci_err(pdev, "Failed to prepare reset, ret = %d.\n",
 				ret);
@@ -3713,7 +3713,7 @@ void hisi_qm_reset_prepare(struct pci_dev *pdev)
 		}
 	}
 
-	ret = hisi_qm_stop(qm);
+	ret = hisi_qm_stop(qm, QM_FLR);
 	if (ret) {
 		pci_err(pdev, "Failed to stop QM, ret = %d.\n", ret);
 		return;
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 6c1d3c7..9d6cf1d 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -355,7 +355,7 @@ static inline void hisi_qm_del_from_list(struct hisi_qm *qm,
 int hisi_qm_init(struct hisi_qm *qm);
 void hisi_qm_uninit(struct hisi_qm *qm);
 int hisi_qm_start(struct hisi_qm *qm);
-int hisi_qm_stop(struct hisi_qm *qm);
+int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r);
 struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type);
 int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
 int hisi_qm_stop_qp(struct hisi_qp *qp);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 2297425..5f1c870 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -901,7 +901,7 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_remove_from_list:
 	hisi_qm_del_from_list(qm, &sec_devices);
 	sec_debugfs_exit(qm);
-	hisi_qm_stop(qm);
+	hisi_qm_stop(qm, QM_NORMAL);
 
 err_probe_uninit:
 	sec_probe_uninit(qm);
@@ -926,7 +926,7 @@ static void sec_remove(struct pci_dev *pdev)
 
 	sec_debugfs_exit(qm);
 
-	(void)hisi_qm_stop(qm);
+	(void)hisi_qm_stop(qm, QM_NORMAL);
 
 	if (qm->fun_type == QM_HW_PF)
 		sec_debug_regs_clear(qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index e2845b2..224041e 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -828,7 +828,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_remove_from_list:
 	hisi_qm_del_from_list(qm, &zip_devices);
 	hisi_zip_debugfs_exit(hisi_zip);
-	hisi_qm_stop(qm);
+	hisi_qm_stop(qm, QM_NORMAL);
 err_qm_uninit:
 	hisi_qm_uninit(qm);
 
@@ -844,7 +844,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 		hisi_qm_sriov_disable(pdev);
 
 	hisi_zip_debugfs_exit(hisi_zip);
-	hisi_qm_stop(qm);
+	hisi_qm_stop(qm, QM_NORMAL);
 
 	hisi_qm_dev_err_uninit(qm);
 	hisi_qm_uninit(qm);
-- 
2.7.4

