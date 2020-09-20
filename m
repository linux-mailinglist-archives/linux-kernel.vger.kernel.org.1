Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244BF271717
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgITShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgITSh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:37:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC91C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:37:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so10008766wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IhTFOXooJMFxAaaEHQf3e3fIzkNVzwZdrWDdh3u1EUQ=;
        b=o6uy/Y2fgeouP5kDFiEtEWyZQ7lXmtHPJbfEjxbGSTzWDHdn+eNakZ+Gzg/pGOLKnB
         RFzvEO05pGIiS64ev14813GpI23vjHFh1kGdEzHu4jfAQ1suDQBBG3Z37JOeLU30eDcP
         hhsGWK/W50Ftu/3407ErlSgOzEWqcuKJnnJvNPnM0eEPbsyljMStKuk4ATkcg5j2nO46
         2i9lY+aF9IbsQGLP6HIpwTfHeXjJ5c5L+4C/MrE4n4r6fwNxv+sT5Ri080hVz8PKJ3bE
         741Zm6Cj5gk3gbTyJmL9Py6XioTv7HDjqjwFSNnlijavF40vEiIxzUvIXIME6oH696qQ
         FAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IhTFOXooJMFxAaaEHQf3e3fIzkNVzwZdrWDdh3u1EUQ=;
        b=c8tthvkazvxtl4Pg+3igp4zCiNK3j4X2LQPoclQBaFcnSHQiEWMYGLxnZeValGOlD/
         Zu8fluNy6G94vJhUiwvbUtuPqVxF/jVxoHCkqlxH17bFL0xwvd+GRJJRxggDNPqOfQVf
         ERhJHf1h2bZ9fUVAqODzOZeEV5tW7hniTev8YJ0TkFvW8rMlnXdBLuhCKucY8+yx/+9E
         kObjmd7WVXP99U08kSJ5RzCaXnyokYyzSBVlD+PQCRPVuVrgF/OoOwuOKTFjdg/hamdc
         dHptWtli257Z6WkeV0dEaKOMmGw+7WVSzJoYebr+fpRuQZvQYY3X0X4PPPGkkTi7TSXH
         F1iQ==
X-Gm-Message-State: AOAM533Mx8PlIWiBvZ/WV7XM0voVcE00n+JsioZGrhFy1gBHx6UYJxHF
        UfnT0Amuo8fdQKyaAW+L5XFXfg==
X-Google-Smtp-Source: ABdhPJynWACDMHNpXhG0zgpk0FI5q7hOkyx5gYWEvchzv4bGQbq/PWLObDidNv2Zs0juQasUPbkAmQ==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr26267083wmg.172.1600627046307;
        Sun, 20 Sep 2020 11:37:26 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e18sm16419841wrx.50.2020.09.20.11.37.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Sep 2020 11:37:25 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/7] crypto: sun4i-ss: checking sg length is not sufficient
Date:   Sun, 20 Sep 2020 18:37:13 +0000
Message-Id: <1600627038-40000-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600627038-40000-1-git-send-email-clabbe@baylibre.com>
References: <1600627038-40000-1-git-send-email-clabbe@baylibre.com>
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
index b92d175b5d2a..2614640231dc 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -188,12 +188,12 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	 * we can use the SS optimized function
 	 */
 	while (in_sg && no_chunk == 1) {
-		if (in_sg->length % 4)
+		if (in_sg->length % 4 || !IS_ALIGNED(in_sg->offset, sizeof(u32)))
 			no_chunk = 0;
 		in_sg = sg_next(in_sg);
 	}
 	while (out_sg && no_chunk == 1) {
-		if (out_sg->length % 4)
+		if (out_sg->length % 4 || !IS_ALIGNED(out_sg->offset, sizeof(u32)))
 			no_chunk = 0;
 		out_sg = sg_next(out_sg);
 	}
-- 
2.26.2

