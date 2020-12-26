Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4582A2E2E23
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLZMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLZMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:20:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E26C0613ED;
        Sat, 26 Dec 2020 04:19:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id x16so8618949ejj.7;
        Sat, 26 Dec 2020 04:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgtk+KcYyeTyKMF2wBck7uk+kOOkd8Plk6T6cyUk1SU=;
        b=h0MV1bgX+w+hpPaEDwSDbkou5jwKH2cZNkqWGQYlliiu2AMHrlF2ho8iDlO9vofXAO
         aGz2mnJENLqSqhGBCtvqTiuratZ/R9LSU1zSAcRJZvTteBi/lvdxd3AoXz7jmng7fm/R
         VG7MpdnH17d3SFXK5/oeB8PjLdiZJKL5hHgYuxk1A5RxxEv2K47il3iB5+Ue+f+X/tey
         agltcayNClMcjHi0IDZTW5xkR9eSesUqcBCMtu2j5XA7QiH2PMH3Qwm1kfHfAZSUd/rw
         FS0kJajLFOJkpJ3yHuakUICrDiukBLweKzekiB1IOLcnGu1kOvqrtgsnusIQrf3cbhoG
         j7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgtk+KcYyeTyKMF2wBck7uk+kOOkd8Plk6T6cyUk1SU=;
        b=LBABvYJJJlQabWLSpffNuYux/bYcxYsn+fP/Sptn2Ijt5vvpmmGC0k57YeuUuql9JZ
         9Y9tvdcgNleccxPT5iQTYtkfUC/LNsV7PzBjrjoe3qxq1f0o3p+qkVAXrL5oxEki4AWC
         Dp0qpF2xpGWGWagtFiDqVoekUHtD5X/ohJJHFPHo0xNbhtHHF+P8xwOth2ZkUb1PUW35
         +/PUf59+wod3NGY9wOGEDICYwVOyMBwx1JNO7U6RHNxOphmglYBuJxFiJUV4ypVspwYa
         d4wy3O+ojeQTHK8od/CTO41QCoBAxkXbnqv7hgXjKOUyd1HsupzfLLId7WjU9Bz2032L
         0+pA==
X-Gm-Message-State: AOAM531Q/sisKZ3GgAvSWkGgWv7JUKmo9DuQMbwENTB6nD3Brfcmavt1
        BFwm/6zAktF4TuTnZBZHGx0=
X-Google-Smtp-Source: ABdhPJzHaWUeLtjGXKYoDfO7HC3w7pkh1RekDFMx1JlDPGbafzIaTA84by+pmeSOGaq0otfnF7PKrg==
X-Received: by 2002:a17:906:971a:: with SMTP id k26mr35375666ejx.515.1608985175831;
        Sat, 26 Dec 2020 04:19:35 -0800 (PST)
Received: from localhost.localdomain (p200300f137218200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3721:8200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j9sm33842662eds.66.2020.12.26.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 04:19:35 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] clk: meson: clk-pll: propagate the error from meson_clk_pll_set_rate()
Date:   Sat, 26 Dec 2020 13:15:56 +0100
Message-Id: <20201226121556.975418-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
References: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Popagate the error code from meson_clk_pll_set_rate() when the PLL does
not lock with the new settings.

Fixes: 722825dcd54b2e ("clk: meson: migrate plls clocks to clk_regmap")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 5b932976483f..49f27fe53213 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -394,7 +394,8 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!enabled)
 		return 0;
 
-	if (meson_clk_pll_enable(hw)) {
+	ret = meson_clk_pll_enable(hw);
+	if (ret) {
 		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
 			__func__, old_rate);
 		/*
@@ -406,7 +407,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		meson_clk_pll_set_rate(hw, old_rate, parent_rate);
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.29.2

