Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45382DECE9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 04:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgLSDbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 22:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLSDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 22:31:50 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA762C061257
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:31 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 19so4136848qkm.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+dMsLBrY99BUWGLKr1cRQ/g1Fbgha5c1iEnYj8qjJo=;
        b=vT8jy5MptC7VW2zdcTnk29uYgSz67EeJOfAP4ek4gPwzqbeurSmmjfcUW9xpmBn2zf
         hTEOcc7PR7X0O2TeTsexiKHG9k7tD3TG4JxiBSlLhgOIITNcdWgbN1zcYBWPsIrA1vU4
         iA47XFB35EOXuYsPkWL2ovbUfR9QYXKe9n+jgBrlCHKyFkNs3GAodS1ifcuFiasH47GU
         FPvErgetFEvolLBB6MDR2N58MQRkRrWbZyHi1hFj2cV5u/bO0RajCqxCYNeUMD14jty7
         qYM26i6S9bL9TuKw5tLRlM6MN+Mhf5boMygkj9QzbexJ6JwbaKicCUkbYMCt3BUCzwyJ
         B5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+dMsLBrY99BUWGLKr1cRQ/g1Fbgha5c1iEnYj8qjJo=;
        b=jZShHaPsXdguxZNtO1NDWgZ1771h0g/Q3/mLNUuQhCKmxAUL8tkW9uCc7zPu4IT8/U
         P8YpDjqcYoly7zHNMTqqQKrsL2jP4+yMTKp2FerGwXlhWsmPkTVyv3232GATkIGcT7+G
         G1QbNIHTle+52LpnXoN5cwpW5GPV++XuzJTzgmhKnwjYTfw5sD9ZFpJGKc7u7XwfOJbH
         aRtcMyPLyfcAA4siw3lSxS2cm6GcrNogqGg7lBy4mL2mvs1YqhJolfEGQeTuGNOkVB08
         3Fw2g4ishJysYGjTJPQ1t528dmxD1v2xyNEJc4zAbRv/vif+gsfeTD1ViBld/qcWIHIu
         GPUw==
X-Gm-Message-State: AOAM533/MlboIQIMNuijnT0WtZ8b9WoR91vaviIQ072XhY7Gx43A3q5C
        OJ83qD5k3aV8koGan9ey5cd7oQ==
X-Google-Smtp-Source: ABdhPJzU/qyYPNNeD+vd+TgYuRGoGACzorAX5fTuj3JMZ6nkU8rS4gcMERgW0MZ2QuWyM3gSvViknw==
X-Received: by 2002:a05:620a:10b7:: with SMTP id h23mr8222309qkk.249.1608348631006;
        Fri, 18 Dec 2020 19:30:31 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id y16sm4376045qki.132.2020.12.18.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 19:30:30 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drivers: crypto: qce: sha: Hold back a block of data to be transferred as part of final
Date:   Fri, 18 Dec 2020 22:30:23 -0500
Message-Id: <20201219033027.3066042-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219033027.3066042-1-thara.gopinath@linaro.org>
References: <20201219033027.3066042-1-thara.gopinath@linaro.org>
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
index b8428da6716d..02d89267a806 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -193,6 +193,25 @@ static int qce_ahash_update(struct ahash_request *req)
 
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

