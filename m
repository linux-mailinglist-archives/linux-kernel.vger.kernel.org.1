Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8717B2DA10A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgLNUE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732829AbgLNUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:04:15 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E34CC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:03:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c12so12811121pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BdxMVC3y5nlR7LDMxIQSz3qWj9jrWm9Nsf2wISBO6pc=;
        b=LFVHg2rNbEt02LLPnkWOohGk8VIhywesyIxgHiqAVoru6cI75unOmiStz32cZ6y+5B
         GL+mJ6YH7mTcGxudEG3o5arOqjNvAQrUwRWzSPqM3W3iJv9O34xi9vG3w41FH5zMUvN1
         3ADDsOv8n7jI+sQAcZBmLufNtQsEwc1/LoOT/1hVCz/kru0CHAKgtKnTGlmeHskONmo+
         CEAoXXJ3X+2jP2fcKovBAXjO4XiHWndTM5VjpJcyjYGp+eqkdDH2c+691UZpMUAAERWu
         8ScMA0Hp3TEsajRGKrtzklh2DM7t/Vu5rGcrKy+t2aRigykj3BF+P0iSSeHgZ4TQ6FQ/
         93bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BdxMVC3y5nlR7LDMxIQSz3qWj9jrWm9Nsf2wISBO6pc=;
        b=rKVRPqRynSTyDXIvliv/L1Zz9kWk5WIlYVKJHlGEmYrM33vvytHBISqut4iB/yxO3l
         69JY+4WhNW5Q8TiHDdeFVpWyFSmBYQ18+x1zpJnnyQP1zetAeTdz+5s0Ec1DOQ28BY5o
         tH8oyw+7BKP7AM6x0UVYVk5Gz3mcvnmVFkqVcObf4oTbtyAAUi/lvIkrkL15ZR3XITj8
         TrFaMDfchAeNflThBY0i6TKSLLIkJK3vtt2G6Wr7KdrGuYtVCvAHhdbauW9wms9aQy7g
         agMzBjiWD18aBr2iXuMKffCcj01/qr1PA6yHdqVBYZqXe+Zee0y2PmXdwKKBksV6y9EA
         Lgxg==
X-Gm-Message-State: AOAM533kEAICfnrrxoPm9Ht9fNaYJUKYXyu7nW4fkyy9prstPYmAG1xx
        DFhejkvbJl4uR5pUtCBtDwgXyMX+7IzmYw==
X-Google-Smtp-Source: ABdhPJzKh8HJaK54TRvEM5Wt0CA7yuq8pZy4BPn2IMdwD95gbsiCsgLgHhwTk/FqSplATiFqAetjqw==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr25034328pgi.74.1607976182932;
        Mon, 14 Dec 2020 12:03:02 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id js9sm22434109pjb.2.2020.12.14.12.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:03:02 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH v4 2/8] crypto: sun4i-ss: checking sg length is not sufficient
Date:   Mon, 14 Dec 2020 20:02:26 +0000
Message-Id: <20201214200232.17357-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201214200232.17357-1-clabbe@baylibre.com>
References: <20201214200232.17357-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optimized cipher function need length multiple of 4 bytes.
But it get sometimes odd length.
This is due to SG data could be stored with an offset.

So the fix is to check also if the offset is aligned with 4 bytes.
Fixes: 6298e948215f2 ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index 19f1aa577ed4..f49797588329 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -186,12 +186,12 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	 * we can use the SS optimized function
 	 */
 	while (in_sg && no_chunk == 1) {
-		if (in_sg->length % 4)
+		if ((in_sg->length | in_sg->offset) & 3u)
 			no_chunk = 0;
 		in_sg = sg_next(in_sg);
 	}
 	while (out_sg && no_chunk == 1) {
-		if (out_sg->length % 4)
+		if ((out_sg->length | out_sg->offset) & 3u)
 			no_chunk = 0;
 		out_sg = sg_next(out_sg);
 	}
-- 
2.26.2

