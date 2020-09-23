Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235A427553A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIWKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:10:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgIWKKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:10:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E099DDF180A020A14AD3;
        Wed, 23 Sep 2020 18:10:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 18:10:38 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
CC:     Kai Ye <yekai13@huawei.com>
Subject: [PATCH v3 1/2] uacce: delete some redundant code.
Date:   Wed, 23 Sep 2020 18:09:21 +0800
Message-ID: <1600855762-10031-2-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
References: <1600855762-10031-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete some redundant code.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 107028e..9b83bc5 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -239,17 +239,6 @@ static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 
 	switch (type) {
 	case UACCE_QFRT_MMIO:
-		if (!uacce->ops->mmap) {
-			ret = -EINVAL;
-			goto out_with_lock;
-		}
-
-		ret = uacce->ops->mmap(q, vma, qfr);
-		if (ret)
-			goto out_with_lock;
-
-		break;
-
 	case UACCE_QFRT_DUS:
 		if (!uacce->ops->mmap) {
 			ret = -EINVAL;
-- 
2.8.1

