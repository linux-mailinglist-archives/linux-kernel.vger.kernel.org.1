Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4D2E2960
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 02:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgLYBVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 20:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgLYBVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 20:21:39 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE6C061575;
        Thu, 24 Dec 2020 17:20:59 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id v126so3229819qkd.11;
        Thu, 24 Dec 2020 17:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pP0KV/2+7GkTRIp32tbGx/ReBjy/Twn2d1xplbAtnNc=;
        b=E9N6HIFlusnXfDWBBoInTFQmW5rVueWZKRVRyLbZnyvd1nlUfKa74nPFgUhY1Ij019
         qk2cIMnRCEj4hBfQLrZmJuXueXB+B8+rRLkfL5fib7v/vxccfbLkUmz8Ptsa8mAUR+4p
         vctiSInbUMjQ7Kq2voTPQP6EASFJLuulWdwCus3NL8D1cqay6nwaDCQktJDxE7NgRV76
         gAEW+lxorTpIYAd7n3mDoTfkrbMpP0CIGhV3gQ0WJu3OOEbb7r9NfK3ssKyGaLvzeUqG
         q5Pe7DMaYkwWtm+SzQcdgOVeKzXBH3URFXHfk2fysV4N9VV6pXzcHw1109Vs0jFIWdkQ
         ww7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pP0KV/2+7GkTRIp32tbGx/ReBjy/Twn2d1xplbAtnNc=;
        b=M1zqVL/osVoNH5XKgF/6Rl3L0Uc8UGb1OjUQV6XhpeC47ME6G0VCQmRsA9QaENXJvU
         G8Pu2QbWf74pWQmFxCG6zYCbbN6IgQXjxIRIy9xxLyr3bwk/e+WvppWmJpQAULl1LxYf
         fHQaH+OwXp5BQpHoRhXbTp7XA5SwkHsylLyo/u/3aZNiQaaEBusR4bn8RSup7I+VNvcv
         oh5YNxKtLo59hqSCC4E0jAagcaIzgeAWnqGaeyUf0LD4aNCUODzFie7jvrz4X8A8w1mu
         rt/a6/gy5XHY28XrLI9PfHIf18gtDHhklXCTEKJljNjGEKfhHStnfhv62riKkU3FlYT2
         x43w==
X-Gm-Message-State: AOAM533vUMIhSFjp1j2dHiCsNjNnoQlnSHnrO1WQfAKMKwX5shwNX1dr
        IqZKq+h62khBalQQV/jkT20=
X-Google-Smtp-Source: ABdhPJyzXSk0ny8cZkeOBtow3I428lF9SfG+izFkxFIAPzhmbIliAXfI+zzTi9/kM+w7JecEW9RJOg==
X-Received: by 2002:a37:478f:: with SMTP id u137mr32609154qka.16.1608859258313;
        Thu, 24 Dec 2020 17:20:58 -0800 (PST)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
        by smtp.gmail.com with ESMTPSA id x47sm17583505qtb.86.2020.12.24.17.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 17:20:57 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Peter Geis <pgwipeout@gmail.com>, Ion Agorria <ion@agorria.com>
Subject: [PATCH 1/2] clk: tegra30: Add hda clock default rates to clock driver
Date:   Fri, 25 Dec 2020 01:20:25 +0000
Message-Id: <20201225012025.507803-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201225012025.507803-1-pgwipeout@gmail.com>
References: <20201225012025.507803-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation defaults the hda clocks to clk_m.
This causes hda to run too slow to operate correctly.
Fix this by defaulting to pll_p and setting the frequency to the correct rate.

This matches upstream t124 and downstream t30.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Ion Agorria <ion@agorria.com>
---
 drivers/clk/tegra/clk-tegra30.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 37244a7e68c2..9cf249c344d9 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1256,6 +1256,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_I2S3_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S4_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_VIMCLK_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_HDA, TEGRA30_CLK_PLL_P, 102000000, 0 },
+	{ TEGRA30_CLK_HDA2CODEC_2X, TEGRA30_CLK_PLL_P, 48000000, 0 },
 	/* must be the last entry */
 	{ TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_CLK_MAX, 0, 0 },
 };
-- 
2.25.1

