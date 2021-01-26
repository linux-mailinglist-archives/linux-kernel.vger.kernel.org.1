Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF88303E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbhAZNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391929AbhAZMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73601C0698D3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y187so2634509wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8T1u34dorC88muTgROvb30sAlojxHjcjn3S8eWKchI=;
        b=oMD6xl4SFT0eTU53M3uPErJ4+nTXkWKXmdZubrAueDfO34/ooNIHmfH7T8dREJUgm1
         OlkGDp/8inaEAuBHE+132rS8QA22d841x8psc4+RlNgkNEDarvxXe47YPeV3ZfW+HANT
         YCCbXQAyAanjmvkhnvi5ks2A8p0MW5er65CsVWB8lysY23+FhQjF3lSI8N21KSNspYuF
         IHM/o+AKe4GzK5us1spd0tVVMCypmikMFco+py/5KcYlhwi670zXSjinTjHjU34mUK3a
         ovNcky78HGkVG8r6Tat6mr0Kiy4zkp3Em916tKSp+5On/sB3u38Gns489lMoZxC1GJ9k
         lw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8T1u34dorC88muTgROvb30sAlojxHjcjn3S8eWKchI=;
        b=KduX6GbPVbVYM0ukYX2seVtAUyUyrOAI8ORGfLUbtnri5eUX8Qf7TEg/WrC+T325e5
         8Jr0dS4Emhr3O8itb+l0rbqQjNzoRbbdmKpde5jl1BO8XkdFuYYYB6VjwaoHSsb/LkvO
         5zhsvoSwhTzDQh2tGbgb0/r7AimzrgLH/GWXWSf+dkrQYIe8LFG669AfEn0cpaKD3ysM
         lCfw6iPJwSBuOEMRRYKCi268x6DvdnGMO9T5aYLhj3/1qpswLHzd+754Ect7MuAfk9Yf
         9wM3MDpjPw7cza58qrrX1c3wnafY+imo7YbgJuj/UTKSesFPgep44P7tkhhXstbMsE/3
         +8cQ==
X-Gm-Message-State: AOAM5338/6j6FXzTPLGTdIRNnjlBBG1rmPC81r7nFXgJ0Ns4aIy/zzX1
        jZr2DKZA+aAKmIbf/GK9TTaEkg==
X-Google-Smtp-Source: ABdhPJwQJjhHhz6+8aVdRCxnSCzGI7zL38pJJEIEPZSfK1LrkdeGVtS3fjzmGZYKF25DJn0g2cu2Dg==
X-Received: by 2002:a1c:b78b:: with SMTP id h133mr4566691wmf.151.1611665153187;
        Tue, 26 Jan 2021 04:45:53 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 07/21] clk: tegra: clk-tegra30: Remove unused variable 'reg'
Date:   Tue, 26 Jan 2021 12:45:26 +0000
Message-Id: <20210126124540.3320214-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/tegra/clk-tegra30.c: In function ‘tegra30_enable_cpu_clock’:
 drivers/clk/tegra/clk-tegra30.c:1107:15: warning: variable ‘reg’ set but not used [-Wunused-but-set-variable]

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/tegra/clk-tegra30.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 9cf249c344d9e..16dbf83d2f62a 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1104,12 +1104,9 @@ static void tegra30_cpu_out_of_reset(u32 cpu)
 
 static void tegra30_enable_cpu_clock(u32 cpu)
 {
-	unsigned int reg;
-
 	writel(CPU_CLOCK(cpu),
 	       clk_base + TEGRA30_CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
-	reg = readl(clk_base +
-		    TEGRA30_CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
+	readl(clk_base + TEGRA30_CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
 }
 
 static void tegra30_disable_cpu_clock(u32 cpu)
-- 
2.25.1

