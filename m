Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38662A1481
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJaJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:09:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7019 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgJaJIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:08:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNYJ951GTzhcdf;
        Sat, 31 Oct 2020 17:08:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 17:08:34 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 4/8] crypto: hisilicon/qm - modify return type of 'qm_set_sqctype'
Date:   Sat, 31 Oct 2020 17:07:04 +0800
Message-ID: <1604135228-18410-5-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604135228-18410-1-git-send-email-qianweili@huawei.com>
References: <1604135228-18410-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'qm_set_sqctype' always returns 0, change it as 'void'.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 627479f..17f84db 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2118,7 +2118,7 @@ static void hisi_qm_uacce_stop_queue(struct uacce_queue *q)
 	hisi_qm_stop_qp(q->priv);
 }
 
-static int qm_set_sqctype(struct uacce_queue *q, u16 type)
+static void qm_set_sqctype(struct uacce_queue *q, u16 type)
 {
 	struct hisi_qm *qm = q->uacce->priv;
 	struct hisi_qp *qp = q->priv;
@@ -2126,8 +2126,6 @@ static int qm_set_sqctype(struct uacce_queue *q, u16 type)
 	down_write(&qm->qps_lock);
 	qp->alg_type = type;
 	up_write(&qm->qps_lock);
-
-	return 0;
 }
 
 static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
-- 
2.8.1

