Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501EA24D658
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgHUNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728805AbgHUNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:43:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB283C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so1929704wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=hV3o0kj0HJ12dHpuFJoquJNpGg3+3sy+hxVF/dD/9xcPj9hApQV+ahPYV8mQg/M9j7
         atxRTYziUnA/3iruuR4MnArdQrceXrrnEFwJhODaxrVskCDlbwttzd+6iRBSv1NejBQa
         6QWzpGx4xZZCevD6BUi2oqo8ykVherC0M8anbgKV++MZAJCK7SAlnT214ZdPoRyTlYdW
         XUnKBNMnmZ/FzgYV2zVnAan/dbQrblLX3KSrRVZG8qvGmS1MmxkMOriB4yIajaad+iIL
         r8UR56S4xaqNk5jT+AGS6wL/TYLhaup8larIdZdidi+E/ecVrO6dC38mdv0o3DKd14zd
         v60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=d9kDPWxgHqZe3NXuDY0DNGDfVY9bW4urcZOgCXJ5EQF2tSHE+xSOycpUfKsAHEVxsA
         yqK4jEcQcYehfblCs1C4yaAZVS3N3jNYEX+/A8l4O7mv+EinxnDJ4YO0J0bFmCa1LUNZ
         UeHWfPhxKHNyBG5KM1oLG9021OOWeq4K2fW9UhoCJZmChFAwYwT7j6vdxCN4Onvrdir5
         psZyfnNfDy5a/UHPhm9LNmXQr10hD7JDQBVHfNrG2sPlzbq/ZNbNDNftD/ULO2/69SMD
         uYg9tlNPTtN8kEfqQ0rZ78mj1pCM4LjhsuYMIcwKe2g2Jx1oobsfE0EyRCikacFNYzE/
         fZVA==
X-Gm-Message-State: AOAM532PyC9+wPPqz/yVetZLzFB00+Xv7gHfOFawHtMzLDNoxU6bZQtY
        8bRIQbRp6ubGk7g7tD50TzOKwg==
X-Google-Smtp-Source: ABdhPJydV9E4SuL/qWhGDCKSao2gIyB7i2QLFuFkSFMGHT9xpAoo04U+XfxYXUTiA5cJylb2y4tSkQ==
X-Received: by 2002:a7b:cd12:: with SMTP id f18mr3846266wmj.42.1598017428670;
        Fri, 21 Aug 2020 06:43:48 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 05/18] crypto: sun8i-ss: Add more comment on some structures
Date:   Fri, 21 Aug 2020 13:43:22 +0000
Message-Id: <1598017415-39059-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
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

