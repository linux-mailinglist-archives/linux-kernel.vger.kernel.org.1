Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA7229810
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgGVMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 08:15:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55454 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:15:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0053E1A0A71;
        Wed, 22 Jul 2020 14:15:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E861E1A0A6B;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 875F1202AC;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 3/7] crypto: caam/qi2 - create ahash shared descriptors only once
Date:   Wed, 22 Jul 2020 15:14:54 +0300
Message-Id: <20200722121458.8478-4-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722121458.8478-1-horia.geanta@nxp.com>
References: <20200722121458.8478-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For keyed hash algorithms, shared descriptors are currently generated
twice:
-at tfm initialization time, in cra_init() callback
-in setkey() callback

Since it's mandatory to call setkey() for keyed algorithms, drop the
generation in cra_init().

This is similar to the change in caamhash (caam/jr top-level library)
commit 9a2537d0ebc9 ("crypto: caam - create ahash shared descriptors only once")

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 811d34eee4f2..1e901344db67 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4500,7 +4500,11 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
 				 sizeof(struct caam_hash_state));
 
-	return ahash_set_sh_desc(ahash);
+	/*
+	 * For keyed hash algorithms shared descriptors
+	 * will be created later in setkey() callback
+	 */
+	return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
 }
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
-- 
2.17.1

