Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0575329D794
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbgJ1WZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:25:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6984 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732968AbgJ1WZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:44 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CLhK8686pzhcj8;
        Wed, 28 Oct 2020 16:18:04 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 16:17:52 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] firmware: tegra: Use memdup_user() as a cleanup
Date:   Wed, 28 Oct 2020 16:29:51 +0800
Message-ID: <1603873791-106258-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning which recommends to use memdup_user().

This patch fixes the following coccicheck warning:

./drivers/firmware/tegra/bpmp-debugfs.c:335:11-18: WARNING opportunity for memdup_user

Fixes: 5e37b9c137ee ("firmware: tegra: Add support for in-band debug")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index c1bbba9..7234136 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -332,12 +332,9 @@ static ssize_t bpmp_debug_store(struct file *file, const char __user *buf,
 	if (!filename)
 		return -ENOENT;
 
-	databuf = kmalloc(count, GFP_KERNEL);
-	if (!databuf)
-		return -ENOMEM;
-
-	if (copy_from_user(databuf, buf, count)) {
-		err = -EFAULT;
+	databuf = memdup_user(buf, count);
+	if (IS_ERR(databuf)) {
+		err = PTR_ERR(databuf);
 		goto free_ret;
 	}
 
-- 
2.6.2

