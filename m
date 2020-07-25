Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CDC22D556
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 08:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGYGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 02:09:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgGYGJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:09:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90B9B8DFA25E9798270F;
        Sat, 25 Jul 2020 14:09:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 14:09:20 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 1/4] crypto: hisilicon/zip - fix the uncleared debug registers
Date:   Sat, 25 Jul 2020 14:06:47 +0800
Message-ID: <1595657210-3964-2-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595657210-3964-1-git-send-email-shenyang39@huawei.com>
References: <1595657210-3964-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Fang <fanghao11@huawei.com>

ZIP debug registers aren't cleared even if its driver is removed,
so add a clearing operation when remove driver.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 8bbae28..cc4a829 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -91,6 +91,11 @@
 #define HZIP_SQE_MASK_OFFSET		64
 #define HZIP_SQE_MASK_LEN		48

+#define HZIP_CNT_CLR_CE_EN		BIT(0)
+#define HZIP_RO_CNT_CLR_CE_EN		BIT(2)
+#define HZIP_RD_CNT_CLR_CE_EN		(HZIP_CNT_CLR_CE_EN | \
+					 HZIP_RO_CNT_CLR_CE_EN)
+
 static const char hisi_zip_name[] = "hisi_zip";
 static struct dentry *hzip_debugfs_root;

@@ -606,10 +611,23 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 	return ret;
 }

+/* hisi_zip_debug_regs_clear() - clear the zip debug regs */
 static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 {
+	int i, j;
+
+	/* clear current_qm */
 	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
 	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	/* enable register read_clear bit */
+	writel(HZIP_RD_CNT_CLR_CE_EN, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
+	for (i = 0; i < ARRAY_SIZE(core_offsets); i++)
+		for (j = 0; j < ARRAY_SIZE(hzip_dfx_regs); j++)
+			readl(qm->io_base + core_offsets[i] +
+			      hzip_dfx_regs[j].offset);
+
+	/* disable register read_clear bit */
 	writel(0x0, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);

 	hisi_qm_debug_regs_clear(qm);
--
2.7.4

