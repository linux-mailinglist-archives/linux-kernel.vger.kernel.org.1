Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19972288B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgGUTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgGUTGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4BC0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so22269358wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEES3ktE4nrApq3IspxeRlC1T/Hc5+7zUjeO1iyCzPo=;
        b=CeNN48cIQg9J/jUgHmlkl32S6rXiii0xJjYwQWm+JbckhqZA1xJ6pzL2TpkCH2goEQ
         W2WsxMvXVQjXC/RD38Oi+X3JhygCY3WG3WzGFd34V3Eax9HYDOYmgr+ugGfqaz+Rut+q
         7KOctci+QG2wgGYyILeepOkVKAx8paW0GnJTLJZ7lnd+r4xVZz68ScYtl6z54FCEANpy
         iwX+jjzTC7ftelZAMmSFYFwJNY8OkUGrGKOZU79uvpzoAkZSMssPafKT8Al5LBtyAq25
         aqxjkeVwGTRjvVChmOGSvUcf4N4/Gc8fO/vmRdYf7LEBc1yh2bMfeAxtJhJKg9Wr7G0C
         53VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEES3ktE4nrApq3IspxeRlC1T/Hc5+7zUjeO1iyCzPo=;
        b=mY4c4GkMWjUfrq+JwRHXx10ClCw5xsf+R/9ZS8uNB7P2Wcdu7fw6EaBkrtGS7IX/wI
         W0y9vBuRJTzqpRxTfbpOYyuQ+pxdEA5Je5PaGeU+aHsIl98iuSSkwHYqN4FydgJMfMOw
         FXrebP3H11NDdTwcEKt0yuGpweckqIcaeJjopIRDZbiXXF5AIJiGdHXGAjgzckerFGaI
         QXIYuajLi1W2luYEFCZgUEatOGnCdm7Lc/yfcVTkUAuX8PJ1L3KCnw2AouISNQ1UcLWB
         rJoAhYJG75VNajAUjoOo7lI/4s2X/8iESF1j4VkTpb57W89MbpLX/QSX1ktSostK7+et
         7Xng==
X-Gm-Message-State: AOAM532/NH7LICOxvwFpPi2IEhL7D9MoJhtDPQSV6ggEqrASSWMy5OIk
        rCM4TupY4h/NPLkUzl420ZELWQ==
X-Google-Smtp-Source: ABdhPJyGUFdzX4+aI0jvRZaJbT79LA1FWVquoBcG+mi4ZY59xNf8s8+pbkIWWaHsgeNMOP1Ubo+XNA==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr28843483wrn.185.1595358403150;
        Tue, 21 Jul 2020 12:06:43 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 01/17] crypto: sun8i-ss: Add SS_START define
Date:   Tue, 21 Jul 2020 19:06:15 +0000
Message-Id: <1595358391-34525-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using an hardcoded value, let's use a defined value for
SS_START.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index d9767e2c84d9..3a9723441e46 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -61,7 +61,7 @@ int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx
 		      const char *name)
 {
 	int flow = rctx->flow;
-	u32 v = 1;
+	u32 v = SS_START;
 	int i;
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 0405767f1f7e..f3ffaea3a59f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -13,6 +13,8 @@
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
 
+#define SS_START	1
+
 #define SS_ENCRYPTION		0
 #define SS_DECRYPTION		BIT(6)
 
-- 
2.26.2

