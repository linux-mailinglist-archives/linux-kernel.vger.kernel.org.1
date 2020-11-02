Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549072A2736
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKBJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:41:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6732 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgKBJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:41:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPnwR5H9JzkdXh;
        Mon,  2 Nov 2020 17:40:55 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 17:40:51 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <gregkh@linuxfoundation.org>, <zhangfei.gao@linaro.org>
Subject: [RESEND PATCH v3 2/2] uacce: modify the module author information.
Date:   Mon, 2 Nov 2020 17:39:25 +0800
Message-ID: <1604309965-21752-3-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604309965-21752-1-git-send-email-yekai13@huawei.com>
References: <1604309965-21752-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spelling of "Hisilicon" is modified.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index eb827f1..d07af4e 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -522,5 +522,5 @@ subsys_initcall(uacce_init);
 module_exit(uacce_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
+MODULE_AUTHOR("HiSilicon Tech. Co., Ltd.");
 MODULE_DESCRIPTION("Accelerator interface for Userland applications");
-- 
2.8.1

