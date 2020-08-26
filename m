Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F81252F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgHZNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:15:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44303 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgHZNP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:15:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id g6so2278339ljn.11;
        Wed, 26 Aug 2020 06:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/nPRgHC0iGFykXQ1veAuL/EAakIUq9/Zg/UORe3DVo=;
        b=ZfgII+nubV6VFC5S9VlSTQf0+5gEAae6S0Kq3K8S67Fa5yzY8IwcMpbvex/dVNqhyx
         EKwrEPL6EI30MZZRfQ2844SAZ2xNFU9eL1WP80sOEBZTrDXdrOZHj3IJP6m/7+uu/t3+
         MlJqAf2yoh26MTg25Szc5EPvNAxhxqTLyTC3fRqghyDQr7BjT/vOQzLUnBimfXfwAnd1
         xCXQ2whsdVCI9XTwWtwJbdO6f21Ja2Hv3HhUFohXcyKObXn+SjdljIhfGN5wsPZJkMLW
         Lj1ZXZJPgf3lMSZkKly1wIAFboYUzeaHn5v7uURyZ5nsO4tthzjhwCJjjHbsXJMyyqon
         a9WQ==
X-Gm-Message-State: AOAM532YSg6DRtW70bxkccC1vb0SAyk/ERqpVGdwu+LBjJv4jatkdad5
        2mp1isPuR094lzE3Cbo+SUvGSr7tUJA=
X-Google-Smtp-Source: ABdhPJz7jT67Fc/sgQR58BoX7ag/DyxVE8rLkkDR/Zi2YcfjbLUVL6Yj5ZMEtRBXxf5+swH7Q6cR0w==
X-Received: by 2002:a2e:85a:: with SMTP id g26mr7096722ljd.60.1598447726234;
        Wed, 26 Aug 2020 06:15:26 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id r11sm503320ljk.46.2020.08.26.06.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:15:25 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-crypto@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: inside-secure - use kfree_sensitive()
Date:   Wed, 26 Aug 2020 16:15:14 +0300
Message-Id: <20200826131515.397667-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree_sensitive() instead of open-coding it.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 16a467969d8e..5ffdc1cd5847 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -1082,8 +1082,7 @@ static int safexcel_hmac_init_pad(struct ahash_request *areq,
 		}
 
 		/* Avoid leaking */
-		memzero_explicit(keydup, keylen);
-		kfree(keydup);
+		kfree_sensitive(keydup);
 
 		if (ret)
 			return ret;
-- 
2.26.2

