Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA172C6958
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgK0QXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:23:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731210AbgK0QXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606494233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kTDF9XwgDcDsIbA1FWIWTR8j2rLY64TEJoSITNKSTYU=;
        b=L3+pgOLLTEsWGXbnrW/+iJxGjhc9fJHvUtoceuLlqkO2IynEDR2CtMSPurvD2ieOWDG8II
        gBu3aE1gh4fjTzFrjXIn6nJZiToSXeKFa2ZBnO8Bx2cXQWjjyZyn0dsPwYhEZrbVg5KgDz
        WMB2pwdTyU8iDmUQfKhjju/koRtBk/Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-RGGs5AkUOzmLbfGE2rTy_A-1; Fri, 27 Nov 2020 11:23:51 -0500
X-MC-Unique: RGGs5AkUOzmLbfGE2rTy_A-1
Received: by mail-qv1-f69.google.com with SMTP id 12so1399101qvk.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kTDF9XwgDcDsIbA1FWIWTR8j2rLY64TEJoSITNKSTYU=;
        b=Cjb8h+0+Al01mpxEH98ZfYHUh80WY15222H6BqkxN/kUCkKC76bJCveED50BMeEena
         395SBzBwqaktG+VshpT6EUXHEO4uSNBtUNp842RCqGb6qXRMCyrqQ/2Q2aYMrqVnwDUN
         o6H/OG6b87HRSNTDsMFr4mcqk1m09o9mMbVp/KxiUpQuno6OBtNNvvvY2AM8tbe6FevH
         OyppkKPQXmGzS+OjOJvvsE3EwE8zvYaizJXZXp8XIgldJSLY/ENPVFKOfqg5AGToR03e
         YunC4NJT1X6K/1p2pxKFw4dX2TWbFmD54iSGFyWKDv4uNTdYPpGoKTZACaKihr8qyN5B
         gI7g==
X-Gm-Message-State: AOAM530nnlWuwp51gFYrBvIhkS/3y6gnD4zOsl1lZcP7/EJIgQixXNiO
        lbKrCdADxmq7yUdmDahnfWI+afy1wVc5LmVUAVyoWr3FlvU3szEEkM7ITptb+NoYtocPWrta3a0
        1q3+aG1uZg0hM1zqbzKcvO/q4
X-Received: by 2002:a37:a402:: with SMTP id n2mr9161509qke.131.1606494230945;
        Fri, 27 Nov 2020 08:23:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0/csaobGZgvBTKF0C6I2w6quYFvr2gOO6F07wHiLj1lNz/WU0GUl9mHzKxBJ4sogYMaq5NQ==
X-Received: by 2002:a37:a402:: with SMTP id n2mr9161495qke.131.1606494230782;
        Fri, 27 Nov 2020 08:23:50 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t126sm6183533qkh.133.2020.11.27.08.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:23:50 -0800 (PST)
From:   trix@redhat.com
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:23:45 -0800
Message-Id: <20201127162345.2653351-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 crypto/seed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/seed.c b/crypto/seed.c
index 5e3bef3a617d..27720140820e 100644
--- a/crypto/seed.c
+++ b/crypto/seed.c
@@ -322,7 +322,7 @@ static const u32 KC[SEED_NUM_KCONSTANTS] = {
 		SS2[byte(t1, 2)] ^ SS3[byte(t1, 3)];	\
 	t0 += t1;					\
 	X1 ^= t0;					\
-	X2 ^= t1;
+	X2 ^= t1
 
 static int seed_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		        unsigned int key_len)
-- 
2.18.4

