Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0AD303DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbhAZMvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391952AbhAZMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B0C0698E3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i9so2664203wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xV2037MpTqxIYdYf/qlhhyKpbo5/pnSBSbkbi3/w7zA=;
        b=XK+B8cmZJgvGTEGTRyLc3SO5a5c8b6otv/2xECAiu13SXrH30DrwqdXR6kt+X7RnC9
         mogCYkgvzIYiEwqc4jUJkT3zYOG8jFC+BBQrV+7WfPifcQ2CrWIQ3YvZNqTniAufzvoK
         sTT5bXKzKJYLFMD10sEpqkTtp2823oAWVPKnTntVI5Xs7P44i4lckxe5khhY0Gn9Znwx
         gxjA8TLk/p9L0pzr9bO9mcwBB89TliY8bzv5nsArobkn0D8yzUm50cEIfN0BBU+qvoyj
         VXj+oywUaId30W8IvPoE0BycccyrJ/JJlcvP/6bq+xihpWzCHJbmwEtwsIZrlAFMqLV9
         9gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xV2037MpTqxIYdYf/qlhhyKpbo5/pnSBSbkbi3/w7zA=;
        b=pPH4lHv5SWs3iBTF8Cib2BaY5kGoKiGIHqzGzCs/X+CdIA+OTQLhXD5+Vf8h+6ATYp
         PvCkjWqiYThzNPlKTDdppD02C/3F7zIA9APqi+h/8D/KI6xMaJ3+uDaZYU6TvJjPXlts
         99IMnXC89APmFxSVlm7es4N08/1iNfCmLy9tJt4r615tRV4oDBze54RugSDh/vj0KR/E
         G9O3tNuEcNZqulubYCRuk3vUTQKa4LMEM5LA7WsSniB62l2XWdaRNRFX+b/LipHEJVgf
         UsRoZj87gYz6uMuP4x2upR0X/hTp+BqZnPLlKug7u2PXNROQS9XikBSakzXRal7DUjvB
         hRNQ==
X-Gm-Message-State: AOAM532/YprOpWROATRvmfuINfxviaX2kaGDnWphscU6gVYsHOdT9VOq
        oYh4p1P8crscWkqT2SGwtpTdbWKYO1fswix6
X-Google-Smtp-Source: ABdhPJwX07IygCoQj1H2udFoApgRu91g3BVErGPZlgNSmDRMkZC8ho3Prm3d11PVxLh1npT9oweq3g==
X-Received: by 2002:a05:600c:24f:: with SMTP id 15mr4559872wmj.78.1611665161131;
        Tue, 26 Jan 2021 04:46:01 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jan Kotas <jank@cadence.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 14/21] clk: clk-fixed-mmio: Demote obvious kernel-doc abuse
Date:   Tue, 26 Jan 2021 12:45:33 +0000
Message-Id: <20210126124540.3320214-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/clk-fixed-mmio.c:62: warning: Function parameter or member 'pdev' not described in 'of_fixed_mmio_clk_probe'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jan Kotas <jank@cadence.com>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk-fixed-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
index 51f26619b6a23..5225d17d6b3f3 100644
--- a/drivers/clk/clk-fixed-mmio.c
+++ b/drivers/clk/clk-fixed-mmio.c
@@ -55,7 +55,7 @@ static void __init of_fixed_mmio_clk_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(fixed_mmio_clk, "fixed-mmio-clock", of_fixed_mmio_clk_setup);
 
-/**
+/*
  * This is not executed when of_fixed_mmio_clk_setup succeeded.
  */
 static int of_fixed_mmio_clk_probe(struct platform_device *pdev)
-- 
2.25.1

