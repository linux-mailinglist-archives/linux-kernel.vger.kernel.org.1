Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DF25D784
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgIDLhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIDLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA540C061258
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:10:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so6352435wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=JXzM4BfFTGoVXCU03k/7IUiSQHrxJgQsHmuSQQwuWK/viG1URNM96o9ZAdRx0EIGSb
         elSdZIcLzXTqSkRorVqU1ErU/6CEWhdDf6lGxCSOnv1DYkASJwxXyzzOCPlo1tbI1aar
         Oc73uBtG5rUBAb57rzeDmYsLmq1EptRm450cS0J7NlaVQWBFOWDX4kPKe+jCO8bVkop2
         sTxZaHaUGtYTx3sC2lRGXLpGOtq+LDvAACH6YlOwuBUyYkUYmbka6ne3P9y7I/G6ZeOo
         /AAT7rVVPjc/McFKZ66c+/e1ygFjPOtBZL+YhL+NscQmWcSITuC+xiEoYfKS+Gip4aQL
         G4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=UAg2iIleb2lDFD/oAzcocTjsaUvjtfOyxnLL6bEzaro05GRfbVVDcK7/dtvZ1cGJlA
         13ZUlOoBa+kOU7pdlwEYEMvuvGgjsAJPSbaltdMDppogh2vmq+XHC12rJmBbc8r3cqWM
         D0AhXmnRXFPK3M9K/2BbeVag0Z6grTy3FzHgivFM1G49qqyXAN2/za9luMTW/jhaC5yZ
         dKaQt1XZZXMF54fAXmmt1zox2G/bjcV6ZbLzZ4Kqr6d2RggpCrcuNjYWUlc+77EoSIO5
         gFDi7MLKkkgVKXWfMgJ+m5RsMyP7BJIWd8NV6Eq6CGA/ewquTuvZYYW9W3tX7k+nBACm
         qCbA==
X-Gm-Message-State: AOAM533JZqHU6UMEp0/xQew0OXcshE2iTk1LStRGvWR/i6iTJO5iTA+P
        TU5fmgq45Kz2wMyJOJd4o3fjmg==
X-Google-Smtp-Source: ABdhPJzLTD+PvBpI825a8vjh5Zb1BAwwnZrkhMUvoKWAHNONldwOpr4en9aR59rdJI6NBuclLymfRA==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr7339891wrr.135.1599217816535;
        Fri, 04 Sep 2020 04:10:16 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 05/18] crypto: sun8i-ss: Add more comment on some structures
Date:   Fri,  4 Sep 2020 11:09:50 +0000
Message-Id: <1599217803-29755-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some comment on structures used by sun8i-ss.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index da71d8059019..1a66457f4a20 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -195,6 +195,8 @@ struct sun8i_cipher_req_ctx {
  * @keylen:		len of the key
  * @ss:			pointer to the private data of driver handling this TFM
  * @fallback_tfm:	pointer to the fallback TFM
+ *
+ * enginectx must be the first element
  */
 struct sun8i_cipher_tfm_ctx {
 	struct crypto_engine_ctx enginectx;
-- 
2.26.2

