Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B022D46C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGYDrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 23:47:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8811 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726706AbgGYDqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:46:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D660E7B2DC9965C47A28;
        Sat, 25 Jul 2020 11:46:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 11:46:40 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 03/10] crypto: hisilicon/zip - modify debugfs interface parameters
Date:   Sat, 25 Jul 2020 11:44:36 +0800
Message-ID: <1595648683-50590-4-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
References: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shukun Tan <tanshukun1@huawei.com>

Update debugfs interface parameters

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 55 ++++++++++++++-------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 058f744..df1a16f 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -156,7 +156,6 @@ struct ctrl_debug_file {
  */
 struct hisi_zip_ctrl {
 	struct hisi_zip *hisi_zip;
-	struct dentry *debug_root;
 	struct ctrl_debug_file files[HZIP_DEBUG_FILE_NUM];
 };

@@ -509,10 +508,8 @@ static int zip_debugfs_atomic64_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(zip_atomic64_ops, zip_debugfs_atomic64_get,
 			 zip_debugfs_atomic64_set, "%llu\n");

-static int hisi_zip_core_debug_init(struct hisi_zip_ctrl *ctrl)
+static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 {
-	struct hisi_zip *hisi_zip = ctrl->hisi_zip;
-	struct hisi_qm *qm = &hisi_zip->qm;
 	struct device *dev = &qm->pdev->dev;
 	struct debugfs_regset32 *regset;
 	struct dentry *tmp_d;
@@ -533,7 +530,7 @@ static int hisi_zip_core_debug_init(struct hisi_zip_ctrl *ctrl)
 		regset->nregs = ARRAY_SIZE(hzip_dfx_regs);
 		regset->base = qm->io_base + core_offsets[i];

-		tmp_d = debugfs_create_dir(buf, ctrl->debug_root);
+		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
 		debugfs_create_regset32("regs", 0444, tmp_d, regset);
 	}

@@ -552,33 +549,32 @@ static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 	for (i = 0; i < ARRAY_SIZE(zip_dfx_files); i++) {
 		data = (atomic64_t *)((uintptr_t)dfx + zip_dfx_files[i].offset);
 		debugfs_create_file(zip_dfx_files[i].name,
-			0644,
-			tmp_dir,
-			data,
-			&zip_atomic64_ops);
+				    0644, tmp_dir, data,
+				    &zip_atomic64_ops);
 	}
 }

-static int hisi_zip_ctrl_debug_init(struct hisi_zip_ctrl *ctrl)
+static int hisi_zip_ctrl_debug_init(struct hisi_qm *qm)
 {
+	struct hisi_zip *zip = container_of(qm, struct hisi_zip, qm);
 	int i;

 	for (i = HZIP_CURRENT_QM; i < HZIP_DEBUG_FILE_NUM; i++) {
-		spin_lock_init(&ctrl->files[i].lock);
-		ctrl->files[i].ctrl = ctrl;
-		ctrl->files[i].index = i;
+		spin_lock_init(&zip->ctrl->files[i].lock);
+		zip->ctrl->files[i].ctrl = zip->ctrl;
+		zip->ctrl->files[i].index = i;

 		debugfs_create_file(ctrl_debug_file_name[i], 0600,
-				    ctrl->debug_root, ctrl->files + i,
+				    qm->debug.debug_root,
+				    zip->ctrl->files + i,
 				    &ctrl_debug_fops);
 	}

-	return hisi_zip_core_debug_init(ctrl);
+	return hisi_zip_core_debug_init(qm);
 }

-static int hisi_zip_debugfs_init(struct hisi_zip *hisi_zip)
+static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = &hisi_zip->qm;
 	struct device *dev = &qm->pdev->dev;
 	struct dentry *dev_d;
 	int ret;
@@ -593,8 +589,7 @@ static int hisi_zip_debugfs_init(struct hisi_zip *hisi_zip)
 		goto failed_to_create;

 	if (qm->fun_type == QM_HW_PF) {
-		hisi_zip->ctrl->debug_root = dev_d;
-		ret = hisi_zip_ctrl_debug_init(hisi_zip->ctrl);
+		ret = hisi_zip_ctrl_debug_init(qm);
 		if (ret)
 			goto failed_to_create;
 	}
@@ -608,10 +603,8 @@ static int hisi_zip_debugfs_init(struct hisi_zip *hisi_zip)
 	return ret;
 }

-static void hisi_zip_debug_regs_clear(struct hisi_zip *hisi_zip)
+static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = &hisi_zip->qm;
-
 	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
 	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
 	writel(0x0, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
@@ -619,14 +612,14 @@ static void hisi_zip_debug_regs_clear(struct hisi_zip *hisi_zip)
 	hisi_qm_debug_regs_clear(qm);
 }

-static void hisi_zip_debugfs_exit(struct hisi_zip *hisi_zip)
+static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = &hisi_zip->qm;
-
 	debugfs_remove_recursive(qm->debug.debug_root);

-	if (qm->fun_type == QM_HW_PF)
-		hisi_zip_debug_regs_clear(hisi_zip);
+	if (qm->fun_type == QM_HW_PF) {
+		hisi_zip_debug_regs_clear(qm);
+		qm->debug.curr_qm_qp_num = 0;
+	}
 }

 static void hisi_zip_log_hw_error(struct hisi_qm *qm, u32 err_sts)
@@ -733,7 +726,7 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)

 	hisi_zip_set_user_domain_and_cache(qm);
 	hisi_qm_dev_err_init(qm);
-	hisi_zip_debug_regs_clear(hisi_zip);
+	hisi_zip_debug_regs_clear(qm);

 	return 0;
 }
@@ -809,7 +802,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_dev_err_uninit;

-	ret = hisi_zip_debugfs_init(hisi_zip);
+	ret = hisi_zip_debugfs_init(qm);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to init debugfs (%d)!\n", ret);

@@ -837,7 +830,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hisi_qm_alg_unregister(qm, &zip_devices);

 err_qm_stop:
-	hisi_zip_debugfs_exit(hisi_zip);
+	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);

 err_dev_err_uninit:
@@ -860,7 +853,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 	if (qm->fun_type == QM_HW_PF && qm->vfs_num)
 		hisi_qm_sriov_disable(pdev, qm->is_frozen);

-	hisi_zip_debugfs_exit(hisi_zip);
+	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 	hisi_qm_dev_err_uninit(qm);
 	hisi_qm_uninit(qm);
--
2.7.4

