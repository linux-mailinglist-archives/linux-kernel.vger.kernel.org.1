Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286E025ACBE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIBOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 10:15:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbgIBOHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:07:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE4697565B4170929968;
        Wed,  2 Sep 2020 22:07:29 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 22:07:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <yuehaibing@huawei.com>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crypto: pkcs7: Use match_string() helper to simplify the code
Date:   Wed, 2 Sep 2020 22:07:17 +0800
Message-ID: <20200902140717.30700-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the array index of a matching string.
Use it instead of the open-coded implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index ce49820caa97..0b4d07aa8811 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -141,11 +141,10 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
 	*buf = sinfo->sig->digest;
 	*len = sinfo->sig->digest_size;
 
-	for (i = 0; i < HASH_ALGO__LAST; i++)
-		if (!strcmp(hash_algo_name[i], sinfo->sig->hash_algo)) {
-			*hash_algo = i;
-			break;
-		}
+	i = match_string(hash_algo_name, HASH_ALGO__LAST,
+			 sinfo->sig->hash_algo);
+	if (i >= 0)
+		*hash_algo = i;
 
 	return 0;
 }
-- 
2.17.1


