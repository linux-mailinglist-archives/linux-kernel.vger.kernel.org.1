Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0405226F6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgIRHYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIRHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8637C061788
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so4528984wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAJr0WUBE2yPoGEM0vPOoVgLMpfMjYp+OuqF+6nqpSk=;
        b=SFIM4JP+6m5x1WlaOHwJ1FjHDI54a9cNYWR6y99+VFV5CAqHcZAvJDHJ1Bv5TAgPgT
         9HngpVcpC9+8DpdQ3wBat8m4phFf6gIGgUOp8/xnYuJ24Etc2vPoWrgXtBAJyzl+wnNG
         Gn/lJaPIkkKwXL9a3p1rUOv2ZiNMFTqyzEZLc9Al+MVt5Vv9LiRCLYjbtq6uwx1cltoG
         b++2/ruZNIHdOYV/ncTo3E7bB8I5ZXcaJYQUYozhjXOJBsdOb78RS42yZms1eZ3/3VJG
         TTxddYPQdSfV/PkZa6l8BfNAoamvOjemDubJPb3pJzkEYuxHFMJ31I9TZSWuQY8jP8/u
         CdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NAJr0WUBE2yPoGEM0vPOoVgLMpfMjYp+OuqF+6nqpSk=;
        b=Zz4FC/fiXeRBOKrTn2Dka58TIUQpYcapM2GkuYGQjTGEA5cEzrp3k6z6ReemRnL6mn
         hDsKCxhcvrIAsp19JIKkG0C1wdP+9H1wN/TqDmRogfBDYjZV6BiQxTkbRl9BsGTBHmTB
         lR7KCvedOJgBW7xCyt4L9lIBQ+I8bUkaFm+G4bIYv1qQDY6SMjf+n+8KJcY24u0eA0Sp
         /h2pBgRvlIU+sVEJ6tU+dF2CnxA+Swsp5UK2NIYmcWhEvyYx17tFBGMuxwSaN/7CwcyZ
         +bO3/3wiDZ/GTdC0X+EL6MjVc800HSlkPNnEnvJEJo84x3NpYhy5He5RMJB1DFZ4r8E7
         Fn4w==
X-Gm-Message-State: AOAM533bOB3TyC1WP5epgE8AaEgP7MQW54cA5IL4wyID3j4+WqBebPwR
        dwAo71U6i5kIHFEgySyROkipPA==
X-Google-Smtp-Source: ABdhPJxwU2nFPwZX9AjZprEjU6MH6zoF/lNhvLZ7R/RxUzKf6tq3tjCmgCZ6zh+T6ksWMsXaNS9GxA==
X-Received: by 2002:adf:db48:: with SMTP id f8mr37456013wrj.144.1600413816422;
        Fri, 18 Sep 2020 00:23:36 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:35 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 10/17] crypto: sun8i-ce: handle different error registers
Date:   Fri, 18 Sep 2020 07:23:08 +0000
Message-Id: <1600413795-39256-11-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
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
index 08ed1ca12baf..65748dfa7a48 100644
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
@@ -131,19 +137,56 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
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
@@ -153,7 +196,10 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
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
index c3053326afe9..6e191d1fa140 100644
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

