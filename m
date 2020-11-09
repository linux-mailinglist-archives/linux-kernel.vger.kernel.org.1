Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76FE2AC39F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgKISWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbgKISWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4BFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:21 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id t67so367144wmt.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8hCxezfBEukY2Vv+vLD9fRtFnmoWP6TcMu+uvwdTys=;
        b=xmEhULjIYrAV9iDsTFrweCaJ9IisRqKXO9hwggTCiFAh8EfLA0GHBczNXLqw1MknyQ
         yqutDnIFNVCKRPwh0lKABziBXpYPhBF7+VzRhlfa7XZiJKBbmv79d0MU/WsRTIAF2DWs
         uAYYyPShqo+WYwgSlnLWYfB73ehIHQaAg4ZVE+pUgNqdDLL6eUCBWx35dDGyyXSwbXA4
         FeIM/hDxNCDnRBfMhZmL3dC0u+yEexSUHpRJldelOMwGRlZXsICy9Zk03WCNvlT2uyVL
         +mwXMKUhDrLjWMAYwIcJBpWhasL6p7rMTWKD2Cu5EJCzQlpeBm4yELElnn4pdyAeNaU1
         F5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8hCxezfBEukY2Vv+vLD9fRtFnmoWP6TcMu+uvwdTys=;
        b=E3u+aX2pQHn9Pf1Pd5BP5HD/vIB0rNUWU7cdwnfekblBiewdl38RYKgu2vYFd1H3ne
         41DoYCjxXqw/ib0BDK7LSf9nglE0HN/vQWhlklSilUVwUgBasMHxUkeG+R+qf6eL52fn
         hfgbwpr139QkO8F8jownNrnYcoq2Lu+M3wJESek21Wg2FAdZxx0hvNL6nVt5KYKcLnxM
         Oym+hYZf4t5yiIcWlgvRljbSJFd2GwggGYoS8ezu811RKRLXnGKqzowi05PSd2z0VJlh
         9jiBSxCXEG0i30UVR1SFdsE59W3h0S6Kma0QHFJZ5OlP+c1P/KiH1K6fkiPfyBsg8kK7
         DP4w==
X-Gm-Message-State: AOAM532LVQLx59YyvaTlO9GC5WZ5dwnw0LcLzBus3JVN3e3TTsu8qLHZ
        iCoy3ka6Ac4FpGQuV00V3uACEjAanwlkZko7
X-Google-Smtp-Source: ABdhPJxfXraeo0LywdAq7+mLOydhEj2ijEp9rCLKkhSDyvX/tw7ttuh+cBu8nPSRC3YIzPrSI5eW5Q==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr518089wmk.4.1604946140016;
        Mon, 09 Nov 2020 10:22:20 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Jochen=20Sch=C3=A4uble?= <psionic@psionic.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 02/23] mtd: devices: phram: File headers are not good candidates for kernel-doc
Date:   Mon,  9 Nov 2020 18:21:45 +0000
Message-Id: <20201109182206.3037326-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/phram.c:19: warning: Function parameter or member 'fmt' not described in 'pr_fmt'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: "Jochen Schäuble" <psionic@psionic.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/phram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 087b5e86d1bfb..9e4d60bd427fb 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) ????		Jochen Schäuble <psionic@psionic.de>
  * Copyright (c) 2003-2004	Joern Engel <joern@wh.fh-wedel.de>
  *
-- 
2.25.1

