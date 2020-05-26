Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2C41A64FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgDMKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728142AbgDMKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B41C008615
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so8855686wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KJ5PBE+QCFWEenkZ4gUgAJxpbhutHi1vjlsaJ3JQibs=;
        b=e1WrT4KcRVi9wuVJVygj8vhAkk71TGHmHpMYTjCJuHliLGWyDssU9cGqkK2CSWVejb
         4tT7JgSQKtWSPtNh3MjeQe8Xag+jQXEUvDzA4/c/aaEnJYs60cHLHBhujmeY4hi+2jOZ
         QOgTyQT1PBEuG3CNM4Dzr7gnqon6jRP/XbvFjRMA5pLCqDH5m4NWksv6aOpkM35twxc1
         C5RVOi9OWRzoAxTOoZeZX/Rqh/7Sb5KQ8kMAoxCxBZfIrd4KOqCmv7p62qTS15T2tZaM
         4LPqKZuEN8KUTxxGwhYIznawduuzubHIjr/o+hRL6rcZfZRKmub0W2+6H1q20NktRFAE
         pIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KJ5PBE+QCFWEenkZ4gUgAJxpbhutHi1vjlsaJ3JQibs=;
        b=C2V4NVjxy6rvq/kJXfcZc4sYL0mlY9oSzPgubjqYU3QLzxyp5rM4OA01KQ2I1W0Rw+
         wHp3pU4w0oh8n9wouMX0HLhxhUh5eeW2pUAPkx6xt8km4rAIHvvyJ8nQhX4mWoDHpF5U
         53XAM1T/OpSnhbjjk1yzf1YmUx4xQvDD7D9+hEdt0mtY/HXPkCUUVV5w2Nsp3PHggExX
         r7j0WaEYI9CDSom/HsqvghAqKKjx31A7ACJ0tKdNagSnzrp3eUAY5UH2NXj7UD+/2yVe
         REsLPIl9wikOc1hsBYIBXTOxdDmAlaoHOqBRlDT9PuCxqOjysatgQ8sQ/m7dWZFmvog3
         ZNOQ==
X-Gm-Message-State: AGi0PuZLnCa+3iZOZOgjL0TegKlKbOBVNax681adQG84j6KDlq3d0jlO
        toRVw3BLegFQADr+senvKVBXSz167y4=
X-Google-Smtp-Source: APiQypI8Oui5Njp9cGwOgZMXxDuOowTpat6FLkW6gIqG5p+5OQvCmGnkx5jBVxT8gj6Q9S2kjdEoxw==
X-Received: by 2002:a1c:c90a:: with SMTP id f10mr17527326wmb.179.1586771902925;
        Mon, 13 Apr 2020 02:58:22 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v21sm13594491wmj.8.2020.04.13.02.58.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:58:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 7/9] crypto: sun8i-ce: Add stat_bytes debugfs
Date:   Mon, 13 Apr 2020 09:58:07 +0000
Message-Id: <1586771889-3299-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
References: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new stat_bytes counter in the sun8i-ce debugfs.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 19ced8b1cd89..ef2f1e5aa23a 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -274,6 +274,7 @@ struct sun8i_ce_hash_reqctx {
  * @alg:		one of sub struct must be used
  * @stat_req:		number of request done on this template
  * @stat_fb:		number of request which has fallbacked
+ * @stat_bytes:		total data size done by this template
  */
 struct sun8i_ce_alg_template {
 	u32 type;
@@ -287,6 +288,7 @@ struct sun8i_ce_alg_template {
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
 	unsigned long stat_fb;
+	unsigned long stat_bytes;
 #endif
 };
 
-- 
2.24.1

