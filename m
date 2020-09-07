Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670E625F4FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIGIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 04:24:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727964AbgIGIYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:24:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D26145277C38C64B3F19;
        Mon,  7 Sep 2020 16:24:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 16:24:25 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v2 07/10] crypto: hisilicon/zip - fix static check warning
Date:   Mon, 7 Sep 2020 16:21:59 +0800
Message-ID: <1599466922-10323-8-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599466922-10323-1-git-send-email-shenyang39@huawei.com>
References: <1599466922-10323-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some code for PClint warning:
    Warning - Suspicious Cast

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index e58baeb..246a43e 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -16,7 +16,7 @@
 
 #define GZIP_HEAD_FLG_SHIFT			3
 #define GZIP_HEAD_FEXTRA_SHIFT			10
-#define GZIP_HEAD_FEXTRA_XLEN			2
+#define GZIP_HEAD_FEXTRA_XLEN			2UL
 #define GZIP_HEAD_FHCRC_SIZE			2
 
 #define HZIP_GZIP_HEAD_BUF			256
@@ -51,13 +51,13 @@ enum {
 
 struct hisi_zip_req {
 	struct acomp_req *req;
-	int sskip;
-	int dskip;
+	u32 sskip;
+	u32 dskip;
 	struct hisi_acc_hw_sgl *hw_src;
 	struct hisi_acc_hw_sgl *hw_dst;
 	dma_addr_t dma_src;
 	dma_addr_t dma_dst;
-	int req_id;
+	u16 req_id;
 };
 
 struct hisi_zip_req_q {
@@ -119,7 +119,7 @@ static void hisi_zip_config_tag(struct hisi_zip_sqe *sqe, u32 tag)
 
 static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
 			      dma_addr_t s_addr, dma_addr_t d_addr, u32 slen,
-			      u32 dlen, int sskip, int dskip)
+			      u32 dlen, u32 sskip, u32 dskip)
 {
 	memset(sqe, 0, sizeof(struct hisi_zip_sqe));
 
@@ -573,7 +573,7 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 		return head_size;
 	}
 
-	req = hisi_zip_create_req(acomp_req, qp_ctx, (size_t)head_size, true);
+	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-- 
2.7.4

