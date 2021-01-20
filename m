Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C982FCE10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbhATKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbhATJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:33:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC15C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so2176273wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CyzRhBdQWuy7NbbbUGcka0gVixtKRd5z8W/5jUM6uQ=;
        b=opSRLVAxhm/wlOnyPfNYTkIGkaz+7I8D0awfOj8/cW6MfioryWdd3b9OCHmD8IDARc
         rYPHmSk1kA/ZVs8KqvXHWlxSeSdVGutfnATOGa0jNWvqDNZ8t30f6AttQB/3bmNyCEN7
         LRNaIKi6cKwB2l0wsy5t6eICcFltJYoalBLpZdPd56sz8eivoyVOcTzdM7v+njz1cKCS
         TSQvv75X6S4tRMWB05+B4+hfI86Nk+kr1bsodzsrFXnNO+65uLsFfBh3NrGNZGOYUG2J
         eV15YaKJla80nYXEzkwI2Ho2UyCjIZ5tiniui4SXzo3qsIhGNwt4M2XbRRVeMMS+5gfx
         C1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CyzRhBdQWuy7NbbbUGcka0gVixtKRd5z8W/5jUM6uQ=;
        b=UDAaA2NuCFqC8KF6WW8MftkqFgl1WBSxH3wEHjeXXnOUgfP1VSsmGIMsNUyW1O08xL
         GQ8zaTdkkb2vjuY/KqlhOlj/pdvXbaeEpyyhq53sGkBdiGG2C5Pk9D5luaxJQ3mdBiQg
         pwx0532Mbsz96FxXBmJqF7W/gX3KRELCcUi6yMdnNAfvJt4mo+Qp4JNdi6NKtvIRNuaa
         /YLiE4AkUwOl7M0u04aNwuOFrccEHVcUnG2l8L/XRqk1OS7AiUYp0RnwjddogAJ0/HBt
         RpXgrTNouwC/CJS6D/ry4A4FSMe9+cU/x7MXKS810s37pgb7p+nEHdMYX0sz1+gx/29r
         UYYg==
X-Gm-Message-State: AOAM532JftV91R09ZxQ73SuF4SrLKkbfahy6iz6OwLbnkYOeYyJaP4pj
        lDdmCulxoCSMRlvdiKCTO9IIaw==
X-Google-Smtp-Source: ABdhPJzmWq3xuS8OdEo60LQmwNZROF/cZlYDhVqbDGwlETLLVTrl3eruNCzEnQ7eb8d+ti2f22fv+g==
X-Received: by 2002:a1c:e2d7:: with SMTP id z206mr3484728wmg.168.1611135055706;
        Wed, 20 Jan 2021 01:30:55 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/20] clk: imx: clk-imx31: Remove unused static const table 'uart_clks'
Date:   Wed, 20 Jan 2021 09:30:30 +0000
Message-Id: <20210120093040.1719407-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/imx/clk-imx31.c:54:28: warning: ‘uart_clks’ defined but not used [-Wunused-const-variable=]

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/imx/clk-imx31.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index 7b13fb57d8428..c44e18c6f63f7 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -51,16 +51,6 @@ enum mx31_clks {
 static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[ipg],
-	&clk[uart1_gate],
-	&clk[uart2_gate],
-	&clk[uart3_gate],
-	&clk[uart4_gate],
-	&clk[uart5_gate],
-	NULL
-};
-
 static void __init _mx31_clocks_init(void __iomem *base, unsigned long fref)
 {
 	clk[dummy] = imx_clk_fixed("dummy", 0);
-- 
2.25.1

