Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0519C132
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbgDBMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 08:35:43 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41508 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387866AbgDBMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:35:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TuQo.oW_1585830908;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TuQo.oW_1585830908)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Apr 2020 20:35:09 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, ebiggers@google.com, pvanleeuwen@rambus.com,
        zohar@linux.ibm.com, gilad@benyossef.com,
        jarkko.sakkinen@linux.intel.com, dmitry.kasatkin@intel.com,
        nicstange@gmail.com, tadeusz.struk@intel.com, jmorris@namei.org,
        serge@hallyn.com, zhang.jia@linux.alibaba.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@linux.alibaba.com
Subject: [PATCH v2 5/7] crypto: testmgr - support test with different ciphertext per encryption
Date:   Thu,  2 Apr 2020 20:35:02 +0800
Message-Id: <20200402123504.84628-6-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402123504.84628-1-tianjia.zhang@linux.alibaba.com>
References: <20200402123504.84628-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some asymmetric algorithms will get different ciphertext after
each encryption, such as SM2, and let testmgr support the testing
of such algorithms.

In struct akcipher_testvec, set c and c_size to be empty, skip
the comparison of the ciphertext, and compare the decrypted
plaintext with m to achieve the test purpose.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6863f911fcee..0dc94461c437 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4025,7 +4025,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		pr_err("alg: akcipher: %s test failed. err %d\n", op, err);
 		goto free_all;
 	}
-	if (!vecs->siggen_sigver_test) {
+	if (!vecs->siggen_sigver_test && c) {
 		if (req->dst_len != c_size) {
 			pr_err("alg: akcipher: %s test failed. Invalid output len\n",
 			       op);
@@ -4056,6 +4056,11 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		goto free_all;
 	}
 
+	if (!vecs->siggen_sigver_test && !c) {
+		c = outbuf_enc;
+		c_size = req->dst_len;
+	}
+
 	op = vecs->siggen_sigver_test ? "sign" : "decrypt";
 	if (WARN_ON(c_size > PAGE_SIZE))
 		goto free_all;
-- 
2.17.1

