Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5026F6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgIRHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIRHXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AEC06178C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so4462025wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hi9tYbpGxDCHNvNclhCZQ2pZw/5KARTnXlMj7WGllS0=;
        b=jZoTvwM0v35r4ji2h3cvZ2WrsWKsriPxIGu3WApmdv1y5xFUHGn8lLRQDHhaXguVHR
         TVWY3N+4LtRkxFWUBLGO345I4h/TcudfTvdgR5u+im2JRZe66oSFBh/bjDDIhLV6qgzz
         MSrAhDGOEnjuhjnBmmFeim6tfV7iDCorXVNUJBbX1MMehQkC+ReeRN3VXrkZdI1QvqpD
         IKysRRPBsiC9dm/FXFtNovsV15KiXzHl4q3SU3WFxrgZ9DyKDpjKMWjtQq9epqXky6jT
         vuXdf1KSnAR2n6JyeNQ5b9K5jO1YN1/u6lOSK7faKjUC4HKiH+Dfew9xKPPmL5ltNeK9
         etHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hi9tYbpGxDCHNvNclhCZQ2pZw/5KARTnXlMj7WGllS0=;
        b=nOnntxyqUCHx+nHChZGWhu8fs4vqPrFVBBgXHw5i5Q/n69rvbysAOvHx3nsZW/DYVn
         lXPins36AWMNWCJAPJ2ByKzLJjRyzfltKYT88ao/uQ669x0jo8Mop/3L8v9CkSurkuIr
         HBBWXwA9tON+7JxqLd1n+RV384RHPsLutZBhedT71RtF9FGnwz/QD0sfphYGl2HmD+v9
         QbSkj1+xXE5i+E+LjSrGDVgLDGh1QPeFofaIvtTVfSf+EMR47fMkGyHwtczcqAeSBq73
         Hzo77p+63dB+NvYOiqGwVdicKuen9sWvP4gygJ1Km5eGqv/Leg0BrOi4C6+WGXJjSvgF
         cxDg==
X-Gm-Message-State: AOAM533hHR0PIsyRWGH4VoefxV8a2x1u6pXLM9YNXxdMLcIzWHv80LN6
        w0GMaNuLnX0eZXT56IG1YnRl0w==
X-Google-Smtp-Source: ABdhPJwEyxPv2PxOqMZtMsWPHvTH150YDYcVqjvCmh5q0ioYZrdvEP9jn1tHcWPlccDKPPzz1LshUw==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr14622505wmi.28.1600413817698;
        Fri, 18 Sep 2020 00:23:37 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:36 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 11/17] crypto: sun8i-ce: rename has_t_dlen_in_bytes to cipher_t_dlen_in_bytes
Date:   Fri, 18 Sep 2020 07:23:09 +0000
Message-Id: <1600413795-39256-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash algorithms will need also a spetial t_dlen handling, but since the
meaning will be different, rename the current flag to specify it apply
only on ciphers algorithms.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index cae307e6bcac..33707a2e55ff 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -118,7 +118,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	common |= rctx->op_dir | CE_COMM_INT;
 	cet->t_common_ctl = cpu_to_le32(common);
 	/* CTS and recent CE (H6) need length in bytes, in word otherwise */
-	if (ce->variant->has_t_dlen_in_bytes)
+	if (ce->variant->cipher_t_dlen_in_bytes)
 		cet->t_dlen = cpu_to_le32(areq->cryptlen);
 	else
 		cet->t_dlen = cpu_to_le32(areq->cryptlen / 4);
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 65748dfa7a48..688976011f07 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -61,7 +61,7 @@ static const struct ce_variant ce_h6_variant = {
 	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
-	.has_t_dlen_in_bytes = true,
+	.cipher_t_dlen_in_bytes = true,
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 6e191d1fa140..0b513771498a 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -97,7 +97,7 @@ struct ce_clock {
  * @alg_cipher:	list of supported ciphers. for each CE_ID_ this will give the
  *              coresponding CE_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @has_t_dlen_in_bytes:	Does the request size for cipher is in
+ * @cipher_t_dlen_in_bytes:	Does the request size for cipher is in
  *				bytes or words
  * @ce_clks:	list of clocks needed by this variant
  * @esr:	The type of error register
@@ -105,7 +105,7 @@ struct ce_clock {
 struct ce_variant {
 	char alg_cipher[CE_ID_CIPHER_MAX];
 	u32 op_mode[CE_ID_OP_MAX];
-	bool has_t_dlen_in_bytes;
+	bool cipher_t_dlen_in_bytes;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
 	int esr;
 };
-- 
2.26.2

