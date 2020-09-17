Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC526E3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIQSin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgIQSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:36:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E6C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so3142839wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=95zSQXucA3JVtCyytHmj0YY6t7Txi03VIMdUw17K6OY=;
        b=dy8qrGfBrIm415C/AKe+zhxMSYXEPCm5p9tVIbpQLxrIuNdaArcxZmfXZ2+/RjNVSr
         cePOmHKnEe8/oekKxsYVXhS0ri5fv0JFc85DA/dP2bKxJfQfndLjhVb+x/+zOD/HXyMn
         rj45ayusWqqcbZXaaPYBr297PIQka5gcTb11rNycGtej9/l27rxbt4x+xnzUFOmN+/6d
         QBYEM6og75J3XUgMb306Mumrb7sSofApnV8jTGgGvhykwNDPRHl3XBZwxQ9j+n/b/U/i
         rkWlL9qDydk04KgRl65sEpqnbosBla5cYMC5Mom2JtamY9zp/HfqYT1X2z+PJDfr6d5F
         Umlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=95zSQXucA3JVtCyytHmj0YY6t7Txi03VIMdUw17K6OY=;
        b=t6uN9tDpWcnf33skkIUigiIHBnKDd2MeUEs7RPjRKmBEMHlr77+9BeNEcIHkDLG1CJ
         jHhfYnnPqfP5Ezjoo0Y8SnFJuBK8tRW5VGM9daviblWmC8FhGZ/Id6xrWFnGIfNohqns
         G/15uwRnMQsN7LiuINgxhWsUAkXR3CZbLkLUjfiVI5GcUdrKtpZP4erRvLpF8x35z96x
         PDkoeUrP2vQ7FSr/yQ+4M+9ZCOQ+acEgBUefhF5odItEUH+Ku67HD7F86EcbUYgwXUig
         v287kEdgGa5RrLztTPph8MW/KpnG0dblWrghUp8d1dmHAPkDu7zrKoYDbou8ebSmt69E
         Lhqw==
X-Gm-Message-State: AOAM530u2eiiYbWYV9YIqahTi5AaWmSpz1/SBaZ7MLfEbajLaTTr/xeh
        PqhW5Qy3PYqYmsLIb4aYLartZg==
X-Google-Smtp-Source: ABdhPJyOLICoWIu3123UpyJexAwTB9qPRSR1qGn78IXm3kL9cpE2LR7gh5Zt/pUtPXnwu2PxLEAwlQ==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr33249298wrc.193.1600367772844;
        Thu, 17 Sep 2020 11:36:12 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x16sm571901wrq.62.2020.09.17.11.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:36:12 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH 5/7] crypto: sun4i-ss: initialize need_fallback
Date:   Thu, 17 Sep 2020 18:35:56 +0000
Message-Id: <1600367758-28589-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
References: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The need_fallback is never initialized and seem to be always true at runtime.
So all hardware operations are always bypassed.

Fixes: 0ae1f46c55f87 ("crypto: sun4i-ss - fallback when length is not multiple of blocksize")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index d66bb9cf657c..c21a1a0a8b16 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -181,7 +181,7 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	unsigned int obo = 0;	/* offset in bufo*/
 	unsigned int obl = 0;	/* length of data in bufo */
 	unsigned long flags;
-	bool need_fallback;
+	bool need_fallback = false;
 
 	if (!areq->cryptlen)
 		return 0;
-- 
2.26.2

