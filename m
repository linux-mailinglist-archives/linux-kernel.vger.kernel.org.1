Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDB26F6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIRHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIRHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F4C061351
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so4474160wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=bx1BdrV4GJAO799G5rMuNP1Wi9OxGF2UQxzFxqD/9SJmHlRj8nE4EHOqgVtrPyihJM
         QOZt+l2otxqb5G005pcL1V63Mlp+a5H2s3oRqllvvF/RIhHpL0m+nQd/4qVOhHAkRE+s
         tepfsQN1MM2baWw+R/ECdFJqDbrCXdEXpiDSWcF+WsenT3EGWfmPbjF498CK+4bgp2QA
         0bCOZR55FPDs2rDvR0PRzNJaT7CrmHFMXM2pSS6oavjicH/cqzPIdQdD2cCrUqHBu+AH
         xnnErBytRoKkmboXbyfhV0ytX5iB6WisFJzXwG+go83ElxVWZdBk8Bip2kUAS6DDzft1
         UZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=stVrKOayfccSgQY+/LdBMB9I3Ss4PXX3vhoBbnUW0PLa8HXmxwiaF4RkLXLanD6vmy
         HEd54KTjQyjbEkuUTtxhwTEmAvFt3d+1AZD6PdT0cgHAzZzGyze1vv7eXrzW2JOOLqkI
         WIRLF0P/bCmR2Z8uZrzwc7f1jmqWeKIO9IRbQHE0IC/fD7h8jUEGlHa2ZjcVeSUq65CB
         DI6/QReN3BEXUXsffraiXxnLbZFgWifZBybXxS/Ph0Ip3MT5k8MzYfd3Cpcyg+3mfQ9v
         qnZZ1skhoZ8dX61UF0KAY6VP+j/zP5fN9NHrDtxaX4yR8iWkABh/NT7BKk0SaLbmv4l0
         wlYQ==
X-Gm-Message-State: AOAM532RBWb8DiUM/TSpTniAy/+1v6CUjA22V2vsa3wT5/CaCjv/wUh7
        pIxz+SSF3gsiY6Y5OAaoe/oLnw==
X-Google-Smtp-Source: ABdhPJwggzaPpmO/GlnSibDjImTt0eHP9toHfxUgTG7utiNlAxM0Nt8knmdxYBJu8e0Z27YJhgO0bA==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr14795715wmb.13.1600413810909;
        Fri, 18 Sep 2020 00:23:30 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:30 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 05/17] crypto: sun8i-ss: Add more comment on some structures
Date:   Fri, 18 Sep 2020 07:23:03 +0000
Message-Id: <1600413795-39256-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
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

