Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1F2E2E26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgLZMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgLZMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:20:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618DBC0613C1;
        Sat, 26 Dec 2020 04:19:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n26so8619549eju.6;
        Sat, 26 Dec 2020 04:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91uzX9btarYwTY48OYqVxCEpJMafqGhM2WDmwvMf2Sw=;
        b=o5krIQlBbFhNaKiyKPhMe1CnTfx/qpi2Q/3thkkIJvjGnJC72ealIx5Oh+pdBbZrTf
         NmT/WpQ/EVCy8FMLda5DsUYxqSgCxDYv9GeACSMig54Z0/GaEw42/qFTRZ0pVOyZ8Po8
         5DFy0lvRDSOH/90p5HXIFIAMMPzteeY0yjkQ0PcuzRlPkyI4qTcZorA1zhV3ToEgdsoi
         AaXufWncHt28dOh3/qEudRyVq6BluZCktrI7JYDA9fVjl8B5rRvI/+cZABF9no9czPcV
         a+ztkbfrEwVLtRSXzaMOV6YO8QQwRQW3n8GYB7P2cZJdA73d0M6OnLGS8cODr98tHB/8
         Wp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91uzX9btarYwTY48OYqVxCEpJMafqGhM2WDmwvMf2Sw=;
        b=cP/aepdF6hDq99LSzlyPtKjliqZXOKLWoRotT1HMxQzh33urlJFFFoYoDYwBdY8a9U
         Lgsazg5tDo0cJeOOgVLPHWUWQq2k9iNB8G72uYzuJMnbfveLQ3bQDPTj0pcseW1ofVHo
         Th2kQZwMi2BFwaXoeuZ2onZ9V4M7qkKFDsimhL/oGa0oQEnzstTtfR7W0BLtMU15vov1
         zqw18axZURaGxyShKjwTpwoqU/8Zwk0Yo8jsCdwEs7AJS5J/DV10pEAcby6Jwp7WspIR
         zalh0zFWxQeZoKvUUyR6+lowZKrwpdEZS7TllDhEiviI8cJ/O9uvOcSenISUrTUcMnjO
         NYrg==
X-Gm-Message-State: AOAM531h4YhUVj8fqM16yYdhbIAIuM/xHBK2Llb/uW8bhZdJDnvcCNtr
        lHCPjtQGiAJhZ2JMyjhO7AnzDaHK30U=
X-Google-Smtp-Source: ABdhPJxW3YGRfa4J2RJQPTSv758UIElxdRO96NXJv6iOlUdtwSq6Q9RL32l7OoaHk5kn5ZtqlwHyUA==
X-Received: by 2002:a17:906:174f:: with SMTP id d15mr28145594eje.52.1608985174028;
        Sat, 26 Dec 2020 04:19:34 -0800 (PST)
Received: from localhost.localdomain (p200300f137218200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3721:8200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j9sm33842662eds.66.2020.12.26.04.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 04:19:33 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] clk: meson: clk-pll: fix initializing the old rate (fallback) for a PLL
Date:   Sat, 26 Dec 2020 13:15:54 +0100
Message-Id: <20201226121556.975418-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
References: <20201226121556.975418-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "rate" parameter in meson_clk_pll_set_rate() contains the new rate.
Retrieve the old rate with clk_hw_get_rate() so we don't inifinitely try
to switch from the new rate to the same ratte again.

Fixes: 7a29a869434e8b ("clk: meson: Add support for Meson clock controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index b17a13e9337c..9404609b5ebf 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -371,7 +371,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
 
-	old_rate = rate;
+	old_rate = clk_hw_get_rate(hw);
 
 	ret = meson_clk_get_pll_settings(rate, parent_rate, &m, &n, pll);
 	if (ret)
-- 
2.29.2

