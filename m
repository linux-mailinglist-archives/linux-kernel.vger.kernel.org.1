Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DBF26F6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgIRHXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIRHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B9DC06178C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so4471582wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=kajG9cKesfuCLkDVQktBcuffakvi8SBjQK518QnYcvbS1EYOuYrvReyD/u61WuAjXS
         KX7phG9hzjPmBUhc2bQ0zXYL0P2aey1VYjZHot7PHBl4ejNlwkCRrYURYkpnjgp5dCLb
         rPLGWUfRQZbe3eR/NNYsSJ3sTS31usThb58CULqMyqs8M4U2707+TgFZk8ApmAcUVWlm
         fzP1HoXtv3OcIQz3Cqii3zTnvd/tbroprmfToN+AvGfoGD1A44HNhIXRFftwjn9Wk0Bu
         Bch9pOOMJo/HWbjm3Q2ibiyW+w2t5nJCotwuOw65vSIBd1g8FzsOuARu66o851iEBknt
         oWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=ACqEmtz1yMybxKSalfEIrtQCexkepRQonW29cXxt/CimrMDtOSsjq1DVgmwkZFGiPI
         Ad1FzrVRCH/9wqPxT1OqrxWUYlwPU7lIzfvlHDVV8HRsrohrOFPODGTVyh2AUMkXsA6S
         DQwgCYiqrdH+1fDe3NeR1WU0jDlUFF2aIh1kz6zWmvkBaPZpdwTMT+ApczVOlEBg/GXP
         eWUlYXsv0GZZLAt/svQUYAgy+P15I3UCOhlKTQ2ETaQvEhcziWOf8YSaNuS6GpXzXs9G
         Pidnrq6gFPpBD7Pb3aNEm31NedR4J8rEEQFnlYHC83IVcXUfyplZ1GIkSPkJrG4gOd6i
         dZmg==
X-Gm-Message-State: AOAM532rZPZzKYaWxIVhWh6et2vJl/eY9+MgcgDl5qvtWxPrRLegEx8e
        M6CiUkodicKQF0nRX1KKQmJ1hA==
X-Google-Smtp-Source: ABdhPJwgYYSuIzrXjZSpjEQwjE+Ch/NO0oWfQmYzsoREzFcKKF64dtUDLBnM55e4X+5xb9gNNvgvIA==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr14509287wmf.111.1600413809980;
        Fri, 18 Sep 2020 00:23:29 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:29 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 04/17] crypto: sun8i-ss: fix a trivial typo
Date:   Fri, 18 Sep 2020 07:23:02 +0000
Message-Id: <1600413795-39256-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
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

