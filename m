Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F992FCE11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbhATKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbhATJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:33:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C0C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c12so3839299wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LY5q2+0hG+fXtIws99tmFRHfiKbz2t7mHZqBtPU26u0=;
        b=qp5ivHIwlPA+mxn7LHz6fR+aGvcqN60QpoPN+nH3YCn0g5OQy7c2P2LFzNZRy7FGge
         hg2ivmGMDSU7cyhjyhZnZgwBQr0ZelkDjPGIRol04lKsfbMpcK/DF1iuHh4iiAvLHUrJ
         4OS3eqZnZu9V5YFZzPzt2Y1+eAg/YlihiacFkH9T/8LZT6mBGQM1Vau2uhk5jCnJfDUE
         Y9c2ZRdHI6t0xFmv10qomVdFhExs9yTbEU38LJK15kLAI8zs8PtF+sAu2VAdH+06Hi8J
         XBpwD4SjiVm2Dp02z3/xHdesudpSzTi0sNwIy9ckSdZQK0LZF9kWrTrGUMx0pbW9vVLt
         QMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LY5q2+0hG+fXtIws99tmFRHfiKbz2t7mHZqBtPU26u0=;
        b=ltQOIE44LLQT527VSxk9O54Qb+W7f44cSSoRWo/JWpScbDcaHiMkngrcuwjcbEpk8J
         6Z4x9uFl61ZCwu+wIuwcd7KdHHd2HeaaMEnPxwrwvLcdHjHUT+cPwuNF0ayRYMAq+0of
         E8vhZrSlywt6sjz+EH/pKQlmiy5m/mbWEB1mwO9Mxa5RHiubq/qh5Mp8N5+qYTB36sUA
         x60k741uZ7ftd5A32mXnvz5ndJgdLKLyh/4RanyyluAVYgdY8AsqO5mPVhyQOgH53gVD
         QJWoGstYQ0+pKNaEdACP7rc+9DimAhgk02GM7WDZ4sZDREWgn307VeyO+K5NXR5KCrfq
         t08w==
X-Gm-Message-State: AOAM533UXBl0REGpYJagQPlZiQSe7nBfqq3vD4Uf3P77zhIbOV4wBM8L
        2mBk+NbFUrYXyqm3wZ5CS2BuE0ioeV4Fqe9D
X-Google-Smtp-Source: ABdhPJywOFFPw6GKnzaGJjvfN+49Y8p8EZJ0VaWdz576grsWMJnhyftNyIUQPnzaGNAr0bQz60j9+g==
X-Received: by 2002:a5d:58d3:: with SMTP id o19mr8594118wrf.250.1611135059258;
        Wed, 20 Jan 2021 01:30:59 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 13/20] clk: ti: clockdomain: Fix description for 'omap2_init_clk_clkdm's hw param
Date:   Wed, 20 Jan 2021 09:30:33 +0000
Message-Id: <20210120093040.1719407-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/ti/clockdomain.c:107: warning: Function parameter or member 'hw' not described in 'omap2_init_clk_clkdm'
 drivers/clk/ti/clockdomain.c:107: warning: Excess function parameter 'clk' description in 'omap2_init_clk_clkdm'

Cc: Tero Kristo <kristo@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ti/clockdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 700b7f44f6716..74831b2752b3b 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -97,7 +97,7 @@ void omap2_clkops_disable_clkdm(struct clk_hw *hw)
 
 /**
  * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
- * @clk: OMAP clock struct ptr to use
+ * @hw: Pointer to clk_hw_omap used to obtain OMAP clock struct ptr to use
  *
  * Convert a clockdomain name stored in a struct clk 'clk' into a
  * clockdomain pointer, and save it into the struct clk.  Intended to be
-- 
2.25.1

