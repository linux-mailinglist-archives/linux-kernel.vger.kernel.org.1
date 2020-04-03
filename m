Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8C19DED1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgDCTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 15:51:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33920 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgDCTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:50:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id c195so2893077wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zbWZNn58CxQj7h2ixDLwgL3Il53yxUmdYNx8Vuq/xbw=;
        b=ReFT24KFxx3+rBNs81WNFyrO/ShJA2uT8xwRBW1ckdOXDHNpddTX/wMIahu2lP0jOu
         pfJxth0BX6a4CiMP6+Iv2BRyhvKcNyQyIqu8ofC8jCXYd0WPFDwP06cOhIINjqtPcwoy
         KN243yWQtl7IQ7DYMq7DzdA58m/Ey5lNV0bRKLES3iDAWYjtxLQYnwtL7Yl10fxILlb/
         u1RuGIdX855OIF8XlrgeU7aQfW6uh+qasdtHFwxaRawBkOyxghbn/1ZwWM4MCasBLjuq
         +uTBpvRVkgr3y3Gt2KynA9bRL71XWFhdzPhtHW6BC2ptKP0hLF+emgBzrYOQTBjv4oNN
         xx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zbWZNn58CxQj7h2ixDLwgL3Il53yxUmdYNx8Vuq/xbw=;
        b=V8nLeyS4si9a8GJ7CH2Qeqi2TGT5h3ua0zbwxlaGG/gr9RnM/9xuNUHe9tblJee202
         kn2quH2xDrGFEYfDIZcNpeetlrXUh4TGqJvUH+zq+Dbr2i96mCYw9Sg/N5JkJimcy62U
         xxNTRUIy2wQfq47B4uzz7GYnlqnAqrs3zSpCgi9NyGp2FO8xY5DSFQ7keGA3XMMnv+fX
         NJwqyrrnrgNi5K7cPawVYs1fITwumtg7gRDBvz9zPe6tHAxeCC1mhdg5NtLerJUYzZZk
         NJx+Fl0cfQi0FeQsPMJfxSWAGfGxrJv5GZmCb1OoGp5+IdLr8UtEd5AipM9jv1DOeuGD
         +WVQ==
X-Gm-Message-State: AGi0Pua3xmkcvMKI6Y+Wqe72a/XHUJyRn4W47G3Rb8QzZujie4qsENQh
        ftOyoh7E0vuVtqJ0POTcMg9Oyw==
X-Google-Smtp-Source: APiQypKlif9uMZrWD7G6ny0AnyaN8NAOhQhfgQr+jvdpHgOBTA5EF51ye1FGhSt7SltWg7Imc54OVA==
X-Received: by 2002:a1c:8149:: with SMTP id c70mr10259245wmd.123.1585943453184;
        Fri, 03 Apr 2020 12:50:53 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c17sm8102448wrp.28.2020.04.03.12.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 12:50:52 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 6/7] crypto: sun8i-ss: Add more comment on some structures
Date:   Fri,  3 Apr 2020 19:50:37 +0000
Message-Id: <1585943438-862-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
References: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some comment on structures used by sun8i-ss.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 056fcdd14201..b2668e5b612f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -171,6 +171,8 @@ struct sun8i_ss_dev {
  * @ivlen:	size of biv
  * @keylen:	keylen for this request
  * @biv:	buffer which contain the IV
+ *
+ * t_src, t_dst, p_key, p_iv op_mode, op_dir and method must be in LE32
  */
 struct sun8i_cipher_req_ctx {
 	struct sginfo t_src[MAX_SG];
@@ -193,6 +195,8 @@ struct sun8i_cipher_req_ctx {
  * @keylen:		len of the key
  * @ss:			pointer to the private data of driver handling this TFM
  * @fallback_tfm:	pointer to the fallback TFM
+ *
+ * enginectx must be the first element
  */
 struct sun8i_cipher_tfm_ctx {
 	struct crypto_engine_ctx enginectx;
-- 
2.24.1

