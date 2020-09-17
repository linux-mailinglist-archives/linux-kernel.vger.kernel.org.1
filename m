Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C826E3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIQSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgIQSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:36:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B2C061353
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so3142795wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9qViGrdUGpa0ThWB+YcFxDSbeYaJXJqK+FKlEA3vuxA=;
        b=nXYqabRMAd6ecAv6o7n+gbyP8lIEInIM1bduwtk6gkOAsnFCZFVNSEbxc4gjOhn2He
         ptpAwvp9f3TYVItGu0CWnX8YSH/bNnf0ThJJc04JiOHRtJMed/bQytK4fSDx4xLq5ZFy
         2m4lN2B4zic6x4Z0W5EltglSFnAcB7ulIL3JEUQJH5Hr2l/z6JlRsNalfq6BcCfjKvAj
         A/ePNKMUbjPbVkZSg+jaPLF0FQ+UpFYLQ/Rcio52l545Dp9pyaJkaLSFTbVsYy8PWjf/
         ffSH9+EovqeSe4kEUnRyjBJXUU1DtlGiKikA5V3fqYz9taWP5JG+htBaVRd3EDpVFT9l
         lffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9qViGrdUGpa0ThWB+YcFxDSbeYaJXJqK+FKlEA3vuxA=;
        b=qZ7fLQnKUxl+cAUnchWYX9bwLQu5/EFO7CeMvlf7QA0hlMa5Z+moBmEMmsBYpFqbAn
         6wXCfj9BJIE53fK3jxZP81ZSqPUuKH5pmIUSLQdlwofIkS2tGxI4aWb+AR7ZKHqe2fss
         PfeV0lIy+QCPv99JIH6pqk8hJZeBzpzcI3PY4n29fHegd4IFA4WxPw/esoR6qM8bz0jV
         K5j+K8uzYaFmbmciFOdLaK2uJdJKnXVVwJrqBKsnB1hML8SJu9IPl6Rxq9lXn+bpcawh
         /YOUXxaMMkRNh5SMfP3ua/9uzpVJcShETyxAWc1Cf2FX/O3Y2eGRsQcEju6Q/DWjbk0S
         5thA==
X-Gm-Message-State: AOAM533Ff96RnJ/oUu5gzFR5Hbelv7UzlHDxylsXECh+qwYUyer1xix8
        higmRybeF6LzsJ2/4nbZNOplxg==
X-Google-Smtp-Source: ABdhPJy7+7QERE4fHeCWidnhS46dr4Oq55POtQVLZeXG+8jIPa6GyhVDO/qNZvzRbwQjpN82CwAdSw==
X-Received: by 2002:adf:81e6:: with SMTP id 93mr33456129wra.412.1600367771799;
        Thu, 17 Sep 2020 11:36:11 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x16sm571901wrq.62.2020.09.17.11.36.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:36:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH 4/7] crypto: sun4i-ss: handle BigEndian for cipher
Date:   Thu, 17 Sep 2020 18:35:55 +0000
Message-Id: <1600367758-28589-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
References: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ciphers produce invalid results on BE.
Key and IV need to be written in LE.
Furthermore, the non-optimized function is too complicated to convert,
let's simply fallback on BE for the moment.

Fixes: 6298e948215f2 ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index c6c25204780d..d66bb9cf657c 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -52,13 +52,13 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 
 	spin_lock_irqsave(&ss->slock, flags);
 
-	for (i = 0; i < op->keylen; i += 4)
-		writel(*(op->key + i / 4), ss->base + SS_KEY0 + i);
+	for (i = 0; i < op->keylen / 4; i++)
+		writel(cpu_to_le32(op->key[i]), ss->base + SS_KEY0 + i * 4);
 
 	if (areq->iv) {
 		for (i = 0; i < 4 && i < ivsize / 4; i++) {
 			v = *(u32 *)(areq->iv + i * 4);
-			writel(v, ss->base + SS_IV0 + i * 4);
+			writel(cpu_to_le32(v), ss->base + SS_IV0 + i * 4);
 		}
 	}
 	writel(mode, ss->base + SS_CTL);
@@ -213,6 +213,11 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	if (no_chunk == 1 && !need_fallback)
 		return sun4i_ss_opti_poll(areq);
 
+/* The non aligned function does not work on BE. Probably due to buf/bufo handling.*/
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	need_fallback = true;
+#endif
+
 	if (need_fallback)
 		return sun4i_ss_cipher_poll_fallback(areq);
 
@@ -225,13 +230,13 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 
 	spin_lock_irqsave(&ss->slock, flags);
 
-	for (i = 0; i < op->keylen; i += 4)
-		writel(*(op->key + i / 4), ss->base + SS_KEY0 + i);
+	for (i = 0; i < op->keylen / 4; i++)
+		writel(cpu_to_le32(op->key[i]), ss->base + SS_KEY0 + i * 4);
 
 	if (areq->iv) {
 		for (i = 0; i < 4 && i < ivsize / 4; i++) {
 			v = *(u32 *)(areq->iv + i * 4);
-			writel(v, ss->base + SS_IV0 + i * 4);
+			writel(cpu_to_le32(v), ss->base + SS_IV0 + i * 4);
 		}
 	}
 	writel(mode, ss->base + SS_CTL);
-- 
2.26.2

