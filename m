Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47772B4544
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgKPNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbgKPNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:54:56 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE1C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:54:55 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so14192651pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xj+we/CZSSQ2b1f+Ofjy3j7GAiNPdJUEj3m5LkQW+Z8=;
        b=QIvhzR8Ka+4MVosZB5z2vAfqoBtB9TzQ48d6m+EVplyYd3cOKx846k4a1eO+P2R6RN
         AlrAPatTxO16vwFQoU0OPKP//FY9Z7wREd0Nw90AtWoSK4hp5cOGzXzq4w1vnYBuO/j0
         IQ3NErQ9Jd5jrIrb1c5EPzyI9rAw5QD3NUzI4e2IxvKffA/WXNQWAm4D1ZeH5lqWNilC
         cupOvUrSlmXyizE4EnOWgIfgZRHIBhWi/vlkIUI4Aq2PM6iP+pQ1eoW7wHKJyVpXLDLa
         ZsIx9a+PAKKTPylxGYpnAh2oYX4wZs7H4Xa7gFv9I7pEyPuRTBKpUuNvOf6KVptyAM96
         uWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xj+we/CZSSQ2b1f+Ofjy3j7GAiNPdJUEj3m5LkQW+Z8=;
        b=eIUGdCZCJJCvECTRNMhTyl8hk5OLyJN6JC+veteasDQAk+vhM106BAO3DW6eKav9Ju
         WlPR2kOrjhRbCw4xoEkjxKWr31HO7b4idHUOhXf7JlHouKEO915q1Axcyr4tWigJZ4gv
         fq0+nVhIiFKT6DVDRi0t9Q6Jbpq3pgxmOOBvt20Zo7Ak24jsRgk1Imm855yZ3psu3/N+
         taDR9SLDKrDrupMCJ9UoKomZ1kBDRLohL0A3gIW6kv6lXBKqfbWWwP1ur3fjxCmesYI7
         V3RQcyvI06bZtV0oZzjnsvubjbcnw3UEaUaqcTvKyNt4gYybYKY4XAcLWLejNQQNBgiW
         n1Ig==
X-Gm-Message-State: AOAM53387obng6GnJ96SW4trf9yoIcubPzMpnkdr+Ro7FWeQVpgnFLae
        W2zBW/rBdBqVXDtYuGDPMYiXRw==
X-Google-Smtp-Source: ABdhPJzp+Q2E1KWWfQx1H88HJTfsPtYT+sc+K9CT+oksYihVeFDXfoypPeVKyNox3TqdS+rOt6k3Dw==
X-Received: by 2002:a17:90a:1b44:: with SMTP id q62mr15651522pjq.59.1605534894775;
        Mon, 16 Nov 2020 05:54:54 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id u22sm15864031pgf.24.2020.11.16.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:54:54 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 6/7] crypto: sun4i-ss: enabled stats via debugfs
Date:   Mon, 16 Nov 2020 13:53:44 +0000
Message-Id: <20201116135345.11834-7-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116135345.11834-1-clabbe@baylibre.com>
References: <20201116135345.11834-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable to access usage stats for each algorithm.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/Kconfig              |  9 +++
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 20 +++++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 56 +++++++++++++++++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-hash.c |  6 ++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-prng.c |  5 ++
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |  6 ++
 6 files changed, 102 insertions(+)

diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index 0e72543ad1f1..e9b7f7e3d307 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -51,6 +51,15 @@ config CRYPTO_DEV_SUN4I_SS_PRNG
 	  Select this option if you want to provide kernel-side support for
 	  the Pseudo-Random Number Generator found in the Security System.
 
+config CRYPTO_DEV_SUN4I_SS_DEBUG
+	bool "Enable sun4i-ss stats"
+	depends on CRYPTO_DEV_SUN4I_SS
+	depends on DEBUG_FS
+	help
+	  Say y to enable sun4i-ss debug stats.
+	  This will create /sys/kernel/debug/sun4i-ss/stats for displaying
+	  the number of requests per algorithm.
+
 config CRYPTO_DEV_SUN8I_CE
 	tristate "Support for Allwinner Crypto Engine cryptographic offloader"
 	select CRYPTO_SKCIPHER
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index 7f4c97cc9627..5af404f74a98 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -34,6 +34,8 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	struct sg_mapping_iter mi, mo;
 	unsigned int oi, oo; /* offset for in and out */
 	unsigned long flags;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct sun4i_ss_alg_template *algt;
 
 	if (!areq->cryptlen)
 		return 0;
@@ -50,6 +52,12 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
 	}
 
+	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
+		algt = container_of(alg, struct sun4i_ss_alg_template, alg.crypto);
+		algt->stat_opti++;
+		algt->stat_bytes += areq->cryptlen;
+	}
+
 	spin_lock_irqsave(&ss->slock, flags);
 
 	for (i = 0; i < op->keylen / 4; i++)
