Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B843825C0B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgICMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 08:04:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728780AbgICL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:56:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E475A43671EBED340873;
        Thu,  3 Sep 2020 19:55:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 19:55:03 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 1/2] crypto: hisilicon/qm - fix wrong return type of 'pci_get_drvdata'
Date:   Thu, 3 Sep 2020 19:53:59 +0800
Message-ID: <1599134040-55860-2-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599134040-55860-1-git-send-email-qianweili@huawei.com>
References: <1599134040-55860-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shen <shenyang39@huawei.com>

The parameter type of 'pci_set_drvdata' is 'struct hisi_qm',
so here the return type of 'pci_get_drvdata' should be 'struct hisi_qm'
too.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 3 +--
 drivers/crypto/hisilicon/sec2/sec_main.c  | 3 +--
 drivers/crypto/hisilicon/zip/zip_main.c   | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 45741d2..4fd0a0a 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -900,8 +900,7 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void hpre_remove(struct pci_dev *pdev)
 {
-	struct hpre *hpre = pci_get_drvdata(pdev);
-	struct hisi_qm *qm = &hpre->qm;
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
 	int ret;
 
 	hisi_qm_wait_task_finish(qm, &hpre_devices);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index f912e57..6d4380b 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -915,8 +915,7 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void sec_remove(struct pci_dev *pdev)
 {
-	struct sec_dev *sec = pci_get_drvdata(pdev);
-	struct hisi_qm *qm = &sec->qm;
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
 
 	hisi_qm_wait_task_finish(qm, &sec_devices);
 	hisi_qm_alg_unregister(qm, &sec_devices);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 8bbae28..6641d39 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -846,8 +846,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void hisi_zip_remove(struct pci_dev *pdev)
 {
-	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
-	struct hisi_qm *qm = &hisi_zip->qm;
+	struct hisi_qm *qm = pci_get_drvdata(pdev);
 
 	hisi_qm_wait_task_finish(qm, &zip_devices);
 	hisi_qm_alg_unregister(qm, &zip_devices);
-- 
2.8.1

