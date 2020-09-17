Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBCF26E3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgIQSi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIQSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:36:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F36C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so3119040wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTdlzUzyc1hcRCjE509a2kDcbNHBKMDXHMkrLBJjCcg=;
        b=Iu747+4nadzvDfyHCyTyuRJhiIU4JEOTx7wcl9fRZmk4C2hj26XLP/pLYoNWCXkNoa
         jOG8/8qUQh9csSVrxPpXSLZB7w7m2/mkvWFMko8b/zg/Z7ttLd1ZC+hExrJdPx60e0PY
         DGPFCHfb55pFL94T4GzExTONjciAmVl0VIYj29tldHOgshEBgmTCekX5f9FxIO8xVy93
         TQrf1HjVu9cDXHHOMehhlpk8KxDRSZt7TDhRQoq66hjhfqUUWsDJC5vKyCqpCfaCHW+3
         JhvQWkL851NyQoea13o8i1gW2piPvOrQirFTd+7HYoZIDSFRTpLgyuneoMGuurVSFMNa
         nHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTdlzUzyc1hcRCjE509a2kDcbNHBKMDXHMkrLBJjCcg=;
        b=tHAFmfquK+u/vbUuPI7nJYjQi9m0kocRX81//z9a1Fv1PdIIDbJVcqEKKyjz7JCMY4
         lNtYguvh8tc2LU72tQIYtFLUPiTE9L1bJLw1SztHiHtZ9bFLBAkCBZmje3ozH7KxgjFp
         IVXLr5P4nocJ7C8W7TwCWb4evs/jRyeqbSw7PsJQXA1k+5gQu6m33cP2oOo7sYfspOyQ
         obd6+Vdntc2ayfUt+EzJTc5xA7MXU3Zassg1TU5TFe5btQCoJ+gyjQ5Vv52zIkH3Ljvh
         4BSC1xENKJubdRiy8xnAPH71MFUPc4418SIWKtF5SqSW7SYsWaTUs3Os5v8bZSYLxATB
         yOtQ==
X-Gm-Message-State: AOAM531czpSbK73kZ5iNYnYm+ii1hof9twPTcRnu0t+LADFsHVrIlYJT
        /wvxRqVknX9sqKKNWYDg+M2FPA==
X-Google-Smtp-Source: ABdhPJwPR3kJwirxBvcg7+EKXYc7it131pIcBWGKU+Rwhgt8ETaSOml+RRDdd+wopE0SsNNZADqqUg==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr36379858wrm.0.1600367768639;
        Thu, 17 Sep 2020 11:36:08 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x16sm571901wrq.62.2020.09.17.11.36.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:36:07 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/7] crypto: sun4i-ss: linearize buffers content must be kept
Date:   Thu, 17 Sep 2020 18:35:52 +0000
Message-Id: <1600367758-28589-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
References: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the non-optimized cipher function, SS produce partial random
output.
This is due to linearize buffers being reseted after each loop.

Fixes: 8d3bcb9900ca ("crypto: sun4i-ss - reduce stack usage")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index b72de8939497..b92d175b5d2a 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -163,6 +163,8 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	unsigned int todo;
 	struct sg_mapping_iter mi, mo;
 	unsigned int oi, oo;	/* offset for in and out */
+	char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
+	char bufo[4 * SS_TX_MAX]; /* buffer for linearize SG dst */
 	unsigned int ob = 0;	/* offset in buf */
 	unsigned int obo = 0;	/* offset in bufo*/
 	unsigned int obl = 0;	/* length of data in bufo */
@@ -233,8 +235,6 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 
 	while (oleft) {
 		if (ileft) {
-			char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
-
 			/*
 			 * todo is the number of consecutive 4byte word that we
 			 * can read from current SG
@@ -295,8 +295,6 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 				oo = 0;
 			}
 		} else {
-			char bufo[4 * SS_TX_MAX]; /* buffer for linearize SG dst */
-
 			/*
 			 * read obl bytes in bufo, we read at maximum for
 			 * emptying the device
-- 
2.26.2

