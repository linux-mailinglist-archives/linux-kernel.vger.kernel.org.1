Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A487A26E3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIQSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIQSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:36:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28489C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so3116611wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdHelnHrIfhdBmXdug1FChKyG7T3Sv9OQk7JTWtycnw=;
        b=XClmft36wq66EBrOpv8lSS73dG/SktaF4Nc0VJZtC1/dzAUC/4zNXqLulkOXCikLpq
         UXrUZPpMwk0+lw9g6z5lZYQzF4eZS2hLDMxoK6rab3DjqDD32q6dN+fyCv9FLoF5YU6f
         BcM3AbfAJPogtKDBJ319T0X3XwzXa4PMyZ6O54SyFgdr4mn6kMooLmg717bujnbxJdU6
         AkVnL8Szk1NEciRmmoQMMKAAmrEL/VDN9hmAu48b7q/FCmkXZLMZJAVzwbTFm0K2q0JL
         km0hMPTptvN1ai5/7pn7+miqaVWvwKq2PDJPd/Ka51lO1OLyZSVLoXhfK43r9N7601LM
         t2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdHelnHrIfhdBmXdug1FChKyG7T3Sv9OQk7JTWtycnw=;
        b=rxf2wLLFDFiWTMzDjIW0TzW8GIdQmhLbE9yCGmKZ8NpHboKb56kO0TRgVR0tahngWD
         egQ0uMvdE3vw+JKGbsnmMJyndtj7sziS62RgZk+ueDneEbK3pToyHwHkV5jsfQsf8cVS
         G/lZKqZj2VZdAaP910lhkBEx54SDJ+rZU5ggOI8ELdD0FzyF5/Pd1JDxkyyWeZFC2JC7
         dlqWiIyCq+tyskFMm8NKLFjHUabsnFYk9wexsFCar1xD/Qi8rJPeC2NzQvMtww4mi6Oy
         nez0U45Dge8qeZBH35p2VB9MYUkMoUd4KdajfgpO9zZtLKj0g233cmL2596YycozaB/s
         ivuQ==
X-Gm-Message-State: AOAM5338jN2L73W6d1dmPeKnFq2MXYFTsOnFSsSeiDG8SEQHBDN8iiAS
        bbg0YjKbWNJX95aSZfGAngWBaQ==
X-Google-Smtp-Source: ABdhPJwfEu7lEY94WzW8h+jGsLcci6F5r/8iU0L+hzcDtJIrfCTxLwLochPoKHE13UDzQjktO/N2KQ==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr33777987wra.21.1600367773784;
        Thu, 17 Sep 2020 11:36:13 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x16sm571901wrq.62.2020.09.17.11.36.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:36:13 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 6/7] crypto: sun4i-ss: enabled stats via debugfs
Date:   Thu, 17 Sep 2020 18:35:57 +0000
Message-Id: <1600367758-28589-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
References: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable to access usage stats for each algorithm.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/Kconfig              |  9 ++++
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 21 ++++++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 54 +++++++++++++++++++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-hash.c |  8 +++
 .../crypto/allwinner/sun4i-ss/sun4i-ss-prng.c |  5 ++
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  | 11 ++++
 6 files changed, 108 insertions(+)

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
index c21a1a0a8b16..be6599220e9d 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -34,6 +34,10 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	struct sg_mapping_iter mi, mo;
 	unsigned int oi, oo; /* offset for in and out */
 	unsigned long flags;
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct sun4i_ss_alg_template *algt;
+#endif
 
 	if (!areq->cryptlen)
 		return 0;
@@ -50,6 +54,12 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
 	}
 
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	algt = container_of(alg, struct sun4i_ss_alg_template, alg.crypto);
+	algt->stat_opti++;
+	algt->stat_bytes += areq->cryptlen;
+#endif
+
 	spin_lock_irqsave(&ss->slock, flags);
 
 	for (i = 0; i < op->keylen / 4; i++)
@@ -134,7 +144,13 @@ static int noinline_for_stack sun4i_ss_cipher_poll_fallback(struct skcipher_requ
 	struct sun4i_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	struct sun4i_cipher_req_ctx *ctx = skcipher_request_ctx(areq);
 	int err;
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct sun4i_ss_alg_template *algt;
 
+	algt = container_of(alg, struct sun4i_ss_alg_template, alg.crypto);
+	algt->stat_fb++;
+#endif
 	skcipher_request_set_tfm(&ctx->fallback_req, op->fallback_tfm);
 	skcipher_request_set_callback(&ctx->fallback_req, areq->base.flags,
 				      areq->base.complete, areq->base.data);
@@ -228,6 +244,11 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
 	}
 
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	algt->stat_req++;
+	algt->stat_bytes += areq->cryptlen;
+#endif
+
 	spin_lock_irqsave(&ss->slock, flags);
 
 	for (i = 0; i < op->keylen / 4; i++)
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
index a2b67f7f8a81..d044eb8f88b6 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
@@ -234,6 +234,53 @@ static struct sun4i_ss_alg_template ss_algs[] = {
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
@@ -454,6 +501,13 @@ static int sun4i_ss_probe(struct platform_device *pdev)
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
 	return 0;
 error_alg:
 	i--;
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
index dc35edd90034..3da60256f498 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
@@ -197,6 +197,10 @@ static int sun4i_hash(struct ahash_request *areq)
 	int in_r, err = 0;
 	size_t copied = 0;
 	__le32 wb = 0;
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun4i_ss_alg_template *algt;
+#endif
 
 	dev_dbg(ss->dev, "%s %s bc=%llu len=%u mode=%x wl=%u h0=%0x",
 		__func__, crypto_tfm_alg_name(areq->base.tfm),
@@ -397,6 +401,10 @@ static int sun4i_hash(struct ahash_request *areq)
  */
 
 hash_final:
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	algt = container_of(alg, struct sun4i_ss_alg_template, alg.hash);
+	algt->stat_req++;
+#endif
 
 	/* write the remaining words of the wait buffer */
 	if (op->len) {
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
index 729aafdbea84..102f8a90ce0f 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c
@@ -32,6 +32,11 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	if (err < 0)
 		return err;
 
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	algt->stat_req++;
+	algt->stat_bytes += todo;
+#endif
+
 	spin_lock_bh(&ss->slock);
 
 	writel(mode, ss->base + SS_CTL);
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index 163962f9e284..a98a2c05089b 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/crypto.h>
+#include <linux/debugfs.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -152,6 +153,10 @@ struct sun4i_ss_ctx {
 #ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
 	u32 seed[SS_SEED_LEN / BITS_PER_LONG];
 #endif
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	struct dentry *dbgfs_dir;
+	struct dentry *dbgfs_stats;
+#endif
 };
 
 struct sun4i_ss_alg_template {
@@ -163,6 +168,12 @@ struct sun4i_ss_alg_template {
 		struct rng_alg rng;
 	} alg;
 	struct sun4i_ss_ctx *ss;
+#ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
+	unsigned long stat_req;
+	unsigned long stat_fb;
+	unsigned long stat_bytes;
+	unsigned long stat_opti;
+#endif
 };
 
 struct sun4i_tfm_ctx {
-- 
2.26.2

