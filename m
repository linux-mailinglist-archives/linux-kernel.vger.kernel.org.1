Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237832FD903
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392451AbhATTDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:03:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:24125 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbhATS6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:58:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DLZX62sgcz9tybr;
        Wed, 20 Jan 2021 19:57:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wNUy4APIEvhB; Wed, 20 Jan 2021 19:57:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DLZX623DVz9tybZ;
        Wed, 20 Jan 2021 19:57:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CBFF8B7F8;
        Wed, 20 Jan 2021 19:57:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pDsI-BVMOiaA; Wed, 20 Jan 2021 19:57:26 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 048988B7F2;
        Wed, 20 Jan 2021 19:57:26 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D733566A56; Wed, 20 Jan 2021 18:57:25 +0000 (UTC)
Message-Id: <bb8560ebc6db72a82afd0fcdecf5ca80cb9c9d3d.1611169001.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4b7a870573f485b9fea496b13c9b02d86dd97314.1611169001.git.christophe.leroy@csgroup.eu>
References: <4b7a870573f485b9fea496b13c9b02d86dd97314.1611169001.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] crypto: talitos - Fix ctr(aes) on SEC1
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Jan 2021 18:57:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While ctr(aes) requires the use of a special descriptor on SEC2 (see
commit 70d355ccea89 ("crypto: talitos - fix ctr-aes-talitos")), that
special descriptor doesn't work on SEC1, see commit e738c5f15562
("powerpc/8xx: Add DT node for using the SEC engine of the MPC885").

However, the common nonsnoop descriptor works properly on SEC1 for
ctr(aes).

Add a second template for ctr(aes) that will be registered
only on SEC1.

Fixes: 70d355ccea89 ("crypto: talitos - fix ctr-aes-talitos")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/crypto/talitos.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index b656983c1ef4..25c9f825b8b5 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2765,6 +2765,22 @@ static struct talitos_alg_template driver_algs[] = {
 				     DESC_HDR_SEL0_AESU |
 				     DESC_HDR_MODE0_AESU_CTR,
 	},
+	{	.type = CRYPTO_ALG_TYPE_SKCIPHER,
+		.alg.skcipher = {
+			.base.cra_name = "ctr(aes)",
+			.base.cra_driver_name = "ctr-aes-talitos",
+			.base.cra_blocksize = 1,
+			.base.cra_flags = CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_ALLOCATES_MEMORY,
+			.min_keysize = AES_MIN_KEY_SIZE,
+			.max_keysize = AES_MAX_KEY_SIZE,
+			.ivsize = AES_BLOCK_SIZE,
+			.setkey = skcipher_aes_setkey,
+		},
+		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
+				     DESC_HDR_SEL0_AESU |
+				     DESC_HDR_MODE0_AESU_CTR,
+	},
 	{	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 		.alg.skcipher = {
 			.base.cra_name = "ecb(des)",
@@ -3182,6 +3198,12 @@ static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
 			t_alg->algt.alg.skcipher.setkey ?: skcipher_setkey;
 		t_alg->algt.alg.skcipher.encrypt = skcipher_encrypt;
 		t_alg->algt.alg.skcipher.decrypt = skcipher_decrypt;
+		if (!strcmp(alg->cra_name, "ctr(aes)") && !has_ftr_sec1(priv) &&
+		    DESC_TYPE(t_alg->algt.desc_hdr_template) !=
+		    DESC_TYPE(DESC_HDR_TYPE_AESU_CTR_NONSNOOP)) {
+			devm_kfree(dev, t_alg);
+			return ERR_PTR(-ENOTSUPP);
+		}
 		break;
 	case CRYPTO_ALG_TYPE_AEAD:
 		alg = &t_alg->algt.alg.aead.base;
-- 
2.25.0

