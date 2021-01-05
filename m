Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA52EA55A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhAEGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:19:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9668 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEGTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:19:30 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D92Nd2sywz15pCp;
        Tue,  5 Jan 2021 14:17:53 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 14:18:43 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] crypto: hisilicon/hpre - register HPRE device to uacce
Date:   Tue, 5 Jan 2021 14:16:43 +0800
Message-ID: <1609827404-6024-3-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1609827404-6024-1-git-send-email-yekai13@huawei.com>
References: <1609827404-6024-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register HPRE device to uacce framework for user space.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index e5c9919..ad8b691 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/topology.h>
+#include <linux/uacce.h>
 #include "hpre.h"
 
 #define HPRE_QUEUE_NUM_V2		1024
@@ -178,6 +179,19 @@ static const char *hpre_dfx_files[HPRE_DFX_FILE_NUM] = {
 	"invalid_req_cnt"
 };
 
+static const struct kernel_param_ops hpre_uacce_mode_ops = {
+	.set = uacce_mode_set,
+	.get = param_get_int,
+};
+
+/*
+ * uacce_mode = 0 means hpre only register to crypto,
+ * uacce_mode = 1 means hpre both register to crypto and uacce.
+ */
+static u32 uacce_mode = UACCE_MODE_NOUACCE;
+module_param_cb(uacce_mode, &hpre_uacce_mode_ops, &uacce_mode, 0444);
+MODULE_PARM_DESC(uacce_mode, UACCE_MODE_DESC);
+
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
 	return q_num_set(val, kp, HPRE_PCI_DEVICE_ID);
@@ -214,6 +228,30 @@ struct hisi_qp *hpre_create_qp(void)
 	return NULL;
 }
 
+static void hpre_pasid_enable(struct hisi_qm *qm)
+{
+	u32 val;
+
+	val = readl_relaxed(qm->io_base + HPRE_DATA_RUSER_CFG);
+	val |= BIT(HPRE_PASID_EN_BIT);
+	writel_relaxed(val, qm->io_base + HPRE_DATA_RUSER_CFG);
+	val = readl_relaxed(qm->io_base + HPRE_DATA_WUSER_CFG);
+	val |= BIT(HPRE_PASID_EN_BIT);
+	writel_relaxed(val, qm->io_base + HPRE_DATA_WUSER_CFG);
+}
+
+static void hpre_pasid_disable(struct hisi_qm *qm)
+{
+	u32 val;
+
+	val = readl_relaxed(qm->io_base +  HPRE_DATA_RUSER_CFG);
+	val &= ~BIT(HPRE_PASID_EN_BIT);
+	writel_relaxed(val, qm->io_base + HPRE_DATA_RUSER_CFG);
+	val = readl_relaxed(qm->io_base + HPRE_DATA_WUSER_CFG);
+	val &= ~BIT(HPRE_PASID_EN_BIT);
+	writel_relaxed(val, qm->io_base + HPRE_DATA_WUSER_CFG);
+}
+
 static int hpre_cfg_by_dsm(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -279,6 +317,10 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 	writel(0x0, HPRE_ADDR(qm, HPRE_COMM_CNT_CLR_CE));
 	writel(0x0, HPRE_ADDR(qm, HPRE_ECC_BYPASS));
 
+	/* Enable data buffer pasid */
+	if (qm->use_sva)
+		hpre_pasid_enable(qm);
+
 	writel(HPRE_BD_USR_MASK, HPRE_ADDR(qm, HPRE_BD_ARUSR_CFG));
 	writel(HPRE_BD_USR_MASK, HPRE_ADDR(qm, HPRE_BD_AWUSR_CFG));
 	writel(0x1, HPRE_ADDR(qm, HPRE_RDCHN_INI_CFG));
@@ -734,6 +776,8 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return -EINVAL;
 	}
 
+	qm->algs = "rsa\ndh\n";
+	qm->mode = uacce_mode;
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
 	qm->sqe_size = HPRE_SQE_SIZE;
@@ -872,6 +916,14 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_with_qm_start;
 	}
 
+	if (qm->uacce) {
+		ret = uacce_register(qm->uacce);
+		if (ret) {
+			pci_err(pdev, "failed to register uacce (%d)!\n", ret);
+			goto err_with_alg_register;
+		}
+	}
+
 	if (qm->fun_type == QM_HW_PF && vfs_num) {
 		ret = hisi_qm_sriov_enable(pdev, vfs_num);
 		if (ret < 0)
@@ -911,6 +963,8 @@ static void hpre_remove(struct pci_dev *pdev)
 		}
 	}
 	if (qm->fun_type == QM_HW_PF) {
+		if (qm->use_sva)
+			hpre_pasid_disable(qm);
 		hpre_cnt_regs_clear(qm);
 		qm->debug.curr_qm_qp_num = 0;
 	}
-- 
2.8.1

