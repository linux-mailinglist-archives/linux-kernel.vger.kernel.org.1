Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7B19C12E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbgDBMfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 08:35:17 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44901 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729166AbgDBMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:35:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TuQZeev_1585830905;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TuQZeev_1585830905)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Apr 2020 20:35:05 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, ebiggers@google.com, pvanleeuwen@rambus.com,
        zohar@linux.ibm.com, gilad@benyossef.com,
        jarkko.sakkinen@linux.intel.com, dmitry.kasatkin@intel.com,
        nicstange@gmail.com, tadeusz.struk@intel.com, jmorris@namei.org,
        serge@hallyn.com, zhang.jia@linux.alibaba.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@linux.alibaba.com
Subject: [PATCH v2 1/7] crypto: sm3 - export crypto_sm3_final function
Date:   Thu,  2 Apr 2020 20:34:58 +0800
Message-Id: <20200402123504.84628-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402123504.84628-1-tianjia.zhang@linux.alibaba.com>
References: <20200402123504.84628-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both crypto_sm3_update and crypto_sm3_finup have been
exported, exporting crypto_sm3_final, to avoid having to
use crypto_sm3_finup(desc, NULL, 0, dgst) to calculate
the hash in some cases.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/sm3_generic.c | 7 ++++---
 include/crypto/sm3.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
index 3468975215ca..193c4584bd00 100644
--- a/crypto/sm3_generic.c
+++ b/crypto/sm3_generic.c
@@ -149,17 +149,18 @@ int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL(crypto_sm3_update);
 
-static int sm3_final(struct shash_desc *desc, u8 *out)
+int crypto_sm3_final(struct shash_desc *desc, u8 *out)
 {
 	sm3_base_do_finalize(desc, sm3_generic_block_fn);
 	return sm3_base_finish(desc, out);
 }
+EXPORT_SYMBOL(crypto_sm3_final);
 
 int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *hash)
 {
 	sm3_base_do_update(desc, data, len, sm3_generic_block_fn);
-	return sm3_final(desc, hash);
+	return crypto_sm3_final(desc, hash);
 }
 EXPORT_SYMBOL(crypto_sm3_finup);
 
@@ -167,7 +168,7 @@ static struct shash_alg sm3_alg = {
 	.digestsize	=	SM3_DIGEST_SIZE,
 	.init		=	sm3_base_init,
 	.update		=	crypto_sm3_update,
-	.final		=	sm3_final,
+	.final		=	crypto_sm3_final,
 	.finup		=	crypto_sm3_finup,
 	.descsize	=	sizeof(struct sm3_state),
 	.base		=	{
diff --git a/include/crypto/sm3.h b/include/crypto/sm3.h
index 1438942dc773..42ea21289ba9 100644
--- a/include/crypto/sm3.h
+++ b/include/crypto/sm3.h
@@ -35,6 +35,8 @@ struct shash_desc;
 extern int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 			      unsigned int len);
 
+extern int crypto_sm3_final(struct shash_desc *desc, u8 *out);
+
 extern int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, u8 *hash);
 #endif
-- 
2.17.1

