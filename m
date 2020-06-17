Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1885A1FCED6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgFQNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 09:50:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgFQNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592401811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioXcL3QMX02vikzo+YkXrpxao9Z43eW1SnDtYQWia3Y=;
        b=J72awWjhixyGoo5yPfwxspZNLYNo5KPTuwvC7w34M90O/ck/tB2A5YmQK/M54iq/q2vcjT
        kQkCWkibs4pigzeHCIXs/FVYCpzvGZN5qsmslHShtEGkY6EUF+hW7xQ1w+uWoqyo9Jx+TV
        IQuTPo4ID/vuV80K99zfNgCM/ED4JoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-z-8NSJsZM5KiN1zMAi_L5A-1; Wed, 17 Jun 2020 09:49:57 -0400
X-MC-Unique: z-8NSJsZM5KiN1zMAi_L5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E5BD18FE87C;
        Wed, 17 Jun 2020 13:49:56 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F3F919D9E;
        Wed, 17 Jun 2020 13:49:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05HDnqos022507;
        Wed, 17 Jun 2020 09:49:52 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05HDnqqS022503;
        Wed, 17 Jun 2020 09:49:52 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 17 Jun 2020 09:49:52 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Eric Biggers <ebiggers@kernel.org>,
        George Cherian <gcherian@marvell.com>,
        Wei Xu <xuwei5@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>
cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Snitzer <msnitzer@redhat.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>
Subject: [PATCH 2/2] hisilicon-crypto: don't sleep of CRYPTO_TFM_REQ_MAY_SLEEP
 was not specified
In-Reply-To: <alpine.LRH.2.02.2006170940510.18714@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2006170949010.18714@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006091259250.30590@file01.intranet.prod.int.rdu2.redhat.com> <20200610010450.GA6449@gondor.apana.org.au> <alpine.LRH.2.02.2006100756270.27811@file01.intranet.prod.int.rdu2.redhat.com> <20200610121106.GA23137@gondor.apana.org.au>
 <alpine.LRH.2.02.2006161052540.28052@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006161102250.28052@file01.intranet.prod.int.rdu2.redhat.com> <20200616175022.GD207319@gmail.com> <alpine.LRH.2.02.2006161416510.12390@file01.intranet.prod.int.rdu2.redhat.com>
 <20200616182327.GE207319@gmail.com> <alpine.LRH.2.02.2006170940510.18714@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is this call chain:
sec_alg_skcipher_encrypt -> sec_alg_skcipher_crypto ->
sec_alg_alloc_and_calc_split_sizes -> kcalloc
where we call sleeping allocator function even if CRYPTO_TFM_REQ_MAY_SLEEP
was not specified.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v4.19+
Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")

---
 drivers/crypto/hisilicon/sec/sec_algs.c |   34 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/crypto/hisilicon/sec/sec_algs.c
