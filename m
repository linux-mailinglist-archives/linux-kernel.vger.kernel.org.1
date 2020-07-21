Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8E2288D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 21:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgGUTIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbgGUTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38A0C0619DE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so22168105wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yXxrOq7y/XEqSAypbjoNDxKbsFCR1eLBq/95DK2gDRg=;
        b=F6j3zpRFRwLd3voWeaAm0+Ovh+KLFZDnR4gK6rXggWeAhmbzSJNwyAkBLadtPTH2GZ
         w6zsuSPftgiwG1OTv37y0vTJx38A3NqqhF8kIkPYqdCK9KbT06moo3gWs04k8YPkYh5c
         5/s0iEt0gvPAaa3mQezBlbnbk2LLTr5Rt0yyWaQxGXf3fHzHPHvYpe+mFlIYCxZXHhg0
         i6hVaJ5s8J2nKPNbuWKNTSlpCDzui+/LxE5a2EfcA7SQag0A5oSN15Q5oU+6mxBFzYl3
         LFYgOEkTCgnjbFGcHzCtc7BoBx857VGbahZtena4JykDu8sCqA/4FVJDvfdH88gXUuqk
         oEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yXxrOq7y/XEqSAypbjoNDxKbsFCR1eLBq/95DK2gDRg=;
        b=itIuO4SkNBLtxHMm2k25GxIl/uRgNwYNIyHlNZ8inXie/5Ei8+yv7gwN424yl/UfPl
         G2Q1j39/0iRedFu5eG1Xj3ffpaHxmtqlSd/xRXkgzeQD/4dIqNuxRlcO10YAQAe6GJUH
         9ysxE47/7FVHh3uYQA87Z6Djxee54+UrYw+9IjzbWbSQbxRJb7JIhWBebIfM8P7tlWOD
         SP+4yi/0MG9hqO4pX+VTtLnYFzD1eX9qciAI6TVGDl1ZCGTBhFLdf1yeVtWbN7Jy4fSm
         ds/ZAcDYAlBoc98CUTDawm37sxI6FPkCeSoakCqROtPAxFTS4PLtv1b7cTFDEJuzztBg
         aPxg==
X-Gm-Message-State: AOAM530Gy+qIUmdJz4P6+69c2hxRi1bZCZDsleeBDzmyDrXUR/mJJmsW
        XPOZ87ejoBu9OBaN4xvgW4EjWg==
X-Google-Smtp-Source: ABdhPJzDZYwaYL1Q2tq5nD548uq+rJJ8ORknySyeXBGJa8uE43WEF8xXDiqBx6Tw7rHEI9T5RiSmVQ==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr26735428wro.375.1595358408498;
        Tue, 21 Jul 2020 12:06:48 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 07/17] crypto: sun8i-ce: handle endianness of t_common_ctl
Date:   Tue, 21 Jul 2020 19:06:21 +0000
Message-Id: <1595358391-34525-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

t_common_ctl is LE32 so we need to convert its value before using it.
This value is only used on H6 (ignored on other SoCs) and not handling
the endianness cause failure on xRNG/hashes operations on H6 when running BE.

Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 0bf8f29c5ae8..0b47a51e1cfc 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -120,7 +120,10 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 	/* Be sure all data is written before enabling the task */
 	wmb();
 
-	v = 1 | (ce->chanlist[flow].tl->t_common_ctl & 0x7F) << 8;
+	/* Only H6 needs to write a part of t_common_ctl along with "1", but since it is ignored
+	 * on older SoCs, we have no reason to complicate things.
+	 */
+	v = 1 | ((le32_to_cpu(ce->chanlist[flow].tl->t_common_ctl) & 0x7F) << 8);
 	writel(v, ce->base + CE_TLR);
 	mutex_unlock(&ce->mlock);
 
-- 
2.26.2

