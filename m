Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9EF202C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgFUTbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbgFUTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:31:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A9C061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v3so7078680wrc.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9LtbB6jJYdkSAlPSi7HcYLddub06whxFmnV1QYfDeqI=;
        b=CaHX4oYyVwhk+ok3BQoZwK9dT64WCKhI5bpEVni7atCAQ78BgZVy5kke2fQBpLn2JL
         9435FvKDHhSxbPNg8FQsdjY3ovPLQWCWLJwLA8FuaockWJ2W26i1bnOrEJ5bhcfFcA0A
         0xhSDxw6Ez3dOOozXmuH4tvNWJHtBSVXzVq7rSNGrZB1H4fdLC5piJfHEnseec6fEa6i
         KAs7q22/8uyO62zRJb2kfcOUXG1ZLQ5Lv3wmglBkf48VmT35L7o2cVcnoJI9NVVaVgfA
         SH1FM36VwmXPHjgKcX7rQre8th/osZkYT7YT2U7FpLrRu6uolKLqnFSWR2z8BUxirfGK
         YynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9LtbB6jJYdkSAlPSi7HcYLddub06whxFmnV1QYfDeqI=;
        b=r+yJYM2epDKszmuOeuCuqPAMgBUKENDtSJkd3xcOTP4opYOuhMw6cyLi3QztXGTzev
         YM92zBigaItzblmr1mO4h31JKqNRQlkboN+6XaDi+DBrgBi9tqVwqhm4Y73nfqmGekgK
         r0z9hWSOQFwFKOZgP96lCfZFGYd+fNDgjDOz9QBxyzYk+1jimIFGWLWckc5eU6SGYBlU
         iNCSWwk8AG1kp+eUh7OxSs7DvaqSA7Z0OFsadEWaPf4NR36dW/IPrPsN3JVJSZ1kMQp0
         rEj/WvoahjpLEGhc/nT1Htje0kR+p//iYElfZacE+zzruoPJ3RtXSBqDYvJZLH/5BEju
         Z3AA==
X-Gm-Message-State: AOAM533pNR5PZUbvUY6ONHyvAAEG/vNzAIUDtPjQq+LBgwdZQTAZtVvd
        2cOyoljcRj3H7jBQm4+/E1IRhw==
X-Google-Smtp-Source: ABdhPJzZzxYhCTxEhC1PRk6CXsMAAbd6IIH2RULn96+njCRcaeQgGpzlkQmy3DFprxAqXfEI62EOhw==
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr15481133wrj.415.1592767881444;
        Sun, 21 Jun 2020 12:31:21 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e3sm16086924wrj.17.2020.06.21.12.31.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:31:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 09/14] crypto: sun8i-ce: handle different error registers
Date:   Sun, 21 Jun 2020 19:31:02 +0000
Message-Id: <1592767867-35982-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
References: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error registers are different across SoCs.
This patch handle those difference.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 62 ++++++++++++++++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  8 +++
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index b957061424a1..94969f86b967 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -40,7 +40,8 @@ static const struct ce_variant ce_h3_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 50000000, 0 },
-		}
+		},
+	.esr = ESR_H3,
 };
 
 static const struct ce_variant ce_h5_variant = {
@@ -51,7 +52,8 @@ static const struct ce_variant ce_h5_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
-		}
+		},
+	.esr = ESR_H5,
 };
 
 static const struct ce_variant ce_h6_variant = {
@@ -64,7 +66,8 @@ static const struct ce_variant ce_h6_variant = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
 		{ "ram", 0, 400000000 },
-		}
+		},
+	.esr = ESR_H6,
 };
 
 static const struct ce_variant ce_a64_variant = {
@@ -75,7 +78,8 @@ static const struct ce_variant ce_a64_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
-		}
+		},
+	.esr = ESR_A64,
 };
 
 static const struct ce_variant ce_r40_variant = {
@@ -86,7 +90,8 @@ static const struct ce_variant ce_r40_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
-		}
+		},
+	.esr = ESR_R40,
 };
 
 /*
@@ -102,6 +107,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 {
 	u32 v;
 	int err = 0;
+	struct ce_task *cet = ce->chanlist[flow].tl;
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	ce->chanlist[flow].stat_req++;
@@ -128,19 +134,56 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			msecs_to_jiffies(ce->chanlist[flow].timeout));
 
 	if (ce->chanlist[flow].status == 0) {
-		dev_err(ce->dev, "DMA timeout for %s\n", name);
+		dev_err(ce->dev, "DMA timeout for %s (tm=%d) on flow %d\n", name,
+			ce->chanlist[flow].timeout, flow);
 		err = -EFAULT;
 	}
 	/* No need to lock for this read, the channel is locked so
 	 * nothing could modify the error value for this channel
 	 */
 	v = readl(ce->base + CE_ESR);
