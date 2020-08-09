Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8323FEF2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHIPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 11:04:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58216 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726510AbgHIPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 11:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596985472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FuXqqlyBLIh85DO5/avWuTbEGQOdsQUAzmArktoPV3E=;
        b=MKtuhae+pF23MamyWE0rsIZun/wJQI4/3jCx81nkfQgbBkUVa152MvQ03+gLh9HDGRFXcX
        1ectv1sgTw56yxS4hGwLHG6Voi19a1aKBdxn6fp30UEWWuit/z+Q5GAGkJz9+hrerkeVal
        fEAolXxvad8KPCXwFFd19NAqYkyCZHI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-cX_rsJ_zOKG_I_SGrdHLhQ-1; Sun, 09 Aug 2020 11:04:30 -0400
X-MC-Unique: cX_rsJ_zOKG_I_SGrdHLhQ-1
Received: by mail-qv1-f71.google.com with SMTP id r12so5530451qvx.20
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 08:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FuXqqlyBLIh85DO5/avWuTbEGQOdsQUAzmArktoPV3E=;
        b=nvYGbCeYWFWdQbhg12gO2MjcrcFPBUYkluMj0LGvbgX9sP0WjJrgPS5FbNeTA2f7Q4
         DqUq3Z/iH5Drebtc1nfeItFxrcafC6x53Tt6dAmrFTMtDFJDffTT/QJ5mffFTYVxgK/a
         xEQ3tnuSEk7ikdszr9u2cceoBiR7f/oAO6spCliOPdtv44sBWy/p+XiryDGcDOXOiD7U
         dDmo/dDLK0+muSxWvbXJXYUNPUuKYupQnI081tHCG8HR4bOyYLA2ENXkxl1xLrmbH4x3
         64SgEq4SHxwRthfQEGpEo/IQPcFPOWb5cmQzoi02Y8E53Khs9bik8IE7+HZhyPYQkg8E
         xg9g==
X-Gm-Message-State: AOAM530851wiICKvBNyrRjVNQOU8PdaRxgSZCI7NpashlD+h9jwIncGt
        WfNgSzu8xwfNzsT6OxPtSmgVAWRvZauWuMh3jjF6ndQ2/NxF5etPP9/tw/XrEAYF1l3dOlPotgX
        xbR+mYI5IE0kLve0A1DeHDAdq
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr24354567qvu.70.1596985469796;
        Sun, 09 Aug 2020 08:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwhusDKO/YhHzoC56SKWKm7gS4s2SkPT/PI9PLLl8Yf4JlkBUQcMSrM8EoXGJTMRGCr1kbtg==
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr24354553qvu.70.1596985469573;
        Sun, 09 Aug 2020 08:04:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n33sm11389118qtd.43.2020.08.09.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 08:04:29 -0700 (PDT)
From:   trix@redhat.com
To:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] hwrng : cleanup initialization
Date:   Sun,  9 Aug 2020 08:04:23 -0700
Message-Id: <20200809150423.31557-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

intel-rng.c:333:2: warning: Assigned value is garbage or undefined
        void __iomem *mem = mem;
        ^~~~~~~~~~~~~~~~~   ~~~

Because mem is assigned before it is used, this is not
a real problem.  But the initialization is strange and not
needed, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/hw_random/intel-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/intel-rng.c b/drivers/char/hw_random/intel-rng.c
index 9f205bd1acc0..eb7db27f9f19 100644
--- a/drivers/char/hw_random/intel-rng.c
+++ b/drivers/char/hw_random/intel-rng.c
@@ -330,7 +330,7 @@ static int __init mod_init(void)
 	int err = -ENODEV;
 	int i;
 	struct pci_dev *dev = NULL;
-	void __iomem *mem = mem;
+	void __iomem *mem;
 	u8 hw_status;
 	struct intel_rng_hw *intel_rng_hw;
 
-- 
2.18.1

