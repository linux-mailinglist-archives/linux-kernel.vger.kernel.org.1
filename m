Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9680F2FCE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbhATKRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbhATJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BDC0617A5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g10so3993127wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kikyg3py8rPk2i6K9Dacq1w/iSE48+4xVY/EOledYSw=;
        b=BXA2ROLqfZgAHikbH3cKXhBo13EjksJYXs1gkCCjc7NYn1FMdp+gTOhOipM8Qjotk+
         hmuu7l1L30D33maDxRQsJiuOi70wSSkYbcbjsd4789gmXd/4kDWIKIHxL+G6rBXHH8Jn
         9JVC1y8OdJX/AWHib6zkVHRV4uTItJHWoz72JX+eGcotR1E2sJ+iLagQfC0WyX154QzX
         exARbyRr7cN5V/zhN6QK2XTltKGkFJV7LF5Mw9qsNcwlF/AuOXwEC/catfRT/4yZDHls
         DfQ6ABWkDrAJkQQ0pM4XyretV/qvpzy/IJPw6fM6dFFg8ZuA4CFz8BucOaG3Nonq4dTy
         IiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kikyg3py8rPk2i6K9Dacq1w/iSE48+4xVY/EOledYSw=;
        b=jf6rLfNuxUdrb0vdiAEanM8rF3HTpS5jn1R6iJNwdKxRQz6V7dLd36cN+rXfbv4ykf
         6bgTn00pXwNkg4tD/qkg6pJdnSYxW5fcwPpd4mzWseymg8lCqmO3zAdmG/gAWe5TiPoG
         IJ7bqEmGHQmcCkphg7kafu4jL/9PjbLs1EbPVYOBuPHTvwx0zqj6XAouAXDDzYhpXUDf
         gTS4B/9VusUZGKOSLZbHqinpFDuoIKa8dcYiOKNClGiMVPAD3/JixUklwcKqrOC3MiwQ
         H1PtoWuxW0BjRjbC6HGOPDG9ZqPUzINEZa/G2FPjf25YElK1s6WfvFwpQnYTJSdkEFVq
         FNuw==
X-Gm-Message-State: AOAM530ULhJJqTRCP8FDshCAGXmzAAcfW7dfKJBGCoZObVsIJ+A3NZ5y
        nsqzvlnfhnBvIepqkfPMWc6EkQ==
X-Google-Smtp-Source: ABdhPJwCCQF84pxZqKUdUDVo6ljxR1M58VAgAFNGkfuTXJSaecgZH1V3B+Ar3+Tn4r2dtGQGFC9oLw==
X-Received: by 2002:a05:6000:1374:: with SMTP id q20mr7083980wrz.44.1611135056918;
        Wed, 20 Jan 2021 01:30:56 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephen Gallimore <stephen.gallimore@st.com>,
        Pankaj Dev <pankaj.dev@st.com>, linux-clk@vger.kernel.org
Subject: [PATCH 11/20] clk: st: clkgen-pll: Demote unpopulated kernel-doc header
Date:   Wed, 20 Jan 2021 09:30:31 +0000
Message-Id: <20210120093040.1719407-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And remove an incorrect entry.

Fixes the following W=1 kernel build warning(s):

 drivers/clk/st/clkgen-pll.c:142: warning: cannot understand function prototype: 'struct clkgen_pll '

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Stephen Gallimore <stephen.gallimore@st.com>
Cc: Pankaj Dev <pankaj.dev@st.com>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/st/clkgen-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index c3952f2c42ba2..119c5b33080cf 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -130,12 +130,11 @@ static struct clkgen_pll_data st_pll4600c28_418_a9 = {
  * parent - fixed parent.  No clk_set_parent support
  */
 
-/**
+/*
  * PLL clock that is integrated in the ClockGenA instances on the STiH415
  * and STiH416.
  *
  * @hw: handle between common and hardware-specific interfaces.
- * @type: PLL instance type.
  * @regs_base: base of the PLL configuration register(s).
  *
  */
-- 
2.25.1