-	if (v) {
+	switch (ce->variant->esr) {
+	case ESR_H3:
+		/* Sadly, the error bit is not per flow */
+		if (v) {
+			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
+			err = -EFAULT;
+			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4,
+				       cet, sizeof(struct ce_task), false);
+		}
+		if (v & CE_ERR_ALGO_NOTSUP)
+			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
+		if (v & CE_ERR_DATALEN)
+			dev_err(ce->dev, "CE ERROR: data length error\n");
+		if (v & CE_ERR_KEYSRAM)
+			dev_err(ce->dev, "CE ERROR: keysram access error for AES\n");
+		break;
+	case ESR_A64:
+	case ESR_H5:
+	case ESR_R40:
 		v >>= (flow * 4);
+		v &= 0xF;
+		if (v) {
+			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
+			err = -EFAULT;
+			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4,
+				       cet, sizeof(struct ce_task), false);
+		}
+		if (v & CE_ERR_ALGO_NOTSUP)
+			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
+		if (v & CE_ERR_DATALEN)
+			dev_err(ce->dev, "CE ERROR: data length error\n");
+		if (v & CE_ERR_KEYSRAM)
+			dev_err(ce->dev, "CE ERROR: keysram access error for AES\n");
+		break;
+	case ESR_H6:
+		v >>= (flow * 8);
 		v &= 0xFF;
 		if (v) {
 			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
 			err = -EFAULT;
+			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4,
+				       cet, sizeof(struct ce_task), false);
 		}
 		if (v & CE_ERR_ALGO_NOTSUP)
 			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
@@ -150,7 +193,10 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			dev_err(ce->dev, "CE ERROR: keysram access error for AES\n");
 		if (v & CE_ERR_ADDR_INVALID)
 			dev_err(ce->dev, "CE ERROR: address invalid\n");
-		}
+		if (v & CE_ERR_KEYLADDER)
+			dev_err(ce->dev, "CE ERROR: key ladder configuration error\n");
+		break;
+	}
 
 	return err;
 }
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index fe97fee74e47..ed1a91da967b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -65,6 +65,12 @@
 #define CE_ERR_ADDR_INVALID	BIT(5)
 #define CE_ERR_KEYLADDER	BIT(6)
 
+#define ESR_H3	0
+#define ESR_A64	1
+#define ESR_R40	2
+#define ESR_H5	3
+#define ESR_H6	4
+
 #define CE_DIE_ID_SHIFT	16
 #define CE_DIE_ID_MASK	0x07
 
@@ -94,12 +100,14 @@ struct ce_clock {
  * @has_t_dlen_in_bytes:	Does the request size for cipher is in
  *				bytes or words
  * @ce_clks:	list of clocks needed by this variant
+ * @esr:	The type of error register
  */
 struct ce_variant {
 	char alg_cipher[CE_ID_CIPHER_MAX];
 	u32 op_mode[CE_ID_OP_MAX];
 	bool has_t_dlen_in_bytes;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
+	int esr;
 };
 
 struct sginfo {
-- 
2.26.2

