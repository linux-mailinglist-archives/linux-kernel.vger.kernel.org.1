Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56B0211A27
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 04:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgGBCcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 22:32:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbgGBCcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:32:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D26CEBA337C83BDB7DF1;
        Thu,  2 Jul 2020 10:31:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 10:31:52 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] crypto: hisilicon/hpre - HPRE_OVERTIME_THRHLD can be written by debugfs
Date:   Thu, 2 Jul 2020 10:31:15 +0800
Message-ID: <1593657079-31990-3-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1593657079-31990-1-git-send-email-yumeng18@huawei.com>
References: <1593657079-31990-1-git-send-email-yumeng18@huawei.com>
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
index 624276b..be7c20e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -553,13 +553,15 @@ static int hpre_debugfs_atomic64_get(void *data, u64 *val)
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

