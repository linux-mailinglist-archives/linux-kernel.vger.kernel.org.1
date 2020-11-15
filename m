Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDECA2B3846
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKOTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:08:25 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58144C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:08:25 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so783647pfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4KPQVzj3XaK0dcddXHao3rFPSxVSyHVZa7GVCBHBYGg=;
        b=QBr+Tfprgj2XQXAST4ZuTFUKXgfRKS//pj86h4zxdfUqPM530T+atjzm6q8qzowE7/
         qpdtzmdQyCAWXpYeIpCQLU8OPsaMW9hFxc6XIpS5znQsI7j0GMmhk4AMg17/kuQ1J8go
         M4H+qyiSl36bUnDwZT+ahShgYJ/5F8MrW+tc+3GqB/X1jHlTfJPryMhJkF2mHDeah1nl
         iNYm28H4Y+Sb/UvoG0d4gqLpFLFyx8KgDMvkLbRx0YP+FWRS18AXKm5VFPA7EcWvTeeN
         uTvx86H5GWuac3Lr+g+ALnCtT92A7yXPmhbQCklK0kXuzWD2B6Cltrh4GLY0ThY7VGeq
         2sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4KPQVzj3XaK0dcddXHao3rFPSxVSyHVZa7GVCBHBYGg=;
        b=TMXFzIGFH4u4szBsiBavyzt/HSg6aCN8NsXSgz+PFIxmrTEjJP2VXP+YdBoSC+OvaF
         OaYFr0uSU14SpbJTw1wjQQtn9Y9D0ejolSBIZkAvJVn1BQJElE5J3+3a0pkaDW9ZkC41
         BPkB8RHk6smQAylt6KRu9qGa47blDRjd8m5wm7PSbPGj4AAP1tAhyH8FQlCz/N9HpCVf
         yzvELoaIZS0/YCfdCPeaBGTXE13MJZbz+WGaqWoHOaBK6KoCbuO0oJeAJUjSdGim9hvb
         ncaIOnGs4R+l8VaxMc008tveBjZvT7Yhfed0hXTvYryVqpcPqwSz5LxM2k3pw+v6W9c6
         oWWg==
X-Gm-Message-State: AOAM530FlwSDjElkqdzE6rssYs/mogFOMc8SzPy+V17cBzYt+mEgAKrY
        fvmXTDFw4nyNBkdoTTkTyi/lPg==
X-Google-Smtp-Source: ABdhPJxnKD9u/eRJm/dyqBqJLS6fVwosAXdLsioU1A+4Lz1XJS5ReKZThYSgP5/749PQIcicugQHpQ==
X-Received: by 2002:a63:484e:: with SMTP id x14mr10340222pgk.282.1605467304921;
        Sun, 15 Nov 2020 11:08:24 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id i16sm15810339pfr.183.2020.11.15.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:08:24 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     dan.carpenter@oracle.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, jernej.skrabec@siol.net,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: allwinner: sun8i-ce: fix two error path's memory leak
Date:   Sun, 15 Nov 2020 19:08:07 +0000
Message-Id: <20201115190807.12251-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following smatch warnings:
drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c:412
sun8i_ce_hash_run() warn: possible memory leak of 'result'
Note: "buf" is leaked as well.

Furthermore, in case of ENOMEM, crypto_finalize_hash_request() was not
called which was an error.

Fixes: 56f6d5aee88d ("crypto: sun8i-ce - support hash algorithms")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index a94bf28f858a..4c5a2c11d714 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -262,13 +262,13 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	u32 common;
 	u64 byte_count;
 	__le32 *bf;
-	void *buf;
+	void *buf = NULL;
 	int j, i, todo;
 	int nbw = 0;
 	u64 fill, min_fill;
 	__be64 *bebits;
 	__le64 *lebits;
-	void *result;
+	void *result = NULL;
 	u64 bs;
 	int digestsize;
 	dma_addr_t addr_res, addr_pad;
@@ -285,13 +285,17 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 
 	/* the padding could be up to two block. */
 	buf = kzalloc(bs * 2, GFP_KERNEL | GFP_DMA);
-	if (!buf)
-		return -ENOMEM;
+	if (!buf) {
+		err = -ENOMEM;
+		goto theend;
+	}
 	bf = (__le32 *)buf;
 
 	result = kzalloc(digestsize, GFP_KERNEL | GFP_DMA);
-	if (!result)
-		return -ENOMEM;
+	if (!result) {
+		err = -ENOMEM;
+		goto theend;
+	}
 
 	flow = rctx->flow;
 	chan = &ce->chanlist[flow];
@@ -403,11 +407,11 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	dma_unmap_sg(ce->dev, areq->src, nr_sgs, DMA_TO_DEVICE);
 	dma_unmap_single(ce->dev, addr_res, digestsize, DMA_FROM_DEVICE);
 
-	kfree(buf);
 
 	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
-	kfree(result);
 theend:
+	kfree(buf);
+	kfree(result);
 	crypto_finalize_hash_request(engine, breq, err);
 	return 0;
 }
-- 
2.26.2

