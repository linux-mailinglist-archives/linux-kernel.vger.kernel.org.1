Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65961B86FA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 16:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDYOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 10:24:13 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3513 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgDYOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:24:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15ea447f4f1b-4afe9; Sat, 25 Apr 2020 22:23:51 +0800 (CST)
X-RM-TRANSID: 2ee15ea447f4f1b-4afe9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.31])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95ea447f3965-824f1;
        Sat, 25 Apr 2020 22:23:50 +0800 (CST)
X-RM-TRANSID: 2ee95ea447f3965-824f1
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] crypto: bcm - Fix unused assignment
Date:   Sat, 25 Apr 2020 22:24:14 +0800
Message-Id: <20200425142414.12264-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused initialized value in cipher.c file.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/crypto/bcm/cipher.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index c8b940854..91db553e6 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -308,9 +308,9 @@ static int handle_skcipher_req(struct iproc_reqctx_s *rctx)
 	    container_of(areq, struct skcipher_request, base);
 	struct iproc_ctx_s *ctx = rctx->ctx;
 	struct spu_cipher_parms cipher_parms;
-	int err = 0;
-	unsigned int chunksize = 0;	/* Num bytes of request to submit */
-	int remaining = 0;	/* Bytes of request still to process */
+	int err;
+	unsigned int chunksize;	/* Num bytes of request to submit */
+	int remaining;	/* Bytes of request still to process */
 	int chunk_start;	/* Beginning of data for current SPU msg */
 
 	/* IV or ctr value to use in this SPU msg */
@@ -698,7 +698,7 @@ static int handle_ahash_req(struct iproc_reqctx_s *rctx)
 
 	/* number of bytes still to be hashed in this req */
 	unsigned int nbytes_to_hash = 0;
-	int err = 0;
+	int err;
 	unsigned int chunksize = 0;	/* length of hash carry + new data */
 	/*
 	 * length of new data, not from hash carry, to be submitted in
@@ -1664,7 +1664,7 @@ static void spu_rx_callback(struct mbox_client *cl, void *msg)
 	struct spu_hw *spu = &iproc_priv.spu;
 	struct brcm_message *mssg = msg;
 	struct iproc_reqctx_s *rctx;
-	int err = 0;
+	int err;
 
 	rctx = mssg->ctx;
 	if (unlikely(!rctx)) {
@@ -1967,7 +1967,7 @@ static int ahash_enqueue(struct ahash_request *req)
 	struct iproc_reqctx_s *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct iproc_ctx_s *ctx = crypto_ahash_ctx(tfm);
-	int err = 0;
+	int err;
 	const char *alg_name;
 
 	flow_log("ahash_enqueue() nbytes:%u\n", req->nbytes);
@@ -2299,7 +2299,7 @@ static int ahash_finup(struct ahash_request *req)
 
 static int ahash_digest(struct ahash_request *req)
 {
-	int err = 0;
+	int err;
 
 	flow_log("ahash_digest() nbytes:%u\n", req->nbytes);
 
@@ -4747,7 +4747,7 @@ static int bcm_spu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct spu_hw *spu = &iproc_priv.spu;
-	int err = 0;
+	int err;
 
 	iproc_priv.pdev  = pdev;
 	platform_set_drvdata(iproc_priv.pdev,
-- 
2.20.1.windows.1



