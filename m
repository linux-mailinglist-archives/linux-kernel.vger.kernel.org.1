Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E62A1474
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgJaJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:09:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:7389 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgJaJI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:08:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CNYJH0YPyz70vS;
        Sat, 31 Oct 2020 17:08:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 17:08:35 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 5/8] crypto: hisilicon/qm - replace 'sprintf' with 'scnprintf'
Date:   Sat, 31 Oct 2020 17:07:05 +0800
Message-ID: <1604135228-18410-6-git-send-email-qianweili@huawei.com>
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

Replace 'sprintf' with 'scnprintf' to avoid overrun.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 17f84db..25c5414 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -932,7 +932,8 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 		return -EINVAL;
 	}
 	mutex_unlock(&file->lock);
-	ret = sprintf(tbuf, "%u\n", val);
+
+	ret = scnprintf(tbuf, QM_DBG_TMP_BUF_LEN, "%u\n", val);
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
 }
 
-- 
2.8.1

