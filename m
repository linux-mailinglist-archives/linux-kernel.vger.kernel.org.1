Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F992DA112
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502942AbgLNUFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502971AbgLNUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:04:57 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A4C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:03:42 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f17so13363472pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=glOnBFiECF8TpThPY1T9sfOwrbTI0Z62FinuvRqJFM0=;
        b=Ihg/wFKGpdoKe519ELAQtVqcDaavMDG5r1bihOEcNRbZQC+E7hplzqpQEDgnpdH4j+
         Oq4WgDsgFsUhl2gaWy8jb2LcpU6VfJdTj6goH9M5mG8HI3M9NSfZXSjLLnRzMDPxRtZs
         IimAH8Frd9xs5hPPBaUPviKS0I7ce5DX4v0ZMKbI11ovv2oy9SoqLOumdsXFRraW1ef6
         9resbu3JryZ2X3XZ6eUytHER6uZ/MiBvaApyfiaQoE3wk1lLeFkuAxTAtI7gDcBRsy3G
         UBZto2UDXbLui+9dqZ0GmYsiYJ2T2wxV7cNEUQls7zJ7ffuD4TV8Jowwfi9/FyzTiK9K
         4CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=glOnBFiECF8TpThPY1T9sfOwrbTI0Z62FinuvRqJFM0=;
        b=mRswOktXrHsG3omi28gh1Fa7xtVNFLF5XBdfRDSY8t8OUMg9aWoDbg1YF1MagHfcNm
         l44sijdeqpPZ5kjBYf7u0y2Yngawl9YYhzspofV5F4mBaejUKbeYmHWVNLCoBUz/na1l
         SqF3dt2+783vab19NbFExkojYr3D++qn+u2xDvQp5iijKWZBAgBzLA/mj+gN4PzEjHW+
         WWZiwltkTSCapxGdaaLpGUsrp7Nl4zbcKKcOXoIGQc8q7jmgYFtnzb8pY5XfJx9gojGe
         nIyV3EhNGPEy8aJ58oV+Var9Trus0bwsyadx2PCuSSdZ7Ix73TLzWXJkCSNAUmcB0CWD
         SiDA==
X-Gm-Message-State: AOAM531lR987m1gIs6H7Sh4OmcXCrBIdc62Hn7xs23KvYmSdAi969OBm
        qBl4jK9wiU3B6Gzf2okudeL+/A==
X-Google-Smtp-Source: ABdhPJwvuNU7fNETFGXKRki8LGh9J9X3JjvJeJr8KA/CryX3oDtGLsr/ecJej4eRH91ApwyyhXsmww==
X-Received: by 2002:a63:4f4c:: with SMTP id p12mr23050633pgl.432.1607976221864;
        Mon, 14 Dec 2020 12:03:41 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id js9sm22434109pjb.2.2020.12.14.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:03:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 8/8] crypto: sun4i-ss: add SPDX header and remove blank lines
Date:   Mon, 14 Dec 2020 20:02:32 +0000
Message-Id: <20201214200232.17357-9-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201214200232.17357-1-clabbe@baylibre.com>
References: <20201214200232.17357-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs fixes some remaining style issue.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 3 ---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c   | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index d5275d914d09..c2e6f5ed1d79 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -148,7 +148,6 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	return err;
 }
 
-
 static int noinline_for_stack sun4i_ss_cipher_poll_fallback(struct skcipher_request *areq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
@@ -562,7 +561,6 @@ int sun4i_ss_cipher_init(struct crypto_tfm *tfm)
 				    sizeof(struct sun4i_cipher_req_ctx) +
 				    crypto_skcipher_reqsize(op->fallback_tfm));
 
-
 	err = pm_runtime_get_sync(op->ss->dev);
 	if (err < 0)
 		goto error_pm;
@@ -649,5 +647,4 @@ int sun4i_ss_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	crypto_skcipher_set_flags(op->fallback_tfm, tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
 
 	return crypto_skcipher_setkey(op->fallback_tfm, key, keylen);
-
 }
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
index 152841076e3a..443160a114bb 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #include "sun4i-ss.h"
 
 int sun4i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-- 
2.26.2

