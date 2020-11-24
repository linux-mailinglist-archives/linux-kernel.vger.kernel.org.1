Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C592C28AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbgKXNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:50:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8580 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbgKXNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:09 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CgQPH1JjrzLlf5;
        Tue, 24 Nov 2020 21:49:39 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Nov 2020
 21:49:59 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <jgg@ziepe.ca>, <stefanb@linux.ibm.com>, <nayna@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm: ibmvtpm: fix error return code in tpm_ibmvtpm_probe()
Date:   Tue, 24 Nov 2020 21:52:44 +0800
Message-ID: <20201124135244.31932-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 994385bf37c0..813eb2cac0ce 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -687,6 +687,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
 		dev_err(dev, "CRQ response timed out\n");
+		rc = -ETIMEDOUT;
 		goto init_irq_cleanup;
 	}
 
-- 
2.17.1

