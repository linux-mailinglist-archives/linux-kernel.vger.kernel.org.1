Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC124D67D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgHUNrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgHUNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38628C0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so2013122wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gSXaIPMXv2p2JdvokUaT0GeoWLMWWGeoBVt/sDwVK3w=;
        b=Rtq/FY2b1l/uTm1zqNRGcMOki4Nhr90y8dw36UY9OBKk1wt7vX9yWf/ZMj8F+6xtXq
         YTDbvFOBtAQxU0LR/qyk8fPz3GIwtOZ1BwetfUi54GgTFgw0LXoscAtctxcy/NbeVmSs
         jL1O0aWDIjWryXP/AC6K36dEYxdJROGpH6SJumsBWX43dt7wuubHClbboH8u2l0Pulp4
         ByImav3DVG+N+1lu6hF2URdYdoJwFU/fbyRYjDz2WQ2v9jXCoP8yXCjn1sIIdxc/m7dx
         w6Kq+OPApVJFC+Uv4qarFCiViA0ogUwrEp3N00AGK4BjWl4epMnx14/4RpgghfJoHAS3
         9RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gSXaIPMXv2p2JdvokUaT0GeoWLMWWGeoBVt/sDwVK3w=;
        b=b+aIrwcGgMvu4WzI+RttUwzrweToAnRd/z1ilykx05xz0o06dP7UUnJHOMrhyIeVGu
         YTU38L9OzPKHf2TleYvvzc1jYdL8oWl5I4MqF7LkZUdagJsigrStxcGg1JvJGDM8zDHR
         Tp7G+1sEh1WR2upZsHcudkLICqDeWYUeWeggYuP/s/+F9UzQOlTdsFWuWlUdzKt3SdFe
         eCnxRK0luLaKwNe9AV9g98SykB8GKWgQLgasSMY1c4BEQsl99dJXcgpy7rJdkQcMT+2J
         b4vYxGDEHYMGG4gHd7d/XL1oU6lhK1JZehXu82QK8c9+yY3sG1YUopmO3DlQb8ZabHrD
         ph/w==
X-Gm-Message-State: AOAM533RNZLg3/nS/9IvO2LyDEH8VA2OXoWqL7QSS7PyvVWK0EDHA0tF
        xPUyca1CkkIzNV97uXOLQAoUCQ==
X-Google-Smtp-Source: ABdhPJz3B6InTIkOYqEFv4i/KcOzpg+W9FPTs9aKP7I5q6ENyn3219x88CEP/HrtsXh7inepIEQzFA==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr2763001wrq.30.1598017434935;
        Fri, 21 Aug 2020 06:43:54 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 11/18] crypto: sun8i-ce: rename has_t_dlen_in_bytes to cipher_t_dlen_in_bytes
Date:   Fri, 21 Aug 2020 13:43:28 +0000
Message-Id: <1598017415-39059-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index fa12c966c45f..2dcf508b0f18 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -119,7 +119,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
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
index eea0847dc1e8..3dbf8ca47b7c 100644
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

