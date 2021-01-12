Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D72F2686
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbhALDGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbhALDGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:06:35 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D47C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:49 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id r9so719298qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzoTTNnCPyrLt8K8sPUqSR8uOcEXNVFa8VbUu/a/sAw=;
        b=gOs/dNmKiiq2t7vlKbE823hViq8mqDd2xe0FlFuWDbHtxk/AxL1dlbLYpWEpp0IghA
         XrNfyCXUVO4coU0Q4AGBBQ8726X3da0O55GZD8mfh6rgie+JfTsEBk0SNAWPvsvyqNoW
         qaBZQnoQRoeg5YB1mUnlFX8+FS4COgYQRV3ADk8RUFSXamH9d25zkyXiKetFrgoN2Fv2
         ZWI3wbDSrk40uqz/NQdI3cNDOn09tpJK/lsJiCnhc6S3h04pWVzXkOIZrEU2tutGKSdW
         Eo9Fhx/ZBvo9eTYvB4mpQZioGxtM1cXoUWpjDUKTxSHlrYYAKDAi+I+x2Csw59+qGyyD
         pDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzoTTNnCPyrLt8K8sPUqSR8uOcEXNVFa8VbUu/a/sAw=;
        b=SjFJz8vwrqLsY4EdNdqsX+zlBVupW3hgq1M4el8wsfD6dv2qYzUWPnEsQVUZy1Xs2R
         ci44pMFh5Urpar65qRXL8b5Xa76MI6JbCcoxrsbYS2ZRUpSjVk835MY6j+A10Q0SluWE
         jIh2VYideRUotQ7pxwVGpua2/Y6aPfJ952lqyvt1dCuOOu2KYeGdIuxeZ6TLs1qZFLIl
         wy4fBMzo4VyhSCEBbb6wuRx3+MRyJv/wu0LGKO+AVrLYY//dCfHQW5kWUddf3s3rCFHd
         jR1ragrGBxyqnZegs/ipWlY1Gx0qmgwS+SMH2ZrnuOxdlJJ3NudMRYsCCqBIHmMOWErc
         3IuQ==
X-Gm-Message-State: AOAM530j8Cs2tj4InHe/rly0TMun2uafXj099b9B2aFK0rS2Ip0sHlzH
        0IkMIr4vNXJD7Qyaq226LeU2+BIZyjj9sQ==
X-Google-Smtp-Source: ABdhPJwgAJDwOJMMVKgbaFcRTlNKxxD1HzB9CEtWQK0CsdIqVmYHMjHsoReAVp5etK3W89G16GObPQ==
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr2696475qtd.269.1610420748810;
        Mon, 11 Jan 2021 19:05:48 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c7sm814235qkm.99.2021.01.11.19.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 19:05:48 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] drivers: crypto: qce: sha: Hold back a block of data to be transferred as part of final
Date:   Mon, 11 Jan 2021 22:05:41 -0500
Message-Id: <20210112030545.669480-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112030545.669480-1-thara.gopinath@linaro.org>
References: <20210112030545.669480-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the available data to transfer is exactly a multiple of block size, save
the last block to be transferred in qce_ahash_final (with the last block
bit set) if this is indeed the end of data stream. If not this saved block
will be transferred as part of next update. If this block is not held back
and if this is indeed the end of data stream, the digest obtained will be
wrong since qce_ahash_final will see that rctx->buflen is 0 and return
doing nothing which in turn means that a digest will not be copied to the
destination result buffer.  qce_ahash_final cannot be made to alter this
behavior and allowed to proceed if rctx->buflen is 0 because the crypto
engine BAM does not allow for zero length transfers.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/sha.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 08aed03e2b59..dd263c5e4dd8 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -216,6 +216,25 @@ static int qce_ahash_update(struct ahash_request *req)
 
 	/* calculate how many bytes will be hashed later */
 	hash_later = total % blocksize;
+
+	/*
+	 * At this point, there is more than one block size of data.  If
+	 * the available data to transfer is exactly a multiple of block
+	 * size, save the last block to be transferred in qce_ahash_final
+	 * (with the last block bit set) if this is indeed the end of data
+	 * stream. If not this saved block will be transferred as part of
+	 * next update. If this block is not held back and if this is
+	 * indeed the end of data stream, the digest obtained will be wrong
+	 * since qce_ahash_final will see that rctx->buflen is 0 and return
+	 * doing nothing which in turn means that a digest will not be
+	 * copied to the destination result buffer.  qce_ahash_final cannot
+	 * be made to alter this behavior and allowed to proceed if
+	 * rctx->buflen is 0 because the crypto engine BAM does not allow
+	 * for zero length transfers.
+	 */
+	if (!hash_later)
+		hash_later = blocksize;
+
 	if (hash_later) {
 		unsigned int src_offset = req->nbytes - hash_later;
 		scatterwalk_map_and_copy(rctx->buf, req->src, src_offset,
-- 
2.25.1

