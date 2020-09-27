Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431D127A2FC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI0Tzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:55:36 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10070
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbgI0Tzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:33 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169501"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:14 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] crypto: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:23 +0200
Message-Id: <1601233948-11629-14-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/crypto/amcc/crypto4xx_alg.c |    2 +-
 drivers/crypto/hifn_795x.c          |    4 ++--
 drivers/crypto/talitos.c            |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/crypto4xx_alg.c
index f7fc0c464125..7729a637fb02 100644
--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -55,7 +55,7 @@ static void set_dynamic_sa_command_1(struct dynamic_sa_ctl *sa, u32 cm,
 	sa->sa_command_1.w = 0;
 	sa->sa_command_1.bf.crypto_mode31 = (cm & 4) >> 2;
 	sa->sa_command_1.bf.crypto_mode9_8 = cm & 3;
-	sa->sa_command_1.bf.feedback_mode = cfb,
+	sa->sa_command_1.bf.feedback_mode = cfb;
 	sa->sa_command_1.bf.sa_rev = 1;
 	sa->sa_command_1.bf.hmac_muting = hmac_mc;
 	sa->sa_command_1.bf.extended_seq_num = esn;
diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
index bfc4ac0e4ac4..7e7a8f01ea6b 100644
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -780,8 +780,8 @@ static int hifn_register_rng(struct hifn_device *dev)
 						   dev->pk_clk_freq) * 256;
 
 	dev->rng.name		= dev->name;
-	dev->rng.data_present	= hifn_rng_data_present,
-	dev->rng.data_read	= hifn_rng_data_read,
+	dev->rng.data_present	= hifn_rng_data_present;
+	dev->rng.data_read	= hifn_rng_data_read;
 	dev->rng.priv		= (unsigned long)dev;
 
 	return hwrng_register(&dev->rng);
diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 7c547352a862..66773892f665 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -806,10 +806,10 @@ static int talitos_register_rng(struct device *dev)
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	int err;
 
-	priv->rng.name		= dev_driver_string(dev),
-	priv->rng.init		= talitos_rng_init,
-	priv->rng.data_present	= talitos_rng_data_present,
-	priv->rng.data_read	= talitos_rng_data_read,
+	priv->rng.name		= dev_driver_string(dev);
+	priv->rng.init		= talitos_rng_init;
+	priv->rng.data_present	= talitos_rng_data_present;
+	priv->rng.data_read	= talitos_rng_data_read;
 	priv->rng.priv		= (unsigned long)dev;
 
 	err = hwrng_register(&priv->rng);

