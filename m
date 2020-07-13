Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BF21B05A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGJHl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 03:41:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbgGJHlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:41:35 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0EECBBAE6E8D9C94105;
        Fri, 10 Jul 2020 15:41:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 15:41:23 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] crypto: hisilicon/hpre - HPRE_OVERTIME_THRHLD can be written by debugfs
Date:   Fri, 10 Jul 2020 15:40:42 +0800
Message-ID: <1594366846-1313-3-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1594366846-1313-1-git-send-email-yumeng18@huawei.com>
References: <1594366846-1313-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Tang <tanghui20@huawei.com>

Registers in "hpre_dfx_files" can only be cleaned to zero but
HPRE_OVERTIME_THRHLD, which can be written as any number.

Fixes: 64a6301ebee7("crypto: hisilicon/hpre - add debugfs for ...")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 3131347..23f2e5c 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -548,13 +548,15 @@ static int hpre_debugfs_atomic64_get(void *data, u64 *val)
 static int hpre_debugfs_atomic64_set(void *data, u64 val)
 {
 	struct hpre_dfx *dfx_item = data;
-	struct hpre_dfx *hpre_dfx = dfx_item - HPRE_OVERTIME_THRHLD;
+	struct hpre_dfx *hpre_dfx = NULL;
 
-	if (val)
+	if (dfx_item->type == HPRE_OVERTIME_THRHLD) {
+		hpre_dfx = dfx_item - HPRE_OVERTIME_THRHLD;
+		atomic64_set(&hpre_dfx[HPRE_OVER_THRHLD_CNT].value, 0);
+	} else if (val) {
 		return -EINVAL;
+	}
 
-	if (dfx_item->type == HPRE_OVERTIME_THRHLD)
-		atomic64_set(&hpre_dfx[HPRE_OVER_THRHLD_CNT].value, 0);
 	atomic64_set(&dfx_item->value, val);
 
 	return 0;
-- 
2.8.1

