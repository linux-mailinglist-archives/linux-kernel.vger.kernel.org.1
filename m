Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8ED2EA552
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbhAEGOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:14:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10021 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbhAEGOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:14:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D92HC6mTTzj3NQ;
        Tue,  5 Jan 2021 14:13:11 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 14:14:01 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/qm - SVA bugfixed on Kunpeng920
Date:   Tue, 5 Jan 2021 14:12:03 +0800
Message-ID: <1609827123-842-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunpeng920 SEC/HPRE/ZIP cannot support running user space SVA and kernel
Crypto at the same time. Therefore, the algorithms should not be registered
to Crypto as user space SVA is enabled.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f21ccae..10a04ab 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4004,6 +4004,9 @@ int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 {
 	int flag = 0;
 	int ret = 0;
+	/* HW V2 not support both use uacce sva mode and hardware crypto algs */
+	if (qm->ver <= QM_HW_V2 && qm->use_sva)
+		return 0;
 
 	mutex_lock(&qm_list->lock);
 	if (list_empty(&qm_list->list))
@@ -4035,6 +4038,9 @@ EXPORT_SYMBOL_GPL(hisi_qm_alg_register);
  */
 void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 {
+	if (qm->ver <= QM_HW_V2 && qm->use_sva)
+		return;
+
 	mutex_lock(&qm_list->lock);
 	list_del(&qm->list);
 	mutex_unlock(&qm_list->lock);
-- 
2.8.1

