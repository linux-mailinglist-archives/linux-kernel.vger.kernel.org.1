Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02132FCE16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbhATKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731441AbhATJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:33:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB80C061382
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w5so22346892wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmw0jyVjQb9zgrucTAXa+ls8bVgxcyDhXKzVAXRUfbE=;
        b=X9QF3Lr3lN7dfe1V82tisU0Bi6WFV+lr/xGNcVA4sl/jAxKUPqQBTGZJ2/jLXg7T5b
         S/Wsl6ARdue2rFAIO53TtgxLTt0/tvL/mAFPCwzo273AewD2Bmx4M4awO0lzBZLk3x8P
         0S1nH5aC2xTSXqrQV4en+BElaoK7xnX+4e/oy01MQHPAmGCN0xDx+76dfwN8dSfzvGQv
         EMuOV/1x/ihvrAfJe7z8HDDGWusTxMr7qGr9+TZYxrHJayz+guwpPoyhniyX4oLdNnwD
         gfZIlLtL2hsJQkt4WZaEOI0bE+jPDZ/O/Jvj6iLZHsBZrvSDvNmurFnL6z7T8PGDVG7k
         xzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmw0jyVjQb9zgrucTAXa+ls8bVgxcyDhXKzVAXRUfbE=;
        b=PyMadi+OYJ0Woo5VlwIdyFt4q6p5/0Je/0vqRgygKXgc2x4JDpzw5N99WYc6wcME/a
         KmFE8xD51h+yw9F3I1S0SjNz1VI8feIlUlsP4IPz+NiAz/+QGymOfBleFxwomeUIeEih
         bRkXsi0nAjimpTh1qZ+S5YVe2ybM1NDFY8I8m4klVFDYpHGaQOUlKXiOBR+yKUdKupy8
         r03PQQj3DPKN7bu2TK7nHIN/5LxsmbpIinVnfp/jyH8wP7VljTl5kHfZx9JSvVszxCA8
         sVEMnmLwF3pTHIiBCv69iuFvQ+kS7ST4yqk6cN7WzlLS1n8vp/PgmMFqvq8miLhNImfu
         QPfA==
X-Gm-Message-State: AOAM5334AJs++VK19XsWYXjJ708ldjFGJrU450Mgj6BeaxP9fEiNIkPq
        0nffPJw6890LJ4xF7ZShaTLj1Q==
X-Google-Smtp-Source: ABdhPJw5BbnjDe6qfRdwflh1jGaOVIlPHk1+fbLgvVnuE3BkdewXjP9WY4nGwSoTihOU+7wFYSYr2A==
X-Received: by 2002:adf:f403:: with SMTP id g3mr2435594wro.212.1611135065099;
        Wed, 20 Jan 2021 01:31:05 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:31:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 18/20] clk: sunxi: clk-mod0: Demote non-conformant kernel-doc header
Date:   Wed, 20 Jan 2021 09:30:38 +0000
Message-Id: <20210120093040.1719407-19-lee.jones@linaro.org>
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

 drivers/clk/sunxi/clk-mod0.c:24: warning: Function parameter or member 'req' not described in 'sun4i_a10_get_mod0_factors'

Cc: "Emilio López" <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sunxi/clk-mod0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 0cca91e075a53..f9d715ec99087 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -14,7 +14,7 @@
 
 #include "clk-factors.h"
 
-/**
+/*
  * sun4i_a10_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
  * MOD0 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
-- 
2.25.1

