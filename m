Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E762FCE07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbhATKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbhATJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB520C061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so22364324wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKuuR4wyj2fWlRIK+EKlFxHaqO4Ik4r36A/blNvBUws=;
        b=DIvBQakzIghVLP5ZRiLIIk76X0nPl+XMwv0GEsSui7fhaPObPa2RRoeC5vLmI46t+9
         0J8F7W9pM9FtV7GG39c9ZhJuoXJOnXKDFEtfBnHUm1Zu86NWbje0uoE96V8beoCS736d
         0EcIrfgUlc1tdGBM8Iqhu6n7qhw8UmEAYEee6oboUVo9LNL5jjHtJcwRM4OtpOw5cBzM
         4f9IJYsbGIYrHf8ab3zTb8IZP3jKVeDxoZVxhuYve4it/wHpstW+l/njlAZUdGuF/bgL
         NpVn4KuGqXcoC3KPlwRhsG6tdeTtP3yzZEdcX0m8QvqtLwBMp0JaPj/1s0M77Eze8x6T
         1DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKuuR4wyj2fWlRIK+EKlFxHaqO4Ik4r36A/blNvBUws=;
        b=T0ohSFnIZFMjC2ZPfgzQrUZAYHKuQ4+F//lQjv6ZWXCExMth0aq7HWWBZkb+TwdLhY
         PmYKoZM/Rqi6v/eMRZiK617XyowUikHXiaGhMhsbGXTcjeCmNlGM2ua/FJzdLjPL5ugU
         TxJqj/6gmDmCv5mabHAJOHGEbC8gYAV6fwLT3slJEAucCxHa4mwgw6YVdizjofYofUl8
         Dzrcxu5ySeXAjuVtTOGTmcEj/r9TeXpfum1wWEI3Zn1XKQIif9VqbHpa4u+IF+lgqIRw
         q42NhOujeOk4sUprlls8/9b23u1gpobrxtj5yx6RbsWMsks4sHTPEYDra+b1tIHL6svn
         9Okw==
X-Gm-Message-State: AOAM530TXMiINSzpNKgsxdSAY5+9J9loW1+QEe7iIeAo1QbE7vacFxfk
        6GHN1wBpZczmbdMfLJNUMeRrdw==
X-Google-Smtp-Source: ABdhPJzkANdQfSHYBemOqLUzk1mQilYRQs50FdyxtrCmZ5LECdlrx9Qh+/KOY40JABAEyKPBigBseg==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr8481420wrm.1.1611135047757;
        Wed, 20 Jan 2021 01:30:47 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 03/20] clk: rockchip: clk-pll: Demote kernel-doc abuses to standard comment blocks
Date:   Wed, 20 Jan 2021 09:30:23 +0000
Message-Id: <20210120093040.1719407-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/rockchip/clk-pll.c:104: warning: Function parameter or member 'i' not described in 'RK3036_PLLCON'
 drivers/clk/rockchip/clk-pll.c:365: warning: Function parameter or member 'nr' not described in 'RK3066_PLL_RESET_DELAY'
 drivers/clk/rockchip/clk-pll.c:584: warning: Function parameter or member 'i' not described in 'RK3399_PLLCON'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Xing Zheng <zhengxing@rock-chips.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/rockchip/clk-pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 4c6c9167ef509..fe937bcdb4876 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -97,7 +97,7 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 	return ret;
 }
 
-/**
+/*
  * PLL used in RK3036
  */
 
@@ -358,7 +358,7 @@ static const struct clk_ops rockchip_rk3036_pll_clk_ops = {
 	.init = rockchip_rk3036_pll_init,
 };
 
-/**
+/*
  * PLL used in RK3066, RK3188 and RK3288
  */
 
@@ -577,7 +577,7 @@ static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
 	.init = rockchip_rk3066_pll_init,
 };
 
-/**
+/*
  * PLL used in RK3399
  */
 
-- 
2.25.1