===================================================================
--- linux-2.6.orig/drivers/crypto/hisilicon/sec/sec_algs.c
+++ linux-2.6/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -175,7 +175,8 @@ static int sec_alloc_and_fill_hw_sgl(str
 				     dma_addr_t *psec_sgl,
 				     struct scatterlist *sgl,
 				     int count,
-				     struct sec_dev_info *info)
+				     struct sec_dev_info *info,
+				     gfp_t gfp)
 {
 	struct sec_hw_sgl *sgl_current = NULL;
 	struct sec_hw_sgl *sgl_next;
@@ -190,7 +191,7 @@ static int sec_alloc_and_fill_hw_sgl(str
 		sge_index = i % SEC_MAX_SGE_NUM;
 		if (sge_index == 0) {
 			sgl_next = dma_pool_zalloc(info->hw_sgl_pool,
-						   GFP_KERNEL, &sgl_next_dma);
+						   gfp, &sgl_next_dma);
 			if (!sgl_next) {
 				ret = -ENOMEM;
 				goto err_free_hw_sgls;
@@ -545,14 +546,14 @@ void sec_alg_callback(struct sec_bd_info
 }
 
 static int sec_alg_alloc_and_calc_split_sizes(int length, size_t **split_sizes,
-					      int *steps)
+					      int *steps, gfp_t gfp)
 {
 	size_t *sizes;
 	int i;
 
 	/* Split into suitable sized blocks */
 	*steps = roundup(length, SEC_REQ_LIMIT) / SEC_REQ_LIMIT;
-	sizes = kcalloc(*steps, sizeof(*sizes), GFP_KERNEL);
+	sizes = kcalloc(*steps, sizeof(*sizes), gfp);
 	if (!sizes)
 		return -ENOMEM;
 
@@ -568,7 +569,7 @@ static int sec_map_and_split_sg(struct s
 				int steps, struct scatterlist ***splits,
 				int **splits_nents,
 				int sgl_len_in,
-				struct device *dev)
+				struct device *dev, gfp_t gfp)
 {
 	int ret, count;
 
@@ -576,12 +577,12 @@ static int sec_map_and_split_sg(struct s
 	if (!count)
 		return -EINVAL;
 
-	*splits = kcalloc(steps, sizeof(struct scatterlist *), GFP_KERNEL);
+	*splits = kcalloc(steps, sizeof(struct scatterlist *), gfp);
 	if (!*splits) {
 		ret = -ENOMEM;
 		goto err_unmap_sg;
 	}
-	*splits_nents = kcalloc(steps, sizeof(int), GFP_KERNEL);
+	*splits_nents = kcalloc(steps, sizeof(int), gfp);
 	if (!*splits_nents) {
 		ret = -ENOMEM;
 		goto err_free_splits;
@@ -589,7 +590,7 @@ static int sec_map_and_split_sg(struct s
 
 	/* output the scatter list before and after this */
 	ret = sg_split(sgl, count, 0, steps, split_sizes,
-		       *splits, *splits_nents, GFP_KERNEL);
+		       *splits, *splits_nents, gfp);
 	if (ret) {
 		ret = -ENOMEM;
 		goto err_free_splits_nents;
@@ -630,13 +631,13 @@ static struct sec_request_el
 			   int el_size, bool different_dest,
 			   struct scatterlist *sgl_in, int n_ents_in,
 			   struct scatterlist *sgl_out, int n_ents_out,
-			   struct sec_dev_info *info)
+			   struct sec_dev_info *info, gfp_t gfp)
 {
 	struct sec_request_el *el;
 	struct sec_bd_info *req;
 	int ret;
 
-	el = kzalloc(sizeof(*el), GFP_KERNEL);
+	el = kzalloc(sizeof(*el), gfp);
 	if (!el)
 		return ERR_PTR(-ENOMEM);
 	el->el_length = el_size;
@@ -668,7 +669,7 @@ static struct sec_request_el
 	el->sgl_in = sgl_in;
 
 	ret = sec_alloc_and_fill_hw_sgl(&el->in, &el->dma_in, el->sgl_in,
-					n_ents_in, info);
+					n_ents_in, info, gfp);
 	if (ret)
 		goto err_free_el;
 
@@ -679,7 +680,7 @@ static struct sec_request_el
 		el->sgl_out = sgl_out;
 		ret = sec_alloc_and_fill_hw_sgl(&el->out, &el->dma_out,
 						el->sgl_out,
-						n_ents_out, info);
+						n_ents_out, info, gfp);
 		if (ret)
 			goto err_free_hw_sgl_in;
 
@@ -720,6 +721,7 @@ static int sec_alg_skcipher_crypto(struc
 	int *splits_out_nents = NULL;
 	struct sec_request_el *el, *temp;
 	bool split = skreq->src != skreq->dst;
+	gfp_t gfp = skreq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 
 	mutex_init(&sec_req->lock);
 	sec_req->req_base = &skreq->base;
@@ -728,13 +730,13 @@ static int sec_alg_skcipher_crypto(struc
 	sec_req->len_in = sg_nents(skreq->src);
 
 	ret = sec_alg_alloc_and_calc_split_sizes(skreq->cryptlen, &split_sizes,
-						 &steps);
+						 &steps, gfp);
 	if (ret)
 		return ret;
 	sec_req->num_elements = steps;
 	ret = sec_map_and_split_sg(skreq->src, split_sizes, steps, &splits_in,
 				   &splits_in_nents, sec_req->len_in,
-				   info->dev);
+				   info->dev, gfp);
 	if (ret)
 		goto err_free_split_sizes;
 
@@ -742,7 +744,7 @@ static int sec_alg_skcipher_crypto(struc
 		sec_req->len_out = sg_nents(skreq->dst);
 		ret = sec_map_and_split_sg(skreq->dst, split_sizes, steps,
 					   &splits_out, &splits_out_nents,
-					   sec_req->len_out, info->dev);
+					   sec_req->len_out, info->dev, gfp);
 		if (ret)
 			goto err_unmap_in_sg;
 	}
@@ -775,7 +777,7 @@ static int sec_alg_skcipher_crypto(struc
 					       splits_in[i], splits_in_nents[i],
 					       split ? splits_out[i] : NULL,
 					       split ? splits_out_nents[i] : 0,
-					       info);
+					       info, gfp);
 		if (IS_ERR(el)) {
 			ret = PTR_ERR(el);
 			goto err_free_elements;

