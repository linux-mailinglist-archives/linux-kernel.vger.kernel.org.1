Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB412B4546
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgKPNzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgKPNzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:55:02 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70BC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:55:02 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t21so6970989pgl.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZw0k++w9vCloWy1RavM8WR5A4PN64leIv/MQNgMwVE=;
        b=yNbRJg4HiOvMln/cy5i68Vh9bezm3f9qSMImulPHzT6yNgmfKS4Fy/ZeIiAoujt9Pu
         8eKHZ5FzSSTLkx87rEi15KdfPiUrFoBzKmShA+p4YaBWqGUCXsMn2zX1w4GylddXBWV3
         ekpdR9KK+Pv8qiQj1Goz2Y4hXnKsS1ibZUSJqGJa/O5JMlZqREWKOO8PvMfIbpWHDdnu
         5H9Y9q67y+e9h+kbER/F7ORLqabBIoELPkE7Ub9DGO7UJFKo/ibjR8jHq+aTj15HsADa
         fkzcB43rdFBGuH6zbWIZX7vZScsdLrtKFbGK1zaPljatHXGiLg2QeXtMufVxfvMlKifo
         MPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oZw0k++w9vCloWy1RavM8WR5A4PN64leIv/MQNgMwVE=;
        b=m2SYajFIEi6OwK5pUfe5Wn+M/78HrGuvuKpwabeklPQuzubzbMZzW+wWgNsM0ptiys
         2q8odoZOqDZWnzaaRj1yAFbtc7RkNpn6cRCoRzWxHc2iwMJXj6Zv4P5F/7rL9rNfJT3c
         o5WboKkepbNZ4QAQ+tx8RmgT6WmULmLVrE2e2GcNmbT9pHi4R453ITIacqc1v5UecdXB
         ESSQaUD1+U58f6zEfrlP/G8Py6jYFRc9LMOjAiNBwR3tqIoWawLVlt+E0f7YcK1lmHsv
         GQSJskCIVVLCIsCsKvSMYU/q8qooQahAW7wcyLDS4jdsu2aqNGyG2vQ4I6kt+GRFI2gZ
         gf0w==
X-Gm-Message-State: AOAM532Bgcv/ksbHKn8W44BvcpGfymm1olACQ0S/vWuezM65gIQ47hN4
        VJcIguDep4GciQs6jldEn4w9BQ==
X-Google-Smtp-Source: ABdhPJzrn1D2lGmE0O6FoIvkmcUXsZwgWET0G+7+CvYHDb549HsqpYYeIyHzseFh6ejoq+TvEPHieA==
X-Received: by 2002:a62:84d2:0:b029:18a:f574:fded with SMTP id k201-20020a6284d20000b029018af574fdedmr14426220pfd.31.1605534901958;
        Mon, 16 Nov 2020 05:55:01 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id u22sm15864031pgf.24.2020.11.16.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:55:01 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 7/7] crypto: sun4i-ss: add SPDX header and remove blank lines
Date:   Mon, 16 Nov 2020 13:53:45 +0000
Message-Id: <20201116135345.11834-8-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116135345.11834-1-clabbe@baylibre.com>
References: <20201116135345.11834-1-clabbe@baylibre.com>
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
index 5af404f74a98..94b9952b16f3 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -135,7 +135,6 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	return err;
 }
 
-
 static int noinline_for_stack sun4i_ss_cipher_poll_fallback(struct skcipher_request *areq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
@@ -541,7 +540,6 @@ int sun4i_ss_cipher_init(struct crypto_tfm *tfm)
 				    sizeof(struct sun4i_cipher_req_ctx) +
 				    crypto_skcipher_reqsize(op->fallback_tfm));
 
-
 	err = pm_runtime_get_sync(op->ss->dev);
 	if (err < 0)
 		goto error_pm;
@@ -628,5 +626,4 @@ int sun4i_ss_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
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

