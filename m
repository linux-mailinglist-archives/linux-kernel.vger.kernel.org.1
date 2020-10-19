Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF68292E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgJSThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730021AbgJSThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KU15bin5yh1/o+lq3KE7RT9x6CrBiQ+UqRtjQPmKPRU=;
        b=GpmNhM0rdmEWWWOYX9RjgJGNWFrwybxg4mq86IxmgwsgeEYa56imwiixqSFwfi/DbvoAAo
        PrhiyLtRaIMC++uM8paBDY7BTTykGcd45jFbOREDt9/4+4bLuVR4jt3B7oqtEt2D+/9ysW
        ZW8wnQj2Jv8RbES3qF4CuqNvokis4GQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-81wLC1SFM9G88eaRwZdQiQ-1; Mon, 19 Oct 2020 15:36:58 -0400
X-MC-Unique: 81wLC1SFM9G88eaRwZdQiQ-1
Received: by mail-qt1-f197.google.com with SMTP id o25so736906qtt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KU15bin5yh1/o+lq3KE7RT9x6CrBiQ+UqRtjQPmKPRU=;
        b=VdKrQA28R57l0ITkgrME3ftqOot8BLGJanydY94RfA2LydYb8nEi0vvAUA0OwZlHNW
         6yS8m4nTUij84ShxBfkOE4qw4ajN4XcDs2pQ+yCAg9mpEZlkvDPEbHVkv8RCjRjRtdk3
         ZElJo5/dE+QKwPMEPDYSvdTF2/Te1ga+4cGE8PnmkkkFtMOOo3O3xvEHZaL6+a/RLSQY
         145j0ZAXi7BwK/gCCT9SRWBy0fpsiBv7lydcA09V37ic0Bkn6YIOMPfLRwj/KkvJHAYO
         zA1uE3fgmH1Ixr8nEI4jPmr5EnVG6wnwvahQE0LTCj28B3czvxmc3apTLkSIjsUH2Umx
         6TuQ==
X-Gm-Message-State: AOAM5314Z88cbz4zhXDfOLmWX/Ik6DsQMhzaBkUuuaZ3r0I5wPWefwQf
        DmoKzsGbOD/KE0tiN3sEdH5H9TRHs7aHr45rPkCHdr1MEGfs4iBjltDyGfk/14ki7YJd6DjFGRR
        UncMydYytz0wPWy4j66kdhNtP
X-Received: by 2002:ae9:e804:: with SMTP id a4mr1107011qkg.324.1603136218438;
        Mon, 19 Oct 2020 12:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvdQAIzHDvjts4PDAgJJfYwub44mHei8vjHCDSaOolSbAYtAnuSPossUBmcHdVD0H8TWveuQ==
X-Received: by 2002:ae9:e804:: with SMTP id a4mr1106991qkg.324.1603136218130;
        Mon, 19 Oct 2020 12:36:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o1sm424115qkf.129.2020.10.19.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:36:57 -0700 (PDT)
From:   trix@redhat.com
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: atmel-sha: remove unneeded break
Date:   Mon, 19 Oct 2020 12:36:53 -0700
Message-Id: <20201019193653.13757-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/atmel-sha.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 75ccf41a7cb9..0eb6f54e3b66 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -459,7 +459,6 @@ static int atmel_sha_init(struct ahash_request *req)
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	ctx->bufcnt = 0;
-- 
2.18.1

