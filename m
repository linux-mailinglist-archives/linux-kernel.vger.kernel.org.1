Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67CE299689
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792657AbgJZTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:13:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48744 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392992AbgJZTGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:06:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E54FD1A056F;
        Mon, 26 Oct 2020 20:06:35 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D85FA1A00AB;
        Mon, 26 Oct 2020 20:06:35 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6223820308;
        Mon, 26 Oct 2020 20:06:35 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Andrei Botila <andrei.botila@nxp.com>,
        Dragos Rosioru <dragos.rosioru@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v2] crypto: caam - enable crypto-engine retry mechanism
Date:   Mon, 26 Oct 2020 21:06:26 +0200
Message-Id: <1603739186-4007-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new crypto_engine_alloc_init_and_set() function to
initialize crypto-engine and enable retry mechanism.

Set the maximum size for crypto-engine software queue based on
Job Ring size (JOBR_DEPTH) and a threshold (reserved for the
non-crypto-API requests that are not passed through crypto-engine).

The callback for do_batch_requests is NULL, since CAAM
doesn't support linked requests.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
Changes since v1:
- add comment for THRESHOLD define;
- update max size for crypto-engine queue.

 drivers/crypto/caam/intern.h | 8 ++++++++
 drivers/crypto/caam/jr.c     | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 9112279..7d45b21 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -16,6 +16,14 @@
 /* Currently comes from Kconfig param as a ^2 (driver-required) */
 #define JOBR_DEPTH (1 << CONFIG_CRYPTO_DEV_FSL_CAAM_RINGSIZE)
 
+/*
+ * Maximum size for crypto-engine software queue based on Job Ring
+ * size (JOBR_DEPTH) and a THRESHOLD (reserved for the non-crypto-API
+ * requests that are not passed through crypto-engine)
+ */
+#define THRESHOLD 15
+#define CRYPTO_ENGINE_MAX_QLEN (JOBR_DEPTH - THRESHOLD)
+
 /* Kconfig params for interrupt coalescing if selected (else zero) */
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_INTC
 #define JOBR_INTC JRCFG_ICEN
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 6f66996..7f2b1101 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -550,7 +550,9 @@ static int caam_jr_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize crypto engine */
-	jrpriv->engine = crypto_engine_alloc_init(jrdev, false);
+	jrpriv->engine = crypto_engine_alloc_init_and_set(jrdev, true, NULL,
+							  false,
+							  CRYPTO_ENGINE_MAX_QLEN);
 	if (!jrpriv->engine) {
 		dev_err(jrdev, "Could not init crypto-engine\n");
 		return -ENOMEM;
-- 
2.1.0

