Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974D825AF31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIBPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgIBPFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:05:38 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7370B20773;
        Wed,  2 Sep 2020 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059137;
        bh=9fjWbCmuALVUvcHuHMkm09b5211sjynNJ9Tq1XvySIY=;
        h=From:To:Cc:Subject:Date:From;
        b=LsixEc0u2r/bJq7yAVUUGvglnE3PaYEdtJmatcn3Azh1lSeG+yUXR3cFJdaqoeUlb
         o3vf/H1TyiQofCDsL5A9e9eY6nkyrb11Q0SqrM9eDjTfjqMJqIWHpF0ZLX45Z8J2Lo
         rQWDbT7cGc35c4SOHoXjclIo1T5sLGHzkKBG0niw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] crypto: caam - Fix kerneldoc
Date:   Wed,  2 Sep 2020 17:05:27 +0200
Message-Id: <20200902150530.14640-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kerneldoc warnings:

  drivers/crypto/caam/caamalg_qi2.c:73: warning: cannot understand function prototype: 'struct caam_ctx '
  drivers/crypto/caam/caamalg_qi2.c:2962: warning: cannot understand function prototype: 'struct caam_hash_ctx '

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 66ae1d581168..0441e4ff2df2 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -59,7 +59,7 @@ struct caam_skcipher_alg {
 };
 
 /**
- * caam_ctx - per-session context
+ * struct caam_ctx - per-session context
  * @flc: Flow Contexts array
  * @key:  [authentication key], encryption key
  * @flc_dma: I/O virtual addresses of the Flow Contexts
@@ -2951,7 +2951,7 @@ enum hash_optype {
 };
 
 /**
- * caam_hash_ctx - ahash per-session context
+ * struct caam_hash_ctx - ahash per-session context
  * @flc: Flow Contexts array
  * @key: authentication key
  * @flc_dma: I/O virtual addresses of the Flow Contexts
-- 
2.17.1

