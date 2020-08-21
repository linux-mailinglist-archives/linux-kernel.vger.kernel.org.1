Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082B224D657
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgHUNon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgHUNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:43:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7CEC061798
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so1876492wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=QolGTzhY8uu671SYPdVz5ozO52BSORulBAAT/JrDr2XP5burJZJrczQN1Dg54RYjwo
         jnBA0xrIVMoFHikKn+VVWDjgbRD9txyA7xOO/0s1+0PvvzAVEfR871uQtOEYUdJYUbq2
         iGd24mLM8DRW6t/vhTocmm2+n19Dto21AovLnlVOeWmQa6Lh6fDwKRGQbTRMaRk0I2uV
         UtyrapY2TQa9krRLD8/WAD7FN+ZBz16+C1Yv0zFxgp+d1KnWanKk0/ZKsL8QYnt939Kb
         PaydM+ukvaiFxd60P6u2W+fQ30S0FnpVRl79wEvZwh5h3OpY988/SzAfkDlf/vYU50pn
         kgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=nEhdrruykotuDSNlWSiYSGvoNrIvvU2TgRYhTdJAWGM4fQi+l14eSoH8xlqIReWmwf
         15XLoVuciV9r2mpo3lo2SQ2S4V/+vHp2cz5qPcY489mZVQHUN852Sz5UGJmOV1piqL2P
         NTMn0sTqKq1+rnzODrAe8tZIzoDK2xQUu46I+CtYNHBoVRHan/R3QL/kP4WO/DRHDV3t
         h8yWtKsIdrHq4jUcmFqCSU4e7NOcGff174DVxk0J60iTIsTdDP4XUN9phqsGxf7/cC54
         IidnnIqe5TjupFp1DRxPZyPDV7oUa1KANjthoQNG45tp0q3jBSyAgIYDr0svraEpy1X1
         zbBQ==
X-Gm-Message-State: AOAM532mkuFo3pyWczh8NXJ8cDlv8O8vwctwaAFYnQF/gA0WIor4F7WZ
        PL8Y3WK74SKIvUhb0dGG+jOzHA==
X-Google-Smtp-Source: ABdhPJwPqwKNxAB0U0QZSoJ6O21Ow9Wbrl09Gojn3LlAyAjGoHYdUvfqRHfuO531ZcWl+4k0uxyPsw==
X-Received: by 2002:a1c:7f17:: with SMTP id a23mr3778721wmd.28.1598017427563;
        Fri, 21 Aug 2020 06:43:47 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 04/18] crypto: sun8i-ss: fix a trivial typo
Date:   Fri, 21 Aug 2020 13:43:21 +0000
Message-Id: <1598017415-39059-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a trivial typo.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 377ea7acb54d..da71d8059019 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -100,7 +100,7 @@ struct ss_clock {
  * @alg_hash:	list of supported hashes. for each SS_ID_ this will give the
  *              corresponding SS_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @ss_clks!	list of clock needed by this variant
+ * @ss_clks:	list of clock needed by this variant
  */
 struct ss_variant {
 	char alg_cipher[SS_ID_CIPHER_MAX];
-- 
2.26.2