@@ -134,6 +142,13 @@ static int noinline_for_stack sun4i_ss_cipher_poll_fallback(struct skcipher_requ
 	struct sun4i_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	struct sun4i_cipher_req_ctx *ctx = skcipher_request_ctx(areq);
 	int err;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct sun4i_ss_alg_template *algt;
+
+	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
+		algt = container_of(alg, struct sun4i_ss_alg_template, alg.crypto);
+		algt->stat_fb++;
+	}
 
 	skcipher_request_set_tfm(&ctx->fallback_req, op->fallback_tfm);
 	skcipher_request_set_callback(&ctx->fallback_req, areq->base.flags,
@@ -221,6 +236,11 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
 	}
 
+	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
+		algt->stat_req++;
+		algt->stat_bytes += areq->cryptlen;
+	}
+
 	spin_lock_irqsave(&ss->slock, flags);
 
 	for (i = 0; i < op->keylen / 4; i++)
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
index a2b67f7f8a81..9a8a5e246d87 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/clk.h>
 #include <linux/crypto.h>
+#include <linux/debugfs.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -234,6 +235,53 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 #endif
 };
 
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+static int sun4i_ss_dbgfs_read(struct seq_file *seq, void *v)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ss_algs); i++) {
+		if (!ss_algs[i].ss)
+			continue;
+		switch (ss_algs[i].type) {
+		case CRYPTO_ALG_TYPE_SKCIPHER:
+			seq_printf(seq, "%s %s reqs=%lu opti=%lu fallback=%lu tsize=%lu\n",
+				   ss_algs[i].alg.crypto.base.cra_driver_name,
+				   ss_algs[i].alg.crypto.base.cra_name,
+				   ss_algs[i].stat_req, ss_algs[i].stat_opti, ss_algs[i].stat_fb,
+				   ss_algs[i].stat_bytes);
+			break;
+		case CRYPTO_ALG_TYPE_RNG:
+			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
+				   ss_algs[i].alg.rng.base.cra_driver_name,
+				   ss_algs[i].alg.rng.base.cra_name,
+				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
+			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			seq_printf(seq, "%s %s reqs=%lu\n",
+				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
+				   ss_algs[i].alg.hash.halg.base.cra_name,
+				   ss_algs[i].stat_req);
+			break;
+		}
+	}
+	return 0;
+}
+
+static int sun4i_ss_dbgfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sun4i_ss_dbgfs_read, inode->i_private);
+}
+
+static const struct file_operations sun4i_ss_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = sun4i_ss_dbgfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#endif
+
 /*
  * Power management strategy: The device is suspended unless a TFM exists for
  * one of the algorithms proposed by this driver.
@@ -454,6 +502,14 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 			break;
 		}
 	}
+
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	/* Ignore error of debugfs */
+	ss->dbgfs_dir = debugfs_create_dir("sun4i-ss", NULL);
+	ss->dbgfs_stats = debugfs_create_file("stats", 0444, ss->dbgfs_dir, ss,
+					      &sun4i_ss_debugfs_fops);
+#endif
+
 	return 0;
 error_alg:
 	i--;
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
index 1dff48558f53..c1b4585e9bbc 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
@@ -191,8 +191,10 @@ static int sun4i_hash(struct ahash_request *areq)
 	u32 spaces, rx_cnt = SS_RX_DEFAULT, bf[32] = {0}, v, ivmode = 0;
 	struct sun4i_req_ctx *op = ahash_request_ctx(areq);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
 	struct sun4i_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
 	struct sun4i_ss_ctx *ss = tfmctx->ss;
+	struct sun4i_ss_alg_template *algt;
 	struct scatterlist *in_sg = areq->src;
 	struct sg_mapping_iter mi;
 	int in_r, err = 0;
@@ -398,6 +400,10 @@ static int sun4i_hash(struct ahash_request *areq)
  */
 
 hash_final:
+	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
+		algt = container_of(alg, struct sun4i_ss_alg_template, alg.hash);
+		algt->stat_req++;
+	}
 
 	/* write the remaining words of the wait buffer */
 	if (op->len) {
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
index 729aafdbea84..152841076e3a 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
@@ -32,6 +32,11 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	if (err < 0)
 		return err;
 
+	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
+		algt->stat_req++;
+		algt->stat_bytes += todo;
+	}
+
 	spin_lock_bh(&ss->slock);
 
 	writel(mode, ss->base + SS_CTL);
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index 02105b39fbfe..e3e6cddf64af 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -154,6 +154,8 @@ struct sun4i_ss_ctx {
 #ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
 	u32 seed[SS_SEED_LEN / BITS_PER_LONG];
 #endif
+	struct dentry *dbgfs_dir;
+	struct dentry *dbgfs_stats;
 };
 
 struct sun4i_ss_alg_template {
@@ -165,6 +167,10 @@ struct sun4i_ss_alg_template {
 		struct rng_alg rng;
 	} alg;
 	struct sun4i_ss_ctx *ss;
+	unsigned long stat_req;
+	unsigned long stat_fb;
+	unsigned long stat_bytes;
+	unsigned long stat_opti;
 };
 
 struct sun4i_tfm_ctx {
-- 
2.26.2

