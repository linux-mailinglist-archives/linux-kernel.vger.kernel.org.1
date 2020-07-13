Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0021B067
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGJHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 03:42:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbgGJHli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:41:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA0B5A26AE825E1274BF;
        Fri, 10 Jul 2020 15:41:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 15:41:23 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] crypto: hisilicon/hpre - Add a switch in sriov_configure
Date:   Fri, 10 Jul 2020 15:40:44 +0800
Message-ID: <1594366846-1313-5-git-send-email-yumeng18@huawei.com>
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

If CONFIG_PCI_IOV is not enabled, we can not use "sriov_configure".

Fixes: 5ec302a364bf("crypto: hisilicon - add SRIOV support for HPRE")
Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Shukun Tan <tanshukun1@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index da17729..37c2bc5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -925,7 +925,8 @@ static struct pci_driver hpre_pci_driver = {
 	.id_table		= hpre_dev_ids,
 	.probe			= hpre_probe,
 	.remove			= hpre_remove,
-	.sriov_configure	= hisi_qm_sriov_configure,
+	.sriov_configure	= IS_ENABLED(CONFIG_PCI_IOV) ?
+				  hisi_qm_sriov_configure : NULL,
 	.err_handler		= &hpre_err_handler,
 };
 
-- 
2.8.1

