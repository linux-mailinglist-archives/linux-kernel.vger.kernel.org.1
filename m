Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160F92682A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 04:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINCae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 22:30:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbgINCab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 22:30:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 101E3F8A209C5E9FFA08;
        Mon, 14 Sep 2020 10:30:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 10:30:19 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>
CC:     Kai Ye <yekai13@huawei.com>
Subject: [PATCH] uacce: fix some coding styles
Date:   Mon, 14 Sep 2020 10:29:07 +0800
Message-ID: <1600050547-32577-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. delete some redundant code.
2. modify the module author information.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
Changes in V2:
	deleted extra NULL pointer check in uacce_fops.

 drivers/misc/uacce/uacce.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 107028e..1d09707 100644
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
@@ -541,5 +530,5 @@ subsys_initcall(uacce_init);
 module_exit(uacce_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
+MODULE_AUTHOR("HiSilicon Tech. Co., Ltd.");
 MODULE_DESCRIPTION("Accelerator interface for Userland applications");
-- 
2.8.1

