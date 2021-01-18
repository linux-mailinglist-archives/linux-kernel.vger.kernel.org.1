Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E12F9B21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbhARIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:20:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11415 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733243AbhARIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:20:20 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DK4S468dPzj7vw;
        Mon, 18 Jan 2021 16:18:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 16:19:30 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - add two RAS correctable errors processing
Date:   Mon, 18 Jan 2021 16:17:25 +0800
Message-ID: <1610957845-5603-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.One CE error is detecting timeout of generating a random number.
2.Another is detecting timeout of SVA prefetching address.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index bf1fa08..d46086e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -45,7 +45,7 @@
 #define HPRE_CORE_IS_SCHD_OFFSET	0x90
 
 #define HPRE_RAS_CE_ENB			0x301410
-#define HPRE_HAC_RAS_CE_ENABLE		0x1
+#define HPRE_HAC_RAS_CE_ENABLE		(BIT(0) | BIT(22) | BIT(23))
 #define HPRE_RAS_NFE_ENB		0x301414
 #define HPRE_HAC_RAS_NFE_ENABLE		0x3ffffe
 #define HPRE_RAS_FE_ENB			0x301418
@@ -129,7 +129,11 @@ static const struct hpre_hw_error hpre_hw_errors[] = {
 	{ .int_msk = BIT(9), .msg = "cluster4_shb_timeout_int_set" },
 	{ .int_msk = GENMASK(15, 10), .msg = "ooo_rdrsp_err_int_set" },
 	{ .int_msk = GENMASK(21, 16), .msg = "ooo_wrrsp_err_int_set" },
-	{ /* sentinel */ }
+	{ .int_msk = BIT(22), .msg = "pt_rng_timeout_int_set"},
+	{ .int_msk = BIT(23), .msg = "sva_fsm_timeout_int_set"},
+	{
+		/* sentinel */
+	}
 };
 
 static const u64 hpre_cluster_offsets[] = {
-- 
2.8.1

