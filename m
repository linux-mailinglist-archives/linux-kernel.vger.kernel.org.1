Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7A2FCE17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbhATKRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731442AbhATJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:33:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DDEC0617BF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j18so2186591wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1bl3qDXqs2QWsHtpCw1hYF8Czg/cncqDgLkvEY/iUQ=;
        b=UluTl24PAc0woLh+QvL0QkYieyL8otdwZgyoUVCvs/WZzW56EfbtkrYY1dCNvDJp3w
         FzBe6w4ufIzbE7dIKpZDo7lVaZq04Rc/mEi6Ct4dw1B6TE+BZ/Il1dYj6+m9zjHnNY6s
         qPojgNZy5RlZL/rDlV3G0nrrPChfb3o1/RU/nzUwVdRbOtFuuJDMgT6LMubMqA+iu59+
         0LaI13OVJu5D16VmdGHmWDpb2Oyge/w/gqde8+P2Xtm4IXN4FfwUGvWzBUCg3TJte2PG
         Dtbe24gAgK8QrwZ91tRZfCd0FTMUnsKwqoHRyrpuEPK+iL3mxIfFCzXajyGBYapubtFI
         M+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1bl3qDXqs2QWsHtpCw1hYF8Czg/cncqDgLkvEY/iUQ=;
        b=Fb8UEKIYbaLfSLESVTNWMq7cIKTpuDRCrj7YZkcJZ2ZWdE6WTjblVbiwS+I/rP+WSm
         aN0qM2SrQW803L4aCH7OANudPW/Wd4xlUZBlqMSCow2vvb+UyOUCd1Ei5R5oz32E+K0D
         0ywbdbzxshVe8aHZVRBeOBIJSYhXWwXcpfeDaWkYtb70L+2JyE5PEUm3cjg2eXKb2Axm
         2cw/yBR7J0wql+26FQN4hahNjSJj7treUN07iC5XdX1ThxjOVKk8HkdWMfMe9U4aFt6B
         DucluzQqpTfR8BHg3c59uPfGKzZsYFNeuv5VmkO8Ti31KmKRRqziwUq1EosiFMxCsFSt
         hlUw==
X-Gm-Message-State: AOAM533emC091D4vzgVxyP8TgtxW/wpjlftQPswvspgXjK3xhHQl1Koa
        FwNbjwMISYy8CeQivBfUW6Vx0A==
X-Google-Smtp-Source: ABdhPJzhia3eL7yODrhkrLrPZukKCx6m5jAT0hXZEPPdZjxL5Q87B2VVnH1Y3E2ycOLMSqlFt8W/GQ==
X-Received: by 2002:a1c:2802:: with SMTP id o2mr3494011wmo.68.1611135063932;
        Wed, 20 Jan 2021 01:31:03 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:31:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 17/20] clk: sunxi: clk-a10-ve: Demote obvious kernel-doc abuse
Date:   Wed, 20 Jan 2021 09:30:37 +0000
Message-Id: <20210120093040.1719407-18-lee.jones@linaro.org>
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

 drivers/clk/sunxi/clk-a10-ve.c:27: warning: cannot understand function prototype: 'struct ve_reset_data '

Cc: "Emilio López" <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sunxi/clk-a10-ve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-a10-ve.c b/drivers/clk/sunxi/clk-a10-ve.c
index cb5daa4b37db7..65810937a13a1 100644
--- a/drivers/clk/sunxi/clk-a10-ve.c
+++ b/drivers/clk/sunxi/clk-a10-ve.c
@@ -20,7 +20,7 @@ static DEFINE_SPINLOCK(ve_lock);
 #define SUN4I_VE_DIVIDER_WIDTH	3
 #define SUN4I_VE_RESET		0
 
-/**
+/*
  * sunxi_ve_reset... - reset bit in ve clk registers handling
  */
 
-- 
2.25.1

